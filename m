Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01812CDD25
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbgLCSLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:11:07 -0500
Received: from mail-dm6nam11on2086.outbound.protection.outlook.com ([40.107.223.86]:15073
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726763AbgLCSLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:11:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqrdn2O/3trgc+4/oga9oGd26i3cnLwV1XR5Gu4VQgDx8kRMK7K3aoY+zO6NSJzMJmv6NIyuYJtB/7MfqdUOZuuNgctrPXfrVhs+pwuTHoG1xb1JzmRWm2c/usFquKeyxSYio3t7TLAgFBsPXkRhBgg3B56HuKkPQ+hhLKrfjbQeF6PToHx7W5DdAm4D2w0ytOtPG96aaRuHI9WrDCAq3OFQlpqf3wnYG0KYt0jDjTAZzTsk78prCbh3GvBTRgfdlGbA+oGSbZInBI/NFHW/U+mtUgtEOL60OHHe/teCFUaqqXaFlwcjuxk+fbaqg1C1bFBZ5W814jXPbIgAbGjSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=222B2JE8cOtMmiOk1jiMCJk1X+sG13yWHYklQQBJfOg=;
 b=JJ4MNSqoWgAcXdDsbr//1/0UBkfsOv1QcGmaNLKkQZvFynGCPpsG6e2WKKS1JLplctHvz+rVyRjsMf9DBHPRXdz3A6GNY6Njuygc7gWFu2uaj+Erzi+uKoBBBzuOI5hBoRRan8nFxbC0+oWUt2azao29en1n1RfFcwdL7SPzk1tz7xkgsg5sRvBI3myRY8KdE1oyUaXzGxzy7VBzOyLMblIlEsROPBkcjDWQEcsjpGShj5d5AVh8VT5GD0oQr5jDwhwi0CDqBE7SSgThOl1CvwqjEQkLJATxLnyYoevAz9XxP/uUfxmHreC8MpqsgRyJW3cTT0Gam8CGlfzQVYK5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=222B2JE8cOtMmiOk1jiMCJk1X+sG13yWHYklQQBJfOg=;
 b=aNZUBEnjCKnHyHdUGodSFp0wHv7ZoFdSPT2425am1kh/o4cpzvqrA8cx1wnOsV+AY+nBLhE3eNrWRyK4iMiOgLTkF7+eECRZmpjRi8qSZJfw6k6LfR/Dy5ccBB25s2AQDwoprXKqOSUbW82q9eG9q0Ep2yFtQATJF902kcKJmqE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.18; Thu, 3 Dec 2020 18:10:12 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845%12]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 18:10:12 +0000
Subject: Re: [PATCH v2 1/3] x86/uprobes: Fix not using prefixes.nbytes for
 loop over prefixes.bytes
To:     Borislav Petkov <bp@alien8.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <160697102582.3146288.10127018634865687932.stgit@devnote2>
 <160697103739.3146288.7437620795200799020.stgit@devnote2>
 <20201203123757.GH3059@zn.tnic> <20201203124121.GI3059@zn.tnic>
 <20201203124820.GJ3059@zn.tnic>
 <1c1b265f-34e3-f5cc-0e7b-186dc26c94b7@amd.com>
 <20201203165420.GL3059@zn.tnic> <20201203170140.GM3059@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <d9b47fc6-6d9d-b966-30df-9ef8c83b46e3@amd.com>
