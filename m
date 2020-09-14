Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00845269442
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgINR5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgINR5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:57:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F300C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:57:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so603094wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=UU4YK6KB8K/yy0/XwXQD3IB16jnJ9qXibO9pMdbOoRY=;
        b=jwtToS9oyke/snrB996EEguzitHvKg1MFr/NuNomJxr/JeDCSBQYtXgqiGrDWMyIBs
         WDS3GVeff43pAMOPmcCu5lEyPOaGEdBzfrGEEEeQRfH9CxgRRkBFrmJX2JSo/zb3mL9d
         vPcl+lpYmHruHXxO75CbY2y5HzUCvKb4Kqq0MjeybOZicYlKcHaMXmmeFqLO/BJAZb10
         Ljw2YIRyz80wONxWjFwDDwbvdPEG6MHaVEVZUKCAUJUNHCM4Txj9IdsbkWSiPSnc1ElT
         5mGh5/Io787xP744ad4MWvYjT+EWejKEcEdL8QRvoORbkI7kDI30IejEs/xWMe58tBQm
         1vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UU4YK6KB8K/yy0/XwXQD3IB16jnJ9qXibO9pMdbOoRY=;
        b=Pshr6hFdG36dWa5baGpZjcOCkYLmTjEpmuQuRNw5ObZi6b+wi4hf0MIH7qO6kGAgEX
         68grThT51MRr/2lZg1chy8KWdDq1CbMq5L4Jw8KNpzqlh/TOqSMzBjgK7NehmnOjFxx1
         nuzXTxbdWx0632cHVKpJp2HJvJYFHYolE4YQfguDTv0n0oPdKpN1pv5ueMi+tKM2Sj9Z
         3ZDR7oJxCoUz3bItvNlAP5DrV+qS2I1W+mkV4VBiV8ejPpbeLM4/f1nIcM6cjuFa4St1
         QIX7d587esKD53EKPSFhNJyOq5eGmtKx2OjoFYjR+SY4ub4nTzwJ5Tgf0pe9zgp8ljXS
         HceQ==
X-Gm-Message-State: AOAM5301O/71Lpn/SV2dzO0aCrZtlpr3D/7JysAdgkd2W8sPmrRJGLw3
        khRj50t6YBWHa019GpTIQuY3iQ==
X-Google-Smtp-Source: ABdhPJwLbvA0bwNZUrY2/J2Jh4bpdu76XjGMxG6gbt+toWQz5yZ5slWLQdM7mvfzT3xeFaz6EtnIkQ==
X-Received: by 2002:adf:f203:: with SMTP id p3mr17433255wro.339.1600106225140;
        Mon, 14 Sep 2020 10:57:05 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id m3sm22115050wrs.83.2020.09.14.10.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 10:57:04 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, kishon@ti.com,
        balbi@kernel.org, martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/5] usb: dwc-meson-g12a: Add support for USB on S400 board
In-Reply-To: <20200909160409.8678-1-narmstrong@baylibre.com>
References: <20200909160409.8678-1-narmstrong@baylibre.com>
Date:   Mon, 14 Sep 2020 10:57:01 -0700
Message-ID: <7hft7kw8b6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Amlogic AXG is close from the GXL Glue but with a single OTG PHY.

minor grammar nit: s/close from/close to/  (also in patches 2 & 3).
Otherwise..

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin



> It needs the same init sequence as GXL & GXM, but it seems it doesn't need
> the host disconnect bit.
>
> The Glue driver reuses the already implemented GXL & GXM work.
>
> The USB2 PHY driver needs a slight tweak to keep the OTG detection working.
>
> Neil Armstrong (5):
>   phy: amlogic: phy-meson-gxl-usb2: keep ID pull-up even in Host mode
>   dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: add the Amlogic AXG
>     Families USB Glue Bindings
>   usb: dwc-meson-g12a: Add support for USB on AXG SoCs
>   arm64: dts: meson-axg: add USB nodes
>   arm64: dts: meson-axg-s400: enable USB OTG
>
>  .../usb/amlogic,meson-g12a-usb-ctrl.yaml      | 22 +++++++-
>  .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 10 ++++
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 51 +++++++++++++++++++
>  drivers/phy/amlogic/phy-meson-gxl-usb2.c      |  3 +-
>  drivers/usb/dwc3/dwc3-meson-g12a.c            | 17 +++++++
>  5 files changed, 101 insertions(+), 2 deletions(-)
>
> -- 
> 2.22.0
