Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FA9299393
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787497AbgJZRSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:18:50 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39360 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1787489AbgJZRSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:18:49 -0400
Received: by mail-il1-f194.google.com with SMTP id q1so9039108ilt.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kf2slL13S23kIiTkgcu/XH/I01QmvP7nzqRqwTpjchE=;
        b=ErGh25PWSgrRKBR+lrdUtyDZ/6bplQJCyolB3cw/latSi/0fcmf4wuOGOcPlXU3ARd
         /BgN9xUjvux1jSiDAvEtTq7bVbWcd502M4QRu0g8KwHhPLAk5u8QlLTvk7fr69OYtUOD
         pd7oSx2wggH/oh3Fhowo3o1M5CfK5T2ENGfX02C0YLUCqo/haiER/qnns9IbZRSd9GXa
         l/AwzDHEWS9sH0duGobt9yg6Eid7CwK7TmniMjUgN1JQQeSXRSjRo46iathsVBUiCb/8
         Z+dT6jgYR/hcukkj/MUqfA3LFpDBk2/ifZRuAw700nFqfpzGjilxVzVI255cE6fOubN8
         oyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kf2slL13S23kIiTkgcu/XH/I01QmvP7nzqRqwTpjchE=;
        b=CAMmNhi7Wk2RUfRFs8i0fqTqy6WKcP0aeBRFLNlo6gHHsTkSw7logSYQ4Ipsg7Yk+B
         IHn4vemLuEpciAHVERibKqjeyKyCgrTHt/ZBITtfhdtIVjj3puKHaxcIYqO45i12mZrm
         2t4f+Z9LN7lWPEC+8g5qRsXiA4049ZhmXuAEUdRVMzKZi5fbC4v7SNLgOk+BjjQFDq6F
         QP8ocWZYsyAcXq55daGe7sAeRm9ArW85Jh0c1O+ZjQmLzd5EOESzf/TEeAkCoaYzko9D
         JY4hpNmqsp8aAQLdvp7FuOqonhwUN0bTVpbyn1eA6aZL2w76uR7IOQqduMFGDpS6fkab
         iEQw==
X-Gm-Message-State: AOAM533wS9cI7nWnVly0cLu6ziLYCATiSRppDPLXq9JquxR/gLC79wel
        tKOnTRj+4hG6hH9bf0Ag8IsydBGjQcDvSFz+o6frrg==
X-Google-Smtp-Source: ABdhPJxaAiZJ2N/5BbUTyaLVKpzqQmGKuG6ERNt1o/WUN1lABApvRd853FwGYPcM3XwTnI0qUj9PzWNbrjk9LiIH7+k=
X-Received: by 2002:a92:7f10:: with SMTP id a16mr12296656ild.134.1603732726663;
 Mon, 26 Oct 2020 10:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201024200304.1427864-1-fparent@baylibre.com> <20201026121316.GB7402@sirena.org.uk>
In-Reply-To: <20201026121316.GB7402@sirena.org.uk>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Mon, 26 Oct 2020 18:18:35 +0100
Message-ID: <CAOwMV_w5N0_Qgg3MFph1147cbvFP1Y=mUtNjGbcr-Tca4ZJ3yA@mail.gmail.com>
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

On Mon, Oct 26, 2020 at 1:13 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sat, Oct 24, 2020 at 10:03:03PM +0200, Fabien Parent wrote:
>
> > +Required properties:
> > +- compatible: "mediatek,mt6392-regulator"
>
> This is no longer used by the driver, should be unneeded and therefore
> should be removed.

It is not used by the driver but it will be used by the MFD driver [0]
like this:
static const struct mfd_cell mt6392_devs[] = {
    {
        [snip]
    }, {
        [snip]
    }, {
        .name = "mt6392-regulator",
        .of_compatible = "mediatek,mt6392-regulator"
    }, {
        [snip]
    },
};

[0] drivers/mfd/mt6397-core.c

>
> > +- mt6392regulator: List of regulators provided by this controller. It is named
>
> This property doesn't seem to appear anywhere - there's regulators, the
> collection of subnodes for each individual regulator which I think is
> what is referenced here, but nothing called mt6392regulator.

Indeed, I will fix it in the next rev.
