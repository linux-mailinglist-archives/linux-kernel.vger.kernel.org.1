Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A4928A3B1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390112AbgJJW4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbgJJTe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:34:28 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795C3C05BD28
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 08:13:11 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id de3so6290465qvb.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lWT2SsVQSkhdJyfkAWZyX8rdrMN1tcpW6dkwA0/22aY=;
        b=mi0A/UJElRKcu8tnBoIW+XFAtoXQrRjhtDeZfR7OQYizIhW8ln5R6MObl8lBq9aRJQ
         zB1iROhYbuzmgdLaMwPN0Zwocpq6NRZdHlwOzHQK1jXlWPy3BCe2L8JVZp8Vtn+ZRoJy
         N3N2TDRwXq8k+Hwi8VZ0Su8tWv+k8wDQlBXeWrbB10pzdmikRFHnSHFJV67/8knrsdtJ
         IkNPGKlqmJSDyfY5JsdCsDLo0OG8DfqOeE5a2+odEeoo1s/W02qVuLRMInpJBWTEkyQA
         qPoCeUYBuu4jvm6T+DX5qPnBg28cZcCA5X/WLqEGIO8MLZqRaO8WXCBNrrzTe7r3Je8U
         to1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lWT2SsVQSkhdJyfkAWZyX8rdrMN1tcpW6dkwA0/22aY=;
        b=ettg/rqAzViBqmOOcvRpdWE0xBmEy+Zko7fdBv4bb1XMt8GQf1F9dSDZo2MOikn4pM
         uxu+c/GBW03rF4Yp8bXoVi2x8Of9S78UvgjrJ5mvZXi5mAeu5rU3ybkzHRfc0qcXVONE
         EKgClmWq7IzoEyW2cFvowMxgaOvTK2CgzkFfwAEDTEOUsSjV5Zb1WsNaRR/PCU0CmzPb
         XnYQt6pzNGKJi+hczaBj8S0y3TXEjJl1cpE2I40iywEN9zkgdvHrxZXAacd0E83LVq8H
         VBmwzlBxPk9nrs9q9hMO5jLTDUpi6GIp4ke5jXx6gUUAifTRIjdmx8KL/AX6FW7NFaRF
         T6YQ==
X-Gm-Message-State: AOAM530BoaNaSZ6y5ZxZbRyvpqfLKyYt9edFb9TvCo7v6bnrB3LtVCEl
        bLomM1CEKeQ1uvebW4oElg==
X-Google-Smtp-Source: ABdhPJygoiafgSWlYFFEBhUARW9eM/Lxs15jEjz8nDjU+zjPhzZ3/rZjGb1YtwjUjhhu8NJAw/kL2w==
X-Received: by 2002:a0c:eac3:: with SMTP id y3mr18472356qvp.57.1602342790619;
        Sat, 10 Oct 2020 08:13:10 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id p3sm8397082qkj.113.2020.10.10.08.13.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Oct 2020 08:13:09 -0700 (PDT)
Date:   Sat, 10 Oct 2020 11:13:07 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, daniel.thompson@linaro.org,
        jason@lakedaemon.net, kgdb-bugreport@lists.sourceforge.net,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jason.wessel@windriver.com,
        tglx@linutronix.de, julien.thierry.kdev@gmail.com
Subject: Re: [PATCH v4 1/5] arm64: Add framework to turn IPI as NMI
Message-ID: <20201010151307.vq74if4mndjn4nhm@gabell>
References: <1599830924-13990-1-git-send-email-sumit.garg@linaro.org>
 <1599830924-13990-2-git-send-email-sumit.garg@linaro.org>
 <20201010015855.vksetnj4luft5enc@gabell>
 <877drypgqb.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877drypgqb.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 10:34:04AM +0100, Marc Zyngier wrote:
> On Sat, 10 Oct 2020 02:58:55 +0100,
> Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> 
> [...]
> 
> > > +void ipi_nmi_setup(int cpu)
> > > +{
> > > +	if (!ipi_desc)
> > > +		return;
> > 
> > ipi_nmi_setup() may be called twice for CPU0:
> > 
> >   set_smp_ipi_range => set_smp_ipi_nmi => ipi_nmi_setup
> >                     => ipi_setup => ipi_nmi_setup
> > 
> > Actually, I got the following error message via the second ipi_nmi_setup():
> > 
> >   GICv3: Pseudo-NMIs enabled using relaxed ICC_PMR_EL1 synchronisation
> >   GICv3: Cannot set NMI property of enabled IRQ 8
> >   genirq: Failed to setup NMI delivery: irq 8
> > 
> > Why don't we have a check to prevent that? Like as:
> > 
> >        if (cpumask_test_cpu(cpu, ipi_desc->percpu_enabled))
> >                return;
> 
> That's definitely the wrong thing to do. prepare_nmi_setup() shouldn't
> be called twice, and papering over it isn't acceptable.

Got it. How about moving ipi_nmi_setup() from ipi_setup() to
secondary_start_kernel() ? so that CPU0 can call ipi_nmi_setup() only
from set_smp_ipi_nmi().

--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -245,6 +245,7 @@ asmlinkage notrace void secondary_start_kernel(void)
        notify_cpu_starting(cpu);
 
        ipi_setup(cpu);
+       ipi_nmi_setup(cpu);
 
        store_cpu_topology(cpu);
        numa_add_cpu(cpu);
@@ -966,8 +967,6 @@ static void ipi_setup(int cpu)
 
        for (i = 0; i < nr_ipi; i++)
                enable_percpu_irq(ipi_irq_base + i, 0);
-
-       ipi_nmi_setup(cpu);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU

Thanks,
Masa
