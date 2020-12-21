Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B292DF873
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 05:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgLUE4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 23:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgLUE4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 23:56:53 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AE4C061285
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 20:56:10 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id n3so7263434pjm.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 20:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aD8F3zpX0cSK92jlYFm0rPZ8cbFr64Bk+pWnjCzU/v4=;
        b=VFBOP49Tf/oZgAntdNhW5/0rbkNZyek5OtZgtlCtgrFklLUdLxiiSxWiqp6YFwULR/
         Lh8v1fWx8j7cTko5rRy7P1bKsLyVCSmbbqfalpCUvGLhkLAVL9eu7glGvXEJj6N/NFce
         iYj5D/l7NIjLbunQgdF+139RCpCyYWV7jpktQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aD8F3zpX0cSK92jlYFm0rPZ8cbFr64Bk+pWnjCzU/v4=;
        b=EZzXnRk8Nc+KHsLOSyAU9i/uLbCALZPSbgqtmgd9Q8eAs2qMDD+v+L6uNxKlPsdVze
         nYFQN9C8DS5T5Ids0tpf09N5U35imaRFlPCVbUVg8qhi14Ax57meLjJYB3rx4pZQ9sz4
         zOTWnxiJbki+B876uDEnWHzww75amJ6h1uYk0OsxcIRD+ETNvOF53CXFD1iQuyc0ffjU
         0IIxmn1SLwLJXUJHkdOo3SBmtQTcSSX/GzMy1osMuxpdkTfYT4n56jzFe0zr8FGtycEt
         v5bCUHhx8pLh8c3u6W5R0qtx6km1NyebHZyB0ouW95ago3PIqsC1KtUFR94ZJqYDDdsE
         KwwA==
X-Gm-Message-State: AOAM532bbDs0LlFhm+isFaXBOUqNRlajCnZV4MC6uPUe301tXz9SbH3L
        qW4RB3fXKAs/cNaobbu5UhYgHUCksnH19WeKDe/H94Gc/0ji6Q==
X-Google-Smtp-Source: ABdhPJw8d7KjqC65970hMryKNpzWdCeSPfe/lxCWvLhC2qMbCfOgQK8Qiu6yJLpZ5qihETaT+x5hLUOxaozHWXP1e5w=
X-Received: by 2002:a67:5c03:: with SMTP id q3mr10529936vsb.47.1608512380324;
 Sun, 20 Dec 2020 16:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20201014131936.20584-1-crystal.guo@mediatek.com>
 <20201014131936.20584-3-crystal.guo@mediatek.com> <1605529631.14806.57.camel@mhfsdcap03>
In-Reply-To: <1605529631.14806.57.camel@mhfsdcap03>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 21 Dec 2020 08:59:29 +0800
Message-ID: <CANMq1KDB5W9ON0+ormDjFy=9oJUnAq4A41zNTUMHcWsAJ449Zg@mail.gmail.com>
Subject: Re: [v6,2/4] dt-binding: mediatek: mt8192: update mtk-wdt document
To:     Crystal Guo <crystal.guo@mediatek.com>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        =?UTF-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= 
        <seiya.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 8:27 PM Crystal Guo <crystal.guo@mediatek.com> wrote:
>
> Hi Maintainers,
>
> Gentle pin for this patch.
>
> Thanks
>
> On Wed, 2020-10-14 at 21:19 +0800, Crystal Guo wrote:
> > update mtk-wdt document for MT8192 platform

Rob: I assume your input is required here? Any chance we could have
your ack/review on this trivial patch? It seems like the series is
blocked pending on a review of this patch -- and I don't think it has
been reviewed before.

Thanks,


> >
> > Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > index 45eedc2c3141..e36ba60de829 100644
> > --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > @@ -12,6 +12,7 @@ Required properties:
> >       "mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
> >       "mediatek,mt8183-wdt": for MT8183
> >       "mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
> > +     "mediatek,mt8192-wdt": for MT8192
> >
> >  - reg : Specifies base physical address and size of the registers.
> >
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
