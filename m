Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665182C8073
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgK3I71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:59:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbgK3I70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:59:26 -0500
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E9302074A;
        Mon, 30 Nov 2020 08:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606726726;
        bh=PiMzl5bnuYdPj6Syuw2erWkfTDrkKeAjIdjuNj4J0bc=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=lNx2ZA5/+lvaHjLAmh8seGbJO7F4ZWNQ3YkvHNvhnxZQfXiKGFxCUF2l3tm3kY4/L
         q2AyTo0Cr8TTvlPaX3IGcV8sr66KU/KimKbsAT/o8j2bJgorvLIxl11iLvyWtVQ89Y
         nCH7X+k2cwQcjPu0DeTiQQJJ/2LdHy3a6tw0p2EI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201129135525.396671-1-maz@kernel.org>
References: <20201129135525.396671-1-maz@kernel.org>
From:   Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH] irqchip/alpine-msi: Fix freeing of interrupts on allocation error path
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>
Message-ID: <160672672303.3588.8640979209865178403@kwain.local>
Date:   Mon, 30 Nov 2020 09:58:43 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,

Quoting Marc Zyngier (2020-11-29 14:55:25)
> The alpine-msi driver has an interesting allocation error handling,
> where it frees the same interrupts repeatedly. Hilarity follows.

That's interesting indeed...

> This code is probably never executed, but let's fix it nonetheless.
>=20
> Fixes: e6b78f2c3e14 ("irqchip: Add the Alpine MSIX interrupt controller")
> Cc: Tsahee Zidenberg <tsahee@annapurnalabs.com>
> Cc: Antoine Tenart <atenart@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Antoine Tenart <atenart@kernel.org>

Thanks,
Antoine

> ---
>  drivers/irqchip/irq-alpine-msi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpin=
e-msi.c
> index 23a3b877f7f1..ede02dc2bcd0 100644
> --- a/drivers/irqchip/irq-alpine-msi.c
> +++ b/drivers/irqchip/irq-alpine-msi.c
> @@ -165,8 +165,7 @@ static int alpine_msix_middle_domain_alloc(struct irq=
_domain *domain,
>         return 0;
> =20
>  err_sgi:
> -       while (--i >=3D 0)
> -               irq_domain_free_irqs_parent(domain, virq, i);
> +       irq_domain_free_irqs_parent(domain, virq, i - 1);
>         alpine_msix_free_sgi(priv, sgi, nr_irqs);
>         return err;
>  }
> --=20
> 2.29.2
>=20
