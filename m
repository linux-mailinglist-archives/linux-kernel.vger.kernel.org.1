Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57EB248CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 19:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgHRRdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 13:33:51 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:43470 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbgHRRdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:33:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id F0524FB03;
        Tue, 18 Aug 2020 19:33:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SV7xgiVLbSXw; Tue, 18 Aug 2020 19:33:45 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 08CA94576F; Tue, 18 Aug 2020 19:33:44 +0200 (CEST)
Date:   Tue, 18 Aug 2020 19:33:44 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] drm/panel: Add panel driver for the Mantix
 MLAF057WE51-X DSI panel
Message-ID: <20200818173344.GA382297@bogon.m.sigxcpu.org>
References: <cover.1597652012.git.agx@sigxcpu.org>
 <20200818170556.GA2291850@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200818170556.GA2291850@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,
On Tue, Aug 18, 2020 at 07:05:56PM +0200, Sam Ravnborg wrote:
> Hi Guido.
> 
> On Mon, Aug 17, 2020 at 10:14:33AM +0200, Guido Günther wrote:
> > 
> > The panel uses a Focaltech FT8006p, the touch part is handled by the already
> > existing edt-ft5x06. It can be found in e.g. the Librem 5.
> > 
> > Changes from v2:
> > - Due to review comments by Sam Ravnborg, thanks!
> >   https://lore.kernel.org/lkml/20200815212727.GA1244923@ravnborg.org/
> >   - Drop unused header
> >   - Use newline before comment
> > - Add Reviewed/Acked-by by Sam Ravnborg, thanks!
> >   https://lore.kernel.org/lkml/20200815212727.GA1244923@ravnborg.org/
> >   https://lore.kernel.org/lkml/20200815212750.GB1244923@ravnborg.org/
> >   https://lore.kernel.org/lkml/20200815212840.GC1244923@ravnborg.org/
> > 
> > Changes from v1:
> > - Due to review comments by Sam Ravnborg, thanks!
> >   https://lore.kernel.org/dri-devel/20200815083917.GA993113@ravnborg.org/
> >   - Don't preserve newlines with '|' in description
> >   - Use reset-gpios and backlight from panel-common.yaml
> >   - Reindent example
> >   https://lore.kernel.org/dri-devel/20200815093226.GB993113@ravnborg.org/
> >   - Drop unused includes
> >   - Use dev_* instead of DRM_* for printing
> >   - Turn off regulators in reverse order from enable
> >   - Silence errors in mantix_{shutdown,remove}
> >   - Drop duplicate mipi_dsi_dcs_enter_sleep_mode()
> >   https://lore.kernel.org/dri-devel/20200815100230.GA1002374@ravnborg.org/
> >   - Use dev_err_probe()
> > - Add delays when turning off panel as suggested by the data sheet
> > 
> > This series is against next-20200814.
> > 
> > Guido Günther (3):
> >   dt-bindings: vendor-prefixes: Add mantix vendor prefix
> >   dt-bindings: Add Mantix MLAF057WE51-X panel bindings
> >   drm/panel: Add panel driver for the Mantix MLAF057WE51-X DSI panel
> 
> Maxime Ripard backmerged -rc1 to drm-misc-next so I went ahead and applied
> this series to drm-misc-next, forgetting you got commit rights. As they are
> already pushed out too late for you to do push them - sorry!

On the contrary: Thanks a lot for handling this so promptly!
 -- Guido
