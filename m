Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C3B2C1FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgKXIQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:16:01 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:55358 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgKXIQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:16:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 144C0FB03;
        Tue, 24 Nov 2020 09:15:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mbhCes4yzW3W; Tue, 24 Nov 2020 09:15:57 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 0DB044026F; Tue, 24 Nov 2020 09:15:57 +0100 (CET)
Date:   Tue, 24 Nov 2020 09:15:56 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] drm/panel: mantix and st7703 fixes and additions
Message-ID: <20201124081556.GA3200@bogon.m.sigxcpu.org>
References: <cover.1605688147.git.agx@sigxcpu.org>
 <20201123214826.GC675342@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201123214826.GC675342@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Nov 23, 2020 at 10:48:26PM +0100, Sam Ravnborg wrote:
> Hi Guido,
> 
> On Wed, Nov 18, 2020 at 09:29:47AM +0100, Guido Günther wrote:
> > This adds new panel type to the mantix driver as found on the Librem 5 and
> > fixes a glitch in the init sequence (affecting both panels). The fix is at the
> > start of the series to make backporting simpler.
> > It also adds a patch to make st7703 use dev_err_probe().
> > 
> > changes from v1
> > - as per review comments by Linus Walleij
> >   - fix alphabetical ordering in Documentation/devicetree/bindings/vendor-prefixes.yaml
> >     https://lore.kernel.org/dri-devel/CACRpkdao_TMcpRsdK=7K5fNKJse0Bqwk58iWu0xsXdDNdcffVA@mail.gmail.com/
> >   - add reviewed by to all except 5/6, thanks
> > 
> > Guido Günther (6):
> >   drm/panel: st7703: Use dev_err_probe
> >   drm/panel: mantix: Tweak init sequence
> >   drm/panel: mantix: Allow to specify default mode for different panels
> >   drm/panel: mantix: Support panel from Shenzhen Yashi Changhua
> >     Intelligent Technology Co
> >   dt-bindings: vendor-prefixes: Add ys vendor prefix
> The above are all:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> >   dt-binding: display: mantix: Add compatible for panel from YS
> Please fix the subjects to read "dt-bindings" - just to be consistent.
> With that:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Fixed locally, thanks!
 -- Guido

> 
> 
> 	Sam
> 
