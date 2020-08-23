Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF38024ED9A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 16:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgHWOMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 10:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgHWOMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 10:12:21 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8856C061573;
        Sun, 23 Aug 2020 07:12:20 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j15so3102986lfg.7;
        Sun, 23 Aug 2020 07:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TSlo4b8ovN8j9ufmCxToQYw7EM4pY/SThcXYNxp45Nw=;
        b=bbSDWEMrNigm9slWkT5KqfUYK5OtYrdkHoE5553RGh0BehhoZj7vSGT0VzumMHfjYR
         oj7zjyDghGHeRTNLY6AG9t0gWrN138M9PYNFyizwNOd2jWkqAvrE9rCUJcao4jMQHNE1
         odfb9/FxVSr7DTzyvxnL5KJbfYnUiOJGm+oQBomMO7FPqimEX4JzcyQXtwGRgLT6ikoa
         WsChrxXwbiBaoe6mpYJtWgTe7m30cHBn+PjfsivnArGWDsetq7gwDrib6tC2OTgSXFrx
         hwvhMksq+RQM4nw3wDtV/uA3dQvmJ4PUQPvgEHc11l37d7yaCxM6FQI7CvOQLb2/C0E9
         xRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TSlo4b8ovN8j9ufmCxToQYw7EM4pY/SThcXYNxp45Nw=;
        b=rC3xDOsCyHxtOc7w4IwSlD8KjKKyMwKr0gll0Yf7Y93U+7Qh7HtKA96B4QlyYWJix+
         7huw3K+9chQwVUSqMCVCgWs8/aSZTZYyUW1I1K5TLz/jvir2YG3o0X4snUItku0VdFYX
         e6Y66tDjKPwCzvwBJdFYDnTZApL902Q+QULW2kee25LEKbCgKt7XBsK2HMQVYZkOd9Xo
         26wzoJW/PSvwcxnuh/G7xShrwOwBBY3DwvJx2tWJ8UUdP5k89nOi9Gy03tJJ/Z5NxPGs
         ojse/HAkjpoGhAcMD8jQ0/4YZWBWlGnOjokUCyxySDw5jIdW7+JJOk82C/HVn2Sx+Tg3
         8fEg==
X-Gm-Message-State: AOAM531qwFhShNdkskJsRsI15zbuk0Rz/v7Id5zBGjLJiWDbOxU+cx1y
        6jFwjYN4MzSOAt0qqPmCoXaOVyGCoRv4ghA56M0=
X-Google-Smtp-Source: ABdhPJzpc9xnXVWN7kBxunjdAXR4CZlJ5vyIKYmlyoGgNSI2LACUJ+7D5x14pIBIsL45fGZyV0/MJBlrDIz0SPaKO84=
X-Received: by 2002:a19:4801:: with SMTP id v1mr370564lfa.56.1598191939039;
 Sun, 23 Aug 2020 07:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR0402MB33427CE688DB9D28DDFC000EE3590@VI1PR0402MB3342.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB33427CE688DB9D28DDFC000EE3590@VI1PR0402MB3342.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 23 Aug 2020 11:12:08 -0300
Message-ID: <CAOMZO5AQdOONXgYFYGV+=0u8KqXUfJm-J53YoKdJDPXJmLtW0Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Add headphone detection for sound card
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang Shengjiu and Shawn,

On Sun, Aug 23, 2020 at 9:31 AM S.j. Wang <shengjiu.wang@nxp.com> wrote:

> I would like to know your opinion, should I move headphone detect GPIO
> To audmux group?

What about adding a dedicated pinctrl_hp for the headphone detect pin
like it is done at:
https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/tree/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi?h=for-next&id=8f0216b006e5f553d28c4c1a991b5234693a49cb#n130

My point is that we should avoid adding a hog group when possible.

Thanks
