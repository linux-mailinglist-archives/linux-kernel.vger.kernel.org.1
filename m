Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE5329D431
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgJ1VuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:50:18 -0400
Received: from mail-eopbgr760047.outbound.protection.outlook.com ([40.107.76.47]:61804
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728000AbgJ1VuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:50:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDnxUrlnHd90kHmAGPu7Bku+5OkffA7+gClEj9cEJwUipSRjwRANzPxaUWFuE/rllnrossSNe3VJ43Fh1guzZBFGDl8CeiJZX3haFntwPFyCDbekoyiLdwhRFmSP6lHOmM8ovhrIpTODZrZkaFxhvXagnQlYMChFPtC6ayZrMlc6AlB8pEoyT/6fW3sz5Fqxe5l7XSoeXZopKpikw4aLa2uRURA0mkAZ4aIJu8nCIqgkBUOYXwl2+G53Un/yRSwFyR73Bc4rE57Rwd8ieNHdOlwG6VQ7QoM4WMU3qftF4xapMC4Jel7VXsuNELDp3w+Yl6hrMzj7Qp5uDJUafFEH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cY17osM388VkhzBnkrMyAAuM1OSsFlVUEJzQSRDtns=;
 b=C/1WAyUZbTNuTa81olN7RfsHAi8CpAAMsq/NNTLoNoeqtKuMad02dXH24CBIJlJyA5Whbx4Y1drrYKWbd31qu6XDDcpLp+QFSv7YEUvk+kYLUsp9x1zfdMv1uoIo7jYT7C56LLNHVFDSAb2BFv1s8BTsL7KatE6vDuw8AR8QxBnHCg5sr6Nyx5sIs9vhgNsU9CW/XPKgZ51aXY5sQslLVeEMMXeMyF4SanEoEInnpxZg1Tz2+RwEa+qawO2fLKTb8fiJkPrGW3ptLr0Bl1U3bJR+R9kSPk5nHFdE8hFUYQbrKsfuo09Pf0lmjUuwU+d6qIQ+iRc109iT7oWEsEUdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cY17osM388VkhzBnkrMyAAuM1OSsFlVUEJzQSRDtns=;
 b=U5u0CZCj6LtXLszfrFO2CG4VubE2EwahQQchVXwjz3x7F9sjPWrFi+C7Wiyh/GBjXFIKzMYDnCoqp36NxaZPk6iz9/Xc7tlQhwtiLnG768YjybguMp+K/Q3uYb45oBxy9P0Kn6kpNkyC/K9QiOtQjmoN6zMGl5eEitZH4Ka3d1o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Wed, 28 Oct 2020 17:15:29 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 17:15:28 +0000
Subject: Re: [PATCH v4 2/5] x86/boot/compressed/64: Add CPUID sanity check to
 early #VC handler
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
 <20201028164659.27002-3-joro@8bytes.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <ca27f626-2a9e-09e6-a2aa-a4acbc51929c@amd.com>
Date:   Wed, 28 Oct 2020 12:15:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201028164659.27002-3-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM3PR12CA0047.namprd12.prod.outlook.com
 (2603:10b6:0:56::15) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by DM3PR12CA0047.namprd12.prod.outlook.com (2603:10b6:0:56::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 17:15:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 831ecad5-0caf-4d0b-8517-08d87b65116a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4516:
X-Microsoft-Antispam-PRVS: <DM6PR12MB45168AA88331A210E5B40052EC170@DM6PR12MB4516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvmNiS0c83fggMN3Xw41XiUF00NABkwAUEDDkfPnOv08a1b6hG+gR2PAer1jIsSu5+LCATD1xDtmzFBi4gtKAoyBBabhp0RwTO3MYzx7povzDa/27QnKVNEnjSd954bu7UKk5BdjnJ7ILLTa7V39I5blQtJD2kppg1tfnFDjHcBQmiMywHa1ddJK0NsAJ4cW2tGkdUhphrRe7Os+bFmlUmoa7zBYyNcSFO6aqx4UMlnOjKD7URARsIqwDP9Yh9Q7KUnJDfrtUPbq+mimiWvDlWItQ3jp3HE9Bmh5KkZGE+oOVFPCxs83rhPcbMHnK4R7INBrxjh/yGvpAAfgL1GunNCzCAzNsUFwPUhHhMLXYM4CWhWypbPIBm7ZNK9z27fM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(16576012)(54906003)(316002)(53546011)(66946007)(6486002)(86362001)(31686004)(36756003)(26005)(2616005)(8676002)(956004)(7416002)(186003)(16526019)(8936002)(4326008)(31696002)(2906002)(66556008)(52116002)(478600001)(66476007)(83380400001)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1bSAHIgUMl4QRNyN3AG5ZUjmR++eyw5LH0BY+HCR52a4zOCTamkbUH2XU63s19MYkonyFTG8MsUkuI4XLsPe4xyU9IoQzYBXMRT2dk7r5WtnFu28tu52n+A/Inh78PjaxAsap0FLb59af6zADcUDZfDn53DPiWylTx2KK9MVqeHH3CDriKRe4HOLNeT8VWvGEVDVwKuNXHyWMBRbW5H+oOGYG0F8pzGVEvGRmF+RkD3W9yJrhAVZ+rCj23vlzWEAztNNi0CXBYCdyaGKlXK+NtfbqbqeJVaD1LYLFtCYjUBBs3wt03klnv0uxndq5Et2pa6A9YjB7ZSF9P0bE4qbS2igCZ+LkR50Y7exeqrr7g3MSw480nk6Xwvct5cF/4J5rkMCUSs7MXdd5OzKX3ON7v+pgCbHoHAu5Tx4g75/EQSmZkCFi/X8AjtP/MWXjGJ5UuxeFv+4sqr723Vyx0eeB3vgBIvXXYmYrbVr2pOTlASoJDb2f+aWdNg8Fs6pBw0BEALM5ZlS6YpvrptQ6Yu0KSPfO6EadVt7E7Lm/J5TzEZ1gLCtG/8w1GnflCFBYdH3jZwhZlifRQ2noqT8rpqekF6XdkQDprZFSNORWHQExk81hYZKTlLIkXZImB/MDvxHSNIbEelkjYoViVfGkTiVJg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831ecad5-0caf-4d0b-8517-08d87b65116a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 17:15:28.8551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MYLUT2recq7gru+fEuYqXV5kr0boBSqt/17J795qDsL/8FtIkRTFpQc2cKvzc/j6refhJ/poR4aiJ8SeMFgsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 11:46 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The early #VC handler which doesn't have a GHCB can only handle CPUID
> exit codes. It is needed by the early boot code to handle #VC
> exceptions raised in verify_cpu() and to get the position of the C
> bit.
> 
> But the CPUID information comes from the hypervisor, which is untrusted
> and might return results which trick the guest into the no-SEV boot path
> with no C bit set in the page-tables. All data written to memory would
> then be unencrypted and could leak sensitive data to the hypervisor.
> 
> Add sanity checks to the early #VC handlers to make sure the hypervisor
> can not pretend that SEV is disabled.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/kernel/sev-es-shared.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
> index 5f83ccaab877..56d16c405b03 100644
> --- a/arch/x86/kernel/sev-es-shared.c
> +++ b/arch/x86/kernel/sev-es-shared.c
> @@ -178,6 +178,32 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>  		goto fail;
>  	regs->dx = val >> 32;
>  
> +	/*
> +	 * This is a VC handler and the #VC is only raised when SEV-ES is
> +	 * active, which means SEV must be active too. Do sanity checks on the
> +	 * CPUID results to make sure the hypervisor does not trick the kernel
> +	 * into the no-sev path. This could map sensitive data unencrypted and
> +	 * make it accessible to the hypervisor.
> +	 *
> +	 * In particular, check for:
> +	 *	- Hypervisor CPUID bit
> +	 *	- Availability of CPUID leaf 0x8000001f
> +	 *	- SEV CPUID bit.
> +	 *
> +	 * The hypervisor might still report the wrong C-bit position, but this
> +	 * can't be checked here.
> +	 */
> +
> +	if ((fn == 1 && !(regs->cx & BIT(31))))
> +		/* Hypervisor bit */
> +		goto fail;
> +	else if (fn == 0x80000000 && (regs->ax < 0x8000001f))
> +		/* SEV Leaf check */
> +		goto fail;
> +	else if ((fn == 0x8000001f && !(regs->ax & BIT(1))))
> +		/* SEV Bit */
> +		goto fail;
> +
>  	/* Skip over the CPUID two-byte opcode */
>  	regs->ip += 2;
>  
> 
