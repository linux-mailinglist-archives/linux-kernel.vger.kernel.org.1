Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D379429D58F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgJ1WFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:05:09 -0400
Received: from mail-eopbgr750081.outbound.protection.outlook.com ([40.107.75.81]:52716
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729683AbgJ1WCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:02:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnIkYqmbtKPi5IVcWwEoxGnaFG304ycaeMlWmasxluQq34N3YNQncvsAt0yuboWuqfK7m4Gk6oPTOn2cq5O2j5grabH3evGbltc5/lQBIOFaHAA8/r7FpDLmwCKTFRjr4vJ2U0/LFAgQsDyRRPO08uczihJhCCU4TG63xgGyeMCGxji5JvcpUX2S9IRTX9E+aWyOpzfUxdwSOTvEnFX518vztPO1CcXw/EIDGmjmeD/gctoamyXFUMRcOOwx7kkd9CTcGRaJkgE4IfYXi+yGjb1Lkaic80HGgwq/CeaXTNxhOA/1pssk3BbVyKFIxye92k67Pbz0j1A7S1nJ6JJWiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IhiQKZGARypJboN/IcXQimHTwCc6ZzuAAgOhsX0Puc=;
 b=h2dEXFF1EYX3tMsW4tm/3p0YWRRgbwT0F9EPYAyz/6dC8amROOjbcjTgSlXhw63DviyC+gO+2jFjeh2S77GaJcR2if/WnILaeZCBAKVQwZA+qh1adk+/y41hSA02SPL4KScALk/ixo+VreM4g1yanYoP8hj5wdKbq6M/jBhV79ath/2d3QVFjyxudJVByfwji74yj56C4+GTbHXwxsaMOk/VvjYXWLu1ElWvA0GFArKI6KH6vNUdINlh1/z0sc5OW4J5s0v8mHKtqlrGQRy78y1vv2N3lNAmXnvjMrx0cS8HSNchM3Q6SanIzGaO1s697/Zin0u6ihe7B5MGE8nJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IhiQKZGARypJboN/IcXQimHTwCc6ZzuAAgOhsX0Puc=;
 b=A3uIS9kwx4DYSl5uf9BE5uLq4DaL/zfkysa5wrh0KMFzFQI62z303h7k0sqOsGpZCt2IQLSdmpRQ8QqUak4IR8Xjl+WSZX/3IT2w5RQCroydx2800ZqjXDbLTC86S+9qotsJUSJu/gYUv/ABLn4P/VvWUxHMuCd9oJlbpOQj6Ls=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB2826.namprd12.prod.outlook.com (2603:10b6:5:76::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Wed, 28 Oct 2020 17:31:49 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 17:31:49 +0000
Subject: Re: [PATCH v4 5/5] x86/sev-es: Do not support MMIO to/from encrypted
 memory
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
 <20201028164659.27002-6-joro@8bytes.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <a3be983c-a612-51c4-2711-de55c7c68c46@amd.com>
Date:   Wed, 28 Oct 2020 12:31:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201028164659.27002-6-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:3:12b::18) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by DM5PR04CA0032.namprd04.prod.outlook.com (2603:10b6:3:12b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 17:31:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f1b50ea-26e6-4dce-4f17-08d87b6759ea
X-MS-TrafficTypeDiagnostic: DM6PR12MB2826:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28265B6438A254FDDBAC24B5EC170@DM6PR12MB2826.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMBLPPEItyqirvRCLysiXETfzEVYHzjxXCYzkaotBJ8aoIyPKanSJRhQnscsu5QbNKuo3YafmljWMz4N6W6jHRcpTnZOhY8e9GUnHqqvP6ZuU9QIXygWTRpb56oKwWptn4KQOo99ehbAKTlYSHIBmOQ1JQmrS4sls/IthkhHchWB0l7FvV0qyJ0Ducvx6frqlGFcdKGvbaJiLQ189moMyM3k0DmUsAFXLWJWNyu8SQqXvk4vHxAdZqy5hf++FqSXopOseMu5ORQZ1/qYgoI7xgWxP/smwC2fZmW7n2VVo0j6ZQ46uCLp5JQy/kbcYpqSzLl3vfq5A7r59gEff2SRP0sGaFd+zXXBGOIsHWRc5UU4VMabHQl9SyB/U51rfXGm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(52116002)(54906003)(8936002)(86362001)(478600001)(2906002)(8676002)(36756003)(7416002)(5660300002)(31696002)(66946007)(66476007)(66556008)(956004)(26005)(2616005)(6486002)(83380400001)(16526019)(186003)(31686004)(16576012)(316002)(4326008)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TNtEn91hOrSPFeOupDSdkMECrYteFZoSM+gp6CwWOKxeiWjZBuEd2E9c73wqnRGBbp4Intr/NU0MPO9OhgmjuKIxlXDgZf3lsTI8ew+Hrk9TLg+YU4GSkmPHAc0YH/zchXVs9XIcv1FNHPkwhpZvWPsh9uUuwMdJihrsi/LfC9HYF+zIe67KlrDrd7OW3+VFQPOcxPLi5GGIS6UsytFoFyyvrUFngfUFAdN+mtI/5POmZMe974NGFAJjoi9zkGLqWw+adkSnB81c8HGiouNm4wEidQqTDSq7ArckJ9O2ylb7weNVrxtIdw3eyZ64jDP+UY5O/i6U80A4+LXM1QJiHaIz/wKaHRuCx5kYSJ1Lt04XGTgHwZ1lAfOnRhuwMSdVC3aXbSPUrHXS0VStyL36c5StWzvXiJLJ9K6p+1k7IL26glF9RTWf75VD3izyRpSdpO4ifX/jR352sKhULoJPUopBObQkG2+IOFp43e2Bwd6c1bxoflTBxGrbpPTBjbHwRBDqgtHxCtmq6AHnNS9x5ZGID24BpczL8beORJCl0GtsiOb1lxcsitu25KY8SuSf6lj7xpOqXz21SHQlJNnI7/fCF8FTUa206peJ44fzveOfM3cHXIZsF0PecDeXAcQREI16Oa8E310NEyonMRzNpw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1b50ea-26e6-4dce-4f17-08d87b6759ea
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 17:31:49.5050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzp6mcs9UXMi+kQVupsT26d304Ua063L1Y4ZVfs8G+AMN+khOZ5+Ghojnd/wnm7W+VLknPN/ilB0xGFj2QU3cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2826
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 11:46 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> MMIO memory is usually not mapped encrypted, so there is no reason to
> support emulated MMIO when it is mapped encrypted.
> 
> Prevent a possible hypervisor attack where a RAM page is mapped as
> an MMIO page in the nested page-table, so that any guest access to it
> will trigger a #VC exception and leak the data on that page to the
> hypervisor via the GHCB (like with valid MMIO). On the read side this
> attack would allow the HV to inject data into the guest.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/kernel/sev-es.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index 4a96726fbaf8..0bd1a0fc587e 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -374,8 +374,8 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
>  	return ES_EXCEPTION;
>  }
>  
> -static bool vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
> -				 unsigned long vaddr, phys_addr_t *paddr)
> +static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
> +					   unsigned long vaddr, phys_addr_t *paddr)
>  {
>  	unsigned long va = (unsigned long)vaddr;
>  	unsigned int level;
> @@ -394,15 +394,19 @@ static bool vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>  		if (user_mode(ctxt->regs))
>  			ctxt->fi.error_code |= X86_PF_USER;
>  
> -		return false;
> +		return ES_EXCEPTION;
>  	}
>  
> +	if (WARN_ON_ONCE(pte_val(*pte) & _PAGE_ENC))
> +		/* Emulated MMIO to/from encrypted memory not supported */
> +		return ES_UNSUPPORTED;
> +
>  	pa = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
>  	pa |= va & ~page_level_mask(level);
>  
>  	*paddr = pa;
>  
> -	return true;
> +	return ES_OK;
>  }
>  
>  /* Include code shared with pre-decompression boot stage */
> @@ -731,6 +735,7 @@ static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>  {
>  	u64 exit_code, exit_info_1, exit_info_2;
>  	unsigned long ghcb_pa = __pa(ghcb);
> +	enum es_result res;
>  	phys_addr_t paddr;
>  	void __user *ref;
>  
> @@ -740,11 +745,12 @@ static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>  
>  	exit_code = read ? SVM_VMGEXIT_MMIO_READ : SVM_VMGEXIT_MMIO_WRITE;
>  
> -	if (!vc_slow_virt_to_phys(ghcb, ctxt, (unsigned long)ref, &paddr)) {
> -		if (!read)
> +	res = vc_slow_virt_to_phys(ghcb, ctxt, (unsigned long)ref, &paddr);
> +	if (res != ES_OK) {
> +		if (res == ES_EXCEPTION && !read)
>  			ctxt->fi.error_code |= X86_PF_WRITE;
>  
> -		return ES_EXCEPTION;
> +		return res;
>  	}
>  
>  	exit_info_1 = paddr;
> 
