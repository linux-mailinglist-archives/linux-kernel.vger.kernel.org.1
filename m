Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27AD2DDA4C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 21:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgLQUtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 15:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgLQUtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:49:01 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9FBC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 12:48:21 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id s2so164044plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 12:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=XUyWc1iixeTrHWHei4BKr2qfrlqPpVbDyUgg8/KnCxo=;
        b=JCb/QpBsjq7oq9QqU5DC4Mu1AruYgcXhlWgsVYS24vpyNNkBPOqRJvB/Ujhzo185CB
         Ak4bAqEwkeHaPxaJYTMeZPdOVtWQQIBfjTFXEHvhfElTJMY8kglffEWrxXbNHd2RaAKY
         PTNZhiQQiuhHjO0Ne8Ii0kTni2++dzohowotLWJXGH5YJLZmHeCRfTsr+4acKVwRgLV8
         q00Mk5s8y33ngzGrcx/E9JHqjKhAvUQpyLT72SoUHT+/HHNibV1Stc4pqsxvNt3c1ntn
         infyk0bOj3gvk28v7+Af3+zaps8uLj1beBj4+gJuW3tZcT+o2JJl3H2wjqt92oywDKza
         9t3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XUyWc1iixeTrHWHei4BKr2qfrlqPpVbDyUgg8/KnCxo=;
        b=Y/MJ1KYnGSy05W9avFKfStM/D7y9DxJRSd/Zgq5adat9YFevQeiTHlywX6bNbm86ey
         TrsemkKAWcZTkMPIZ3oANp3ELkEm6YfWfPF4kQuGKGqrHTU1n43/qPdaXAmuJztEeDmK
         0qMgxUcQN5APuR5M8V0GAFva3z3G+2lUCMXlQSqOJKeibWuI1S6pnEqTQqxMtydg3Pk7
         FsSMU2su6lWuCF+nsuJsqdjeeW/oGPuKHGMIiCGvby6Y/Nfu9kwmQ8be8AR7I79kid14
         hMT8DuIW1SxpAsQkAbdvmM5ZSByAdPaY9Ff1MXl65Mz7MKHh9+Y2r1yZ4uiNAtCqcIDy
         XAjA==
X-Gm-Message-State: AOAM531mwTOmmSAvA/ajVyTvS23n2jTou3LuBVIxnBbvGpCYxovH+Lm+
        X+OD+JVBwN1l/p/SDgBRp/W0PsxcYFo=
X-Google-Smtp-Source: ABdhPJw20Xzpgq+EDZAAp4AtsHhFXVKQOZngBs07frtkrnAezYeqbUfnjLj6k0mY0s/gRkDQOtGirw==
X-Received: by 2002:a17:902:eac1:b029:da:88ce:f38f with SMTP id p1-20020a170902eac1b02900da88cef38fmr1125394pld.42.1608238101337;
        Thu, 17 Dec 2020 12:48:21 -0800 (PST)
Received: from localhost (g39.222-224-245.ppp.wakwak.ne.jp. [222.224.245.39])
        by smtp.gmail.com with ESMTPSA id o32sm7446149pgm.10.2020.12.17.12.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 12:48:20 -0800 (PST)
Date:   Fri, 18 Dec 2020 05:48:18 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mateusz Holenko <mholenko@antmicro.com>
Subject: [GIT PULL] OpenRISC updates for v5.11
Message-ID: <20201217204818.GG3168563@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider for pull.

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git@github.com:openrisc/linux.git tags/for-linus

for you to fetch changes up to d8398bf840f8964220508aff7901c924e322f5e8:

  openrisc: add local64.h to fix blk-iocost build (2020-11-21 07:13:07 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.11

This series adds:

 * New drivers and OpenRISC support for the LiteX platform
 * A bug fix to support userspace gdb debugging
 * Fixes one compile issue with blk-iocost

----------------------------------------------------------------
Filip Kokosinski (4):
      dt-bindings: vendor: add vendor prefix for LiteX
      dt-bindings: serial: document LiteUART bindings
      drivers/tty/serial: add LiteUART driver
      openrisc: add support for LiteX

Pawel Czarnecki (2):
      dt-bindings: soc: document LiteX SoC Controller bindings
      drivers/soc/litex: add LiteX SoC Controller driver

Stafford Horne (2):
      openrisc: fix trap for debugger breakpoint signalling
      openrisc: add local64.h to fix blk-iocost build

 .../devicetree/bindings/serial/litex,liteuart.yaml |  38 ++
 .../bindings/soc/litex/litex,soc-controller.yaml   |  39 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |  10 +
 arch/openrisc/boot/dts/or1klitex.dts               |  55 +++
 arch/openrisc/configs/or1klitex_defconfig          |  18 +
 arch/openrisc/include/asm/Kbuild                   |   1 +
 arch/openrisc/kernel/traps.c                       |   4 +-
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/litex/Kconfig                          |  19 +
 drivers/soc/litex/Makefile                         |   3 +
 drivers/soc/litex/litex_soc_ctrl.c                 | 176 +++++++++
 drivers/tty/serial/Kconfig                         |  32 ++
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/liteuart.c                      | 404 +++++++++++++++++++++
 include/linux/litex.h                              | 102 ++++++
 17 files changed, 903 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
 create mode 100644 arch/openrisc/boot/dts/or1klitex.dts
 create mode 100644 arch/openrisc/configs/or1klitex_defconfig
 create mode 100644 drivers/soc/litex/Kconfig
 create mode 100644 drivers/soc/litex/Makefile
 create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
 create mode 100644 drivers/tty/serial/liteuart.c
 create mode 100644 include/linux/litex.h