Date:   Thu, 3 Dec 2020 12:10:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201203170140.GM3059@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN4PR0601CA0001.namprd06.prod.outlook.com
 (2603:10b6:803:2f::11) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN4PR0601CA0001.namprd06.prod.outlook.com (2603:10b6:803:2f::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 18:10:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70a68c39-25a1-4f26-5736-08d897b6ad92
X-MS-TrafficTypeDiagnostic: DM6PR12MB4958:
X-Microsoft-Antispam-PRVS: <DM6PR12MB495898DC7B172CACE35BD56DECF20@DM6PR12MB4958.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Z29xQjJNXTfJOvgpwC5StzH96AuoksXdtgojMahxLnvZYeR2SJ5maBra7lxXCm3AJp4WOkviyna8JFjnTuLboQoqN1MTZemeptdCKwg6ZzI/xDI0fQybrrfoFWfem+zaoHM7Rg1oGiVLGAaLgWHVf+BS4/660bUYeCkpW8VQ16X9uPWn6iKIfuAAAzUc6B5rqa3hBb78Y+dkwOOVy5JwGO8YxKFAEQqhTfq9DteawQXwa1vvh5YScrsct6FcfWpX2eOOosWnYqMxoA9+7yPMEOzCMbm5F45Fv68Bcp9lhqjlrw1kOCPT45NyqMqEeswNiyC2u3Y6m0kRtVD2EqpYPyQ3mjbcJo7AhT08/mF4T8DDPT5rHv4OmhSqQSaJgkoW+n9iyX82mm0IDVc8JC+Do1UYSMtHmByeYFhTKY2qJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(16526019)(186003)(36756003)(66556008)(2906002)(7416002)(6512007)(31696002)(6486002)(66476007)(66946007)(4326008)(26005)(2616005)(5660300002)(53546011)(6916009)(478600001)(8936002)(52116002)(31686004)(54906003)(316002)(4744005)(956004)(6506007)(86362001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WWRhQnRFNzNPMWRQYVM3RHZDNGZJck9LTmRjU2laemRpa1RvWDF6K010bnZU?=
 =?utf-8?B?UGV5eWlLRDZTbk1IbjIycnVybFpzbG0rWjVuN09VTkgzdGNrSFJBMzZ4RnM2?=
 =?utf-8?B?MzdiYm5LUlJ1UUZocDQvWktxZHpMY2U1dlFxbUxCZ3RuTlBaMXc0elJpTnpa?=
 =?utf-8?B?RFZ4S2x2emRoSmNsQmVxMC9yWFBKVXFoR2NSZ1B4cGFmQlYrWG02WVJPaFpX?=
 =?utf-8?B?OWV4dzJvbkhHaXg3a2tDRWt6Tk1Gc2tXSGRlR3pHQ1llRFFQcDRBMEx4Wmgw?=
 =?utf-8?B?SnRYeTAxYUNjS0QvS0xueEJiMTFjWjg3YjZUMkFYM1NLUVFHSThzeDZ4L1dG?=
 =?utf-8?B?eENNWGpVaFlaMUNTSEY3QWRRc2I4WmE0NDQ0SStsVmVjY09sTk4zY0hSSzh2?=
 =?utf-8?B?Q1hMa2VnNmxYMThwNzlBLzh6bXd3MjJJeWpBamt6VTEvZDN4UDZoejJqNUFj?=
 =?utf-8?B?T3R4WUs4UjJldFNPWll0OWxyODVpK0lvalVNR1NHeEdlbXRVcUNNeWdtNVN2?=
 =?utf-8?B?WDE3RGE4NC9jR1NqbUcvaDZpS3crcXRSbmRydWVuUmtiSlI1QTRsRDQ2Z205?=
 =?utf-8?B?ejJKNW53N1JOMUgxZmdjQm9BTUduMUdMdWswVHVPK2h2WndrQmVJRE1STWJz?=
 =?utf-8?B?d09Oc3BZdElzZ0NtVUJ1dS9kUGNCZXQ5YWRFOFZEZ0V0SVRJSmZ4Z1czSS9Q?=
 =?utf-8?B?UkRDTnhyZG5kOExiMDRzRGgxMitmcXFjallYSnI0ZzJXL0xDdDRPdlErOVFH?=
 =?utf-8?B?dEFBdnRVaTJTMEJiRzlJK3BtU2dqeE1BejRVYlI1dEZsdU5lU2p3S1U4dXlm?=
 =?utf-8?B?QmYzeHc5RTJMaUhTZE40V280V3dXTXNMQVF3SjB0cTRHNzFxWFg2bldJQlVh?=
 =?utf-8?B?MDNGMFdxcUhSZXZHOHREdFNUYmxRcXV1ZDZVbUtNZ1pHSU1DcWdRTitON1Q1?=
 =?utf-8?B?S3RJZHo3em9BZFBHdS9kakFxV2FNZEpNK3JueTRZN0JFUkRaMTBieXlSam5w?=
 =?utf-8?B?L3l4OFhTb3ZWTjY2WWZBVGdjbjJtbW5ZUlQvUDZqYnRTZkl1SHBWb1BYQ2p4?=
 =?utf-8?B?Sy9sRkYvdEFQMHRBc2ZtQVFJSWI2K1FKSXdCRXF1Ump6d1YyMDNpQ0paNnpi?=
 =?utf-8?B?R0hzemtpZHlSWUhHSXlrN1ZkRFAyTjR6bmxUM1M4alVhRythR0pkT2haWkhi?=
 =?utf-8?B?NmF1YnBaV2JFVmdRTnR4ekZxb1hUZW0wTnp1b3kxRFJNS0ExNG5QWm9BN2kz?=
 =?utf-8?B?YWgxTGRIb212blNGNmovQUFjT1AwMGRhUThnbUtaU1I5amwxcGJ5aG4way9s?=
 =?utf-8?Q?SQPgwKnbSpBEJaSwoDaC3+82Rao0cRhrq5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a68c39-25a1-4f26-5736-08d897b6ad92
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 18:10:12.7375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnzzoI2+vnyIblFpdpmvNRczQbjQrwYmevkw0RAeL8Hr7yBL+A3QIiL3CA9DSEEziBqMkRd3Y1W2O+tFEW+9oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/20 11:01 AM, Borislav Petkov wrote:
> On Thu, Dec 03, 2020 at 05:54:20PM +0100, Borislav Petkov wrote:
>> On Thu, Dec 03, 2020 at 10:45:48AM -0600, Tom Lendacky wrote:
>>> Since this is based on the array size, can
>>>
>>> 	idx < NUM_LEGACY_PREFIXES
>>>
>>> be replaced with:
>>>
>>> 	idx < ARRAY_SIZE(insn->prefixes.bytes)
>>
>> Actually, this needs another change:
>>
>> struct insn_field {
>>          union {
>>                  insn_value_t value;
>>                  insn_byte_t bytes[NUM_LEGACY_PREFIXES];
> 
> Blergh, spoke too soon. All those struct insn members are struct
> insn_field.
> 
> insn.prefixes should probably be a separate array of explicit size
> NUM_LEGACY_PREFIXES, not that insn_byte_t bytes[] gets enlarged in the
> future for whatever reason, while the max legacy prefixes count will
> remain 4.

Since that struct is used in multiple places, I think basing it on the 
array size is the best way to go. The main point of the check is just to 
be sure you don't read outside of the array.

Thanks,
Tom

> 
