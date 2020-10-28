Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFD929D539
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgJ1V7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:59:25 -0400
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com ([40.107.243.67]:35171
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727931AbgJ1V7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:59:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dENXkjBbYfrKztDTd0YIgTk7ILSqn7Y4scvn2DwXRR46qFyDSGJr2khsZWzoBGxsrnNGilxh2HA3/HFJve/v5IE6qJU+8jMyeqAHHyoe1EfrMl4dCHUJtMjEB/8Ep2GkCu6JoWCc/UwhOgZbhETLEjzlNO5LVEOLEJ23t/gxPDhz0F7SDz58SjexB7EvuUTBI+0x1BR+azfP1kW5ednmkUFC6D8bHRmZZ5Zv83fFwB2SKKuifsuAbe3HsRb9xVbNCzvj3MkmUIuvq+pHGDnwTcjUp6ihXn6BydUl4ZGnJQLXltDngV2B49i+CT4ndG/BK/54NdomvcEF5rt7sb0sUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjbqgBRBFB9haNxNVmPm2c/592+CngYyhLx7dbdQVFo=;
 b=bYjTDg641Ju1iJIik/XiRilZcXVQCM7vq1biX3+27TC+oyIo7XI2FziIYYtB/7QB+/vzC7dTD72RAiFdq9W2Lf+bOthMG7m4ALbtMmBwMmLH2/Ue0qMtLgRQ1Kj3IzEJC7w/8JETSgcbzNonwOwbiyZG+k2HzOJaDdJBxmjoaIJsv6UK2+GiMnQBL5qZLiPQnI6n+qY2jzxTxvs139W3atqB6tx2yTFs10HH720xz/gO1e0WDC8HaFeNLzdtJWNVdFWTmh02Oncs5PDB4SL58sjfFjT0MIuN2p7ocerf8DKzHGZnCaOJr7Ba9iTJssqgWEzvcPCHKk+n/oIWW01aWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjbqgBRBFB9haNxNVmPm2c/592+CngYyhLx7dbdQVFo=;
 b=NVlhCzaDyQH6ox2B0Rf1mTZ//2E4rwLWsfgFbZWepxJpYmSwJkSCvoxd5yFpH7eVF0r3vkevVcau/+MZuhWExJQMcpZBynremPvez6FN/xW71iWvQ8b3H80RhO0y7fB6WIwEC9jehX9RGsexA5PrIm/keYXbSdvZy3FlqdMQJ/0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB2826.namprd12.prod.outlook.com (2603:10b6:5:76::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Wed, 28 Oct 2020 17:25:20 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 17:25:20 +0000
Subject: Re: [PATCH v4 3/5] x86/boot/compressed/64: Check SEV encryption in
 64-bit boot-path
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
 <20201028164659.27002-4-joro@8bytes.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <a10053a4-be13-a593-2645-47f1723be1f2@amd.com>
Date:   Wed, 28 Oct 2020 12:25:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201028164659.27002-4-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR17CA0062.namprd17.prod.outlook.com
 (2603:10b6:3:13f::24) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by DM5PR17CA0062.namprd17.prod.outlook.com (2603:10b6:3:13f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 28 Oct 2020 17:25:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90191716-1997-484a-6c49-08d87b6671f1
X-MS-TrafficTypeDiagnostic: DM6PR12MB2826:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2826AB935FB4CE2069001F35EC170@DM6PR12MB2826.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TuIeYjkIRZXiGHe0a403/ADgGx20rmA+tFqLkAl5vNnH0Bh6d//G+grbpxf0lcfTShZAVFd6fFDvJip3DqwwyDaLU7boJBE6bVKx3XqTfKSHOwON3dW9wKeMPWkOyvgB/aMwYWAS3AD0Ow+zy5jA7tlhyb32mh8MqqttLsW5BAQW2mvabtZzEoWsnfZ0FlAQPqZgyvzM/bHjMZU8KVuriX6kZ94aYtzw9dkt77IDNSZcAU3nLndT7HfGfGWCIHiXuj9njwrjSN5m6513bKDDnBgXEPKCbsClSbZ8u1GZOVGqSixtpKKMJTuR+3vbWi8fdTTxHg1w+Vm7luYHUJ71xbvbw/FahZolvN9WcdXFJsh0y0wTTUf9k1+hiEQlMBF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(6486002)(83380400001)(956004)(2616005)(26005)(16576012)(316002)(4326008)(31686004)(53546011)(16526019)(186003)(8676002)(2906002)(86362001)(478600001)(52116002)(54906003)(8936002)(66476007)(66556008)(66946007)(31696002)(36756003)(7416002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Bfj4AFdC72+aQsQwdVGoTIgWWwunQ8f4JMPjVTlGMRKR0PzXwmQD2sTPp42wI5LHIkfmy89uYyo69LL1BRThgO58WwS4ezMa8KmUC2lr8jAoQaWX2FsQSuEXT7djnCRaq51p8DL4tTauoBeYhMmbhD+Q9qI6QmOOZhNCJaEP+pxd3zGw7lhWMPctr4LlRllTbxocI9E/hizG+2iVxZNZWMAxZyN3EWMtFdcg2R9aXd/B2bN29pGnjA17nh9kPW74LVY1V1JhQZV8oU6tYy3jqUJ7teb5zs2IJ2aiqvBInK3pk6bUL8MxyLbRol/FbycMeO7ThifGD2qjx6cwnPCjdAQi2YD+RtXxKO5zJb+U4QxafWVT2D2o5muUZyW8ZFnj53+pvjZJ7HMK74pZ56wV776pwu6BEQzHVrpcDWnZIlvKYRJTzQScMwtOdsSaaUePRxq1ESUnmgHALUFKmUw5rB73wwkLrPRpQSPuB8oBrdmAzDsvVwXIpxjTUaJICAi/K/XpTOZ6oo1ASzo+AaI5y8VqAP7mTCZhyexznHctxqy1sMZVLS3OUvEWTxtRBXjjB77hM/yvCL3Y+WG6LTbHviegcLwUTbqAS0d/dLddkKifrPDpI1NQhfVv+oGA4a1YNIzcetqhPBZKOHdi3bBBRg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90191716-1997-484a-6c49-08d87b6671f1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 17:25:20.3192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LeRPyjVMM1a5XOzuucmY09CZtcSdOAg0FRWBYOm9aMSXzsyq4bSEZrwWo7Nu2sNyVpWJLTlGCKyILYg4U0HLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2826
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 11:46 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Check whether the hypervisor reported the correct C-bit when running as
> an SEV guest. Using a wrong C-bit position could be used to leak
> sensitive data from the guest to the hypervisor.
> 
> The check function is in arch/x86/kernel/sev_verify_cbit.S so that it
> can be re-used in the running kernel image.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Just one minor comment below, otherwise:

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/boot/compressed/ident_map_64.c |  1 +
>  arch/x86/boot/compressed/mem_encrypt.S  |  4 ++
>  arch/x86/boot/compressed/misc.h         |  2 +
>  arch/x86/kernel/sev_verify_cbit.S       | 90 +++++++++++++++++++++++++
>  4 files changed, 97 insertions(+)
>  create mode 100644 arch/x86/kernel/sev_verify_cbit.S
> 
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index a5e5db6ada3c..39b2eded7bc2 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -164,6 +164,7 @@ void initialize_identity_maps(void *rmode)
>  	add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
>  
>  	/* Load the new page-table. */
> +	sev_verify_cbit(top_level_pgt);
>  	write_cr3(top_level_pgt);
>  }
>  
> diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
> index 0bae1ca658d9..3275dbab085d 100644
> --- a/arch/x86/boot/compressed/mem_encrypt.S
> +++ b/arch/x86/boot/compressed/mem_encrypt.S
> @@ -68,6 +68,9 @@ SYM_FUNC_START(get_sev_encryption_bit)
>  SYM_FUNC_END(get_sev_encryption_bit)
>  
>  	.code64
> +
> +#include "../../kernel/sev_verify_cbit.S"
> +
>  SYM_FUNC_START(set_sev_encryption_mask)
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  	push	%rbp
> @@ -111,4 +114,5 @@ SYM_FUNC_END(set_sev_encryption_mask)
>  	.balign	8
>  SYM_DATA(sme_me_mask,		.quad 0)
>  SYM_DATA(sev_status,		.quad 0)
> +SYM_DATA(sev_check_data,	.quad 0)
>  #endif
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 6d31f1b4c4d1..d9a631c5973c 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -159,4 +159,6 @@ void boot_page_fault(void);
>  void boot_stage1_vc(void);
>  void boot_stage2_vc(void);
>  
> +unsigned long sev_verify_cbit(unsigned long cr3);
> +
>  #endif /* BOOT_COMPRESSED_MISC_H */
> diff --git a/arch/x86/kernel/sev_verify_cbit.S b/arch/x86/kernel/sev_verify_cbit.S
> new file mode 100644
> index 000000000000..b96f0573f8af
> --- /dev/null
> +++ b/arch/x86/kernel/sev_verify_cbit.S
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + *	sev_verify_cbit.S - Code for verification of the C-bit position reported
> + *			    by the Hypervisor when running with SEV enabled.
> + *
> + *	Copyright (c) 2020  Joerg Roedel (jroedel@suse.de)
> + *
> + * Implements sev_verify_cbit() which is called before switching to a new
> + * long-mode page-table at boot.
> + *
> + * It verifies that the C-bit position is correct by writing a random value to
> + * an encrypted memory location while on the current page-table. Then it
> + * switches to the new page-table to verify the memory content is still the
> + * same. After that it switches back to the current page-table and when the
> + * check succeeded it returns. If the check failed the code invalidates the
> + * stack pointer and goes into a hlt loop. The stack-pointer is invalidated to
> + * make sure no interrupt or exception can get the CPU out of the hlt loop.
> + *
> + * New page-table pointer is expected in %rdi (first parameter)
> + *
> + */
> +SYM_FUNC_START(sev_verify_cbit)
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/* First check if a C-bit was detected */
> +	movq	sme_me_mask(%rip), %rsi
> +	testq	%rsi, %rsi
> +	jz	3f
> +
> +	/* sme_me_mask != 0 could mean SME or SEV - Check also for SEV */
> +	movq	sev_status(%rip), %rsi
> +	testq	%rsi, %rsi
> +	jz	3f
> +
> +	/* Save CR4 in %rsi */
> +	movq	%cr4, %rsi
> +
> +	/* Disable Global Pages */
> +	movq	%rsi, %rdx
> +	andq	$(~X86_CR4_PGE), %rdx
> +	movq	%rdx, %cr4
> +
> +	/*
> +	 * Verified that running under SEV - now get a random value using
> +	 * RDRAND. This instruction is mandatory when running as an SEV guest.
> +	 *
> +	 * Don't bail out of the loop if RDRAND returns errors. It is better to
> +	 * prevent forward progress than to work with a non-random value here.
> +	 */
> +1:	rdrand	%rdx
> +	jnc	1b
> +
> +	/* Store value to memory and keep it in %r10 */

This should say "keep it in %rdx"

> +	movq	%rdx, sev_check_data(%rip)
> +
> +	/* Backup current %cr3 value to restore it later */
> +	movq	%cr3, %rcx
> +
> +	/* Switch to new %cr3 - This might unmap the stack */
> +	movq	%rdi, %cr3
> +
> +	/*
> +	 * Compare value in %rdx with memory location - If C-Bit is incorrect
> +	 * this would read the encrypted data and make the check fail.
> +	 */
> +	cmpq	%rdx, sev_check_data(%rip)
> +
> +	/* Restore old %cr3 */
> +	movq	%rcx, %cr3
> +
> +	/* Restore previous CR4 */
> +	movq	%rsi, %cr4
> +
> +	/* Check CMPQ result */
> +	je	3f
> +
> +	/*
> +	 * The check failed - Prevent any forward progress to prevent ROP
> +	 * attacks, invalidate the stack and go into a hlt loop.
> +	 */
> +	xorq	%rsp, %rsp
> +	subq	$0x1000, %rsp
> +2:	hlt
> +	jmp 2b
> +3:
> +#endif
> +	/* Return page-table pointer */
> +	movq	%rdi, %rax
> +	ret
> +SYM_FUNC_END(sev_verify_cbit)
> +
> 
