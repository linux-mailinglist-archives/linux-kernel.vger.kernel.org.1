Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6416429D3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgJ1VsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:48:15 -0400
Received: from mail-dm6nam10on2055.outbound.protection.outlook.com ([40.107.93.55]:29112
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726552AbgJ1VsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:48:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meBLf/MOO7Fq06CgEWsNQrfbL0OxHYN71p9IRC61LiCYludu2tmKA/o+hrtMPpxgomRX4KCRLODroEKOME+nf6YGFxSz8ImAIWTP3GObIjKMRs64WVM1E9GoPTr4agQF3qo/NrsBPs2uaECi9hw+keQyBBnf98HEOYtWtZDIdxgrXVFE6SfZQBD50CTrzKYsPifM14lBuZG2U6v2c7BAi4nUyDvi5JF+l4XCacKs6AWtY1hC/b8bCElMwu8ep1w7To2XeNuYHBStd+5LWUoeSpsDIaSDU+Ixjk+D96jNL1WhNpTtO74nOoZwd6TFgNjFRTQxaZEeKPXCyfWjVVZq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ac3jzR3+wA5cnJvIeiLVILT0F28PnAmKIB1OzebofHA=;
 b=L1exvGbFBExvFZ0UbPiz8q9cX0qpB1POuN7iAdIFVzniPT34OsLsi8GsOAuDhy+M/3YdA/3zTW168/F2QVBrLPyc1vGykjnrMNlGQmyEPQTT13LAdyDDmuKg36gE5dyDzN/NTteofbXeDAWin4rdPmk2J1jXawSh9sGRLuzjOGkqgdroy0sy1JjwCy+vIKLOVwgdxipuQyqV3/5W0UFfQjrzsk2/Qa6Y1ODN9EMcp/ru8OWcWioDSk3qrQ80BjyEg9wLw+KNth7datF69gG5aPARSciAzC28ZEldJdCGK8k4Kf/QMK0yw/udJNFI99L0YLyZmvfXZy9IuU5UQPKU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ac3jzR3+wA5cnJvIeiLVILT0F28PnAmKIB1OzebofHA=;
 b=KlQRKk8zblyWlrDyIEZMHiYxGlRuHxOrclLrALVOoGVRIiRutt2hz5bfsc4dkAcnmvJciBFf2lrcsE1+n25en3IiYEg+yh+5bj1Qp2SpRKvXv6dKliHHqIRKOSprNaC8gbNP339bz3CDZvJA03oiKR8cHGhzGKraCzO7cMGT+pc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Wed, 28 Oct 2020 17:14:01 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 17:14:01 +0000
Subject: Re: [PATCH v4 1/5] x86/boot/compressed/64: Introduce sev_status
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
 <20201028164659.27002-2-joro@8bytes.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <56004d19-d0f4-b98f-11b6-dc50b5d8b462@amd.com>
Date:   Wed, 28 Oct 2020 12:14:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201028164659.27002-2-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM3PR12CA0046.namprd12.prod.outlook.com
 (2603:10b6:0:56::14) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by DM3PR12CA0046.namprd12.prod.outlook.com (2603:10b6:0:56::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.22 via Frontend Transport; Wed, 28 Oct 2020 17:14:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 53e9dab7-30e1-49d9-7b3b-08d87b64dd4a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4516:
X-Microsoft-Antispam-PRVS: <DM6PR12MB45160922EE690AB40F9324CAEC170@DM6PR12MB4516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1dDkqCk9nhnO1lnta5a8Ry1UQ4W0/23LwbMtrdI56eZ0E8CpF2WWXYef3tNdhQABu5YS6RhsJq8FjmgoGuHl45svq97CSO9/1APxWlFBdjNLHyVXf8iBQlTXWkSm0NA2G7VYOxsF8rzXDls4Dhts8xSQrEwr764im8zRfzo+U1cHza4kdalVGVJJTG7g+cg7EAwI67y63AgqOISF1WMcPvTQ9uwInwH3b7Ul0Sryo2axYBj8o57X6ap2yElx/c3f/kGqnTOtUuzsKROUnNv5ipyBscNdCaztbOQOZyABgiHGIWwBF+Rwv1XWdNfKuGoOgPjzrtHAlmIoBTqDLodF1ADCQEpXoN3uqcNLC9na2gmcOP89k91RlB2y9KZkUmB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(16576012)(54906003)(316002)(53546011)(66946007)(6486002)(86362001)(31686004)(36756003)(26005)(2616005)(8676002)(956004)(7416002)(186003)(16526019)(8936002)(4326008)(31696002)(2906002)(66556008)(52116002)(478600001)(66476007)(83380400001)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jicuNbMXyuO0r9R6clW8hMLt5GrfefJWJCFToUka4a8A9vlZTFioqWyEFTBRcalFGGdMP3EXwSnGEerqOQqs+En5EiO2ov77niZshVsfzzQzqlGwa3tXAgtO+bE7vWOAPVFDKmTxNa3WfSJV9qCon3Hd9Z0YJgK5lnuTlrZn/M/5uZVnZ0pkObkAaSq0MMOnoVFzW13ShSPA199FjejB1ZyvXzruPLBJKiJSoomtOqhdwrZamwbg2dpVlRBPw5SPclQMyrvNkZX7fxJkBubAkSfO1Z9iwlsZXGWGY+v9x9mnN8zd3uN0qEFEiMqZGwnEkf6GRr7LXVAnadg5eYA3sPbSJDhY4DYPJRcaFMTFNKHrpYarYxBhw3E0zovk3cSnee+TKwKxMvXCR8U6MecyK+C5sdvzefx0FCSyJ20uJtYXzN2qVvuCfBsAz4PtMegiio6SJhOcaQXxM8UQl01RPLblgofeCb/oMHyRHswtF2glPmUQXLErzric9PEZ2FvBmJwLugz48IPn6xAY3E/K0v3N0UyYDeoLEU7vcyTrm1OxR1skBfE9h4WQO3QnY7fd4+AEsF9pwo3lZJ1kp8pkMLLqJVltAwtIaFeGUNehSVqJvK5NY+JUcdBD6nLdO5KPLI/3jSCZ+TGRfo1bSyLDzg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e9dab7-30e1-49d9-7b3b-08d87b64dd4a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 17:14:01.4946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJMhwht+7pMjDaks3zKLN2OWPLVNmvJcUrX2Z/H+Mem/nP7bkULvWMXA+CP8JDSCy/yL+dV2hty4cTAwrj2djg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 11:46 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Introduce sev_status and initialize it together with sme_me_mask to have
> an indicator which SEV features are enabled.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/boot/compressed/mem_encrypt.S | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
> index dd07e7b41b11..0bae1ca658d9 100644
> --- a/arch/x86/boot/compressed/mem_encrypt.S
> +++ b/arch/x86/boot/compressed/mem_encrypt.S
> @@ -81,6 +81,19 @@ SYM_FUNC_START(set_sev_encryption_mask)
>  
>  	bts	%rax, sme_me_mask(%rip)	/* Create the encryption mask */
>  
> +	/*
> +	 * Read MSR_AMD64_SEV again and store it to sev_status. Can't do this in
> +	 * get_sev_encryption_bit() because this function is 32 bit code and
> +	 * shared between 64 bit and 32 bit boot path.
> +	 */
> +	movl	$MSR_AMD64_SEV, %ecx	/* Read the SEV MSR */
> +	rdmsr
> +
> +	/* Store MSR value in sev_status */
> +	shlq	$32, %rdx
> +	orq	%rdx, %rax
> +	movq	%rax, sev_status(%rip)
> +
>  .Lno_sev_mask:
>  	movq	%rbp, %rsp		/* Restore original stack pointer */
>  
> @@ -96,5 +109,6 @@ SYM_FUNC_END(set_sev_encryption_mask)
>  
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  	.balign	8
> -SYM_DATA(sme_me_mask, .quad 0)
> +SYM_DATA(sme_me_mask,		.quad 0)
> +SYM_DATA(sev_status,		.quad 0)
>  #endif
> 
