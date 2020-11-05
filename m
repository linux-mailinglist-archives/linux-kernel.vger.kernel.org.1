Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798CE2A88DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbgKEVWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:22:18 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:47146 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbgKEVWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:22:18 -0500
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9737CC0004;
        Thu,  5 Nov 2020 21:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1604611337; bh=7NzLBMJhywvbz5o/KezRmvcXaTDUD/3R56cGXf39sdA=;
        h=From:To:Cc:Subject:Date:From;
        b=YN7xQXqskWqjRX2FT/v/WWofoAmnun6Tlrer8CdclM5kSv55mdn4zH3XqROLaZH5I
         HUpuZPhz/5EIqpWrX25wUmi8HOawpLY17wthGK9aaaMfizw4FECNitYylyCYlb3ScJ
         nvQL9L56VRke7RvpTJ/tCSFy4/zjcel9x1S+D72IHXYnqfSEYfW6EMFvP6naLrSCgE
         R1NOAgomkbJWUkjRCArYePKPxTXFlF+NQuyEoJ3LxspamTk77opk0FCikgcZav8xTf
         uwnqFJ3c1CdALFTmP18007BQLSLlr/vCNqRAKTCMfs7VZR1p0gNTx9Mn0Oc844JEa8
         8I7acEtaAFhvw==
Received: from vineetg-Latitude-7400.internal.synopsys.com (unknown [10.13.183.89])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6EC9CA006F;
        Thu,  5 Nov 2020 21:22:14 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 0/3] Remove drivers used by EZChip NPS platform
Date:   Thu,  5 Nov 2020 13:22:07 -0800
Message-Id: <20201105212210.1891598-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes any drivers associated with EZChip NPS platform
which was removed from ARC in 5.10-rc1.

Vineet Gupta (3):
  drivers/clocksource: Remove EZChip NPS clocksource driver
  drivers/irqchip: Remove EZChip NPS interrupt controller
  include/soc: remove headers for EZChip NPS

 drivers/clocksource/Kconfig     |  10 --
 drivers/clocksource/Makefile    |   1 -
 drivers/clocksource/timer-nps.c | 284 --------------------------------
 drivers/irqchip/Kconfig         |   7 -
 drivers/irqchip/Makefile        |   1 -
 drivers/irqchip/irq-eznps.c     | 165 -------------------
 include/soc/nps/common.h        | 172 -------------------
 include/soc/nps/mtm.h           |  59 -------
 8 files changed, 699 deletions(-)
 delete mode 100644 drivers/clocksource/timer-nps.c
 delete mode 100644 drivers/irqchip/irq-eznps.c
 delete mode 100644 include/soc/nps/common.h
 delete mode 100644 include/soc/nps/mtm.h

-- 
2.25.1

