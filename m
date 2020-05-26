Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B91119FDEB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 21:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgDFTPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 15:15:32 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:34666
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbgDFTPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:15:32 -0400
X-IronPort-AV: E=Sophos;i="5.72,352,1580770800"; 
   d="scan'208";a="345152404"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 21:15:29 +0200
Date:   Mon, 6 Apr 2020 21:15:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Alex Dewar <alex.dewar@gmx.co.uk>
cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Coccinelle: zalloc_simple: Fix patch mode for
 dma_alloc_coherent()
In-Reply-To: <20200403173011.65511-1-alex.dewar@gmx.co.uk>
Message-ID: <alpine.DEB.2.21.2004062115000.10239@hadrien>
References: <20200403173011.65511-1-alex.dewar@gmx.co.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Apr 2020, Alex Dewar wrote:

> Commit dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()"), in
> removing dma_zalloc_coherent() treewide, inadvertently removed the patch
> rule for dma_alloc_coherent(), leaving Coccinelle unable to auto-generate
> patches for this case. Fix this.
>
> Fixes: dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()")
> CC: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>
> ---
>  scripts/coccinelle/api/alloc/zalloc-simple.cocci | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> index 26cda3f48f01..c53aab7fe096 100644
> --- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> +++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> @@ -70,6 +70,15 @@ statement S;
>  - x = (T)vmalloc(E1);
>  + x = (T)vzalloc(E1);
>  |
> +- x = dma_alloc_coherent(E2,E1,E3,E4);
> ++ x = dma_alloc_coherent(E2,E1,E3,E4);

Hi,

I don't understand the above case.  The before and after code seem to be
the same?

julia


> +|
> +- x = (T *)dma_alloc_coherent(E2,E1,E3,E4);
> ++ x = dma_alloc_coherent(E2,E1,E3,E4);
> +|
> +- x = (T)dma_alloc_coherent(E2,E1,E3,E4);
> ++ x = (T)dma_alloc_coherent(E2,E1,E3,E4);
> +|
>  - x = kmalloc_node(E1,E2,E3);
>  + x = kzalloc_node(E1,E2,E3);
>  |
> --
> 2.26.0
>
>
