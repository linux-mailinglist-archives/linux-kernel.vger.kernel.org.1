Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2455F2A1866
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 16:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgJaPFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 11:05:34 -0400
Received: from mail-dm6nam08on2081.outbound.protection.outlook.com ([40.107.102.81]:24416
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbgJaPFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 11:05:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYkUa8yyxmK2o06U4U+C4Bep56/d4vOmfwZ04jbBcMqGDJ3xhCw2s3DKgKFQfpR1i4owiUgK6xnlfLS847Q2lueko6kZ3j0QQ1JjmBRLVtIWQ8mCxmk3idqfSm9H+nh9AyeC9nTx2aW5toX0TCxmJpqdxizNuu8ABtwY4aRuOg+vMc2GYWvg3WOzsQmknXwUBGJ/DD+FgfJHPBFYdi9nCwrSHhB87yF7Doo1+VYsjGfK4jpd7F3HEHCxy9Z2+RcsPurTvyYl3KclhImzEpC4OjV1p8zautTJMt9nI5hkxrKrfVdrsCtOfKJ67J1LDQIquBv3ptKWcpABI6J8QpwDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2SBTg1yIgEgzvZbU5X6WdSKGd2z7FO/Z1fRCra+4hg=;
 b=b3ExmK2lJlXkGicXMDQaMz6EO38qHmX641wCGsEeMfHktSnfBE41533SM3cXsasn9meMsvWGykSl2P3OWTgRYjlHWCCwYRp/SBFhhmHbem/guSMcZQJXmGy4uzoHS6oteAmgXWY6EHkNk/pXiuccKomBpWIrS9omIA1L2+P4kIpwdMRlw1feXfJVu73jYxRnMaR5Q+DwmO6HAtzuED7w3FxAxemn6liTLAydWxsKO3VAY49KSjFRQaWN0Yy7Lha5txYQS/gWIvpIwtCDdkALR2X+ooDLAURacIYKhYoBXu3bNIFCcHiT9W66xFYyoPfTfYCZJQ/+8fwYP3O+xabXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2SBTg1yIgEgzvZbU5X6WdSKGd2z7FO/Z1fRCra+4hg=;
 b=gUeTBN/B/keNt7+T8isi3tC3K5MRahaAIAwuD1xT87EOhDmj9LpC2tUCZTnLXHlp8l6ce23EeDUhCHgamwVFyT5fw9jSLcAnOVgACbPkerd9PPfKNWg+v/XHVm1Koi4NCimOoZGCGs8JY80zDEn7Ay9j+rPsevFVjEJ3X8BYT10=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR1201MB2504.namprd12.prod.outlook.com (2603:10b6:3:e3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Sat, 31 Oct 2020 15:05:28 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.027; Sat, 31 Oct 2020
 15:05:28 +0000
Subject: Re: [PATCH 1/1] x86/speculation: Allow IBPB to be conditionally
 enabled on CPUs with always-on STIBP
To:     Anand K Mistry <amistry@google.com>, x86@kernel.org,
        linux-kernel@kernel.org
Cc:     joelaf@google.com, asteinhauser@google.com, tglx@linutronix.de,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
References: <20201029065133.3027749-1-amistry@google.com>
 <20201029175120.1.Ifd7243cd3e2c2206a893ad0a5b9a4f19549e22c6@changeid>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <839fad53-4377-592a-a0da-2cf18b5c6027@amd.com>
Date:   Sat, 31 Oct 2020 10:05:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201029175120.1.Ifd7243cd3e2c2206a893ad0a5b9a4f19549e22c6@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA9PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:806:6e::14) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SA9PR11CA0009.namprd11.prod.outlook.com (2603:10b6:806:6e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Sat, 31 Oct 2020 15:05:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5687018c-b125-4429-e224-08d87dae66f4
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2504:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2504CA238147ADC39D60CE66EC120@DM5PR1201MB2504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GsCjdwBW8ne8B9/8QYJ4aXJNPcLZKAVgGgbPM1EAU6sss4CN4USP7VUi25H59S2ixDhgZ9WfMlCgM2svsd8+AFbVWni3O+DVBaNtj9QlKOIGx3/iw45VM9cvdUz+DHV7V7oHy1ItuDB01QCtZp5Z3ajwMgRn2jgCRUa+fazQAIZhdcM9CKYlsGGrSoluMh9tY4W2QblGNTR+N353Qd/kO2zbXS8bYPfs9YlMW+diI7nPgi1Ym2xMw/192gmKOvOqo6KcrQpa7OmlAaD2DECwcAj4x5tDWTLITxc0TTBGy4/YyiSqhT7jAA84INKU9iir53VOi6pHnEru2NYftemqE9L5VyX/Vo94JCmQpOsjOuObGTJGwQyRbkMtfYxyjECz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(7416002)(2616005)(316002)(6512007)(66476007)(66556008)(31686004)(956004)(66946007)(86362001)(6486002)(26005)(54906003)(5660300002)(16526019)(478600001)(186003)(2906002)(4326008)(53546011)(52116002)(8676002)(83380400001)(31696002)(36756003)(8936002)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eHF0KNNLvr98sXEtn+x/R64FWxidhbS2ToI+LABbidHwbgTQ1E/Cd35Sh7UB4c67h2Jix6J/xvX9TleiJWWnIHTuVALdiiymudZ9CLxas5N8kvJJ/mfWfEYHPYyJtixzJRFW8K/Rea3rDu76ZRj2DqspizmLSCZs8i7V6AuntXhEvnVCylAGXfJGKG2JchVoSRXIEPwurbovYigdHcOB91kPmZZRwbGak+ydS3O2SZUKAYs/AAKqM4AL58tXk4ymnwwlhbGuTL0I6//LfPOr5ZHyJL4BGMoBbHEu1me3jGfT/g5bCRyvXngl2ixmMzrKrROMlpbtlQKsPgjQW6mZ/z7Nq93PNk3o+ePobQsE+wuGFDbupx7VRy6LVKU0KaQgMdmORSpm0USrCewGPsRcUA4iiP/AKJjYjpKzfNKIGAoOGgWK/eSANajT7FZmXNJM1M8XSjTl+an/5x5m23FT4lMMXrH2J1d3BoE4w/igIEQRN2mv91jO//gJgNg64ejPFntFVbT/pIa64AhANG2EmXYMDuF+OBWSGMLvzqo9gO4fO/kBDy+yUeotbM88eDdKZyUjUCrVbHeSwTjDt+zF6soxHy+9aLF7RuY0jwMJNtAeYFdSH9XYx+6vdKrtw8z4FXdRiocdYCCx4HLc/K0LIg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5687018c-b125-4429-e224-08d87dae66f4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2020 15:05:28.2749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiWCcdTYgDXIIICy8eobIyyFCAoAjaZRz5QBAIvKBEi7cjrl18SyG/gPdJcb1yI1SLgeEc6Pni/tFP1AjI/dnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2504
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/20 1:51 AM, Anand K Mistry wrote:
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
> At a high level, this change does one thing. If either STIBP is IBPB is

s/STIBP is IBPB/STIBP or IBPB/

> set to conditional, allow the prctl to change the task flag. Also,
> reflect that capability when querying the state. This isn't perfect
> since it doesn't take into account if only STIBP or IBPB is
> unconditionally on. But it allows the conditional feature to work as
> expected, without affecting the unconditional one.
> 
> Signed-off-by: Anand K Mistry <amistry@google.com>
> 
> ---
> 
>   arch/x86/kernel/cpu/bugs.c | 41 +++++++++++++++++++++-----------------
>   1 file changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index d3f0db463f96..fb64e02eed6f 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1254,6 +1254,11 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
>   	return 0;
>   }
>   
> +static bool is_spec_ib_user(enum spectre_v2_user_mitigation mode)

Maybe something like is_spec_ib_user_controlled() would be a better name.

> +{
> +	return mode == SPECTRE_V2_USER_PRCTL || mode == SPECTRE_V2_USER_SECCOMP;
> +}
> +

I like the idea of passing in the mode you want to check, but it appears 
they are never used independently. The ibpb and stibp modes are always 
checked together in one of the if statements below, so you could make this 
a function that checks both modes and just have a single call. I'll leave 
that up to the maintainers to see what is preferred.

>   static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
>   {
>   	switch (ctrl) {
> @@ -1262,13 +1267,16 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
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

You probably want to reference the STIBP always on mode that allows this 
situation.

>   		 */
> -		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
> -		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
> -		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ||
> +		if ((!is_spec_ib_user(spectre_v2_user_ibpb) &&
> +		     !is_spec_ib_user(spectre_v2_user_stibp)) ||
>   		    task_spec_ib_force_disable(task))
>   			return -EPERM;
>   		task_clear_spec_ib_disable(task);
> @@ -1283,9 +1291,8 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
>   		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
>   		    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
>   			return -EPERM;
> -		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
> -		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
> -		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
> +		if (!is_spec_ib_user(spectre_v2_user_ibpb) &&
> +		    !is_spec_ib_user(spectre_v2_user_stibp))

The set function seems reasonable to me.

>   			return 0;
>   		task_set_spec_ib_disable(task);
>   		if (ctrl == PR_SPEC_FORCE_DISABLE)
> @@ -1351,20 +1358,18 @@ static int ib_prctl_get(struct task_struct *task)
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
> +	else if (is_spec_ib_user(spectre_v2_user_ibpb) ||
> +		 is_spec_ib_user(spectre_v2_user_stibp)) {
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

The get function also seems reasonable.

Lets hear what some of the other folks that are familiar with this area 
have to say.

Thanks,
Tom

>   		return PR_SPEC_NOT_AFFECTED;
>   }
>   
> 
