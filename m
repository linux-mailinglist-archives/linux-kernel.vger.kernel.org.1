Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B1626ADEC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgIOTqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgIOTqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:46:07 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF8AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:46:07 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id i22so6784393eja.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p5sSzZShC8ORfwakA39ohe9fpx/z+QIq6SJKz70/TTM=;
        b=dbghCkE3Hztc+UqWBaVJ5vK3WzRel4RlQnWexaWlRD1F19KQk+fmGvushQq5ZZHhru
         hJxuM67sWo4kXfUzRYoU0Vxy5nlcYXIQkRW3hwOTG3QsmGnLhR3cYY9LLWC+Wuajfbjt
         vbc2wmJQMO88nW/e5iX3bwe7kAfREFFuj4dSRxWEdv47EOzamDfAZUhqwpPVOsykOnLH
         G/pWuseRHRm0In86mQrDE/Tr7Xzy4ZvHWsmHP9opxWLAA+XRCi/zMAWNKg0xppBNUbJa
         cYSF96dfpjGBTBlm6AMkHrMgv4W370asMd4bShZiydmcRKychtYpWIBsUqiNiCQVwTWs
         Nmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p5sSzZShC8ORfwakA39ohe9fpx/z+QIq6SJKz70/TTM=;
        b=XtSFZnS7MvuBL+TbUC1n5OwmACYTGMVHYXxqoJUWjZvOh9A1lFeVJo1ydZOeGa89DH
         Jr7v0L01k4wnWQNgYGMZadAPPxpZN45pY2xOMvRfc269b5DWS7892AwX65TeHAskwEiC
         xyJhHX3eo95yOHol2a1szO37ewPsszj/7PRraXmhO5NvY2eHiuRAiayPDTW0h63za6jM
         IZZbLxKBF/XAKzlClCdPdcNzAmkhGsKxCn+gGks3lMUQmTAsO5y39D4Uc+olKb7jjfK9
         wz7eYJGFYnHbZG2f0UhQUgN5NXNwQx1i6aotR+SbNb3ar4vBdDxw76n/ndtsNHYenGZa
         I5DA==
X-Gm-Message-State: AOAM531KD9Orb7I/JJ1r3jIDGIvHWbuzfINsmqpfYLAFw/uHspVbGmd2
        /7KqoJ68f4+JbcWNGq7I6etFUybIqS0ibE+MNgMrz8csx10=
X-Google-Smtp-Source: ABdhPJy2LEJ8BwYCymGuaU1iN1I1+zohKpeh+4Eu1QEO9Ok9estRenU6CYefzM0h0DDp5c0zJ4H6XVdhuQFsCHIICqk=
X-Received: by 2002:a17:906:874f:: with SMTP id hj15mr22844624ejb.539.1600199165966;
 Tue, 15 Sep 2020 12:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200904161654.24141-1-narmstrong@baylibre.com> <20200904161654.24141-3-narmstrong@baylibre.com>
In-Reply-To: <20200904161654.24141-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 15 Sep 2020 21:45:55 +0200
Message-ID: <CAFBinCBDKuFkdR_mTyS=cYPAwCzs+TYSh1koR29uTnLmAtugPQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] soc: amlogic: meson-ee-pwrc: add support for
 the Meson AXG SoCs
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Sep 4, 2020 at 6:17 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Power Controller in the Amlogic AXG SoCs is similar to the GXL one
> but with less VPU memory domains to enable and a supplementary Audio
> memory power domain.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I have three small comments below - no show-stoppers though:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +static struct meson_ee_pwrc_mem_domain axg_pwrc_mem_vpu[] = {
> +       VPU_MEMPD(HHI_VPU_MEM_PD_REG0),
> +       VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
> +};
> +
I would put this above the g12a one

[...]
> +static struct meson_ee_pwrc_domain_desc axg_pwrc_domains[] = {
> +       [PWRC_AXG_VPU_ID]  = VPU_PD("VPU", &gx_pwrc_vpu, axg_pwrc_mem_vpu,
> +                                    pwrc_ee_get_power, 5, 2),
> +       [PWRC_AXG_ETHERNET_MEM_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
> +       [PWRC_AXG_AUDIO_ID] = MEM_PD("AUDIO", axg_pwrc_mem_audio),
> +};
> +
same here

[...]
>  static struct meson_ee_pwrc_domain_data meson_ee_gxbb_pwrc_data = {
>         .count = ARRAY_SIZE(gxbb_pwrc_domains),
>         .domains = gxbb_pwrc_domains,
> @@ -566,6 +588,10 @@ static const struct of_device_id meson_ee_pwrc_match_table[] = {
>                 .compatible = "amlogic,meson-gxbb-pwrc",
>                 .data = &meson_ee_gxbb_pwrc_data,
>         },
> +       {
> +               .compatible = "amlogic,meson-axg-pwrc",
> +               .data = &meson_ee_axg_pwrc_data,
> +       },
this one I would put above the GXBB one


Best regards,
Martin
