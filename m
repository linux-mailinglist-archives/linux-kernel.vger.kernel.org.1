Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586E6270774
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgIRUuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRUuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:50:50 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B78C0613CE;
        Fri, 18 Sep 2020 13:50:50 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id i17so8573853oig.10;
        Fri, 18 Sep 2020 13:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQBTYd/i7TL56jJTVQHkU8FPXDKYu/R4V8hCfAPSzJo=;
        b=r5aGYz+rFyzfIoItLLPRg0TWqJvXc782/dbNt7PSwOTmfECPgbPftiexIoJkmFTXtY
         vK4UuJdscGwkJgnTX/t8tlx9Z7Q/eOVC0jbIuSuj/58XQV9sWNdOS+A82CTSgiMta/u7
         uWQ/AYufjXogcJQpODpjD2prPYEWNCRPkks3c2V8pRp4Vv1LgYC+cVsE+kJPPCw0FBj7
         U3e2A6CFjMd12j5aCHGLnlMRvVRHngzVR0UYL7Y7dNZk8OYyal5IYSmOiSEQuNazDCAR
         Qh+MUj5CCTduEz3ESmgu6tb6KIFSCO6DgMyIbu4nv4eveg7nFsKcRcOce2Ou2wCbVKqy
         bBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQBTYd/i7TL56jJTVQHkU8FPXDKYu/R4V8hCfAPSzJo=;
        b=XKLs9W4Qm2C/RipJ/HAiiZvKFtnyoKja2BlyCiVzA5RRLjU5rgw9QwLrTcpbBM0PRU
         bn/5PnPcp+b4cY+scWrMFpmvl2FEvKOY+dTkRDXGTda49QRiuiYtRyqehnDGQgXLrnS/
         m666k5ibdbFD8dXLAgVCAsMVZWIuVNZ5Rzh5nashvRaEnAZ+9+hGjT1og85OaBFFGZjs
         uXvYCEMD+YOmt/TXxUIIFlVvMxhvWr0JyUtgS0Yf5uTgsiFJUf61wyelEideh7EEby+k
         1azxlVgF4KEsxx+TUe/A3gxy9sLbHp4l8PXTYJ0HjwkzIUV3VcEX55KAtumQsiOURS2Q
         Lzrw==
X-Gm-Message-State: AOAM533mH74Hn2fVdyNFayw5eYeDPODHUc+FBWSGzzqgy0b98FT9/jh2
        OV6ZdjUkGZe13w+wuLP7IiyJBUbqdXHfjeXauXw=
X-Google-Smtp-Source: ABdhPJwLFCTn89gsNeMXFYjEgZOXfTDO437610Y8/ZpvSrOdjvvz3QGyVx9hb5/bIum5U6OkxJE/NlABUGT6UuwFT+0=
X-Received: by 2002:aca:5b45:: with SMTP id p66mr11082126oib.39.1600462249606;
 Fri, 18 Sep 2020 13:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
 <20200910172826.3074357-4-enric.balletbo@collabora.com> <CAOwMV_z9OBpNqStCH+HEcwAK-TwPVeMH4LwJbp78T1P=t9bEKg@mail.gmail.com>
In-Reply-To: <CAOwMV_z9OBpNqStCH+HEcwAK-TwPVeMH4LwJbp78T1P=t9bEKg@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 18 Sep 2020 22:50:37 +0200
Message-ID: <CAFqH_535GA6nFGKTu4wms1FGySfdrJPeZOf0tuFzaYwVwQuucg@mail.gmail.com>
Subject: Re: [PATCH 03/12] arm64: dts: mediatek: Add mt8173 power domain controller
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien,

Thank you to look at this.

Missatge de Fabien Parent <fparent@baylibre.com> del dia dv., 18 de
set. 2020 a les 22:24:
>
> Hi Enric,
>
> > -               scpsys: power-controller@10006000 {
> > -                       compatible = "mediatek,mt8173-scpsys";
> > -                       #power-domain-cells = <1>;
>
> This change generates a lot of warning when compiling the MT8173 device-trees.
>
> Warning (power_domains_property): /soc/mutex@14020000: Missing
> property '#power-domain-cells' in node /soc/syscon@10006000 or bad
> phandle (referred from power-domains[0])

I think that there is a mistake in that patch #power-domain-cells =
<1>; should not be removed. Anyway, I talked with Matthias and I'm
going to redefine this part as doesn't really match with the hardware.
We're thinking on something like this:

scpsys: syscon@10006000 {
     compatible = "mediatek,mtk-scpsys", "syscon";
      reg = ...

     power-controller {
           compatible = "mediatek,mt8173-power-controller";
           #power-domain-cells = <1>;

           <- the list of domains ->

Thanks,
  Enric
