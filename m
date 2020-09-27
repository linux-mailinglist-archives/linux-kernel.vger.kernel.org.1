Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A92327A010
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 11:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgI0JVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 05:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgI0JVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 05:21:10 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FE2C0613D4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 02:21:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w3so5891228ljo.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 02:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o7lRMwheEwMVDoZh1+98Zj6EI+Y2FXPbKq6Vx/JPPmg=;
        b=nCAMQcfO1adjOnVSOrDKmFpM0l1QZmc4Gk4gzdgH5NCxKbVN7fIsZnb1++bdbbHuGK
         0gO+FJihvUKpd+joia7EV4Y/nhDc5SkY1CghBYz8FI1tFntyf4tspPVYKMlDpxEVCOyn
         ZdjIv/d3/vg6gRQ5hV0yiN1LUo6RkI2F1SbMeOne/ds+3Zifnb6ihpoLZ8kBdeRR28i8
         Eo1tjpVlBqUimhkh3lEZZWkByJlb368sDd+SsSM6wdS5L1uBCP6zwdCEc5s4jyQLQ5zO
         TLFYNchXVtFGjAM0Vj9UgX3gB+GBpxeK2xX1wMeAxOGwa7im2wn+T2PMmm9u09HD6Rhe
         QQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7lRMwheEwMVDoZh1+98Zj6EI+Y2FXPbKq6Vx/JPPmg=;
        b=eXc4rd8MYoLdEEIdHkkGLpzDe9vHYI5uJGI1rzru2JuadKpmtLN3EpvRYDnEnTtr9p
         6j/UxcMsoQWiun80e7m3retf5ZxW61Hp7pHZcpg/tN+CokXLaQ3MmUzkWIa0uJHfO3U+
         m9Jh/YuiDp8oMKdx/ZNCetYoyljclpsdsIntf+IzTLMGTSozLZBS+doe9HaPoJrl9P+t
         ociUeax4lillh9HY96mhzxatHP3khhGm+VI8hVCJlciTWz1VV7htaBhnvNmfeq7k3Aqp
         VACP9euYSQfU+1yEaGdleptacXHiV0McoMOKmVlbgbme7mzCJ+EuWa1UnBEKXxHjh3LS
         eZzg==
X-Gm-Message-State: AOAM532fhcnVnjCX7DbmvHPKDIoyDS9PnLTTdsHeyBSgGOtOyejkwLNI
        pBHc3anKxYbgo7hCaD0E2nFEIo5bRXlksJPQjnwWoK93ac0Gqg==
X-Google-Smtp-Source: ABdhPJy6MVk1x45l3SzYVBvvCdEvD+7U4T8hhSI5A1uyFMODZMWC5/YlREL/K/c2cdE/Px3GbHJYxQ+SeOMZ3QRW/wI=
X-Received: by 2002:a2e:a177:: with SMTP id u23mr3403136ljl.104.1601198468123;
 Sun, 27 Sep 2020 02:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200907110221.1691168-1-fparent@baylibre.com>
In-Reply-To: <20200907110221.1691168-1-fparent@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Sep 2020 11:20:57 +0200
Message-ID: <CACRpkdZ8hqVok8ejVACo7pxMuc8EpKt1Z+hSKnpGq6Waj9-5Pw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: mt65xx: add OF bindings for MT8167
To:     Fabien Parent <fparent@baylibre.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 1:02 PM Fabien Parent <fparent@baylibre.com> wrote:

> Add binding documentation of pinctrl-mt65xx for MT8167 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Patch applied.

Yours,
Linus Walleij
