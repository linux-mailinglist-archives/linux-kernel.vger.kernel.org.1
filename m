Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572392CC0E9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbgLBPc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:32:56 -0500
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:28032
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728451AbgLBPcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:32:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHnhmsPBzUhbtsxS50P2Zu1P+8VjuKNps+0yHF9xaeeMWsiVMG/T/fC/fUTmP3gYXv42qaZXyhTIaYe426I+Rtb3k8tC9eZSjKqJ6TUrDsEmR1xzDm+/xvYq6HuoHlKYz6x/XumQklltIhYgSHSN6jkWgI29BzznSeMkbPQJIXNwg3O8XTcfTGcMNIh0u1U3h54q6xypgu9LQgYKppP9a7y9PBKMZf/sVE5hk+Z8YYEz88OJnScwqpPevEsXnbJPqQ8HkOmzFJkymr6q7ek9cGz3YToXFBjYH9C0EthJnlPU87hRuo03j7hz7fXNj4jWdmIGU7I5KXile+7AmCxI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gd5kGis5MK9/xf6S1PKL8LAocV/dKOVkkX1mWEpCPk=;
 b=M3ufcS3g6kpyWMrx4pHVP7nz3vIemUm//u669iSFzrD22INSpHJSAhQiC9DWvMCsWSQHuTM48Nr9z2ag8FoF9A0CMKNq1DLQrui64tmPWt3CMIEVVAUONjxb0h9t05Gi03FaJEDwVCjyoLJ7+AwnClxJwM1jJswZ5bh2R+mhOLFpfaMZOItnr+eg0szT8D1pyFBfNvShw8SjbHrEqdq33PB1vLjO8NyDCpbZDDYwUxMsgsmANi6m54jRDWxPxxCxmUgCydvivCI/tdJvQWA/cQ5mEbyyQ7u1edCu9nUhdFO4FJuYrlHj3qkEttUtLb9yO4/+USZX865hwMVs9rK0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gd5kGis5MK9/xf6S1PKL8LAocV/dKOVkkX1mWEpCPk=;
 b=B0Msxuy12WA9JEU+ip587jmPCthxJod9iSP7bCesu9k/h9b53scqIWdRsTAuR43YkPwAkOiZLoEoJU1c8aFB+8JRsl+EilH6GoETRkPE2wSSbIiOfSjbmdaEWpqqMtTvxvW2wLbs9yqLfOPU4/9K4LyeB7qLol7cEUQZCePdOTs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.18; Wed, 2 Dec 2020 15:32:00 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845%12]) with mapi id 15.20.3632.019; Wed, 2 Dec 2020
 15:32:00 +0000
Subject: Re: [PATCH 1/3] x86/sev-es: Fix not using prefixes.nbytes for loop
 over prefixes.bytes
To:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <160689905099.3084105.7880450206184269465.stgit@devnote2>
 <160689906460.3084105.3134729514028168934.stgit@devnote2>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <54417a56-241b-14f9-2540-11b23e40e2b2@amd.com>
