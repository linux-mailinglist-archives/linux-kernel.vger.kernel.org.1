Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7202C2980
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388947AbgKXO0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388940AbgKXO0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:26:03 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D21C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:26:03 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id a186so519677vkh.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V535LKPebOfjmdDDJc9j/Xpd7Zkc2zNFkTI8tr1mekU=;
        b=aeB8G8gSYDiqcddXjf+bJO2gfHQapF4V+qksw4C4BVIyGL0pyLClxbkKLh02/5t5Ij
         oVA/vysGuoetb0VxPUrgrCN1I8b9JE/KtU6QBoe4IjuXdvQEuvCWAoOWFkxfmmZaoN5s
         vSfOSVZOzeEs7lGZaPfl//8ukdsSJ+Vlh7rwh4HQ2ep4BAtYYhTVDzsX3j74fwUapJnS
         UQQepa7pny+PS5ntOk6paekdm5slPySeTjfgROn1cNhuIq2+DdLER2DTWf40uDfPIoBB
         O6+HOE6DSl1S/GpOvWJLRQWURiI8jjodXAlx/6BypopUJH6XyzUS2RBAvrOl+Kdvb8MQ
         b0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V535LKPebOfjmdDDJc9j/Xpd7Zkc2zNFkTI8tr1mekU=;
        b=AbKSwChCdW+oDRWrg4tW7+xq0lusM6A0vvu4mYaQOIiVdvpel8sm0o44WWHaLw4U7Q
         fTGkwdhyH/1Z6XhL7SzQRWPqjeJMzkKNup89oFKsT5Uas7/fk/4LexDgy52Zh6lUJEQQ
         fphgAGmv9ejykPXT8gDpoVkKjg3k6TV1ViCTH/r+789rJ1BQOGCTcxYWaqzkN3l3+Xf9
         q++pbr+033t9FQ8hucibQf5NLdvIhkaEyq/h6QATFb+HdMyBMEHz3JGpqW5L2113ejns
         a84Rt4jQvzxHGvDheemJarYqZe2dLANkhBebvI8KsCsb9f7EhYa7AO/Ip6VQD+JTMhsQ
         ccGQ==
X-Gm-Message-State: AOAM530nza6KCmnIKHnX/j0jF6XDxkbayHoLWqYDMIQmzItolW+QzfTv
        x6u4fIXyMvMscJ3yEQiTarWDyJS2aLoSOdOI5MXfig==
X-Google-Smtp-Source: ABdhPJxncBq4QuAAzYdQ/eP6RGjssC+Rf5A4aYYuP4SphD7S8VrYEzyMVPS7yB7/TJm6uE+PNx+C9iC8IvIHjz7gDsM=
X-Received: by 2002:a1f:2cd4:: with SMTP id s203mr4017312vks.6.1606227962418;
 Tue, 24 Nov 2020 06:26:02 -0800 (PST)
MIME-Version: 1.0
References: <20201122120056.100045-1-krzk@kernel.org>
In-Reply-To: <20201122120056.100045-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:25:25 +0100
Message-ID: <CAPDyKFpTCtJx7Uab+072fz-8Mr00r5DuHLwj9sFbbnN3k-f0pQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: depend on COMMON_CLK to fix compile tests
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Nov 2020 at 13:01, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The MFD_OMAP_USB_HOST uses Common Clock Framework thus it cannot be
> built on platforms without it (e.g. compile test on MIPS with LANTIQ):
>
>     mips-linux-ld: drivers/mmc/host/mtk-sd.o: in function `msdc_ops_set_ios':
>     mtk-sd.c:(.text+0x2bbc): undefined reference to `clk_get_parent'
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 310e546e5898..bfe912ec8955 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1023,6 +1023,7 @@ config MMC_BCM2835
>  config MMC_MTK
>         tristate "MediaTek SD/MMC Card Interface support"
>         depends on HAS_DMA
> +       depends on COMMON_CLK
>         select REGULATOR
>         select MMC_CQHCI
>         help
> --
> 2.25.1
>
