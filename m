Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7453299586
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790096AbgJZSib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:38:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40538 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442385AbgJZSib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:38:31 -0400
Received: by mail-io1-f65.google.com with SMTP id r9so11169473ioo.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1XLqJl5vO2wWqmgb9LT+ITrNAM4FaYnH32PMkyjUkwU=;
        b=U6rgcLPopeY+yLxDRznBLJXxFLKGgrzqcjfFpNlkRuTjUZU3L6L4X9PU1ee3RvMa7+
         tCNGjsczrHyLeuJpp1FJgIusoZAD2HQRw/b0XMwu3MjheCJPPp5miFBqKhQ2awQB5ARS
         Quh6VF2ccXhCSoc422X2K9Iw5F7vGpvUkXKgZhR2yBiTYrLcv6qBpFW6o+pyFKIvFLdi
         IH0K6HDRCn6/4tc3gyOB5Sju904nMvGLHbtkK83c+fIFJE5RKwlKJpWXosyPofqszADl
         RkjngwAtJtRSWaxQVC5doRFFBX+p+JxbGtgkaher5nXaaL7lLDWPrzrTVor88nQkjsKu
         ILHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XLqJl5vO2wWqmgb9LT+ITrNAM4FaYnH32PMkyjUkwU=;
        b=GVcV/7AGgF766lg+xCBt7bK+UJtLJUX/Jcabr3pHsLLxG30NwYZ4LW4eQwthBkY1Qo
         6LPCRGqsy5PLEsGWaFd0/eCTxadwYpXriNKedlK7hMUzp/kfDIp8S1b6xyNnbqRWtqC9
         agTAAbETTSSkQku4R+QN0qBwqLk7FZHSh+4KdKvkNuXy5/wLFVpDOyYhSU/zvSwifDCu
         9u5+cbAK1c6aMkMBT2Th7AaiZQdx7FNEbeZ9zohuMoskrRGC2zCAQ9zpZIQtcckpnffY
         +nsjh+G4PtbsBFrfVZyn7f7uky32sDIhMJ++Neob7BKzLKvw35V1f4AlD9fV/mqVH8DI
         AYZQ==
X-Gm-Message-State: AOAM530T1jVd2Ulx3R8r2DpU+Xc+EhDMHns9C9f63q0Ety3sEPbCC+1E
        D4yOaoSbTnxRlBSKJWNj03/181HDD87G+dpsAtAJ7Q==
X-Google-Smtp-Source: ABdhPJwf56+lb7bD44CUrLWq/bsLRBUFkrCwKEnxLO52La3PA3TL1ljkGdJ1n02YMO6sRL1kgcUE4qOIFcgHOMQErFw=
X-Received: by 2002:a05:6602:2d8c:: with SMTP id k12mr5570349iow.46.1603737510347;
 Mon, 26 Oct 2020 11:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201024200304.1427864-1-fparent@baylibre.com>
 <20201026121316.GB7402@sirena.org.uk> <CAOwMV_w5N0_Qgg3MFph1147cbvFP1Y=mUtNjGbcr-Tca4ZJ3yA@mail.gmail.com>
 <20201026172431.GI7402@sirena.org.uk>
In-Reply-To: <20201026172431.GI7402@sirena.org.uk>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Mon, 26 Oct 2020 19:38:14 +0100
Message-ID: <CAOwMV_xt=OV6cKqQTZUUSAvYKxUUQZAUywAHtFFHL=E5xVu-Zg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: regulator: add support for MT6392
To:     Mark Brown <broonie@kernel.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Oct 26, 2020 at 6:24 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Oct 26, 2020 at 06:18:35PM +0100, Fabien Parent wrote:
> > On Mon, Oct 26, 2020 at 1:13 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > On Sat, Oct 24, 2020 at 10:03:03PM +0200, Fabien Parent wrote:
>
> > > > +Required properties:
> > > > +- compatible: "mediatek,mt6392-regulator"
>
> > > This is no longer used by the driver, should be unneeded and therefore
> > > should be removed.
>
> > It is not used by the driver but it will be used by the MFD driver [0]
> > like this:
> > static const struct mfd_cell mt6392_devs[] = {
> >     {
> >         [snip]
> >     }, {
> >         [snip]
> >     }, {
> >         .name = "mt6392-regulator",
> >         .of_compatible = "mediatek,mt6392-regulator"
>
> This is still unneeded, it's just a reflection of Linux implementation
> details and should be removed.   The MFD can just register the child
> without supplying a compatible and things will continue to work just as
> well.

I'm not exactly sure how it is supposed to work. mfd_add_devices seems
to register devices based on of_compatible or acpi_match from the
mfd_cell. This platform does not have ACPI so I don't understand how
the regulator driver would probe without this line. Anyway I tried to
remove the lines below in the MFD driver and the device tree and the
boot of the board failed because the regulator driver didn't probe.
Any help to get me understand how it should work without this line
would be helpful, thanks.


                regulators {
-                       compatible = "mediatek,mt6392-regulator";
-
                        mt6392_vproc_reg: buck-vproc {


@@ -135,7 +135,6 @@ static const struct mfd_cell mt6392_devs[] = {
                .of_compatible = "mediatek,mt6392-keys"
        }, {
                .name = "mt6392-regulator",
-               .of_compatible = "mediatek,mt6392-regulator"
        }, {
