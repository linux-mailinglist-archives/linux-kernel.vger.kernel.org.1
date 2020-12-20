Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCDA2DF483
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 09:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgLTIwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 03:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbgLTIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 03:52:42 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBF6C061282
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 00:52:02 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d9so6131335iob.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 00:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w8c/XeH3OhekJ65ae7Kgx4wvrNHsagFJtU/k//HI1M4=;
        b=YMSjafd6Z2zq89rEKkoTKZ/rpuUTS1q+QTc+UUitpCCne530mDPOFiDIDjTEUsMdRT
         +0ZxCmIIHD4BXPs6Duvj2OyajmAOWdhkz5yewC3D17VU00IQygHx3l3c/Sm0OKtIISiW
         w7MePh8WRnqBwZzH6Pr/kqcKxqcWi1sLHlcqCOeouZTZz6TaaCNH+LKbDieQmNn6s/Nf
         3WwSHTZLHIMB8R7CsIT7xFjFXST6tQybxx2Xi32/j1xV3kmi6ylsEoLWQodyLLvm46W1
         n6T8tlojb4LAOAlVvhAdf6NEW/NOdcgkDHqmSg9dxjUc5txkeitFzDgRjgzppKf5d5lv
         cR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w8c/XeH3OhekJ65ae7Kgx4wvrNHsagFJtU/k//HI1M4=;
        b=rBFJLnPyXujp0CHI0FEgyBM4kXgqPRNscyLpgfgrYTaplhp5BItLFzwWaykZv+7YQE
         Ve+k+E2AXLSKOEaXTkFALAgKPUXtUl3edzxYDxpUQHaOt38pjyvoNzfkqoWWMdvNy7Sr
         Fh7owjp4JXfRUxl8tomDyywKzSlj7LOge3yOQplPCdOUwForGlQwxPqNC3JAi2vkfZx7
         9qXjDQmFplA2FvS70++HFGJY+NkDgAzyvBQPoePu33gGInis5vJDtHHZ7OEPROKOlsZF
         nJgeVhZsbIXsGpJti1GL0o6a/VnL5qD1uIxZTIDlosPptm79KnCEsQ6ghLVq3eOYfXR9
         hQDQ==
X-Gm-Message-State: AOAM532oTVEPl69GUBQbGBJJmQn4jhoG9uCSWTEL56VCARJekdCt24mf
        vgzew98A87VQHlQpvI1lNhG7wS5dtQ5/2WSb2fI=
X-Google-Smtp-Source: ABdhPJyWtwahbrOCWKkgpwYXpuTw8UpnmhIQaW9Fm/mqd2Z3fZt7HE8h20HLeiDj5YSCQnmoh7qchbUaccnruZFbmSM=
X-Received: by 2002:a05:6602:1cb:: with SMTP id w11mr10320647iot.45.1608454321761;
 Sun, 20 Dec 2020 00:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20201215214656.649896-1-bert@biot.com> <410ca5c2-96a0-ffd0-e1c0-316fe37ff4d5@microchip.com>
 <faaa83e9-e702-abfc-e298-fda1fa224b69@biot.com>
In-Reply-To: <faaa83e9-e702-abfc-e298-fda1fa224b69@biot.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Sun, 20 Dec 2020 16:51:50 +0800
Message-ID: <CAJsYDVLEggVBAm2zXe1V7jeAAwXACHrEj6UgiL9Wc-cNq=Zuww@mail.gmail.com>
Subject: Re: [PATCH] Add spi-nor driver for Realtek RTL838x/RTL839x switch SoCs
To:     Bert Vermeulen <bert@biot.com>
Cc:     Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>, john.garry@huawei.com,
        Boris Brezillon <bbrezillon@kernel.org>,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        open list <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sun, Dec 20, 2020 at 7:01 AM Bert Vermeulen <bert@biot.com> wrote:
>
> On 12/16/20 9:30 AM, Tudor.Ambarus@microchip.com wrote:
> > On 12/15/20 11:46 PM, Bert Vermeulen wrote:
> >> This driver supports the spiflash core in all RTL838x/RTL839x SoCs,
> >> and likely some older models as well (RTL8196C).
> >>
> > Can we use SPIMEM and move this under drivers/spi/ instead?
>
> I wasn't aware spimem was the thing to use for new drivers. I will rewrite
> the driver to that API.

Are there any limitations preventing this from being implemented as a
generic SPI controller?
spi-nor and spi-mem are designed for controllers which can only perform
spi-mem/spi-nor specific transfers. I can't find such limitations from
your current driver code.

BTW I found a SPI controller driver for RTL8196C here: [0]
It seems pretty similar to the controller you are working on.

[0]: https://github.com/hackpascal/lede-rtl8196c/blob/realtek/target/linux/realtek/files/drivers/spi/spi-realtek.c

-- 
Regards,
Chuanhong Guo
