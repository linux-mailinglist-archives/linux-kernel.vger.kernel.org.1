Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C002CFF67
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 22:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgLEVyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 16:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLEVyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 16:54:18 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78E1C0613D4;
        Sat,  5 Dec 2020 13:53:37 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id v22so9630631edt.9;
        Sat, 05 Dec 2020 13:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=788XxievPXArbKhvDvDluT6oiya+GFzAh5wtfB7G8D4=;
        b=uks2duSw/rgzSVa0Wy9QZMX4eX1UZD/ObNuA0OnGaaSL7ufLwU0SBIJw9OD0RYE+im
         F9mq/Mev8cTvLquRvwj2voJAknZZ6Rizl+z88koWxj7QBTEUi/MHm70wV1uWqOSAOx71
         S2MPnu0j1qpAzGpT5yXbQ54Ly8AJuHhl8s+dSiSgr/quGRfW9M3zOUV4rvxvn50hjjLw
         iE7fZl22f3ozNklSzh2IdCUjqnZcL+Uu11Y2HA/xVzNYbiVerky32y2LM6TDiDYZ7v0p
         ELAfQbMau+DYi8OYY/9vvbgGi4A7WMaHtJu+ghntJrNVc/sqTPTDuDpYrO9JlFyO/wAM
         +ntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=788XxievPXArbKhvDvDluT6oiya+GFzAh5wtfB7G8D4=;
        b=dlfNis7LJ4IVeLGqqFmxYj65JoQacXrNWm1Alt6nZJ7C/Yfhj+1oXOCbS0r6/Z3Jl9
         GgYd1ItVjQp0IdKNCukYU4DiqSkELz4u///yBKgR5Rd9xRtWDdlDKRFiKSn86ru6Wo4l
         TRxxNAgb6a1WBQ5cY4IZ5eFOZ1q27xuoeX1PC7UknjFnJf8c+NHUJCXIk4QL2NR0EtqI
         0q3iBtArKYGc2FiIQg+55bhGEHVkq2rl7G2I73DRLnijR0jTVku0XVxP+vdm3WmCXSOS
         p5PhM2vt03EyQK9xOqf0hKlg5JZTyvIY/qFnvIPjoRv4Zsn+QjMSIRz4v68Jz0DZgmFP
         LgQw==
X-Gm-Message-State: AOAM530Lw3fRB6M5jE8I/+gwck2tjNFtdIdcorvu4kMdWtsC5+YOiyDp
        47jzdXuHlhOL8aber9rWIDafv9jJyKLvL5gYXuv3sNLR7AE=
X-Google-Smtp-Source: ABdhPJx0u0sr7vJSvKYatDZ6Kj4W2Nxil0cvX0AFnS4Eb9JTemyfn2No/PM91puUzN+wuT5YoYiZj832uifQmVuaNAc=
X-Received: by 2002:a05:6402:3074:: with SMTP id bs20mr13697948edb.365.1607205216408;
 Sat, 05 Dec 2020 13:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20201201190100.17831-1-aouledameur@baylibre.com> <20201201190100.17831-2-aouledameur@baylibre.com>
In-Reply-To: <20201201190100.17831-2-aouledameur@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 5 Dec 2020 22:53:25 +0100
Message-ID: <CAFBinCARfW9wtLTA=siqCH_bhF8D_CLHxU9maM+Y6p_6njGOaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] phy: amlogic: phy-meson-gxl-usb2: fix shared reset
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

On Tue, Dec 1, 2020 at 8:01 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
>
> Use reset_control_rearm() call if an error occurs in case
> phy_meson_gxl_usb2_init() fails after reset() has been called ; or in case
> phy_meson_gxl_usb2_exit() is called i.e the resource is no longer used
> and the reset line may be triggered again by other devices.
>
> reset_control_rearm() keeps use of triggered_count sane in the reset
> framework. Therefore, use of reset_control_reset() on shared reset line
> should be balanced with reset_control_rearm().
>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
