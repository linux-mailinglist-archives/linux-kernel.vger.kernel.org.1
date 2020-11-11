Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA942AF406
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgKKOr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgKKOr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:47:56 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C59BC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:47:55 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l2so3520778lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4SiNHgcNa9S8HJJmjSFSnxEDAWFgmq3I+SIkewruq4=;
        b=VUSt7loxTu31ID1r4ukQIK/NMio8Dteef1slMScG02dsdbWqzuua7N8q6c0sNk0sLR
         PdDU9DIVLjz3GG3mvkQHwhia5E+FT7DKVcsDjD4ZDs1EMH8TjnvD0Ei7rz7PSlD0DPBS
         2kbo0t0f0ZybSE+nQy4E4mAmjTIlChYDEefaK5J5cjOmN/X/QGNkDfkVn63FkgRnXhj0
         DbAxgSnwtKe4nsFvsqu9NhdgrATionxxw4H5OnvuniIWBbZnw3NEfBRpI5O4FzpFbu4s
         TuQaY3tdNiPNxax4qxmS0B+SNRs5wuRdlw4aQHdrs33EbU/uAe0FHJjNbUKKJHONJN+w
         a50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4SiNHgcNa9S8HJJmjSFSnxEDAWFgmq3I+SIkewruq4=;
        b=SXB3iyzd4y274oWny7Vb14mSsSDPBg/Cl3cRByrrcvpnV1KfYxzKjrl4BePT/sc9uP
         +iHYxzp8hPhsRHs0VMExkwHvO3hxRd6MMchEzapBMah9/7Wb35Hq442hhegz+YVAdwCr
         /G1X71WX5CBmN09IpPFEtGlGLs0btDVKXLKXlzPQkOu17/qbo41JGBdN/6mM3FzbWMBY
         +QKcjMWXLJ8xwI7e6rDUZbX7tNIr7524ao13pocI/G9LbPSSx7aoGSf2dmPbZPxZyO1N
         7p7zJqf0ZXbXCqBB5G2I1KqTy5+2Z1UWg6skoiqkTqDRSAEdSBCB8IWew+0K2YaJCBLo
         dhqA==
X-Gm-Message-State: AOAM532bVVN+V1+KUlX3UWGrFoKE3lB8TfVOkAo75ovlx1NJf+fZiKP+
        DBamnMmLah2pZqioJdKlR0NqYCy3OMUUMhuApG7SPw==
X-Google-Smtp-Source: ABdhPJynWg2NZu8cHN1BBHfkL9vzIVmNezFDvbJeTwqFFk88iGGwiuy8kLTl8lMOeGSujhJI5m9OHwbV9W8QMC6X0ak=
X-Received: by 2002:a19:7b06:: with SMTP id w6mr10507072lfc.260.1605106073628;
 Wed, 11 Nov 2020 06:47:53 -0800 (PST)
MIME-Version: 1.0
References: <20201108180144.28594-1-martin@kaiser.cx>
In-Reply-To: <20201108180144.28594-1-martin@kaiser.cx>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Nov 2020 15:47:42 +0100
Message-ID: <CACRpkdZetg7Qu0nhZjB=rZmEk+o_C1y=fZXEevFN+e91ujo3gQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinctrl-at91-pio4: Set irq handler and data in
 one go
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 8, 2020 at 7:01 PM Martin Kaiser <martin@kaiser.cx> wrote:

> Replace the two separate calls for setting the irq handler and data with a
> single irq_set_chained_handler_and_data() call.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Patch applied as kernel looks better after than before.

Yours,
Linus Walleij
