Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B75A265767
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 05:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgIKD0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 23:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgIKD0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:26:31 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4905DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 20:26:31 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id z12so2673333uam.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 20:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvQeieKv5rbJ5/s4eJT2O+IOF1Saic+Crp4J5iKZQf4=;
        b=T8vrlsUAjemV8EhbZG0kArfreNIjgn3IeAZ9umv25OXXKgdAG3mJcTUQXK+AvrXY13
         BAI+4GjON0vIeGj0QPlOIe/Qlb74NnKfR2ocY5plpnUUgw7BwrDWNJRggjmMvQbn3T8Q
         aXC3dFk102DstFA3OZdzhxqeyaAstAE0NfHaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvQeieKv5rbJ5/s4eJT2O+IOF1Saic+Crp4J5iKZQf4=;
        b=tYyPmF3SbOXLntpKznIDrVJDuYellDkQzF8665IT7rR/GTH2AyAdc4KgcH7fRdTX4B
         TTlVE6Ap9Ah6BzU9r5Xu6kWCVhT5PyRCIYTUDhJJujJjWbaIPgVIotEdNWfYod0gdPX+
         6ytSB2in+OyPtjgVxXPVnO3t3yvdEUihMkFp21Zrpti3bBLJqsNjnrERIQC4ZpnulSTm
         y+WMVjupIcL3SfnBILa+erWY8x8c4aQ7sTFLKLBTu8jQdlBI35FwBsVF8h4g6FdVLgrg
         JKVLXlY2Mj0aZ3RxUV1T6yr8h00KacgvqicvNhdrw7d7Nnsxpw1QhT2ovdzqY6gCHDj8
         lqfA==
X-Gm-Message-State: AOAM532imSFlTAfmphTkEpYlx25cx6wu+fE2vri9m6cZrwdtFsxe+ga8
        LSX6LDsYWqkPkM9LVzwsxylhOWRH4CWZ2+38dFQxNA==
X-Google-Smtp-Source: ABdhPJwxVrNhrniN5woxKGWcan1oHwHrjdiscQz8zYmgZM3N/r1SrH7wmqgMzlo7PmXudZk/YFVEzcQkn29JMBnylaw=
X-Received: by 2002:ab0:1450:: with SMTP id c16mr523uae.27.1599794789775; Thu,
 10 Sep 2020 20:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200803071501.30634-1-crystal.guo@mediatek.com>
In-Reply-To: <20200803071501.30634-1-crystal.guo@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 11 Sep 2020 11:26:20 +0800
Message-ID: <CANMq1KA=t8srKfC4XUqk2V2N6Jm0=-P4rQSh9Mqbo2tFFKgTEA@mail.gmail.com>
Subject: Re: [v4,0/5] watchdog: mt8192: add wdt support
To:     Guenter Roeck <linux@roeck-us.net>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, seiya.wang@mediatek.com,
        Crystal Guo <crystal.guo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias, Guenter,

These patches have all been reviewed (apart from fairly trivial 2/5),
which maintainer should be picking those up?

Thanks!

On Mon, Aug 3, 2020 at 3:15 PM Crystal Guo <crystal.guo@mediatek.com> wrote:
>
> v4 changes:
> revise commit messages.
>
> v3 changes:
> https://patchwork.kernel.org/patch/11692731/
> https://patchwork.kernel.org/patch/11692767/
> https://patchwork.kernel.org/patch/11692729/
> https://patchwork.kernel.org/patch/11692771/
> https://patchwork.kernel.org/patch/11692733/
>
> Crystal Guo (5):
>   dt-binding: mediatek: watchdog: fix the description of compatible
>   arm64: dts: mt8183: update watchdog device node
>   dt-binding: mediatek: mt8192: update mtk-wdt document
>   dt-binding: mt8192: add toprgu reset-controller head file
>   watchdog: mt8192: add wdt support
>
>  .../devicetree/bindings/watchdog/mtk-wdt.txt  |  5 ++--
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  3 +-
>  drivers/watchdog/mtk_wdt.c                    |  6 ++++
>  .../reset-controller/mt8192-resets.h          | 30 +++++++++++++++++++
>  4 files changed, 40 insertions(+), 4 deletions(-)
>  create mode 100644 include/dt-bindings/reset-controller/mt8192-resets.h
>
>
