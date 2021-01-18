Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F752FA019
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404058AbhARMkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391741AbhARMgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:36:25 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D05C061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 04:35:44 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id JCbi2400E4C55Sk06CbiEb; Mon, 18 Jan 2021 13:35:42 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l1Tkz-004aJc-QR; Mon, 18 Jan 2021 13:35:41 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l1Tkz-002MtD-89; Mon, 18 Jan 2021 13:35:41 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Robin van der Gracht <robin@protonic.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/3] auxdisplay: ht16k33: Improvement, fix, and json-schema conversion
Date:   Mon, 18 Jan 2021 13:35:35 +0100
Message-Id: <20210118123538.564597-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Robin, Rob, Miguel,

This patch series contains various updates for the Holtek HT16K33 LED
controller with keyscan DT bindings and driver:
  1. Make the keypad function optional, from an old patch by Robin that seem to
     have fallen through the cracks,
  2. Fix the default brightness range,
  3. Convert DT bindings to json-schema.

Thanks!

Geert Uytterhoeven (2):
  dt-bindings: auxdisplay: ht16k33: Fix default-brightness-level range
  dt-bindings: auxdisplay: ht16k33: Convert to json-schema

Robin van der Gracht (1):
  dt-bindings: auxdisplay: ht16k33: Keyscan function should be optional

 .../bindings/auxdisplay/holtek,ht16k33.yaml   | 77 +++++++++++++++++++
 .../devicetree/bindings/display/ht16k33.txt   | 40 ----------
 MAINTAINERS                                   |  2 +-
 drivers/auxdisplay/ht16k33.c                  | 14 ++--
 4 files changed, 84 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/ht16k33.txt

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
