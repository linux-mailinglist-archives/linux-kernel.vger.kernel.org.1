Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080372B6C43
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgKQRto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:49:44 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:34854 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbgKQRtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:49:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 0DA99FB09;
        Tue, 17 Nov 2020 18:49:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BQydNYeGOYsT; Tue, 17 Nov 2020 18:49:38 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 016CC43F6E; Tue, 17 Nov 2020 18:49:37 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
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
Subject: [PATCH v1 0/6] drm/panel: mantix and st7703 fixes and additions
Date:   Tue, 17 Nov 2020 18:49:31 +0100
Message-Id: <cover.1605635248.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds new panel type to the mantix driver as found on the Librem 5 and
fixes a glitch in the init sequence (affecting both panels). The fix is at the
start of the series to make backporting simpler.
It also adds a patch to make st7703 use dev_err_probe().

Guido Günther (6):
  drm/panel: st7703: Use dev_err_probe
  drm/panel: mantix: Tweak init sequence
  drm/panel: mantix: Allow to specify default mode for different panels
  drm/panel: mantix: Support panel from Shenzhen Yashi Changhua
    Intelligent Technology Co
  dt-bindings: vendor-prefixes: Add ys vendor prefix
  dt-binding: display: mantix: Add compatible for panel from YS

 .../display/panel/mantix,mlaf057we51-x.yaml   |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 39 +++++++++++++++----
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 24 ++++--------
 4 files changed, 43 insertions(+), 23 deletions(-)

-- 
2.29.2

