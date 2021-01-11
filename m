Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3962F1E08
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390528AbhAKSaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:30:05 -0500
Received: from mail-mw2nam10on2069.outbound.protection.outlook.com ([40.107.94.69]:60000
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390039AbhAKSaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:30:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0lZ+fKCghAp9G2Ut2vUpxq3ayHFI58ABAx0QquJF1mk6RdP35OG12oEF4L+JP8Y1jdCOk2Fafq4lBN5gtMoAMxI/ARREymijQ9YhSVdOhYQRFrsABXrWJ8vvHJxDYvgzPJFgjv9oXlJM9Ia3Q72lPmiXr0vFd3KkfYJf6AeGaM3Y2andz7895n+w7d0/PKsd76z0EHemGX8achMyHBD2jb9KpOugXQJrEhP0q3ryoETKqwAOvUH3USEp9yS6BmyME1crWVyed0hz/okLfW84IJsTn1P5wJUOVijoJ7ANrCp8loMUVEKqQRUIVBVh3wzfQjdIRekFVe4NviZSBMv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7f6lnjubrmQHhXg3ihrmU0vwuQtrXDlTjPM+/5M60Y=;
 b=YmTAPizHqq3PxHX5SpXfLFjUMQy8fvdb/5siHbVk+D0fnzlhmlCNQYit5YIPYWTTn/vZ8YgSKoltGa2MpvY5eZAKFBFe36+vtwFHth8GITjECoS7w5sQAx96gz9VaQMk2oGudPV+jpoLfh2R0EEMmdfgbDv3R+QVbx3GNEXZLXFJ8caR4EC1+s+43eK3i8CKudbNATQOZioLlYCDIlyx8IfBvbxzb0nVzI3yAyzByn4ZettoUscM0RySp/6fWW5JXW0b/uowYqPggRQWlVsVbweI8lgCNoVySz2jy8hvo2k08oj1rz+AtgVa4Stkc2VKhaf+fjORDdhJWDSNaiIXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7f6lnjubrmQHhXg3ihrmU0vwuQtrXDlTjPM+/5M60Y=;
 b=uFMm6VjtMNRYrsD9fIr/3/jUYw7x5zhSCaw095yR/B0PPcN88arWIngxdOLLQb/5WumuiIEy9HeplrPZgTY2iQK8W2lW+0fmGb3Ji323SeQr5zgH5PzOQh2ei5RY7KiSS+sahQ6B/yyAbPzDetqvOMuGQXyorVTHCzPnzRt3UMU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB2618.namprd12.prod.outlook.com (2603:10b6:5:49::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.12; Mon, 11 Jan 2021 18:29:10 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845%12]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 18:29:10 +0000
Subject: Re: [PATCH V2] x86/sev-es: Fix SEV-ES #VC handler for string port IO
To:     "Hyunwook (Wooky) Baek" <baekhw@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Joerg Roedel <jroedel@suse.de>,
        David Rientjes <rientjes@google.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210110071102.2576186-1-baekhw@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <1c7f7df6-11f0-e290-cb26-6d8c01b45e2c@amd.com>
Date:   Mon, 11 Jan 2021 12:29:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210110071102.2576186-1-baekhw@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA9PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:806:20::21) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SA9PR03CA0016.namprd03.prod.outlook.com (2603:10b6:806:20::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Mon, 11 Jan 2021 18:29:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4d08ec32-b018-4c4e-c9ac-08d8b65eca0e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2618:
X-Microsoft-Antispam-PRVS: <DM6PR12MB261875237D7506F04F13DE3AECAB0@DM6PR12MB2618.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbmLF3NYRJkeirCnBnmyiKPM5gX5m3pu9RGNfU1HsLLiRL1vP5BBydfTIEqyMq5PrLsUsjHoHZpfub9QbAM/q3AlPiJDcA64kmKe1VsUyEqxKoQUfJw4afnJ3OMp8uPbBYCyooEDoQibg/wvbLCezfh1kGHGmUzj8M1ruaLh06aULu9FWoPSRbU38DHTE5FbS9Wi3bRq99a3K+6ZBJ56DIqtDzP8GFZPkhkyj247VRwB24NqwjRD5QBYbAqggvaUHPeP5HwNdEoJGatVmk0LlZ4Wzkbha53+5R56kLSMzXIFoZcmXJB5d0OMg+NQ51Pwuag0LTMLamSrf28q0fJOcfYBxhvb8e55Ney/mKetDRtlJOnRUoQg9M3A57oj6SvVa3INF3L/90LCH3KTwRSspx3UCeq/MJT/Rxz63HBPoORdaOzX60xe6l6h+GX0F8zVKkWYk5cV4r5OgAFHZYO8wkRVyiG4RO/XZlYFzAP7njI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(52116002)(2616005)(956004)(31686004)(186003)(6486002)(26005)(478600001)(16526019)(6506007)(86362001)(53546011)(6512007)(36756003)(8676002)(66556008)(4744005)(4326008)(31696002)(83380400001)(2906002)(66946007)(54906003)(8936002)(66476007)(110136005)(5660300002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q3IrSXJwSXg3K1YyZnpoZjlKczhwTFFWWExudmwyTTJqRFkxT1BlcExKbExm?=
 =?utf-8?B?dVVhUEtwejNOZzU0UFd4ekFBY25TOUlmaktZK05TQVVhbHdvTHNUbEdHajhB?=
 =?utf-8?B?cWRUMUl0a216NUFSYW4rYUFHWU1CM3ZXTUxqRkpqVkZnZldtc1RlWWZUczNj?=
 =?utf-8?B?bHdwdDI2U1F0OXh2MTMvcXgwZFJ6dXVaa1VmSmtwbmVQUGxIMzhVUG9LOGow?=
 =?utf-8?B?WTFyK0xUYjI2RDB1NVJLSjlIdjF3eSs2Mjg5Q08veXZWWnZ0eG9hWFhUT1pp?=
 =?utf-8?B?ZXFBdGVkQmlhYzlzY1lQL1JwVEZoRXV0Y0lDL0QxcXY4Zk5xdXhzdGNDNHpa?=
 =?utf-8?B?OGoxeU1hMUdKU1NVOFJ2YStwTFNXWVNreVBNWXRBQWgwQ1BPRGNnamlCclhH?=
 =?utf-8?B?d2VENW13NytrUXkyOTJ1czNiR1lISHBTVDJZdzJ3Mzl1Wnl4dkwyNGpmTFl1?=
 =?utf-8?B?SXF1dGNQUjQyWFczMmJjN2V3VENSano1SnMrVXJEUVJqUEQ3OEVEeGY5b2Z6?=
 =?utf-8?B?R3VqVkNYSTdRSVI1b0tOcHBaQTRMclV5KzV3RC9Ecm9hVnhDa2xEenJrR2JE?=
 =?utf-8?B?Sk82Yk01MjdodjYyWlJvZ3ZwK28vV0VBdGRhUXdrVjVtS3BhWkdVanQ5cUlM?=
 =?utf-8?B?WFBaRzI1ZHlvTHc5QmhOWFR2NWdhb0JBWEtEMkNodmRRMlMxZ0FiSndUNUJT?=
 =?utf-8?B?QWtWZXRqOUJYMGdCTmo4MkQ5ZVhMSm5KSDZCSC9HWS9HSUs5WVBiSldEL1Fk?=
 =?utf-8?B?QktPaHJMQVdVRmh6WXRGT0FsU3FyR3UrTCtiYXNFSGpEazMyOHRTMmdxZloy?=
 =?utf-8?B?Q3A1cG4yV1lIemxtSEZaaU1BN3RpS1VzMkhZcmFIeExmT05XUVJIOTV4djVy?=
 =?utf-8?B?eTRETXVaZktnWjhVbk8zYVVPVGxUWHMrOTR5UWpZc1I3dEh3MEtET0pZdkdv?=
 =?utf-8?B?YUJZY1N4eGhuUHA1U0FGS0ZOWU1PeDVBTVVyaWFuYTVpeGhnT3ZCclpUOUxo?=
 =?utf-8?B?YitIVmtCckg1Ri9sSnZ3QW1sdWs0cWNzbHRLQWN3NkF4eWlveFppL0loOGwz?=
 =?utf-8?B?b2orNnZ5cGZWMnNJRFRrcVN6ejdROFFjbVAzZmNyaEdNZXBHMUZSbFk3QU1l?=
 =?utf-8?B?cGFsdzVBN0tMTFM3QzZYd0J6TnRYdTdsSnZhKzVFL2JwbHdDSjY2NWw3cVhv?=
 =?utf-8?B?TnRYakxIdEdvRiszUloweXpTK2pvSjQrUHRHTi9ueHlpTllSbXF6RWJBZ3FD?=
 =?utf-8?B?b2VJeFM0ZENHNWt3V3ZVajJ3NGxFUXpUb0ozRkN6c3JjT3crUytVeUViTVB4?=
 =?utf-8?Q?dRa8gtezv5JlqO6WRzs0rwQd0O9sxLzFsr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 18:29:10.5423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d08ec32-b018-4c4e-c9ac-08d8b65eca0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+qMeDBRa76jIrdYNTXFarKgm+WJh1HAffJlOiVft9ICXQFBrHNwyHWHAvEsjykNTRmiKkSomy/vffxLADSHoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2618
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/21 1:11 AM, Hyunwook (Wooky) Baek wrote:
> Don't assume dest/source buffers are userspace addresses when manually
> copying data for string I/O or MOVS MMIO, as {get,put}_user() will fail
> if handed a kernel address and ultimately lead to a kernel panic.
> 
> Signed-off-by: Hyunwook (Wooky) Baek <baekhw@google.com>
> Acked-by: David Rientjes <rientjes@google.com>
> ---
> 
> This patch is tested by invoking INSB/OUTSB instructions in kernel space in a
> SEV-ES-enabled VM. Without the patch, the kernel crashed with the following
> message:
>    "SEV-ES: Unsupported exception in #VC instruction emulation - can't continue"
> With the patch, the instructions successfully read/wrote the string from/to
> the I/O port.

Shouldn't this have a Fixes: tag?

Thanks,
Tom

> 
>   arch/x86/kernel/sev-es.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
