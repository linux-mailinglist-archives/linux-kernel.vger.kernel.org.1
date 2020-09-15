Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA9D26AE8D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 22:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgIOUN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 16:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgIOUEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 16:04:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9AFC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 13:04:41 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g4so4324026edk.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 13:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VLKDKb2hqOkm7A363zOGeGMrkT18ahcERl8cCX3o8xw=;
        b=PH3y9sLztgyw3CJmJfG2SV+wUTjAmuGkywTHpU5Lw828iENIufekxVTxdpIkk1yJ61
         4AXVOOBCtkf1q6o2ey/oRGb+T2f2N564/jkjmmoCm3bgkECNDgTJYOGr+r7VkEYjdh9E
         V2VEgNnWZGRBNudMae2EBKPyckFxT5RH0/bSRI8Yo/iCorpRw3JaS24k7Oe5erl95hvP
         CVCz73FI/6r4Ii1JAIjEftd1IewkxH9F/SBvGsc/ITHydnxQms/6WvrRnCy08eF8/StP
         5UPPKmpqxXu6HtDgqJKyiNVolzXrdYMUM67yVU8hPp0EQY1BtAiB77HvHUAKgfgCaHGK
         rAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VLKDKb2hqOkm7A363zOGeGMrkT18ahcERl8cCX3o8xw=;
        b=jspCZQdwLbgtN92DnJulAAgYK4w5/DvodnrduPmNpcqOAiNWLuQCljhAO4ub7I0Gx3
         R8frxxiSDc6RUBpYE5j0BQO/mKTgmlRFJCMc4RHYBInIf8zZ9QoYzGDsUHJWE/qcIBr9
         htS5/hAih63n9z7jOLafkoDR1r9Bj5jvJ2lwoS3qqDygKUaRXOE2tBTFtrIozacjfdM1
         +TTL2vE6mc6adUaoX+idu92bNXVNhOl+EEiYNom4+H9i+JE9OT0d4mEK8ccinkOU3ZqW
         /EDZk2U0fx26kazgYC/8mimCqskRPnhYOp4Qywk40rHPmvXTwa3zc4uz+xwkse/MRdqu
         /EWg==
X-Gm-Message-State: AOAM533IjiQ3T4KUsxAFNklFQmRKHwqiFqRxu9dD+fnqY8O4rDmcBtnk
        cJfvqtfctmvfJB3JoGyoTGjvL3ZKLwg86tjYqpE=
X-Google-Smtp-Source: ABdhPJznwiU7gDjxGlhX7mV7m/E3LQs2BNJMDejZyDM65uf7+iiwIcD62u1g0/76v/XmrKZZ+Mv7s45qrdH7aToP/qc=
X-Received: by 2002:aa7:d6c4:: with SMTP id x4mr23711789edr.98.1600200280107;
 Tue, 15 Sep 2020 13:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200909160409.8678-1-narmstrong@baylibre.com> <20200909160409.8678-5-narmstrong@baylibre.com>
In-Reply-To: <20200909160409.8678-5-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 15 Sep 2020 22:04:29 +0200
Message-ID: <CAFBinCDgqu-fz9xhwC0-jEbQ3eY9RfZEb61-BR6Mwjbo3BOedg@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: meson-axg: add USB nodes
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, Sep 9, 2020 at 6:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This adds the USB Glue node, with the USB2 & USB3 controllers along the single
> USB2 PHY node.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +                       usb2_phy1: phy@9020 {
> +                               compatible = "amlogic,meson-gxl-usb2-phy";
> +                               #phy-cells = <0>;
> +                               reg = <0x0 0x9020 0x0 0x20>;
> +                               clocks = <&clkc CLKID_USB>;
> +                               clock-names = "phy";
> +                               resets = <&reset RESET_USB_OTG>;
> +                               reset-names = "phy";
> +                               status = "okay";
if you have to re-send this for some reason: status = "okay" is the
default and so I think we can omit this
