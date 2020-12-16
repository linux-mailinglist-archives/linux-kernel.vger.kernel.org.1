Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3842DC69C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 19:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbgLPSgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 13:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731089AbgLPSgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:36:21 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29808C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 10:35:41 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id 6so19548740ejz.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 10:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2bDH/Hol0H2oHf/Yy3g6/HrXyqHXNmIJk03IBlf6dA=;
        b=ruJ7UmwDaf1pgP+nog1BinyUL0Id2q9FFmQZAYWRO0BzfsP6yBb4jRLW23HrDtURw6
         XRqwa9mvxETQIfCFrmJ6ZDL4F/lwQf9eaQagjGmOhiF9iG7V3vFoP6LqSC6Mg8zXK2fW
         OgPNaORyQGTFj+qTHC/FDy+wQ+MrrDiDtCnu13UuxPmnr1bmSXODmOWDlJY+0guEnkSm
         yBEKFUeqLf2TTEgBSqroN2/i3nVf2HHw4uD6p7lKRvAYKPrV+3y2blyc9EsGf7l6zdEz
         cnHhLNg05rpedHAgP0dWTRhm3GbLDmqGmaukknDr3JeV6mnf56WcojRV7EyLDxIVQ0f3
         tlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2bDH/Hol0H2oHf/Yy3g6/HrXyqHXNmIJk03IBlf6dA=;
        b=sRozgHwMbTmV/Y9sBIRTSEKhts44ld+IDd7bZLbdx59v8o3fYMzc8FanryDImPNTtW
         hX/S0fdLgWtUNV3tw3eJKQUdK3HwTYXtBF6Bhl9HRXDLtLEAlnuhBL6DUqiuKU2pwP4U
         W6Y6MyYPTq0eLSebRVHMIIcr/ZhOjbqtFyXZ6F8wnj37t8wFdaaT19oGuEe04PXqIsKl
         tysAO59YpQ1qIhidqzICIQjOTo8DpPR4NPhAMkGDDqZmptkTUkVwY/OwcT8tBxA8iAC2
         EDkh5maerzCgqfgNI+MahYowehAdNO6mG666n6uYWKatUmPF//Es31tTl1qMHxFrsQPV
         QwOA==
X-Gm-Message-State: AOAM531SLXY4goQ7xC8rQL+S22HG1Cnici62wAAmsZtZp+LkCcR+2AwP
        XYNW5VkIkAim6mKJaHM+NSSCE6+qCY7wtCS2ch05mwHlKnCdOg==
X-Google-Smtp-Source: ABdhPJwJorgowRP1Ej+Yh/emGfpY3PCwFgLOuCERmNcG8RW/aPrBJ/ZsgMiAwxwMp8IbhO1yk7JtRd/oNlBt7/s2Kkw=
X-Received: by 2002:a17:906:ce2b:: with SMTP id sd11mr32928366ejb.334.1608143739911;
 Wed, 16 Dec 2020 10:35:39 -0800 (PST)
MIME-Version: 1.0
References: <3F164009-1941-4980-A704-A35EAE3EDAB1@hxcore.ol>
In-Reply-To: <3F164009-1941-4980-A704-A35EAE3EDAB1@hxcore.ol>
From:   Mathieu Tournier <mathieutournier@gmail.com>
Date:   Wed, 16 Dec 2020 19:47:19 +0100
Message-ID: <CABWh7Q-j57g_vcTx29Po_L8t_nnOMNjUvYdzbuGsFz-xsmV7AQ@mail.gmail.com>
Subject: Re: [PATCH v6] drm/bridge: add it6505 driver
To:     "allen.chen@ite.com.tw" <allen.chen@ite.com.tw>
Cc:     "Jau-Chih.Tseng@ite.com.tw" <Jau-Chih.Tseng@ite.com.tw>,
        "Kenneth.Hung@ite.com.tw" <Kenneth.Hung@ite.com.tw>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "hermes.wu@ite.com.tw" <hermes.wu@ite.com.tw>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "jitao.shi@mediatek.com" <jitao.shi@mediatek.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "pihsun@chromium.org" <pihsun@chromium.org>,
        "yllin@google.com" <yllin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen.

As it6505 is compatible with DisplayPort 1.1a,
Should DPI_PIXEL_CLK_MAX be 165 000 instead of 95 000 khz ?
This would permit 1080p support, as it may be supported.

Mathieu
