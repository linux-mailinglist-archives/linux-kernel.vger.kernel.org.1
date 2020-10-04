Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3767C282D57
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 21:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgJDTru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 15:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgJDTrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 15:47:49 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AD6C0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 12:47:49 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 197so8331927lfo.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 12:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XG1wTZsegfbn4qSMGTJS4ZJXmsnG2K3cv9FPUxyxcl0=;
        b=tyvwm6vJeWvUG+YylyY192T8KZn8Qr5yrM6GStT9s5de2OxMteL5B7wGjth4sUWlJN
         yeRtZ8fzQPLTP9l2wh0H4IA+OpTFu+WFAAplzJ8qc9EgqPbrd2PoM0mVI+iXrNmT75AN
         zcroezNosDv86rT9OyuWus0A0/2KUpofl7Ic65A/DKOQSHF2ZxeFdfHeZIBk6XkKcUxP
         HcSwGnU3K1N1pOubYNNMe+L1KRExsaA+TjbpHqxVxSIX365Uj2OrENw22Bctly0oE6hB
         GdG+QQMsq0my+4UDQnJFFUrBuYSUf4kcP9liwUpC/a4Ob7vniiKdILK/bCPKjY49XOww
         WnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XG1wTZsegfbn4qSMGTJS4ZJXmsnG2K3cv9FPUxyxcl0=;
        b=dA1HaDcKexLYkmXRlhLOVy7Dd2K9k/GCp11ctk/8vahEBWzZF8RdJpp9E5Tb1uUInP
         coucJrPq+wLulalY+hlKkC3CREc/eli1/NXpJYi9m88uoLarB+3JeNyoORlD1Bi3oecv
         r+zAuHMtvlzJ6qkPUtdbf4kgPeY0CQQIGDcEIwY98wUr+5YuL/R+9H3Ck5OVrsAuZZtC
         KvjypGu/rY/01zzHKbDjLRdv1EgWIXVhPzGmPeRJM0PwGA0hfTdEE0eBPhZwII6RghWS
         Rmf111PgGSbc8U4D8fCYTB71FDiYhSH4ATUc/+on2M27gvoqS0pt+r67eJjUZWAnKtD2
         mb8w==
X-Gm-Message-State: AOAM53316HB+rSxQ0oP8kvUuLZo18azRN1Rpz295gqUfDvgcaWzTLVXy
        Inb881b0yxTTfH0lYXTfxsUNKgdw8HJy/nnBnmf+HA==
X-Google-Smtp-Source: ABdhPJyyPZraV7h6Tujv7YTcdF+DimoKQoWubCHdJkkJBqSwis5CluCtrWiab98vMgU9wcgCmJaaSrN9A56tCRbI6Eg=
X-Received: by 2002:ac2:42d8:: with SMTP id n24mr3845234lfl.502.1601840867685;
 Sun, 04 Oct 2020 12:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201003103335.23404-1-krzk@kernel.org>
In-Reply-To: <20201003103335.23404-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 4 Oct 2020 21:47:36 +0200
Message-ID: <CACRpkdYASOe+rRu+AcXX7bgb=+JZFT9asQNUJ4U7Mq4DPDAvEQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: favor "gateworks" over "gw"
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 3, 2020 at 12:33 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> There are two vendor prefixes for Gateworks: "gw" and "gateworks".
> Favor the longer one (more descriptive) and mark "gw" as deprecated so
> it will not be used in new bindings.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
