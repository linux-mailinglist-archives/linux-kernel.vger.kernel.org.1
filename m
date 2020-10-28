Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E27129E06F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgJ1WEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:04:55 -0400
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:33089
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729467AbgJ1WA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:00:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNd1yMtEnZflyk7hcptmu6Cw+VIpdt66ceAHAaaPaB+XWVHHJ41HYHoDfr+a8KRKSZz7Z4wN7FD3FDbdMxzyy8+aZSB2ty0GIC0yMXUByoJ8wN2BicPn7D/bRZaj1NGaBm0FFnZ+gq5kA8uLqvvkKoxEu5jS/fZ5ZSbijrcoFWOSpnSd1KozbHoIRxk0MV0REC3w/W+ws8cKgouHZ3/AI9RX5+zNGmvvrLx1Xd+EaeIb7mDGbPE98rRmm+ZRnn33b8DBgz1hSm555bmmX0SjbbTftAd75Q40e+Q7vQgQRELRV5MpQe+uLgHB29+l8uq4S1qTXzpsWL2pHeL5yvQYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUcQjUzVNcHM6I4q+AWdi9x2didBB2wqe8pfwQvLHWg=;
 b=Q8sy5aj82DdTJUSKDLRZr88YVW+xIwkcroONVkeNGH8dH1cVEaZhpqv22J/0H9bJrjuLWiAaaFBeEpBuazViklOxUb6oBpqlBpphU+rxejves5jFqYuLkBX97S/xTyVR3NyX5f4yeCEt2S2AaPSWCWXbON823U6QicRDayu0FzF1kjHOAWjkRiMDFks8+TE2n5kELb9zLKGAFaEE5nQI2MrqQ9XVCGuWSUOHDVnnQQEGn0FrFYFgP7BnYcOSlpXJE8E5fIjTSIworf+xx+y+Jq8Je8wcza70aim91oiHFn1R19TbVYzFtsgq61Gu/0T/Xmcfay5di823QdDjaYWq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUcQjUzVNcHM6I4q+AWdi9x2didBB2wqe8pfwQvLHWg=;
 b=vOvjpFnJZuJVYpmF9yP/cB754wNUkMURbZ3gXGlm/RQzcdPwHiG18AJnMQoAKPH2aujVwLo07kiynYFkgTSqUYqN8RYoyn4rDUufPBYuBVzS2YM8XHXvzkVxJB7EzVMGMrV0mHMBtyOhKLYnf0ZWCP7fI4FjCcKzn/v+EhDqADg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB2826.namprd12.prod.outlook.com (2603:10b6:5:76::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Wed, 28 Oct 2020 17:29:37 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 17:29:37 +0000
Subject: Re: [PATCH v4 4/5] x86/head/64: Check SEV encryption before switching
 to kernel page-table
To:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org
Cc:     Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20201028164659.27002-1-joro@8bytes.org>
 <20201028164659.27002-5-joro@8bytes.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <19b93a95-eed2-c8f9-6f7f-f79fe7146c0c@amd.com>
Date:   Wed, 28 Oct 2020 12:29:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201028164659.27002-5-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM3PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:0:50::18) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by DM3PR03CA0008.namprd03.prod.outlook.com (2603:10b6:0:50::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 17:29:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf9c22d7-31b6-45af-108b-08d87b670b48
X-MS-TrafficTypeDiagnostic: DM6PR12MB2826:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2826EF88B2D5261B3F4579C3EC170@DM6PR12MB2826.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sgrqiW4lBG7GrFRBDJBXbR/7JB7w+ABZ9AxZjhiE7+exP3tk0+D4EN1gDlCrpokQrIcJ52Xpfxe+OAg5G3z3ssP5CbLuMgebQwr6/Bjs4FgC1/dTtgvRt7XpHR+s2ZWVNTV56q6h2hfEGCdZWXqcWtbCQ+NeLCuc6+Z0MS1WLLQEbhBN7NYIOIBuYhU5/P/Jg/eguwH9svhI4KR8rfGFP5y0Hw/BIOKlDl78zgNioXPHK63QAHdp/7Ics+h2wqnupzE6qXJOtIxoSFK1QcsWcTEo+gEBu1nd+tDvmjiQMdAPy0mtFrVC2RvgX2frkPnGAv3UdKtdUwKo0T9asmEP64LtqoAV1S+nSOjx5+DZZulECheNZc5XfrY/7iJr0Ql6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(52116002)(54906003)(8936002)(86362001)(478600001)(2906002)(8676002)(36756003)(7416002)(5660300002)(31696002)(66946007)(66476007)(66556008)(956004)(26005)(2616005)(6486002)(83380400001)(16526019)(186003)(31686004)(16576012)(316002)(4326008)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: DorlsIQTKUTwuKdkGXK8y1hUM9Bn71hqvp6RTMgUdbWGJGFRlf6Eto7MeNMPpWzBo+zooaJDHC558ZSVqdrG++K7sNVHd0wm/7AjfNocmAmFtfXBXxFS7NLJ5GnUbZTUJ8TkCE7QUOgqZ+wkCB1e2fFtj1hXCidlvZOpoCdupve5hn3oszEh6EA5dJ/f7mFAv0seUdzmdTCa5llu53uxwuoUOI0RjJuej0q1YuJpgkWLo3FVPHKCN182s3Hp6lX0qtPCM28gNprdBq0Z6+YGmU8n5C2UZ1bbZnVQrf5x7HhR30eb161wBeiIZl7svE+tSYjyXhXPoUDVNkDALThNMNzshZI2uHIBnwNoCnK86aXsV1bORcsP3eNzIKCNP1XUO2L7sr3aDuS/8XSlf4wgsiegxSxTSyprGMO+tttnGWB5p7XUYMgLznk8Uo4je/LFQ4p8KEyKEwEaLgRiYdHno4lqtaoZzp/R74zdy3kQivzu/FZc7YypECmD35FCiTr7wt1Blg2xWPYcWHa0xYNAOU20t5N+Ori4OWSLgw4jau+Ie42vvFv/50W2YrICPWF/XJKebk+msvX4NDLfFlM/1rHYG6nhuw1GcsPFq71kOr0L77Y4+34bRB34zkSNHrverjdqQLMKwYkrhP6hHiFjAQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9c22d7-31b6-45af-108b-08d87b670b48
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 17:29:37.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3Cd8KQkBvZirKk8zz6/b0skRdL7NEY1MNxSDPvTE4CVnvvMBKrL18993+i44o1l2O496IHePOnAuFDnOOqLlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2826
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 11:46 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> When SEV is enabled the kernel requests the C-Bit position again from
> the hypervisor to built its own page-table. Since the hypervisor is an

s/built/build/

> untrusted source the C-bit position needs to be verified before the
> kernel page-table is used.
> 
> Call the sev_verify_cbit() function before writing the CR3.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/kernel/head_64.S | 16 ++++++++++++++++
>  arch/x86/mm/mem_encrypt.c |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 7eb2a1c87969..3c417734790f 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -161,6 +161,21 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  
>  	/* Setup early boot stage 4-/5-level pagetables. */
>  	addq	phys_base(%rip), %rax
> +
> +	/*
> +	 * For SEV guests: Verify that the C-bit is correct. A malicious
> +	 * hypervisor could lie about the C-bit position to perform a ROP
> +	 * attack on the guest by writing to the unencrypted stack and wait for
> +	 * the next RET instruction.
> +	 * %rsi carries pointer to realmode data and is callee-clobbered. Save
> +	 * and restore it.
> +	 */
> +	pushq	%rsi
> +	movq	%rax, %rdi
> +	call	sev_verify_cbit
> +	popq	%rsi
> +
> +	/* Switch to new page-table */
>  	movq	%rax, %cr3
>  
>  	/* Ensure I am executing from virtual addresses */
> @@ -279,6 +294,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  SYM_CODE_END(secondary_startup_64)
>  
>  #include "verify_cpu.S"
> +#include "sev_verify_cbit.S"
>  
>  #ifdef CONFIG_HOTPLUG_CPU
>  /*
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index efbb3de472df..bc0833713be9 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -39,6 +39,7 @@
>   */
>  u64 sme_me_mask __section(".data") = 0;
>  u64 sev_status __section(".data") = 0;
> +u64 sev_check_data __section(".data") = 0;
>  EXPORT_SYMBOL(sme_me_mask);
>  DEFINE_STATIC_KEY_FALSE(sev_enable_key);
>  EXPORT_SYMBOL_GPL(sev_enable_key);
> 
