Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E5E2115A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 00:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgGAWK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 18:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgGAWK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:10:57 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE9720780;
        Wed,  1 Jul 2020 22:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593641456;
        bh=3HfrAS82XLUcoM600jeQhPjXXnFAucaIgDdgxTpT5yk=;
        h=From:To:Cc:Subject:Date:From;
        b=YBtMdFtFk0Bq14Gn4WnGiiDEP3+gC8ZrsSRR1BYUgJ/yLMWcHzO5a/recuD1/CDg9
         IUdbvaKl1xq9LTIWqL/WsPbP8Qef81WWBnU4vWULuP5Nstxfm3vPaKDhTUo172btt3
         v7HrzYhVtX+n30XTRYs7Rqe22Y1VZgYZvYYk8UpQ=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] Fix IRQ 0 cases
Date:   Wed,  1 Jul 2020 17:10:38 -0500
Message-Id: <20200701221040.3667868-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid")
added a warning if platform_get_irq() returns IRQ 0.  These patches fix a
couple places that might cause that.

Bjorn Helgaas (2):
  ARM: imx: Remove imx_add_imx_dma() unused irq_err argument
  virtio-mmio: Reject invalid IRQ 0 command line argument

 arch/arm/mach-imx/devices/devices-common.h   | 2 +-
 arch/arm/mach-imx/devices/platform-imx-dma.c | 6 +-----
 arch/arm/mach-imx/mm-imx21.c                 | 3 +--
 arch/arm/mach-imx/mm-imx27.c                 | 3 +--
 drivers/virtio/virtio_mmio.c                 | 4 ++--
 5 files changed, 6 insertions(+), 12 deletions(-)


base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
-- 
2.25.1

