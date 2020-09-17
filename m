Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3469726DE08
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgIQOVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgIQOUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:20:37 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6201C061A27
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 07:20:20 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id q10so1046985qvs.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 07:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7jZEG2Sruw3Jx4XQRAj0GDBXLVaPTMEGlVWTk6ugBI=;
        b=Zq1phMQAKGYqJWuXNL0yZLtOuPC6XEm8SZDz33cEnAJUyc/4q021fuLhFs53dtzuE2
         lX3OQeSDXqzF0+nGbWzTsZZzEc69i4icLE7jvV9WCYbTJvRwWeaPqDvFU6z2oN/0z5us
         i77gKNaXxZ4k4oehzh7O6nFoCLjtYCovgSZCqpX7tnBLfOWabI9OhbNiq1HZkFqALWAE
         Rvniy59LTFJBqxd4Xu5DtsM1TJT/0HAofrXp64PtT3FwCfbviGH3uw66qBczPiRdIex5
         ba/xkV5IOt6231SSZLzoRX8beU/dsIR4pNMcW7qLM1Y9meXOc0O7rg4VneOYg/cMsKJw
         pFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7jZEG2Sruw3Jx4XQRAj0GDBXLVaPTMEGlVWTk6ugBI=;
        b=npENhKHuSSb4iwU+P7UXZRIHuzGtbr17/ORqAzfc2ulsq0Tv7JBbsQhkqrbEE7V31j
         jbtNbh3GS8fMTWgMqcjZzmiGKyyI1m5Gfx33+EKe5TqbWH7xxaNxO0tlpPLfXTizQfc/
         c9e4ttyUYmr0WpSg2YRB9aJYWqXX+6X9ZOi8tZzwtwtRKUs0P9/AvB4roLYAPPihVsvE
         df8qEiX3PitPlQ2QB+z0AUT8OmVc3ha6qic79Kdr8NqPJcaEYtT2HQx8oNmyoV1xLBOV
         HxvpPubmHPg8y397Zy8fDZ+PmdEAIcRi7U1oE+wLM7xqh5opes8acLtjR1r5FS/I002n
         LnLw==
X-Gm-Message-State: AOAM530AZRQYiTzC2y3w/IEa1SRs5CtVgp1N1i7HHN+DLwvvXcqXtQ8h
        aYxsEOlQKoL1iFtNYH3dOBbuA7DAhNI1KO5GYFRPkw==
X-Google-Smtp-Source: ABdhPJwMCn4z6UNz8c+Wp5fWTbuMOdJQrYNPE8efSjlFDxPEi/5DlPH02wBB60WIc/pNmJqU0u1f/FQRQ+txF6naRMA=
X-Received: by 2002:a0c:e348:: with SMTP id a8mr12621270qvm.49.1600352419745;
 Thu, 17 Sep 2020 07:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <1600274110-30384-1-git-send-email-grzegorz.jaszczyk@linaro.org> <9797030dd2c11b24ae0f7ef760f12ffa@kernel.org>
In-Reply-To: <9797030dd2c11b24ae0f7ef760f12ffa@kernel.org>
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Date:   Thu, 17 Sep 2020 16:20:08 +0200
Message-ID: <CAMxfBF6P7qz0WQs8j18j93Jjw5H3VfmP+1KOwHKw_giCAFKg1A@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Add TI PRUSS Local Interrupt Controller IRQChip driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, jason@lakedaemon.net,
        "Anna, Suman" <s-anna@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        David Lechner <david@lechnology.com>,
        "Bajjuri, Praneeth" <praneeth@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 at 12:45, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-09-16 17:35, Grzegorz Jaszczyk wrote:
> > Hi All,
> >
> > The following is a v7 version of the series [1-6] that adds an IRQChip
> > driver for the local interrupt controller present within a Programmable
> > Real-Time Unit and Industrial Communication Subsystem (PRU-ICSS)
> > present on a
> > number of TI SoCs including OMAP architecture based AM335x, AM437x,
> > AM57xx SoCs,
> > Keystone 2 architecture based 66AK2G SoCs, Davinci architecture based
> > OMAP-L138/DA850 SoCs and the latest K3 architecture based AM65x and
> > J721E SoCs.
> > Please see the v1 cover-letter [1] for details about the features of
> > this
> > interrupt controller.  More details can be found in any of the
> > supported SoC
> > TRMs.  Eg: Chapter 30.1.6 of AM5728 TRM [7]
> >
> > Please see the individual patches for exact changes in each patch,
> > following are
> > the main changes from v5:
> >  - Add Co-developed-by tags.
> >  - Change the irq type to IRQ_TYPE_LEVEL_HIGH in patch #2.
>
> Applied to irq/irqchip-next.
>

Thank you!
Grzegorz
