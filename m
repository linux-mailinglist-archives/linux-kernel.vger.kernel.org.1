Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C732D28F49D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgJOOXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgJOOXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:23:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD2EC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:23:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602771795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqPI3gET3ZxGMVbMkxI5H2daoNN2gBwrBpkoA5B72J8=;
        b=mt9OVvN6tt4EPkd0YU8S/7bHnYV3jPpzmCXzZ6yZNCEzNYeeNiY/5VdYWZdCEc5F1mSU2u
        tBioNTwt3su5cdikmbB3z9dWSqMUJgfJ1/ldhh9hLdChGcyqIX488GhrNudSaf4tMx12Bc
        OhERCNGuGBe4fkDXaAv3ysqG/rEQdNJcUDdyygBVHEp9CUwS3OHzQZP15vPYugRR4kG/sc
        Q+GhzHTGaDm+7szluXCoiCIFNRdf1SlXc99fZTNX0gto+mKED8uHHG8KkDBVvioDRy54wK
        2X91KuZ7zgndBSxu3kyl4V2PBRN50gdrsYWwa3ha71wUg61Y1iGva/Z2NuCsPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602771795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqPI3gET3ZxGMVbMkxI5H2daoNN2gBwrBpkoA5B72J8=;
        b=pnFtO/33nXp9v14zJGXo8x6Vn/6UlJKkqwj6n9Zu4OZvxkbfK/gHKpiHCQvcdITfNSiAkO
        tp5uKlimGQPi6uAg==
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>
Subject: Re: 5.10-rc0: build error in ipi.c
In-Reply-To: <20201015101222.GA32747@amd>
References: <20201015101222.GA32747@amd>
Date:   Thu, 15 Oct 2020 16:23:15 +0200
Message-ID: <87imbba7qk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15 2020 at 12:12, Pavel Machek wrote:

Cc+ Marc

> I'm getting build problems in 5.10-rc0 in config for n900. ARM board.
>
> CONFIG_SMP=3Dy
> CONFIG_SMP_ON_UP=3Dy
>
>
>   CC      net/devres.o
>   kernel/irq/ipi.c: In function =E2=80=98irq_reserve_ipi=E2=80=99:
>   kernel/irq/ipi.c:84:9: error: implicit declaration of function
>   =E2=80=98__irq_domain_alloc_irqs=E2=80=99; did you mean =E2=80=98irq_do=
main_alloc_irqs=E2=80=99?
>   [-Werror=3Dimplicit-function-declaration]
>     virq =3D __irq_domain_alloc_irqs(domain, virq, nr_irqs,
>   NUMA_NO_NODE,
>            ^~~~~~~~~~~~~~~~~~~~~~~
> 	            irq_domain_alloc_irqs
> 		    cc1: some warnings being treated as errors
> 		    make[2]: *** [scripts/Makefile.build:283:
>   kernel/irq/ipi.o] Error 1

That probably comes from the ipi as irq rework for arm/arm64.

Thanks,

        tglx
