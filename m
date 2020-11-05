Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A652A8823
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbgKEUcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:32:17 -0500
Received: from mail-mw2nam12on2042.outbound.protection.outlook.com ([40.107.244.42]:53916
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726996AbgKEUcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:32:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtBk0BDoySYWswtpNoPfrDGHIU0fZsOQoxXPJ4n+HpD2rYhLdndlzTOQD7Tr3/ROiKMXY+snAE25+GwvU1RCFm0jsRLeI8AswHUp2Rzq7TKQThJLM7nFNQFPqcoXsrPIrM8TzvvHV122lN7W6yPODybaJltV8/igZWDIeWFTng9FWshCig1xiKgImVxuhSLKGmy8tnzKbb5exxXLkBTcbdhYy+fRUS3e+ZCllKnbQr3c4YrbuB7xevWx+QWUoMTzzA+O+9T7h2sh6TgmRDMdfnyGwrS9ow/QoXBoPaCMBtr+6+qCM+0TGpOYnrKT6IrwFYk8nYwXjpBtL0rb52rX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7p2pa6OLhaAyrmHMYMtxbUunF299xqqhZmbyqP6/Hs=;
 b=JI5BfQ6dJ59hS77LdYQQTxxof2O0MOei7GKjV65PZmZHV7ysUD74IVDnCUHenBQ+3ILFqSPc5qu7ehyBTvnX9XNvJ2awjiOeZZ50BO3sH0HDtr9hekuM3tM12EASFLMtucXT2dXXjTQs8BfDK/xpe3ltHTdcEhV9QL4HoX8TgbXkSeryIJFndKQm0uE9+FFV8xDUMdF//mToHWO4pmXF2M3AURgbXM3hajA3ui3Ia2nPzcKNOOu0dSXdjiHTEfca5gCQvv7/qzrt2ZmzBFa0+rF0B3WN5ncx7rANp2CsPRzd4Mou6/IJAHtjjQGyLdhkisLKOZmiKXiyNrhJ5i/ZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7p2pa6OLhaAyrmHMYMtxbUunF299xqqhZmbyqP6/Hs=;
 b=zxyxAlQqPOLwgcZk0VHKHuytPbeStYPIXSrgJWfpXc/FLa1PCYm1r7pc1b06OnCExag48oZZ0tG3Gw8xOmE18JvHYAd//3O4EHfMSf5FPUUnY0nmaOKLsbuGQQo+4VlJWJv1AZ1TfG655gpj2xo9Nb7Mlbu2KaQQz60U07WUbWc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Thu, 5 Nov 2020 20:32:13 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 20:32:13 +0000
Subject: Re: [PATCH v2] x86/speculation: Allow IBPB to be conditionally
 enabled on CPUs with always-on STIBP
To:     Anand K Mistry <amistry@google.com>, x86@kernel.org
Cc:     asteinhauser@google.com, tglx@linutronix.de, joelaf@google.com,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
References: <20201105163246.v2.1.Ifd7243cd3e2c2206a893ad0a5b9a4f19549e22c6@changeid>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <23d2bdb5-ebe6-b943-5c07-6e3087710651@amd.com>
Date:   Thu, 5 Nov 2020 14:32:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201105163246.v2.1.Ifd7243cd3e2c2206a893ad0a5b9a4f19549e22c6@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN1PR12CA0061.namprd12.prod.outlook.com
 (2603:10b6:802:20::32) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN1PR12CA0061.namprd12.prod.outlook.com (2603:10b6:802:20::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 20:32:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 707804f3-4100-445a-88f9-08d881c9e07b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4957:
X-Microsoft-Antispam-PRVS: <DM6PR12MB49578B1AB321D5131EDE4A9CECEE0@DM6PR12MB4957.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0iiQyGqXQi5oG0Gei9eAmsQ+X97pliIyLxzW5QqqaFDAfLpjFpZjG8weK6omuzKVUfj7aFx2gy18x6DyqZkgYiy15KZ1VaqCh2xgjRI41gNagTGEzhP5xzpKQmb1m/yYW0vKRb9qLtuJqmqz4MaJMkIxkiuGEmm0Z4nllzl9M1fJsma6W7MiXRp47HbXM9YDSPeCXf202eV2/0DTHrvVfPv6y2TT/XfGrKL7xAjaCRYNdlEhG9STGMfKuk4BBSmqDM/54n6gC9TMMz2YU91Hf/sZ/JLlGJ7XF7YAv5i9bM1av0xupIU0BV7f68YRNLQ18GPNZHbNBKpFGdHWXE2jUI4kH1A5FjTMD07eFnclwRkGsagQmB9/xeUtw+i+0a0+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(31696002)(6512007)(5660300002)(478600001)(16526019)(186003)(2906002)(4326008)(2616005)(316002)(54906003)(66556008)(66476007)(6486002)(956004)(52116002)(26005)(53546011)(6506007)(66946007)(86362001)(8676002)(83380400001)(7416002)(36756003)(8936002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ho6XXviQpSC0HFtJ/j7Zu7xByfPqXvJoejM5dDZw4X686FWejt6t9DFKxquRW6IDp5mxy8Y/6xbO3ADg9Sh6iFzRzamHpDR1aECDda+pIO9UXD67KiJx9F1NS4Pu13TDrEB2ZDLz4IgA9bpRQH6260rhkbnoDiRSelXvn6UDZepQF4NHCdEd7uYAb3yDkoN1qvQXu+y1yL8qEiyuHtSrVV0BDbQT6tPcmNF17HiyKwXB37DuRBPdJyIFVrrWWp2WYImsG46mIkcevDo2mMSRVnbQaoMS8BQXeHyCXI+EterM6N6a2nh8EU2pCMVSFqcm0ZSBowiTcO/Dw9t7J++vd56mRfmoC0uXTHgJouMuak6xgOBmWNvq27mVNS4m5b9nVVcpC7aY66cEm7l5fzpMWwhdl+qsrt4cV9anB62kuqvcSHGvr8FVGI/d+Y1nRDFqerdQLMFc7V+YYRRSpZ1RuvFOMuuOq/5FWQUINy40rGC3JU1ZGKuav1F1cYmU9YLRpa+lmyUz5fbr+aDUH3upJlJ/kYYXgeadr/GgOgaoVzu5IbDv0uQKltinGslNqDv0HST4bcWQhIBHIdEJ3NKhpJz7lippe/WfgxcLAnhDQi7pt3yg+ek3Atz+GhXmZyqtGbrHKPOA35aS/nVGopoheA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707804f3-4100-445a-88f9-08d881c9e07b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 20:32:13.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8Rsu9odmVWH18cLVq6DhCFYd/IploVtyaiY/ycafqLIyLvvBZ4UX5Xf0GnJ5NsH6rjhJ8Ff2Vwg9gjgbp2NPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/20 11:33 PM, Anand K Mistry wrote:
> On AMD CPUs which have the feature X86_FEATURE_AMD_STIBP_ALWAYS_ON,
> STIBP is set to on and 'spectre_v2_user_stibp ==
> SPECTRE_V2_USER_STRICT_PREFERRED'. At the same time, IBPB can be set to
> conditional. However, this leads to the case where it's impossible to
> turn on IBPB for a process because in the PR_SPEC_DISABLE case in
> ib_prctl_set, the (spectre_v2_user_stibp ==
> SPECTRE_V2_USER_STRICT_PREFERRED) condition leads to a return before the
> task flag is set. Similarly, ib_prctl_get will return PR_SPEC_DISABLE
> even though IBPB is set to conditional.
> 
> More generally, the following cases are possible:
> 1. STIBP = conditional && IBPB = on for spectre_v2_user=seccomp,ibpb
> 2. STIBP = on && IBPB = conditional for AMD CPUs with
>     X86_FEATURE_AMD_STIBP_ALWAYS_ON
> 
> The first case functions correctly today, but only because
> spectre_v2_user_ibpb isn't updated to reflect the IBPB mode.
> 
> At a high level, this change does one thing. If either STIBP or IBPB is
> set to conditional, allow the prctl to change the task flag. Also,
> reflect that capability when querying the state. This isn't perfect
> since it doesn't take into account if only STIBP or IBPB is
> unconditionally on. But it allows the conditional feature to work as
> expected, without affecting the unconditional one.
> 
> Signed-off-by: Anand K Mistry <amistry@google.com>

Does it need a Fixes: tag?

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
> ---
> 
> Changes in v2:
> - Fix typo in commit message
> - s/is_spec_ib_user/is_spec_ib_user_controlled
> - Update comment in ib_prctl_set() to reference X86_FEATURE_AMD_STIBP_ALWAYS_ON
> - Have is_spec_ib_user_controlled() check both IBPB and STIBP modes
> 
>   arch/x86/kernel/cpu/bugs.c | 46 +++++++++++++++++++++++---------------
>   1 file changed, 28 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index d3f0db463f96..534225afe832 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1254,6 +1254,14 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
>   	return 0;
>   }
>   
> +static bool is_spec_ib_user_controlled(void)
> +{
> +	return spectre_v2_user_ibpb == SPECTRE_V2_USER_PRCTL ||
> +		spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP ||
> +		spectre_v2_user_stibp == SPECTRE_V2_USER_PRCTL ||
> +		spectre_v2_user_stibp == SPECTRE_V2_USER_SECCOMP;
> +}
> +
>   static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
>   {
>   	switch (ctrl) {
> @@ -1262,13 +1270,20 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
>   		    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
>   			return 0;
>   		/*
> -		 * Indirect branch speculation is always disabled in strict
> -		 * mode. It can neither be enabled if it was force-disabled
> -		 * by a  previous prctl call.
> +		 * With strict mode for both IBPB and STIBP, the instruction
> +		 * code paths avoid checking this task flag and instead,
> +		 * unconditionally run the instruction. However, STIBP and IBPB
> +		 * are independent and either can be set to conditionally
> +		 * enabled regardless of the mode of the other. If either is set
> +		 * to conditional, allow the task flag to be updated, unless it
> +		 * was force-disabled by a previous prctl call.
> +		 * Currently, this is possible on an AMD CPU which has the
> +		 * feature X86_FEATURE_AMD_STIBP_ALWAYS_ON. In this case, if the
> +		 * kernel is booted with 'spectre_v2_user=seccomp', then
> +		 * spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP and
> +		 * spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED.
>   		 */
> -		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
> -		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
> -		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ||
> +		if (!is_spec_ib_user_controlled() ||
>   		    task_spec_ib_force_disable(task))
>   			return -EPERM;
>   		task_clear_spec_ib_disable(task);
> @@ -1283,9 +1298,7 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
>   		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
>   		    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
>   			return -EPERM;
> -		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
> -		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
> -		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
> +		if (!is_spec_ib_user_controlled())
>   			return 0;
>   		task_set_spec_ib_disable(task);
>   		if (ctrl == PR_SPEC_FORCE_DISABLE)
> @@ -1351,20 +1364,17 @@ static int ib_prctl_get(struct task_struct *task)
>   	if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
>   	    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
>   		return PR_SPEC_ENABLE;
> -	else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
> -	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
> -	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
> -		return PR_SPEC_DISABLE;
> -	else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_PRCTL ||
> -	    spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP ||
> -	    spectre_v2_user_stibp == SPECTRE_V2_USER_PRCTL ||
> -	    spectre_v2_user_stibp == SPECTRE_V2_USER_SECCOMP) {
> +	else if (is_spec_ib_user_controlled()) {
>   		if (task_spec_ib_force_disable(task))
>   			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
>   		if (task_spec_ib_disable(task))
>   			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
>   		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
> -	} else
> +	} else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
> +	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
> +	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
> +		return PR_SPEC_DISABLE;
> +	else
>   		return PR_SPEC_NOT_AFFECTED;
>   }
>   
> 
