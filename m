Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8F82B3008
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 20:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgKNTNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 14:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKNTNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 14:13:30 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6983CC0613D1;
        Sat, 14 Nov 2020 11:13:30 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id v22so14552334edt.9;
        Sat, 14 Nov 2020 11:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fAmhgd7CFeJ/DRc9/3PIR4VNFnC868K9QnLj6x8FscU=;
        b=bkZXkOc1xXB6QiRCHqLJ6ctJ108itiNUae1xk/gPYOCEvbaNB1CdBZCmo68ChVxtAh
         rBQhwkzJE621CRoQZtGvHfGT/WmSkiq3NfYF3pzEs/jFlLvMkVArZmXN8Bjp0lNq8X9I
         CpLaj8aYzc8fX4aiu4t0QKU+HwqSRZlxMHjATiQmu756NIp2s8KPs9nF90bmBVlET4fs
         HpN/Ik5qj04UxZuqBWdSM90M1f63JJPXD76b7YuKvBclPnXH/+Zcy1layjGGC/q6QBxe
         UTgu63+x8U7/AZK/4bvuDwVsEiPp04+BoVeAvT3xZdWp7kTJyBIbEkESAjK7LN5MWBKx
         JBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fAmhgd7CFeJ/DRc9/3PIR4VNFnC868K9QnLj6x8FscU=;
        b=kNc/02vMTUmvtQI9J8DL3gTbnA2duRiRSAq8Zpm3IFTYbgYBzlPvYcM+YWt1KEYN9k
         h9IZ9h8ACz33aouOhE1+uxTnpMAE1jF1RHT2XfP/odDCLSuRjq48hYZY97xcO4vU1Fn7
         ZO6DbxIaZtdQapNkHIeGAUMBVl18fOkGX3WutcHdkKWMnn0mttxxupF4Wwp0ptx89xGg
         LAsfgpB9wVAHQVFqFW4O63cKxTMkMNonkVfzHgpEPCfzkR0kIfl3sXmq+e2LddMASygL
         EHLWvylDFaOv9JT1lFWPot4NdGl2u5F2i+/sndNI3uCA8OwKrQxa4nHWbOjdRePm3pYo
         1O7w==
X-Gm-Message-State: AOAM5313kCf6qiygFSKIuRVz9zg0ba2cTFTS+qwhiXT83ydshcj7hAqq
        7nEMdV7URWEfYnag05WJ78XV1YkuLZEXfzLIguY=
X-Google-Smtp-Source: ABdhPJzjTzrkJMfc06gBXgrdl6yrGT0kmA5LbSTfIvuqgeMBMblV/d8H35XpHEpDdj7dksdJwFOpTy78mWMyApBMsLc=
X-Received: by 2002:a05:6402:30b5:: with SMTP id df21mr8473297edb.146.1605381209138;
 Sat, 14 Nov 2020 11:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20201113000508.14702-1-aouledameur@baylibre.com> <20201113000508.14702-2-aouledameur@baylibre.com>
In-Reply-To: <20201113000508.14702-2-aouledameur@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 14 Nov 2020 20:13:18 +0100
Message-ID: <CAFBinCC92FfvFt1aAspkF_Mrrtu_QpS327TN2=9Yc3tWMTcu_w@mail.gmail.com>
Subject: Re: [PATCH 1/3] phy: amlogic: phy-meson-gxl-usb2: fix shared reset
 controller use
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amjad,

On Fri, Nov 13, 2020 at 1:06 AM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
[...]
> @@ -124,6 +126,7 @@ static int phy_meson_gxl_usb2_exit(struct phy *phy)
>  {
>         struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
>
> +       reset_control_rearm(priv->reset);
please move reset_control_rearm after clk_disable_unprepare as
mentioned on the other patch to clean things up in reverse order of
initialization

>         clk_disable_unprepare(priv->clk);


Thank you
Martin
