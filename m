Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CA72BC850
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 19:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgKVSsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 13:48:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgKVSsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 13:48:00 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E66F20760;
        Sun, 22 Nov 2020 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606070879;
        bh=hJX7xDdX2ZlSDFjW7BBC3VaOCIFCWXqEGMQ3o8vSc6Q=;
        h=From:To:Cc:Subject:Date:From;
        b=HMMSZIqxiC69QxVCz3P2dL/znRI6GAEsMm4ji12YGTEpTujHAyK9022tqK/o2cyMm
         8BE+7z/H7qk8XM3hWD6NDPF240wlScR0gaukffvk9QdwLdkD1b0w/SQ0webX4g2aS8
         86rlkTULEl8zy0DRqjWcrcE0B7jCBbGaFJvLWcSU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kguOz-00CjzM-C8; Sun, 22 Nov 2020 18:47:57 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Chen Baozi <chenbaozi@phytium.com.cn>,
        Xu Qiang <xuqiang36@huawei.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip fixes for 5.10, take #2
Date:   Sun, 22 Nov 2020 18:47:52 +0000
Message-Id: <20201122184752.553990-1-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, ardb@kernel.org, chenbaozi@phytium.com.cn, xuqiang36@huawei.com, kernel-team@android.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here a couple of patches from the irqchip department: a fix for a typo
leading to incorrect trigger information being used on the Exiu
driver, and another for save/restore with the GICv3 ITS.

Please pull,

	M.

The following changes since commit d95bdca75b3fb41bf185efe164e05aed820081a5:

  irqchip/ti-sci-inta: Add support for unmapped event handling (2020-11-01 12:00:50 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.10-2

for you to fetch changes up to 74cde1a53368aed4f2b4b54bf7030437f64a534b:

  irqchip/gic-v3-its: Unconditionally save/restore the ITS state on suspend (2020-11-22 12:58:35 +0000)

----------------------------------------------------------------
irqchip fixes for Linux 5.10, take #2

- Fix Exiu driver trigger type when using ACPI
- Fix GICv3 ITS suspend/resume to use the in-kernel path
  at all times, sidestepping braindead firmware support

----------------------------------------------------------------
Chen Baozi (1):
      irqchip/exiu: Fix the index of fwspec for IRQ type

Xu Qiang (1):
      irqchip/gic-v3-its: Unconditionally save/restore the ITS state on suspend

 drivers/irqchip/irq-gic-v3-its.c | 16 +++-------------
 drivers/irqchip/irq-sni-exiu.c   |  2 +-
 2 files changed, 4 insertions(+), 14 deletions(-)
