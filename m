Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA97926AE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgIOT4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgIOT43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:56:29 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E11C06174A;
        Tue, 15 Sep 2020 12:56:24 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w1so4283378edr.3;
        Tue, 15 Sep 2020 12:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5enmw55Fem91T+DvSEPj+IHaKM+L/svAv9/sGu5e/Ds=;
        b=Gy4OIdYhMC4ajTg8uZCs56b6sKBkd/CL8S0ZImQKbOenS8JYsOhm18ycyFH8evinV5
         rmc7GMn1mi9cYIBxaLiYk2r2GKAdjRg0sOoexSqDlLL+A87yqXDSLBDL8whX2LCWgbKh
         fFLLGClMLQ/wRYvbPDPlm8gdN86iYVCgo4hKff3Ltwm4vR5AK8JHFxq+IEhnAaKqPKeZ
         sOehcLDyjGzRQltjh6Y11gL/ALPKQTk2de7UP1wofvbOBpeT0RjWGIL3Q4j02KNLbgo1
         bdYkVsC0jBEkj/kMmxeci910gUtO3FnPG1N5SLdLbnc+DhCyy51Tgff8nFBplAeNddci
         RXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5enmw55Fem91T+DvSEPj+IHaKM+L/svAv9/sGu5e/Ds=;
        b=Fh1G92zh9xN7MLF2537aRgCfAnEdfp3MgQTLi1d3MQJLSQ2/UnOlMhbkMMIxKGoZkp
         4ftHI76kjBAzE4DODDcBchSkd2t6nuQTvGi9Zr1Tkf8e4iiogDSK0SnNX1USmKwhwG4A
         DUrcl4MBHERRhdUMMWtnnGHrP/d246BXHggtR+GVsV+vteTvPlCxDWwMngPybnxnhwNy
         Hv1Q5gGyhcSU7iLll8DQJUMMlTQhp92rtnTAnNzBalC3QIxoAmUhU03K8a9Md6pSGTqx
         dWcfSjZHkcMavtd6W4MhTcvAveBVWJ00HJOt6Qj3dNYvEvbGWea8JfYfhRMj+3hvcFNa
         6QaA==
X-Gm-Message-State: AOAM532s2VmEXAAO3iUNHJNfwsX14RI38nihEzC25mKoGOBRUklzrHbw
        1EncO+PYOf5hHqE9AWKaafqmfKj1L9tGCnaieWU=
X-Google-Smtp-Source: ABdhPJyO2Vz913/ZIwBEKyWfB1ZN+xCuIcv/RKPdD0tvxcr1S81cF3S8LwcKpW5biZPhxEtVuLj7sVRGM4i+XxBltEc=
X-Received: by 2002:a05:6402:489:: with SMTP id k9mr23681127edv.287.1600199783611;
 Tue, 15 Sep 2020 12:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200909160409.8678-1-narmstrong@baylibre.com> <20200909160409.8678-3-narmstrong@baylibre.com>
In-Reply-To: <20200909160409.8678-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 15 Sep 2020 21:56:12 +0200
Message-ID: <CAFBinCBEoGv5PJqG_b+HyEoe9Lm0+CaFbsBaUnFv4uB0M6J78Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: add
 the Amlogic AXG Families USB Glue Bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil

On Wed, Sep 9, 2020 at 6:04 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic AXG is close from the GXL Glue but with a single OTG PHY.
nit-pick: I think this should be "close to"

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  .../usb/amlogic,meson-g12a-usb-ctrl.yaml      | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> index 5b04a7dfa018..c0058332b967 100644
> --- a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> +++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> @@ -25,13 +25,14 @@ description: |
>    The Amlogic A1 embeds a DWC3 USB IP Core configured for USB2 in
>    host-only mode.
>
> -  The Amlogic GXL & GXM SoCs doesn't embed an USB3 PHY.
> +  The Amlogic GXL, GXM & AXG SoCs doesn't embed an USB3 PHY.
nit-pick: not sure if we need to fix it here: s/doesn't/don't/
(personally I would also put AXG first - in reality it changes nothing though)


Best regards,
Martin
