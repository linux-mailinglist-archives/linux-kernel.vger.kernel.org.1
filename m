Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9597D2FD1B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbhATNY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:24:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389121AbhATNQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:16:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C86F723357;
        Wed, 20 Jan 2021 13:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611148570;
        bh=IjAfpLmYmn3Sa6lRu7q8XaJEX6wj6JeAgquDQjINgX8=;
        h=From:To:Cc:Subject:Date:From;
        b=gym/6avkieYDXiQyJ+hcq8B16CkDR5MgF+1F+8tJCGIU0xMGbvTM6ZPhaE15TMZ3a
         T3PIRUYhZCtCr+3gVhkFcw2SWNq0CSLdm7y8DzKFcY0gpouBqnKvxYlqFZSfjgudkT
         bj1r7EDTMP0u32fRFgVQVQgePvIwyqWXLxbYld9jYA9ZCt2luLoLAV2Bro+v+T0N9q
         AXXYWbGUUwV5jinQCW75x8sueCuNWxeKnim0Ubdpfj0Y7Vic82WB43/rqoHjDKwTYX
         fe0nmy0g3Z9dqm8l9RSfdS6dubkjuC6MKJikxdAyByCcS+ZI9CfisqJmR11pq1nkBD
         7Ya82PiPGQQ3w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/4] clocksource: remove obsolete drivers
Date:   Wed, 20 Jan 2021 14:15:55 +0100
Message-Id: <20210120131559.1971359-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A few Arm platforms are getting removed in v5.12, this removes
the corresponding clocksource drivers.

Link: https://lore.kernel.org/linux-arm-kernel/20210120124812.2800027-1-arnd@kernel.org/T/


Arnd Bergmann (4):
  timer: remove u300 driver
  timer: remove tango driver
  timer: remove sirf atlas driver
  timer: remove sirf prima driver

 .../timer/stericsson-u300-apptimer.txt        |  18 -
 drivers/clocksource/Kconfig                   |  27 --
 drivers/clocksource/Makefile                  |   4 -
 drivers/clocksource/timer-atlas7.c            | 281 -----------
 drivers/clocksource/timer-prima2.c            | 242 ----------
 drivers/clocksource/timer-tango-xtal.c        |  57 ---
 drivers/clocksource/timer-u300.c              | 457 ------------------
 7 files changed, 1086 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/stericsson-u300-apptimer.txt
 delete mode 100644 drivers/clocksource/timer-atlas7.c
 delete mode 100644 drivers/clocksource/timer-prima2.c
 delete mode 100644 drivers/clocksource/timer-tango-xtal.c
 delete mode 100644 drivers/clocksource/timer-u300.c

-- 
2.29.2

