Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1C42CC262
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgLBQcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:32:01 -0500
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com ([40.107.92.77]:38337
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727942AbgLBQcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:32:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjRPJ1pDsoIpc69daI3pkT5sggzxXMME5cudowH4wAia++QCt64FYEJzptx/FTDO6uAGnOogaspR55Mt+IWxYm3WMLvCNSc1ft9O+uxwj9cAaSM8zVFPZLYhg2ehrU8hrn5jCy0vpR5IZjqCXe+51s/ZnYA6dMGkIcY9Dm+OQg1qK4tg7B3rJuVmSqlYoTRsu1rSyELLtdq6uQBGLQYGLOPew/FTNzcoqsowY218OFiV1jHdw8lm2W2tcb96MFjn0WvEOjEWNH9OIFYZ0a1ft3ofyg8X5gihDmy/idw2uJV99QMX5acUDZaD81P4Q9W8J4q7GvoFYgcrqpCTzAzsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uq0Bfn8YfRhVh9j6p7Psv/sGfIKPRvY6iB6ssSiE49Q=;
 b=ERxYyWwsY7a23qobnoNQSiV643j/038kcUzrr/dHR/7pvPlbyFE7b5tbfSp4ubms6pOvrrSxcUFmO58bX/zA188rcvQmsSrfbD+oOPeoikm9PDlVn3PBf1CSeLdh7bkqgEyu9TzYRuw8CRgz/M+ENK9oYqeVxiK/tWZO3RZTaWNZgFL2Q/TvetT4HL42YgW39cecAL+2ECgiPou5rA88ZhBDyULxtVxfqN6qHctVyQezLeIp9BIBeyexo6cLY+nt4gy82SPYXgwMRQY8d5mgnvYiAKDSO++WqJbgjKhfxhFmntM/PMQcIzWUFNCDeDIwMDP9AVqoylTmt3UU0dM37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uq0Bfn8YfRhVh9j6p7Psv/sGfIKPRvY6iB6ssSiE49Q=;
 b=a2SBN/2FedHxRdN8njY6H2tRYCxFI7JIgZQMT67yqE9ByXnIpX50v+m0RdcZMrgh/s7chvQkhzKPtXu7qwYEZojURHeficVpg2vmBeZZGtZ3V3baRO7Ewc3BAVGwBcOzng6b3YCCC/+84Kbf2OKfO2Fh8deLgCDpMeOeqJY1Peg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR1201MB0123.namprd12.prod.outlook.com (2603:10b6:4:50::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Wed, 2 Dec 2020 16:31:07 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845%12]) with mapi id 15.20.3632.019; Wed, 2 Dec 2020
 16:31:07 +0000
Subject: Re: [PATCH v2] nvme: Cache DMA descriptors to prevent corruption.
To:     Tom Roeder <tmroeder@google.com>, Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Peter Gonda <pgonda@google.com>,
        Marios Pomonis <pomonis@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        David.Kaplan@amd.com
References: <20201120012738.2953282-1-tmroeder@google.com>
 <20201120080243.GA20463@lst.de> <20201130185045.GA744128@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <489515e1-9b6e-ff14-d790-69cbb7101f3e@amd.com>
