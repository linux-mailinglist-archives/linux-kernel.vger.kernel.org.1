Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC5D203586
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 13:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgFVLTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 07:19:14 -0400
Received: from vps.xff.cz ([195.181.215.36]:39930 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbgFVLR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1592824673; bh=0Vk8stGqwL22qIG2VXDYwb4JGvkgfdgnlutpWfVaaAk=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=hMaou2x9rawSaJ4M5p19fxiRzhurhEBjn1CGSowMO2tYKM9IJoFSarK0qMn+8/iUC
         QH14oc8yPRGUjFTfQRuHO4k7CSkHb5Ln3SzS/3PWhOfd5i/IKTAmlqdjH7LMHbhgSz
         2stzJLkR41K8a25eokQMst0y1t2GMdOVo2NEgg60=
Date:   Mon, 22 Jun 2020 13:17:52 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Bhushan Shah <bshah@kde.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Luca Weiss <luca@z3ntu.xyz>,
        Martijn Braam <martijn@brixit.nl>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/5] drm: panel: Add Xingbangda XBD599 panel (ST7703
 controller)
Message-ID: <20200622111752.jsz37zl7hidvkozw@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>, Bhushan Shah <bshah@kde.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Luca Weiss <luca@z3ntu.xyz>, Martijn Braam <martijn@brixit.nl>,
        linux-arm-kernel@lists.infradead.org
References: <20200617003209.670819-1-megous@megous.com>
 <20200617003209.670819-4-megous@megous.com>
 <20200620212529.GB74146@ravnborg.org>
 <20200620223010.fqjwijiixxkewk3p@core.my.home>
 <20200622080802.GA650963@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200622080802.GA650963@ravnborg.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sam,

On Mon, Jun 22, 2020 at 10:08:02AM +0200, Sam Ravnborg wrote:
> On Sun, Jun 21, 2020 at 12:30:10AM +0200, Ondřej Jirman wrote:
> > On Sat, Jun 20, 2020 at 11:25:29PM +0200, Sam Ravnborg wrote:
> > > Hi Ondrej et al.

...

> > > Would it not be better to have one st7703 driver that suipports both
> > > panels?
> > >
> > > The driver would need dedicated init functions depending on the panel.
> > > But a lot could also be shared.
> > 
> > I guess I can move the code there. 
> In the same process the river should then be renamed to follow other
> sitronix based drivers.
> So the next developer will recognize this and use the correct driver.

Are driver/module names considered kernel ABI? Or is it possible to
change them?

regards,
	o.
