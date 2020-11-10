Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686262AD9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbgKJPOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730981AbgKJPOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:14:14 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D9CC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:14:13 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u18so18009181lfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=esaALOmKo83QH8MAAmVaB5BXgE9Ow2/0mSnbljaNYM4=;
        b=aeQXNm0tKZwhf6aXmLrbFggPtUpqewp/8SjnXWL1j4vT5eUrA7/62XUhY9QD6/EBGU
         qQA/akMYY9vJ5JrVyvRU8WCeIh2lFOFU8nHEBdC/lPkksAvwc8HAPUBzV0wdH87WBr8P
         +2NIFt2eLokVMO3bLCkXJ4qDp8Y9oeqFHsD4Ymsag+fkcI6AgjpZT51AyiJrYSivYFzI
         gSGbC7l3bMeVw9m+0Mk4obXDiKISugOOebVyUAKJ2qI1yUeclXNYHFV3DIjnbksXy92F
         wOv+06H1kw409IyWkKA21K/ACTEP8Li8w9GB+8khDD237duXDW78OvjwQcfRniyY9aff
         l4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esaALOmKo83QH8MAAmVaB5BXgE9Ow2/0mSnbljaNYM4=;
        b=Kq5Ad8aCamxDhcf6xyySZQNcAF73OehNdT69wS++5F6M/RvI6DY7Fz3CJdIV3YPgyu
         kuyflEGct0J32L0hRVflNXgcZOI1x2fDyaxH86kUrhS/Rm+0dhseE53dXQWRewyHCrTC
         wpw7Kl4/a2GlXdP/KLH87/T2G1mZjnUSAV0rIqaaBOOUiRCAeHSD6PG160sEUF7Wsazu
         0CPRRw/r/1CF94DJPGEku1fPRp1MaKIdbcQ0/yHcI2l/EWJMZWFjLIgkyIGPBuee8vUR
         TvmSSEgyju1gUKr4/lp4NlJHXu1574+ACQ3PnpMTW9DVPZAXsd5IOuBzspmYskqB1DDO
         N70A==
X-Gm-Message-State: AOAM532HpHAQhdKMV8gMg2lmZ6eqTmfZho8oVzCR0VDdMmVPWURJG1IE
        6xG26U/kV1cX9HDemtBUS+Ysqx3SVEVvTq7CgBWaKQ==
X-Google-Smtp-Source: ABdhPJwzF+JOkojGk7BDkPHJu/89IPzTit6/oFTL4Sc2j3Z1+spPJaHh0ixYhP7yxxb/DDLLnEcf0ZAt1jgWDhmZ9IU=
X-Received: by 2002:a19:fc03:: with SMTP id a3mr6142298lfi.472.1605021252171;
 Tue, 10 Nov 2020 07:14:12 -0800 (PST)
MIME-Version: 1.0
References: <20201105111823.1613337-1-anders.roxell@linaro.org> <20201106151240.GA45829@kozik-lap>
In-Reply-To: <20201106151240.GA45829@kozik-lap>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 10 Nov 2020 16:14:01 +0100
Message-ID: <CADYN=9+FZgm0ufR-Gdqh0b7dht0KiDxEm8S+d5neFYmJQtzPuA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: freescale: fix typo Makefile
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 at 16:12, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Nov 05, 2020 at 12:18:23PM +0100, Anders Roxell wrote:
> > While trying to do 'make dtbs_install' the following error shows up
> >
> > make[3]: *** No rule to make target
> >   '/srv/src/kernel/next/out/obj-arm64-next-20201105/dtbsinstall/freescale/imx8mm-kontron-n801x-s.dts',
> >   needed by '__dtbs_install'.
> > make[3]: Target '__dtbs_install' not remade because of errors.
> > make[2]: *** [/srv/src/kernel/bisecting/scripts/Makefile.dtbinst:34:
> >   arch/arm64/boot/dts/freescale] Error 2
> > make[2]: Target '__dtbs_install' not remade because of errors.
> > make[1]: *** [/srv/src/kernel/bisecting/Makefile:1344: dtbs_install]
> >   Error 2
> > make: *** [Makefile:185: __sub-make] Error 2
> > make: Target 'dtbs_install' not remade because of errors.
>
> Don't paste unrelated messages and don't wrap too early ("Error 2"
> should not be after new line). This blob is not useful at all.
>
> Keep only first two lines, all rest is meaningless.

Thank you for your review Krzysztof, I'll do that.

>
> >
> > Fix typo in imx8mm-kontron-n801x-s.dts change file ending to *.dtb
> >
> > Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>
> You need to CC the maintainers of platform. Unfortunately Makefile is
> not included, so point to the DTS file to get the proper folks and
> mailing lists.

Ok, I'll send out a v2 shortly.

Cheers,
Anders