Date:   Wed, 2 Dec 2020 10:31:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201130185045.GA744128@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN4PR0501CA0145.namprd05.prod.outlook.com
 (2603:10b6:803:2c::23) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN4PR0501CA0145.namprd05.prod.outlook.com (2603:10b6:803:2c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9 via Frontend Transport; Wed, 2 Dec 2020 16:31:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7dc1b5a6-74a9-4dc0-6dcc-08d896dfab9e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0123300F037384EDF7D1DC1FECF30@DM5PR1201MB0123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSTMvk533muof4dGbpWCIWQWeyx+tgwe9rw2iAuxNUSl/h9UBuLu60TJBC+tDeGFTyT8gJ0+ZkKrSvnHbMdkxe+TmgGgZsPhqg94Q5zKLpIgoZK++o88aRzN7niLVBiYvrPf2I9nLfy19i2VZfFqck8bxHVMnhytqdAQg05ej4CzpWP0KwIL5cf+ikFbTNjuM5BNuguI+yjvxAlWVLBD+QcesPn5DNeCRMeCZN7g+dBQuehzEnWtAizg38KXQOGfkV2iks6Fknx25EZ9fSncTgR3wBimT0vkOLbJC6Ps01cWNj5/KH+uU+iYzh/WT3m7WjZnSiSNvCkSTzrzm4NcnyNxiQbPbQvq3/90rpT/ybdwM7b81Q3sQuwRltcqukETVl1gJeWqTRu9NGeg1RSsuNFXQVD84TANT8AJJTqrJGY9FjJ5ujHe/PQc5mPKf7Q8WM4BNpKMa2Ms+OleMqdVAWkh6e2ni6tnQCiArNfMQ31Cb2DFYr2DNJvDUzuqFbH4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(31696002)(2906002)(8676002)(6512007)(6506007)(83380400001)(2616005)(66946007)(16526019)(53546011)(966005)(956004)(316002)(66476007)(66556008)(186003)(5660300002)(31686004)(36756003)(4326008)(86362001)(8936002)(26005)(478600001)(6486002)(52116002)(54906003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UGxSUUh1Q1BKREZGSE8zK3lMTk1YeXc2OU5ZQzY2T25hd3RvNGsxUzhuSndG?=
 =?utf-8?B?NS96dFZWUkVyaVpFdlNRVWNVQTFlZWp2OWZodXRoZWtYU0czc2lTNmkvcDJP?=
 =?utf-8?B?T3RocGx4ZXV3WmVMaHN5anl1aHQrZVdqSUU1WDFac1BJK0Rhd3pUSVhITzJ2?=
 =?utf-8?B?S0VDdC9ZVjNGYUR2RDBUTi93VHNobFpGNGlnTlFhL29iWmxjTFlKSlloNzd5?=
 =?utf-8?B?cFhhY1YzclJWMVFOTTVqdXNhVG5JZTNEbVI0SWxkUVBEUVNzZ0lZMHg5VEtq?=
 =?utf-8?B?UC9WcHhCZlZvMWVRaEVMTDhoZHdXckFoTDVnaUIvV2tLWWxuVnRHODQwOGRC?=
 =?utf-8?B?aWd3ZUhsYUhOTHoyZWVVbWQxUS85TXg3T3AvRG9QZ3dBM2ExOCs5MjY0Kzc2?=
 =?utf-8?B?TDY5Z2ZISW9BdW1qd0JNYnhjMm1LY1lCKzFYRTFORUplOW9LTldYSHdGcFcv?=
 =?utf-8?B?cmc0M0FEVzR3ellzUjVSbVZMV1J4Y3FqRTBMSVIweTE0cllEUzJPYlB5aThx?=
 =?utf-8?B?dDF4UlIrUE1mRjl0RmFlb0EzS0FqS01LY3BmSkFESGxBSzFzdkxRZk52TXNK?=
 =?utf-8?B?SzJQOW8wL21ib2JsVkNoa1NIamRPaVdqendVaUJNRVN3UytwOGVpbk5KRFg1?=
 =?utf-8?B?VWJ1amNXOFIvcDBQLzJHVVRIYWQwSGI2L3NIbXdZYVl1eGpudkhHeUhIUWpv?=
 =?utf-8?B?VklqUTFzVTFqQ1VJVGNhSC91S20vK3BHZitlUVcwak93WjkrQUVuekNWS1Bu?=
 =?utf-8?B?SWRZa0hMbkNadXBYSTBMNEMzTFJ5TjBSQ1E2dU5COC85THlReEVxNXdwU2Jy?=
 =?utf-8?B?amt0ckpCNVJnMktvdkRPTEZUUVV4ZVVHaGxXVWJZNVRjQzVCbTV2R0l1SUZ4?=
 =?utf-8?B?N1RHVjVsSkx3YUNGMXJXTnJuM1NzdmVwY2dySTFOcC9wNGkyRVVyY29aTUhS?=
 =?utf-8?B?TnlTZmlmWFhSNUpDZWNnRDZiKzVyUWhvajNjS0ltVWFqQzFxL0ExOHRGcWJw?=
 =?utf-8?B?STBEZlNSMzZ2QkFVRUt6SzBBNDZETEhsYkM5akt0UTZ1aWZCa2YxNWNLNnk2?=
 =?utf-8?B?Z01iUFdNZGUwRFFPejl3SjFseFkvNGlPWTJ0Nm50Zzh5MmdyOFBpSDM4V1lW?=
 =?utf-8?B?bnlnUFdsTHBUT1ZudG1JNHZMbTk3NjVPckR5d085K3NIMERnOXdGZXJwMlhS?=
 =?utf-8?B?ak1LbDFQK2RsNHNkZmhhbHlmdHE3bnJmcFh0dnpoSG80SVpRd25tR2FsYmdG?=
 =?utf-8?B?K1pudzU1NW5KUENhd0huNklVdkg1ekJ6TTNYQUNXTWt5eERFV1o2Tmg0T3hr?=
 =?utf-8?Q?3DCD9JeEpkOHL7UVFbXwLL3ZgnnOOttN06?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc1b5a6-74a9-4dc0-6dcc-08d896dfab9e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 16:31:07.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERsCzfLxY2OGla7T2aUJJX/TGaIXuYxVG1FlNlY7lyhO6ym35Z0/4cRGYeXLFjZ1+ddPmmx/6PfA8whog8qpAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/20 12:50 PM, Tom Roeder wrote:
> On Fri, Nov 20, 2020 at 09:02:43AM +0100, Christoph Hellwig wrote:
>> On Thu, Nov 19, 2020 at 05:27:37PM -0800, Tom Roeder wrote:
>>> This patch changes the NVMe PCI implementation to cache host_mem_descs
>>> in non-DMA memory instead of depending on descriptors stored in DMA
>>> memory. This change is needed under the malicious-hypervisor threat
>>> model assumed by the AMD SEV and Intel TDX architectures, which encrypt
>>> guest memory to make it unreadable. Some versions of these architectures
>>> also make it cryptographically hard to modify guest memory without
>>> detection.
>>
>> I don't think this is a useful threat model, and I've not seen a
>> discussion on lkml where we had any discussion on this kind of threat
>> model either.
> 
> Thanks for the feedback and apologies for the lack of context.
> 
> I was under the impression that support for AMD SEV SNP will start showing 
> up in KVM soon, and my understanding of SNP is that it implies this threat 
> model for the guest. See the patchset for SEV-ES, which is the generation 
> before SNP: 
> https://lkml.org/lkml/2020/9/14/1168.> This doesn't get quite to the SNP threat model, but it starts to assume 
> more maliciousness on the part of the hypervisor.
> 
> You can also see the talk from David Kaplan of AMD from the 2019 Linux 
> Security Summit for info about SNP: 
> https://www.youtube.com/watch?v=yr56SaJ_0QI.
> 
> 
>>
>> Before you start sending patches that regress optimizations in various
>> drivers (and there will be lots with this model) we need to have a
>> broader discussion first.
> 
> I've added Tom Lendacky and David Kaplan from AMD on the thread now, since 
> I don't think I have enough context to say where this discussion should 
> take place or the degree to which they think it has or hasn't.
> 
> Tom, David: can you please comment on this?

Any discussion should certainly take place in the open on the mailing
lists.

Further information on SEV-SNP can be found on the SEV developer web page
at https://developer.amd.com/sev.

There is a white paper specific to SNP:
  https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf

Also, volume 2 of the AMD APM provides further information on the various
SEV features (sections 15.34 to 15.36):
  https://www.amd.com/system/files/TechDocs/24593.pdf

It is a good idea to go through the various drivers and promote changes
to provide protection from a malicious hypervisor, but, as Christoph
states, it needs to be discussed in order to determine the best approach.

Thanks,
Tom

> 
>>
>> And HMB support, which is for low-end consumer devices that are usually
>> not directly assigned to VMs aren't a good starting point for this.
> 
> I'm glad to hear that this case doesn't apply directly to cases we would 
> care about for assignment to guests. I'm not very familiar with this 
> codebase, unfortunately. Do the same kinds of issues apply for the kinds 
> of devices that would be assigned to guests?
