Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F0F21398D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 13:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgGCLr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 07:47:26 -0400
Received: from vps.xff.cz ([195.181.215.36]:41220 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGCLrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593776842; bh=qqqmBER67TiL8jtm7bhHtg++KZK59EXYjjn1FFY2Hhw=;
        h=From:To:Cc:Subject:Date:From;
        b=DbJowuWfMruGil3/tF0lPmG3d0y4hFQRLw+XYenolmZ/mzEj51epdT99Ct62ZSdde
         Zn/toun/nuoisgRPpQPNppJZ4Zq1FtJUSEBIYfe8AeVmbCvM7nCicxuKAoQ6sCYPt6
         ecnmG4VeSr+xvqt5hOH2L9eA71MRPZeQchnhipWc=
From:   Ondrej Jirman <megous@megous.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ondrej Jirman <megous@megous.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix warnings in display/bridge/nwl-dsi.yaml DT example
Date:   Fri,  3 Jul 2020 13:47:15 +0200
Message-Id: <20200703114717.2140832-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes warnings in the example in display/bridge/nwl-dsi.yaml
revealed during port of display/panel/rocktech,jh057n00900.yaml to
yaml.

Please take a look.

thank you and regards,
  Ondrej Jirman

Ondrej Jirman (2):
  dt-bindings: display: Fix example in nwl-dsi.yaml
  dt-binding: display: Allow a single port node on rocktech,jh057n00900

 .../devicetree/bindings/display/bridge/nwl-dsi.yaml      | 9 +++++----
 .../bindings/display/panel/rocktech,jh057n00900.yaml     | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.27.0

