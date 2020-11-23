Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EF62C17FE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 22:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbgKWVuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 16:50:02 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:41724 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbgKWVuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:50:02 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id B5DC820051;
        Mon, 23 Nov 2020 22:49:59 +0100 (CET)
Date:   Mon, 23 Nov 2020 22:49:58 +0100
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
Subject: Re: [PATCH v2 1/6] drm/panel: st7703: Use dev_err_probe
Message-ID: <20201123214958.GD675342@ravnborg.org>
References: <cover.1605688147.git.agx@sigxcpu.org>
 <36405038d93eb148f3e8ed8e5ea70de8e87afd78.1605688147.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36405038d93eb148f3e8ed8e5ea70de8e87afd78.1605688147.git.agx@sigxcpu.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=ze386MxoAAAA:8 a=KKAkSRfTAAAA:8
        a=rHKuKkdvJC2CxiFwilcA:9 a=wPNLvfGTeEIA:10 a=iBZjaW-pnkserzjvUTHh:22
        a=cvBusfyB2V15izCimMoJ:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 09:29:48AM +0100, Guido Günther wrote:
> Less code and easier probe deferral debugging.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Nice.

I hope someone comes around and update all panel drivers to use
dev_err_probe. It is simpler and better than the current code.
And it will fix a lot of drivers that are noisy during deferral.

	Sam
