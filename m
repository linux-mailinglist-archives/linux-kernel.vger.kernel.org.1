Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9A42BA9C8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgKTMER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:04:17 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:55622 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbgKTMEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:04:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 6FD90FB03;
        Fri, 20 Nov 2020 13:04:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9mru4xLJe_vU; Fri, 20 Nov 2020 13:04:11 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 2AAF743F6E; Fri, 20 Nov 2020 13:04:11 +0100 (CET)
Date:   Fri, 20 Nov 2020 13:04:11 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] drm/panel: mantix and st7703 fixes and additions
Message-ID: <20201120120411.GB23988@bogon.m.sigxcpu.org>
References: <cover.1605688147.git.agx@sigxcpu.org>
 <CACRpkda97nJ+nJX4CuZHQnDVh1mhykc_vb6xFh7BcAWQoNjz7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkda97nJ+nJX4CuZHQnDVh1mhykc_vb6xFh7BcAWQoNjz7Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
On Thu, Nov 19, 2020 at 09:35:17AM +0100, Linus Walleij wrote:
> On Wed, Nov 18, 2020 at 9:29 AM Guido Günther <agx@sigxcpu.org> wrote:
> 
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
> 
> The whole v2 looks fine to me, I'd give the devicetree
> maintainers some slack to review the DT patches then I can
> apply the whole series unless you have commit access yourself,
> just tell me.

I have commit access, so i can push in a couple of days. Thanks!

> 
> For all v2 patches:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> If you have time, please review my s6e63m0 series.
> https://lore.kernel.org/dri-devel/20201117175621.870085-1-linus.walleij@linaro.org/
> https://lore.kernel.org/dri-devel/20201117175621.870085-2-linus.walleij@linaro.org/
> https://lore.kernel.org/dri-devel/20201117175621.870085-3-linus.walleij@linaro.org/

Done. The panel stuff is always scary with all those magic values.
 -- Guido

> 
> Yours,
> Linus Walleij
> 
