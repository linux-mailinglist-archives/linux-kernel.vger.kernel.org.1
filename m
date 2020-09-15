Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B50226AE14
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgIOTve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgIOTu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:50:59 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512BFC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:50:58 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id t16so4245625edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wGypR57e44lnrn/T3MrhnXSKZVtdZe8Et+2S99K2mho=;
        b=cxGAzRO0fXvk44Yp1ZSLcjtw7DvQRdbzcoFUQHSRSG8x/SNcJjgp2DTlAK4kA38ssl
         9pRExJ0CY6jQ/o2RuHT5w3f0vwmyO6B7/bNk6qnOU0hI/CseNYJC962F3PdUuP/m37dw
         vkqpM5Bs6ut5quo5WXzwdacP13xa86SDd+XgrA2KqO0yV1P9HPfyqYpiHIBfQujsk36R
         a7lZVbk4c07FN4deSbfivRYppXrNCCsBp0Eci0WXzNzUrypUY2jGmKdkNsOVjflQZ/DB
         wrYglXbfhGzeWTCXYbGVNVc7T4yd93IWG3gnYEhY7SP9CxH0FijTLI/JVyGEkb7zE9Lc
         Vg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wGypR57e44lnrn/T3MrhnXSKZVtdZe8Et+2S99K2mho=;
        b=GtzSj74wyAT8vw425+O78PzfVARkpkrhv3nD4eWaxhS3oHfTWHcyldjnL6clRne3d6
         ULsdRffprLUD55fTJu+WcWT81xlDkMu/S6OCkSOu6BWbHdqsSCs5/dk3TXRxTp/+54Yv
         Y/K0YpGNRyC+fjsTeM9giu3/TESlSnLJ/vdukhDXO//uwIZ13a8plxPsO8IBRhMD7Jzb
         bgvBUTeOaClP/FSbouBHpWTCZh3JIkCvExpLk+n5YZK5Wgz4kS6tx3BW0Upydi1xAgZg
         bxR4rCsw7K1ZbirAbrNu/85mHhAtqGcDRnPp0hGIKr/f5RRsNxB/y0NUMIZsO3UygVNp
         D+AA==
X-Gm-Message-State: AOAM5314YuCk2ktWHTJQlA5D4Y+8FrYdSJXcGp4hkzwbq+GJRzOl9AXy
        JMYId7JFouBEH2r232+1BTtQbCMy/S6DQb1LMGI=
X-Google-Smtp-Source: ABdhPJzzRC2QC1wIF17cEAtKLsbw4RuhNY4uEwxeqac8HFjP8QzYvGhHRSXvbnqkYFgOISrNFHzQZPtg+Ao/rliAHfc=
X-Received: by 2002:aa7:c0d3:: with SMTP id j19mr24908441edp.40.1600199457020;
 Tue, 15 Sep 2020 12:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200907083300.14412-1-narmstrong@baylibre.com> <20200907083300.14412-2-narmstrong@baylibre.com>
In-Reply-To: <20200907083300.14412-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 15 Sep 2020 21:50:46 +0200
Message-ID: <CAFBinCBz_wR7_PcNN7LYxz-Vw+p2HZWBPqQg6z_w5nN+v+tU=Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: meson-axg: add VPU and PWRC nodes
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Sep 7, 2020 at 10:33 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This add the display VPU node and the power controller PWRC node.
s/add/adds/

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +               vpu: vpu@ff900000 {
> +                       compatible = "amlogic,meson-axg-vpu";
> +                       reg = <0x0 0xff900000 0x0 0x100000>,
> +                             <0x0 0xff63c000 0x0 0x1000>;
my plan is to replace the "hhi" binding with a reference to the HHI
syscon - but at the same time I'm not sure if it's a good idea (or
whether for example CVBS support should be split off into a sub-driver
which is then part of the HHI MFD syscon).
maybe we can align at some point about the next steps with the the DRM
driver (as I want to add support for the older gen SoCs still)
that's nothing for this patch though


Best regards,
Martin
