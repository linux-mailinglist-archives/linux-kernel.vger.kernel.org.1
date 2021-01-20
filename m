Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25572FD2C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390615AbhATOfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388915AbhATO2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 09:28:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB63723380;
        Wed, 20 Jan 2021 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611152886;
        bh=zudMpjzae87hvmHg+zOy2DSdD7J4U324/qUR1LjfDPQ=;
        h=From:To:Cc:Subject:Date:From;
        b=kQ2iMVHtIc/QSdvt6bFHJWc/JcJxnSIhrmMzmfMl36KVD53fwhFnAJ4CKxD+p+Xic
         gIMMWkWb7sOMXjpRAGhEkZA3dETg00B1TVwYk5hOP387n11S+pPOZl4CryZth3Zcuq
         0kQfC9dPN6WR78Gc+ZZMR7hc5govqJovNdkcLBSvEoJFxQRTtozQVOc0GImdjc82FG
         LYDkgUMkmaLh5HFHrqRzpcFlYA2YT2mq/m0ypRIpemthl6lZ1AMOfeJDIWjzBdHfu9
         Y54TLRT1yV1oes1czsNhxoiBXHuwqVHX/zNpSa2Kwgwt1sMzw4QvROQCPU//conELO
         koEqmCjked24A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/2] mmc: remove obsolete drivers
Date:   Wed, 20 Jan 2021 15:27:59 +0100
Message-Id: <20210120142801.334550-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A few Arm platforms are getting removed in v5.12, this removes
the corresponding mmc drivers.

Link: https://lore.kernel.org/linux-arm-kernel/20210120124812.2800027-1-arnd@kernel.org/T/


Arnd Bergmann (2):
  mmc: remove dw_mmc-zx driver
  mmc: remove sirf prima/atlas driver

 .../devicetree/bindings/mmc/sdhci-sirf.txt    |  18 --
 .../devicetree/bindings/mmc/zx-dw-mshc.txt    |  31 ---
 drivers/mmc/host/Kconfig                      |  21 --
 drivers/mmc/host/Makefile                     |   2 -
 drivers/mmc/host/dw_mmc-zx.c                  | 234 -----------------
 drivers/mmc/host/dw_mmc-zx.h                  |  32 ---
 drivers/mmc/host/sdhci-sirf.c                 | 235 ------------------
 7 files changed, 573 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
 delete mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
 delete mode 100644 drivers/mmc/host/dw_mmc-zx.c
 delete mode 100644 drivers/mmc/host/dw_mmc-zx.h
 delete mode 100644 drivers/mmc/host/sdhci-sirf.c

-- 
2.29.2

