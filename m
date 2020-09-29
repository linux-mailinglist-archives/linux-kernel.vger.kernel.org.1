Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864B327D94E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgI2Uye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:54:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39207 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2Uyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:54:33 -0400
Received: by mail-oi1-f196.google.com with SMTP id c13so7034370oiy.6;
        Tue, 29 Sep 2020 13:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=PYQmC7QRqL/jrjd8bqNyBSlI+Fhl5IXu5uYdUVIKlrA=;
        b=U+dAx4lKwLa5Y6cOuy4tbD28nGMzSbrRdZ9XmSX9U6L7wGfWr4yF03hYijorEeOmsA
         cO2DUaT3D0VGsHvBEDYstKv1dUKvVPAMG7IMcSgk7eaImJ42A/eCBSwCzffMKTx5SdLB
         KOAsVqUdxkIjsv5JIBDK+xejZVWYJfmAHsRcZfNFl4RVJmK+jMc2rINDyBVyeAnwQgRX
         GdlJKGj4Nl9wqegonnVwXf9ofJ40O4sNCC/WsnpUj9Z7rmgYPZ21XRAwek2e2LvWIzTE
         WxbiGATIYywZzdjFZMDmr315umGYvsGqUOhZ87VDTEwfcp/ySeXwEfEcribuNvFrhcUg
         iAZQ==
X-Gm-Message-State: AOAM533DW19iwYmbFhlajvagFnN3gAkdzO2AChFry04Rz7Mbrq/1O2SG
        NuVJsQqiWuX9wqEkuRmhpen9p2NJTk2KHAs=
X-Google-Smtp-Source: ABdhPJzccgS0lVeNEYE02XkMKkSAAnx14wdjOG2wnSA4OeSW9k5T7aJlzInexX10TCMoOFwLBuA+0w==
X-Received: by 2002:aca:c758:: with SMTP id x85mr3797200oif.102.1601412872879;
        Tue, 29 Sep 2020 13:54:32 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r7sm1248386oij.34.2020.09.29.13.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:54:32 -0700 (PDT)
Received: (nullmailer pid 1171004 invoked by uid 1000);
        Tue, 29 Sep 2020 20:54:31 -0000
Date:   Tue, 29 Sep 2020 15:54:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.9, take 3
Message-ID: <20200929205431.GA1165869@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull a couple more DT related fixes for v5.9.

Rob

The following changes since commit 5cd841d2676a702e5f79a8bacbfbae3bfc2411f7:

  dt-bindings: vendor-prefixes: Remove trailing whitespace (2020-08-21 16:27:57 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.9-3

for you to fetch changes up to efe84d408bf41975db8506d3a1cc02e794e2309c:

  scripts/dtc: only append to HOST_EXTRACFLAGS instead of overwriting (2020-09-29 15:48:08 -0500)

----------------------------------------------------------------
Devicetree fixes for v5.9, take 3:

- Fix handling of HOST_EXTRACFLAGS for dtc

- Several warning fixes for DT bindings

----------------------------------------------------------------
Marek Behún (1):
      dt-bindings: leds: cznic,turris-omnia-leds: fix error in binding

Maxime Ripard (1):
      ARM: dts: bcm2835: Change firmware compatible from simple-bus to simple-mfd

Rob Herring (1):
      dt-bindings: Fix 'reg' size issues in zynqmp examples

Tero Kristo (1):
      dt-bindings: crypto: sa2ul: fix a DT binding check warning

Uwe Kleine-König (1):
      scripts/dtc: only append to HOST_EXTRACFLAGS instead of overwriting

 .../devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml | 4 ++--
 Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml            | 2 +-
 .../devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml       | 8 ++++----
 .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml         | 2 +-
 .../devicetree/bindings/leds/cznic,turris-omnia-leds.yaml         | 2 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                                | 2 +-
 scripts/dtc/Makefile                                              | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)
