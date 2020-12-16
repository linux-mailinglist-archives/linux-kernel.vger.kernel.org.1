Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33822DC5B4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 18:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgLPRuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 12:50:16 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:46826 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbgLPRuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 12:50:15 -0500
Received: by mail-oi1-f181.google.com with SMTP id q205so15678521oig.13;
        Wed, 16 Dec 2020 09:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=YHYDH46cBhOW9MdbdKwXMuCn0mvGIk5Dz9fJjNwpw0s=;
        b=p6T/B3Pd3m5YZbhX/6+xixH1mqatXah6L0qz5xc785+rebInEw1sV7rBxBIhtWOd3g
         idfgt0N9MDoL22RZPQ2NYrJVQhHxObdtkyjzgHPo3Y/C2VQoNiet0gZKsDsSLtHIewoQ
         HhwTc//7J4pTu/6TfPyU+6byeDsyPIfeHFrs+fbMC0skCvCahLJfc+lMoY7hrHFsg9Y2
         dIuJ73SW2hWZ+zywwPHnxxl1Vh824TaPNUC6Y7PaIF64Q0j0d20c86eLIJRwFz44vgN0
         BwJoKBwhWxBmUj0gCAfvLcLughiF5Yp22cqj1/gmVjmMjey63YbkM+WUv28QuQqGWyYS
         8g3g==
X-Gm-Message-State: AOAM532hTGOCkWsWamB9xCWx9B3t8r9WeFXOnoxDjmCD/2KTdDHFm+R9
        k5xUErqwSxJk5IGXqTMFUJ4lVxu/qw==
X-Google-Smtp-Source: ABdhPJzgO6SGUIjxTKKcvtXg+Ps/0Ezob5WhK3niJ7yLCYkPF3uPzL8zlOu4cWTWkkW9/8/w3JU1Gg==
X-Received: by 2002:aca:fc8d:: with SMTP id a135mr2720802oii.87.1608140974381;
        Wed, 16 Dec 2020 09:49:34 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q184sm541845oic.41.2020.12.16.09.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 09:49:33 -0800 (PST)
Received: (nullmailer pid 2167020 invoked by uid 1000);
        Wed, 16 Dec 2020 17:49:32 -0000
Date:   Wed, 16 Dec 2020 11:49:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree updates for v5.11
Message-ID: <20201216174932.GA2165438@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT updates for v5.11.

Rob

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.11

for you to fetch changes up to e33dc2f3636749c2f949a59c2ff8acd4a69c9c78:

  dt-bindings: mali-bifrost: Add dynamic-power-coefficient (2020-12-14 16:07:09 -0600)

----------------------------------------------------------------
Devicetree updates for v5.11:

- Add vendor prefixes for bm, gpio-key, mentor, FII, and Ampere

- Add ADP5585/ADP5589 and delta,q54sj108a2 to trivial-devices.yaml

- Convert fixed-partitions, i2c-gate and fsl,dpaa2-console bindings to
  schemas

- Drop PicoXcell bindings

- Drop unused and undocumented 'pnx,timeout' property from LPC32xx

- Add 'dynamic-power-coefficient' to Mali GPU bindings

- Make 'make dt_binding_check' not error out on warnings

- Various minor binding fixes

----------------------------------------------------------------
Alexandru Ardelean (1):
      dt-bindings: add ADP5585/ADP5589 entries to trivial-devices

Cengiz Can (1):
      dt-bindings: fsl-imx-drm: fix example compatible string

Cristian Ciocaltea (1):
      dt-bindings: Fix error in 'make dtbs_check' when using DT_SCHEMA_FILES

Fabrice Gasnier (1):
      dt-bindings: mfd: fix stm32 timers example

Geert Uytterhoeven (1):
      dt-bindings: pci: rcar-pci-ep: Document missing interrupts property

Gustavo Pimentel (1):
      dt-bindings: Fix typo on the DesignWare IP reset bindings documentation

Ionut-robert Aron (1):
      dt-bindings: misc: convert fsl,dpaa2-console from txt to YAML

Joel Stanley (1):
      dt-bindings: vendor-prefixes: Add FII

Jon Hunter (1):
      dt-bindings: Correct GV11B GPU register sizes

Jonathan Cameron (1):
      dt-bindings:i2c:i2c-gate: txt to yaml conversion

Krzysztof Kozlowski (1):
      dt-bindings: arm: vt8500: remove redundant white-spaces

Lukasz Luba (2):
      dt-bindings: mali-midgard: Add dynamic-power-coefficient
      dt-bindings: mali-bifrost: Add dynamic-power-coefficient

Max Merchel (1):
      dt-bindings: vendor-prefixes: correct the spelling of TQ-Systems GmbH

Quan Nguyen (1):
      dt-bindings: vendor-prefixes: Add an entry for AmpereComputing.com

Rafał Miłecki (1):
      dt-bindings: mtd: convert "fixed-partitions" to the json-schema

Rob Herring (4):
      dt-bindings: Don't error out on yamllint and dt-doc-validate errors
      dt-bindings: vendor-prefixes: Add undocumented bm, gpio-key, and mentor prefixes
      ARM: dts: lpc32xx: Remove unused and undocumented 'pnx,timeout'
      dt-bindings: Remove PicoXcell bindings

Zhen Lei (1):
      dt-bindings: i2c: dw: cancel mandatory requirements for "#address-cells" and "#size-cells"

xiao.ma (1):
      dt-bindings: trivial-devices: Add delta,q54sj108a2

 Documentation/devicetree/bindings/Makefile         |  10 +-
 .../devicetree/bindings/arm/picoxcell.txt          |  24 ----
 Documentation/devicetree/bindings/arm/vt8500.yaml  |   3 +-
 .../devicetree/bindings/crypto/picochip-spacc.txt  |  21 ---
 .../bindings/display/imx/fsl-imx-drm.txt           |   2 +-
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  |  17 +++
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  |  17 +++
 .../devicetree/bindings/gpu/nvidia,gk20a.txt       |   4 +-
 Documentation/devicetree/bindings/i2c/i2c-gate.txt |  41 ------
 .../devicetree/bindings/i2c/i2c-gate.yaml          |  39 ++++++
 .../bindings/i2c/snps,designware-i2c.yaml          |   8 --
 .../devicetree/bindings/mfd/st,stm32-timers.yaml   |   6 +-
 .../devicetree/bindings/misc/fsl,dpaa2-console.txt |  11 --
 .../bindings/misc/fsl,dpaa2-console.yaml           |  25 ++++
 .../devicetree/bindings/mtd/partition.txt          | 131 +-----------------
 .../bindings/mtd/partitions/fixed-partitions.yaml  | 152 +++++++++++++++++++++
 Documentation/devicetree/bindings/net/macb.txt     |   2 -
 .../devicetree/bindings/pci/rcar-pci-ep.yaml       |   9 ++
 .../devicetree/bindings/reset/snps,dw-reset.txt    |   2 +-
 .../bindings/timer/snps,dw-apb-timer.yaml          |   7 -
 .../devicetree/bindings/trivial-devices.yaml       |   8 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |  10 +-
 arch/arm/boot/dts/lpc32xx.dtsi                     |   3 -
 23 files changed, 290 insertions(+), 262 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/picoxcell.txt
 delete mode 100644 Documentation/devicetree/bindings/crypto/picochip-spacc.txt
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-gate.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gate.yaml
 delete mode 100644 Documentation/devicetree/bindings/misc/fsl,dpaa2-console.txt
 create mode 100644 Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
