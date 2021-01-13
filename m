Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAC12F4C06
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbhAMNIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbhAMNIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:08:48 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA3EC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:08:08 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id p128so482866vkf.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9oNPkEmUO8hkna64sWXChu9HZjo0m5iZB1erj41a8uI=;
        b=qwHeMAfERZE2zl0I3lja3nX4Mwy/ITwsKJwRa1su1yK90uMfOzGztxj9fWZNqvNv8S
         7/oc1PDmQUX3bnjseo4QLXR/7Gv2NRuBmyCjHAwDAW+5Jo6tMsxSe9OpV/tkq3GVl0Lf
         OsSRcY4nHnN+1qNrbqZaD97FSchwHLK7q9ZPiUA6FWW7ajkKfAyCnxIAl6aT1+vXtt7h
         0+vJa0/3j9DlBiL9TFXutAPHb5GN3JPMLYh1MWgr0RysQyW1as0DKK+ZXKBYZg0wqStO
         4r4pmEeIpBFtiOe1XBwlY27+0zS52pNudiNejRz8H33dZIREBYFwpP40yKuUdH8rtBPa
         tVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9oNPkEmUO8hkna64sWXChu9HZjo0m5iZB1erj41a8uI=;
        b=I1sHck+YNALNbbnQeyITQUPNoJa8+NArzwFTfYPMN4uvTn6N90xaEJzG+lToyfz7e6
         PGxs5q22je4274TOKJWKADPa/UcUjmaBoSaqlWAOn3P0uP0GrNL2/xKf08pPhMpf84+n
         u1nploAUk5nTfz2m6OawPgpvhiNSmvtnunHwf2bOxKTtfa5ZqSKOJGcQjiAu8xtfzXDC
         OZ2EZ4sqvxqtGua8X/DOvZgOB823SoJaSPE80ypPUCIviiADZOtuKwZFs+Amr+jXkPs9
         f6d+CNnTHrf/83P88IiFnuP5TiQ+RCxrOKtWVzsHysko+iw65kbMCcp5q0HufIqiTyF3
         vxYw==
X-Gm-Message-State: AOAM531BIYvUrZFnQ4QisgqRJDaSM8CSyFeGoTQeJ9lTMWjf54zoq4M+
        KUauOh2W5bKUzMKDxjHXBoAAudKSNaaECbmoCR7xmg==
X-Google-Smtp-Source: ABdhPJwQAdLZCij898e92iUq41dX/oLOa7oxz5JbuvCcn/nO6ViS5Yj/u70grbsYjpCHZ4QTgqWEAq4wyvXXNKee4vo=
X-Received: by 2002:a1f:dec2:: with SMTP id v185mr1702891vkg.8.1610543287405;
 Wed, 13 Jan 2021 05:08:07 -0800 (PST)
MIME-Version: 1.0
References: <20210113105723.7916-1-ricky_wu@realtek.com>
In-Reply-To: <20210113105723.7916-1-ricky_wu@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 14:07:30 +0100
Message-ID: <CAPDyKFrxpihy6wtRUPrAwRkWnwmRVxJcKMUesbjPKJURfrHJBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: rtsx: add delay before power on
To:     =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        feng@realsil.com.cn, Doug Anderson <dianders@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 at 11:57, <ricky_wu@realtek.com> wrote:
>
> From: Ricky Wu <ricky_wu@realtek.com>
>
> Make sure voltage below 0.5V before power on
> when do power cycle
> At mmc-core recognition card phase will do
> power cycle quickly so our device need at least 100ms
> to make voltage down to below 0.5V
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

Applied for next, by amending the changelog a bit, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index e6f5bbce5685..0e5043a03965 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -906,6 +906,8 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
>         if (host->power_state == SDMMC_POWER_ON)
>                 return 0;
>
> +       msleep(100);
> +
>         rtsx_pci_init_cmd(pcr);
>         rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_SELECT, 0x07, SD_MOD_SEL);
>         rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_SHARE_MODE,
> --
> 2.17.1
>
