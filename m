Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7D22956C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 05:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895410AbgJVD3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 23:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443900AbgJVD3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 23:29:35 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB3CC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 20:29:35 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q9so71092iow.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 20:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IMFKi57vTn4WORdntFjLONbVhz/S8EeuoMU/ru37Fjk=;
        b=QmKzFiaHxS37kWhYqOevmJSha395OemOg2KLsjigL/6YgPyC0cWSkaDr+ffKa61vPU
         GXX3dfuhinc3Qluqg/LcYmWn/uxtlNOgkwHIV8z5wVdWNaIK/qBYmvkfpKFr6uIPXDuS
         AfhJpRPcSFHBisu+853OTgVeFr30qYIhwo146On5XcIrt6UvkDzAOUc8b9oPP4LHY+aP
         mcF96p2cmiAaoW59NhLHswwH2t/U88kQXPZ09XztB41AQUXax5V0J3N4+8uTmW9J5nLp
         gvtykGqSZeSnzrM85+VdZrTtv1zRS7Q7rVERJrrNJBtv0PRbYLmliKduECch9kebV8vo
         8yGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMFKi57vTn4WORdntFjLONbVhz/S8EeuoMU/ru37Fjk=;
        b=WLK/NMgQHflQtNYVf4Ojwg4cq8N/aEnVFlwa6aIqs9PQoMZfC7IEw1oXEdhrQSloXa
         KGxtbu6oxB+qt1QQBjifH3v/5zp4e4UWzm6OSTKmiGiDnx80V/ug6VYL01Qzpw1O2j2h
         CjwXTRvu6hB1w0TgxfYrZIiFWRgAuTJIy3iRsg88OdVyGTLrUi3trS0Se0fEsoZ3Fwh7
         G/4HEYF15YA26xdGfUqJE5PaDpZfsGieFVZYDHhEEtnbp0nBzw0mWpbzs8U3LSfncaLS
         YUTwlBNy5maANujGMz8CH/zseGjToWopLb1mJXys9ZnwHGxJbzI3Rcc/6m3zj94qRqby
         ab/g==
X-Gm-Message-State: AOAM531tWnzx89Gy+5Q23z8uewe18hupVhMjYcahnoku3IXkIw9BlgAU
        4ASCBHnDF1kGHCkQnZipnoKcohWrSHX8h/Smt2Sv/7lTaAjisVwX
X-Google-Smtp-Source: ABdhPJxMauPqYM6FB9F47HpfghenbvywgGSYzCRS3yrWm7U0RrqNphhFJ8ty4CuavT4aU+0YJFuGRFcGD/Y9+5aVe7A=
X-Received: by 2002:a5d:9f0e:: with SMTP id q14mr438269iot.185.1603337374464;
 Wed, 21 Oct 2020 20:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200914080619.4178587-1-cychiang@chromium.org>
 <20200914080619.4178587-3-cychiang@chromium.org> <7bdc0d63-27b1-f99e-c5f8-65f880733d16@linaro.org>
 <CAFv8NwLkvxX2avoLY+4NY5gBv0dQ863hFFiqy7iQOJxH4WenmQ@mail.gmail.com>
 <20201015161251.GF4390@sirena.org.uk> <CAFv8NwL1xX=yPGFqQL_mOzAnPTfH0Z0J6ibG1+D32W46Nx0KYQ@mail.gmail.com>
 <20201020143711.GC9448@sirena.org.uk> <63f1a29c-0758-97b8-ce80-fe43d91630fa@linaro.org>
 <CAFv8NwJ-+f146Ss9Mk=nEXjm1B--ZwhAgnfx-cTi7DGEKqC1-Q@mail.gmail.com>
 <e876421c-dfeb-e853-1b65-53a786e9bcf9@linaro.org> <20201021123913.GD4497@sirena.org.uk>
In-Reply-To: <20201021123913.GD4497@sirena.org.uk>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 22 Oct 2020 11:29:23 +0800
Message-ID: <CA+Px+wV-uoODRQTZqv7RuyOUoGBoh5GnT2h4iW9mJGRL=UFfgQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] ASoC: qcom: dt-bindings: Add sc7180 machine bindings
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Cheng-yi Chiang <cychiang@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Srinivasa Rao <srivasam@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, sorry for jumping into your discussion but I am trying to
summarize them to make sure we are on the same page.  Pardon me to
manually copy-and-paste partial sentences to quote.

ACK:
- Don't expose DAI connections in compatible strings.
- Use "model" DT property to make the card more UCM2-friendly.
- Expose new DT properties to distinguish different DMIC models.

NACK:
- All the board variations using exactly the same compatible string.
=> This is less realistic.  Although the CODECS information can be
retrieved from DT, it is inevitable to have some custom code for each
CODEC.

Per Mark's words:
> a different CODEC is something that often justifies a separate compatible
I think we should use different compatible strings for new CODECS
combinations.  And we should try to reuse the machine driver if they
share the most code.  In the worst case, introduce a new machine
driver for the new CODECS combinations.

- Srinivas's suggestion to set driver_name.
e.g. card->driver_name = "SM8250";
=> This sounds like a new DT property should be parsed in
sound/soc/qcom/common.c.  For example: "qcom,family"?  But as we do
less care about UCM2 for now, I would prefer to just leave it as is.


I would expect the following variants in DTS (just for example):

sound {
  compatible = "qcom,sc7180-trogdor";
  model = "sc7180-rt5682-max98357a-1mic";
}

sound {
  compatible = "qcom,sc7180-trogdor";
  model = "sc7180-rt5682-max98357a-2mic";
  dmic-gpio = ...
}

sound {
  compatible = "qcom,sc7180-pompom";
  model = "sc7180-adau7002-max98357a";
}


Please correct me if there is any misunderstanding.