Date:   Wed, 2 Dec 2020 09:31:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <160689906460.3084105.3134729514028168934.stgit@devnote2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN2PR01CA0069.prod.exchangelabs.com (2603:10b6:800::37) To
 DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN2PR01CA0069.prod.exchangelabs.com (2603:10b6:800::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18 via Frontend Transport; Wed, 2 Dec 2020 15:31:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 453eed80-efdd-4840-f1e3-08d896d7693c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0219:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0219B05DA24D862310D2B25BECF30@DM5PR1201MB0219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tBhvZ6gtdCC8i2x4aIih0JG0sEm2lcl813CkGb4iykH0Q7NGHqWu2nKQE0izp2JTeYcT7mNABgP604aXdv/KZmwmiGPlW9n1CIHLyCUvdaKe6tZt8MeYt8xtWuhSZmrHQY5UHya+ZGQsXibWR6rjryGmF+CguT738HFrR5b59OgXvkLPKmKzHwQ3Kjg8sFttrDurQEnnL/HbG5xL1LQirXkPAWMMV3kKu5504cCNYVO5Avn515hCqvzebKlKA6xfQVk+yEAju4Y36VX8NnX4qUKiQWU3PT2cKTp/H7jDN9kLgux7afTlPTXlvAkSAceeAXTZ8pUZBnXs+7d9216ZshNJglRGboGg91k3lkUdnUSUfYS0WyER3aMZSpkBEPh2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(36756003)(6486002)(6506007)(54906003)(53546011)(110136005)(52116002)(26005)(6512007)(186003)(16526019)(956004)(2616005)(83380400001)(316002)(7416002)(8936002)(478600001)(8676002)(31696002)(4326008)(66476007)(66556008)(5660300002)(2906002)(66946007)(31686004)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VkQzdWcwTnY1bk9YYXdKUkwzWlJpTmNJUXFKU1RHUG5KN0pYd0x6NXRUejBZ?=
 =?utf-8?B?UXdoQ2h2MmhqRU5FME12Tm0wWmtWdHVqVVF1WnJ6ZFA1OWdzVlZFNE1IbzVz?=
 =?utf-8?B?OEY2NzBCelQrYzZjSVJDU2pMUkFvNyt1Nk53U1E2ZFJ6MHVJUTk0eEdkWW1h?=
 =?utf-8?B?bGNPTGhwbjR2NE5WY05ON21LSGZuYXpXdFdQNitvL0xpZTFXZmh0S09kcjY5?=
 =?utf-8?B?enNSOHNBNTFYWGhDbFFXTUxlbWdQSU5EcVEvaVI4WGkyaENpZmZqTHFkNDcy?=
 =?utf-8?B?OG0vZDRWaVdyRTJaNGljRDQ0L3lENlNmOTZjZmVsWHRBT2ViZFdvQlA2Z1Jo?=
 =?utf-8?B?VU9FNUkzdlJiRWp6dTJDdndjL1ZrZkYvbXQvaTgyTDlrUXFPdE9LOC9vMDlp?=
 =?utf-8?B?Q1E2NUloWmFSM1dHcG1lQ1Q4Rk5kZjdBSE5BVUV6LzBSa0NOZDJCZjRyQnlo?=
 =?utf-8?B?SGQ2RVFHa3dYUnEzdllGTFVDU1c1eHJQMjFjY29wUUJxR25WUTlRVWl6RGFS?=
 =?utf-8?B?VHlQaDZyZDVFTmhPcHBxS3NUajJTQkZWQlNRajNtVGlWS2locTd5S1MxRTkx?=
 =?utf-8?B?S2s5Y001YThaRkZNMCtpd2VWTmE3QUdpeVhDWUpRQmx2bHN4NithMU9aNk8r?=
 =?utf-8?B?czBiV0swVWhZUmtWUndIM3VUVVh6NElGUEx4SFk2SzJQUk9Wd3hEc1lrWmgw?=
 =?utf-8?B?UWVvZllZb290N2J4ckZudmQwR1VKMkNoNjk0em9rSmtWMXlNb1dJeGxLbEZi?=
 =?utf-8?B?RUk3QWlIWHJSNXVRcmordTdmV0hhb25DRjJwaFB0RDJoRk83Ynp1SFZMMms5?=
 =?utf-8?B?Sy9GNFpranlDYVluZnl5c0VjKzJmd2xQcHFqVjdHR25WNFZhalI4cHZIWU9M?=
 =?utf-8?B?WXl1S2VEckZqV2hhT3VKbnNMR3ZRcGV5UXNwVUhjc3JLOGZoQmNRdkI5bUdG?=
 =?utf-8?B?S2RLREJzbW92ZE5YQ0FRS0NDNkp1OVJEZS9QOTRtazN6NGxWQ084TXVsTGxx?=
 =?utf-8?B?L3V4MXlQVTdabHFTNjcxUUJDNHlaZkFkd09RRm1zNmFQZWlER3Z1WmlHUkFw?=
 =?utf-8?B?aVRMcmZKOFlkV2JUcVRpSFNUWXNQUXk2UWY0VnNNL2FXb3ZLTjZ5RHBmNHpw?=
 =?utf-8?B?R256VlpqZTVhenlkbG5NRlpmYWFlSDBHMCtPblJFT3I4dnZhVHZxeFgxbGNY?=
 =?utf-8?B?Zk9Nemw4ZnFCRUtRUk02ejdnT0lsTW5QNE52RFJXVWhkYzdoSzFnYjl6bjUr?=
 =?utf-8?B?WThCeFRYQVZhWmZwRTVHc3U4V3FPalRUNkJpZlN3VUZVdTlCeElCUVd2Wm1z?=
 =?utf-8?Q?qZltDuJ+/lnurPaOKHFtMOMCwo3ObOqd/R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453eed80-efdd-4840-f1e3-08d896d7693c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 15:32:00.2521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b90O0ljbpYVtAjIKHfOs6o1DwAsqIOIOtqBgEZdSLgAM3GcRlM3wYzouRDLZvd1fzzoFgYTXr/6gODGeLp053w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/20 2:51 AM, Masami Hiramatsu wrote:
> Since the insn.prefixes.nbytes can be bigger than the size of
> insn.prefixes.bytes[] when a same prefix is repeated, we have to
> check whether the insn.prefixes.bytes[i] != 0 and i < 4 instead
> of insn.prefixes.nbytes.
> 
> Fixes: 25189d08e516 ("x86/sev-es: Add support for handling IOIO exceptions")
> Reported-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>   arch/x86/boot/compressed/sev-es.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
> index 954cb2702e23..6a7a3027c9ac 100644
> --- a/arch/x86/boot/compressed/sev-es.c
> +++ b/arch/x86/boot/compressed/sev-es.c
> @@ -36,7 +36,7 @@ static bool insn_has_rep_prefix(struct insn *insn)
>   
>   	insn_get_prefixes(insn);
>   
> -	for (i = 0; i < insn->prefixes.nbytes; i++) {
> +	for (i = 0; insn->prefixes.bytes[i] && i < 4; i++) {

Wouldn't it be better to create a #define for the size rather than hard 
coding 4 in the various files? That would protect everything should the 
bytes array size ever change in the future.

Thanks,
Tom

>   		insn_byte_t p = insn->prefixes.bytes[i];
>   
>   		if (p == 0xf2 || p == 0xf3)
> 
