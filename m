Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5032D28B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgLHKUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:20:02 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:33878 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbgLHKUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:20:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 0F5B8FB03;
        Tue,  8 Dec 2020 11:19:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 329PfmN7beNV; Tue,  8 Dec 2020 11:19:18 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 959564068D; Tue,  8 Dec 2020 11:19:17 +0100 (CET)
Date:   Tue, 8 Dec 2020 11:19:17 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 6/6] dt-binding: display: mantix: Add compatible for
 panel from YS
Message-ID: <20201208101917.GA30738@bogon.m.sigxcpu.org>
References: <cover.1605688147.git.agx@sigxcpu.org>
 <eb2a0e50cbb8cfebc27d259607e543fedb8c6b27.1605688147.git.agx@sigxcpu.org>
 <20201207213206.GA864202@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201207213206.GA864202@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Dec 07, 2020 at 03:32:06PM -0600, Rob Herring wrote:
> On Wed, 18 Nov 2020 09:29:53 +0100, Guido Günther wrote:
> > This panel from Shenzhen Yashi Changhua Intelligent Technology Co
> > uses the same driver IC but a different LCD.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  .../devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml  | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

Thanks! I've appplied the series to drm-misc-next now.
Cheers,
 -- Guido
