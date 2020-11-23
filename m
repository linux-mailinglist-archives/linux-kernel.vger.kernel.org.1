Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF212C17F5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 22:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbgKWVse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 16:48:34 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:41600 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbgKWVsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:48:33 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id E532B20051;
        Mon, 23 Nov 2020 22:48:27 +0100 (CET)
Date:   Mon, 23 Nov 2020 22:48:26 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
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
Message-ID: <20201123214826.GC675342@ravnborg.org>
References: <cover.1605688147.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1605688147.git.agx@sigxcpu.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=7gkXJVJtAAAA:8
        a=meuEgf7b1xA4w4DmhCUA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Wed, Nov 18, 2020 at 09:29:47AM +0100, Guido Günther wrote:
> This adds new panel type to the mantix driver as found on the Librem 5 and
> fixes a glitch in the init sequence (affecting both panels). The fix is at the
> start of the series to make backporting simpler.
> It also adds a patch to make st7703 use dev_err_probe().
> 
> changes from v1
> - as per review comments by Linus Walleij
>   - fix alphabetical ordering in Documentation/devicetree/bindings/vendor-prefixes.yaml
>     https://lore.kernel.org/dri-devel/CACRpkdao_TMcpRsdK=7K5fNKJse0Bqwk58iWu0xsXdDNdcffVA@mail.gmail.com/
>   - add reviewed by to all except 5/6, thanks
> 
> Guido Günther (6):
>   drm/panel: st7703: Use dev_err_probe
>   drm/panel: mantix: Tweak init sequence
>   drm/panel: mantix: Allow to specify default mode for different panels
>   drm/panel: mantix: Support panel from Shenzhen Yashi Changhua
>     Intelligent Technology Co
>   dt-bindings: vendor-prefixes: Add ys vendor prefix
The above are all:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

>   dt-binding: display: mantix: Add compatible for panel from YS
Please fix the subjects to read "dt-bindings" - just to be consistent.
With that:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>


	Sam
