Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17979303B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392163AbhAZLRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:17:04 -0500
Received: from 6.mo52.mail-out.ovh.net ([188.165.49.222]:51171 "EHLO
        6.mo52.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389737AbhAZIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:15:12 -0500
X-Greylist: delayed 1510 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jan 2021 03:15:11 EST
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.163])
        by mo52.mail-out.ovh.net (Postfix) with ESMTPS id 259872368DE;
        Tue, 26 Jan 2021 08:25:37 +0100 (CET)
Received: from kaod.org (37.59.142.100) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 26 Jan
 2021 08:25:37 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-100R0036943b526-2570-4cdc-a1d4-711e75c6cee5,
                    5D556FFD98B84F2EA34A7A8BED120B5F5B9D3368) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Subject: Re: [PATCH 3/5] powerpc/xive: remove unnecessary unmap_kernel_range
To:     Nicholas Piggin <npiggin@gmail.com>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        <linuxppc-dev@lists.ozlabs.org>
References: <20210126045404.2492588-1-npiggin@gmail.com>
 <20210126045404.2492588-4-npiggin@gmail.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <336902f4-58e6-0240-fe7a-ec06a45e118e@kaod.org>
Date:   Tue, 26 Jan 2021 08:25:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210126045404.2492588-4-npiggin@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 85cc3d89-2df3-4a71-b88c-7de071b97d5b
X-Ovh-Tracer-Id: 14119066310198463270
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdeggddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeekudeuudevleegudeugeekleffveeludejteffiedvledvgfekueefudehheefnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 5:54 AM, Nicholas Piggin wrote:
> iounmap will remove ptes.
> 
> Cc: "Cédric Le Goater" <clg@kaod.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Looks good. 

Acked-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C. 

> ---
>  arch/powerpc/sysdev/xive/common.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index 595310e056f4..d6c2069cc828 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -959,16 +959,12 @@ EXPORT_SYMBOL_GPL(is_xive_irq);
>  void xive_cleanup_irq_data(struct xive_irq_data *xd)
>  {
>  	if (xd->eoi_mmio) {
> -		unmap_kernel_range((unsigned long)xd->eoi_mmio,
> -				   1u << xd->esb_shift);
>  		iounmap(xd->eoi_mmio);
>  		if (xd->eoi_mmio == xd->trig_mmio)
>  			xd->trig_mmio = NULL;
>  		xd->eoi_mmio = NULL;
>  	}
>  	if (xd->trig_mmio) {
> -		unmap_kernel_range((unsigned long)xd->trig_mmio,
> -				   1u << xd->esb_shift);
>  		iounmap(xd->trig_mmio);
>  		xd->trig_mmio = NULL;
>  	}
> 

