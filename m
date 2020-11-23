Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7EF2C0247
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 10:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgKWJ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 04:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgKWJ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 04:29:10 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7763CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 01:29:08 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so17834112wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 01:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oP064/YoSybWWI1ICcTHgnGH1OvAg15H5I+x0Ai9JRM=;
        b=tc2FSCMksV59M4EtjiNWL8jYvxSmVR5HwDIE2Tr71m7qnAClPF0WfZkK6l1j/v1pgg
         x3DTXnv21DuT7mxGXmNG95HWVVpIqYllKM/ceX8Fk8RbADMKqK3EGw2NAn20RT50uLx9
         vzqySDtlWJF3MoZCG8RGUDaaMsLff8t+PiO1O6H5/57hg3Vi6lG8UYMjV9YhVpj6JKhA
         Xue3Hp163rBm56BqB6SfMRrGA/D/n14zLO0EG3XGCEnzGT3vvfVEHtAYk+vH8n8i6VFR
         Zj6MDGOiEXGasq1wZNU2vR5zQxf9gHNLRMH3CaCTrxQ8shv8EmDqwRwN7OUX8Jc+XDCG
         2/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oP064/YoSybWWI1ICcTHgnGH1OvAg15H5I+x0Ai9JRM=;
        b=MdNl3i6StMNGrLY5GkGBSUZr1Fvo9s02uBqQdVDflj6h7wgEyKMQ+H/GK2HTF5Dit3
         NxIFDJtUB7Hjl0wnNSOS4klteaHwgyv/vGTXd+nM5kenH3kMNndf0uxkMSZaBe41T3PV
         CoZSekGoaxdjRL7YsuX0GbMOC2MCyHj2EHtob5t8o2ZkiBXKQ7RyLOlC4fMm73M0J8yh
         /IDs7/PP2QyFjNwrFhps+c944M1Nkmz3YVlWDhLlsgMuhNpTSgZ1TpjdMHYONK6XKopv
         BCG2yPTR8KC44sNG1pyVpqYr0gMMCeLhuydZ/b/wHldHAgc04YqVX41kOD6G+LS/dGkA
         b02A==
X-Gm-Message-State: AOAM531G73R567xb8V/h/9WcK4ksyIv8Pp1J1tjzEVItVgqs0TyOYjjo
        kN2Yf6qk1A1GccopUQRiu/iO+w==
X-Google-Smtp-Source: ABdhPJze2Z5hY7lJwWf2ixUnWns3PM39g8MYfbp1DWWbev6ip3HKIrUgxapU+GPCk1Cbcjffb3NKdA==
X-Received: by 2002:a5d:6743:: with SMTP id l3mr29498818wrw.82.1606123747181;
        Mon, 23 Nov 2020 01:29:07 -0800 (PST)
Received: from ?IPv6:2001:861:3a84:7260:8466:ae5d:28e6:8c59? ([2001:861:3a84:7260:8466:ae5d:28e6:8c59])
        by smtp.gmail.com with ESMTPSA id a15sm18441848wrn.75.2020.11.23.01.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 01:29:06 -0800 (PST)
Subject: Re: [PATCH 0/3] usb: meson: fix shared reset control use
To:     Kevin Hilman <khilman@baylibre.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20201113000508.14702-1-aouledameur@baylibre.com>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Message-ID: <093933fc-eac5-de56-d314-a1348de348af@baylibre.com>
Date:   Mon, 23 Nov 2020 10:29:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113000508.14702-1-aouledameur@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Felipe and Kevin,


Could you please review this patchset ?

Thank you in advance.

On 13/11/2020 01:05, Amjad Ouled-Ameur wrote:

> This patchset fixes a usb suspend warning seen on the libretech-cc by
> using reset_control_rearm() call of the reset framework API.
> This call allows a reset consummer to release the reset line even when
> just triggered so that it may be triggered again by other reset
> consummers.
>
> reset_control_(de)assert() calls are called, in some meson usb drivers,
> on a shared reset line when reset_control_reset has been used. This is not
> allowed by the reset framework.
>
> Finally the meson usb drivers are updated to use this new call, which
> solves the suspend issue addressed by the previous reverted
> commit 7a410953d1fb ("usb: dwc3: meson-g12a: fix shared reset control
> use").
>
> Important:
> Please DO NOT merge before this patch [0] is merged, it adds
> reset_control_rearm() call to the reset framework API.
>
> [0] https://lore.kernel.org/lkml/20201112230043.28987-1-aouledameur@baylib
> re.com/
>
> Amjad Ouled-Ameur (3):
>    phy: amlogic: phy-meson-gxl-usb2: fix shared reset controller use
>    usb: dwc3: meson-g12a: fix shared reset control use
>    phy: amlogic: meson8b-usb2: fix shared reset control use
>
>   drivers/phy/amlogic/phy-meson-gxl-usb2.c |  5 ++++-
>   drivers/phy/amlogic/phy-meson8b-usb2.c   |  4 ++++
>   drivers/usb/dwc3/dwc3-meson-g12a.c       | 19 +++++++++++++------
>   3 files changed, 21 insertions(+), 7 deletions(-)
>
>
Sincerely,
Amjad

