Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B8F2E04B4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 04:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgLVDY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 22:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgLVDY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:24:28 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B9BC0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 19:23:47 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j13so580193pjz.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 19:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Fml0HPxjeW3KlPkKcmTMycAdGJqoiBPdorZITHm27g0=;
        b=t2Ihxv8CCjKXimsL3cXaHE5f4jZID8yHMHiPh2PSkXudjaAFnpGShEaw6VdhToOq7+
         aNwOHfGCpikS0MrjzXMHXHuhzfy4RAbHzd19BZzm2VsL4iJnXjXSlCfSJwmqvSXD4RiR
         9byzZOdm5eIJmeiWoEiYBI9x3xy5pbZYx01hE3mrNWQNLV7c7YHTv9dav+BLtG7HUt21
         o4NMzKRpP7sncqtH19KvcsgIpOQRR+bQ8p0WatBuH4qkp/RtoYW4KHSvLTxOGFE6vpNf
         qCUABT1NvZKEUoSWYxkYLcUUiHeyTlL8t7Gkol+C80Idj0+nPfIOahhErsc2O49n3lRr
         QYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Fml0HPxjeW3KlPkKcmTMycAdGJqoiBPdorZITHm27g0=;
        b=ZOV0EuwF+d1rHVkRT4ddGj3sISTo6XIQ+K4cWxDlXd+hCmrly/LaXtSbB+BfocEhJQ
         SsseKW+9VMBUoL4r4Whn7rDgRB9a/awIfVN0lRwF2mc+slHlwZ/Q+fTInKYcs8ivwNGp
         kDBFTStP/XuVW4b7QPB4hZgLbQN2O0DT4ehHVFtXZky+sY5FQUVnvY8PAXmU+PD+MIkh
         rtcsgjQ8dv0G5mCOAX592+duF2aaIBorw269WgOEDvcUuw5o4VnikZXjyeDRTI6MXnrG
         S/NzxeacQ37nhfkczHweeHERMf/7L9Il/glExrAHYPRqm1dDHQIXRwA9UJqQXiocKdnr
         kttg==
X-Gm-Message-State: AOAM531b90TYnHaUUDxXlwKlot3nPSTnmj4pBixtyLykWBOeqEfhCFuv
        PZ7pl5GhuEEMcyoBI2VXkxD/OQ==
X-Google-Smtp-Source: ABdhPJxDXLKNIS+nAjmXcerR0lYz9gNHq8QC54QEIsJysxTCG2V28VwRupYxSkOil5ucyogRD7tvXw==
X-Received: by 2002:a17:90a:3e4f:: with SMTP id t15mr20316849pjm.57.1608607427201;
        Mon, 21 Dec 2020 19:23:47 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w27sm14448896pfq.104.2020.12.21.19.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 19:23:46 -0800 (PST)
Date:   Mon, 21 Dec 2020 19:23:46 -0800 (PST)
X-Google-Original-Date: Mon, 21 Dec 2020 19:23:16 PST (-0800)
Subject:     Re: [PATCH v2 6/9] dt-bindings: i2c: Update DT binding docs to support SiFive FU740 SoC
In-Reply-To: <1607403341-57214-7-git-send-email-yash.shah@sifive.com>
CC:     linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        broonie@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        aou@eecs.berkeley.edu, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        andrew@lunn.ch, peter@korsgaard.com,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org,
        yash.shah@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     yash.shah@sifive.com
Message-ID: <mhng-c1b8fc11-36ec-4143-846b-130086defe06@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Dec 2020 20:55:38 PST (-0800), yash.shah@sifive.com wrote:
> Add new compatible strings to the DT binding documents to support SiFive
> FU740-C000.
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-ocores.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> index 6b25a80..a37c945 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> @@ -5,8 +5,12 @@ Required properties:
>                      "aeroflexgaisler,i2cmst"
>                      "sifive,fu540-c000-i2c", "sifive,i2c0"
>                      For Opencore based I2C IP block reimplemented in
> -                    FU540-C000 SoC. Please refer to sifive-blocks-ip-versioning.txt
> -                    for additional details.
> +                    FU540-C000 SoC.
> +                    "sifive,fu740-c000-i2c", "sifive,i2c0"
> +                    For Opencore based I2C IP block reimplemented in
> +                    FU740-C000 SoC.
> +                    Please refer to sifive-blocks-ip-versioning.txt for
> +                    additional details.
>  - reg             : bus address start and address range size of device
>  - clocks          : handle to the controller clock; see the note below.
>                      Mutually exclusive with opencores,ip-clock-frequency

Presumably this new one no longer has the interrupt bug?  The current
implementation turns the errata off (it's only enabled for the fu540), so if
that's the case we should be good to go.
