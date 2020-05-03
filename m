Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0F1C2E2E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 19:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgECRT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 13:19:28 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:36778 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728852AbgECRT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 13:19:27 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49FXlm1tRrzBc;
        Sun,  3 May 2020 19:19:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588526365; bh=qcQYscDQASAGGq1qfnXT5pHuuM+wfGhJkYYXvoJsvpU=;
        h=Date:From:Subject:To:Cc:From;
        b=od9bfafI4fE+aETX9mRSeCMvhi1V9y75RE3umEUcAlesgbmLaUJMSdfsdxwXjueBV
         dOKMOTwOObMzN/0M1bkMfIvc4cIeiQQGQaiAzCY3fyV8+w68k+K6xSdhQyCwzf8hFU
         Jd/Jbwp2Vq3aR0zEkL5D3v/Tv4UwEIsqh0cfzLU4XgS6t3Df604INpiBjgbTSPDLtF
         wrHr6fDiA2xHrv+GLitZ4Gj2AFDAkaIC/bYFpYoqe6FnpoQr+YW5Lf4bCExZtITZlw
         QOtr5pxLzdsoaJX6uvlHXqHnKCoZKr/dvEvqzgEye90QbQdF465VUwFNI4astf323T
         wjIlBp/rTObrg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 03 May 2020 19:19:15 +0200
Message-Id: <cover.1588526049.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 0/3] clk: at91: support configuring more clocks via DT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends AT91 clock support with references to PCKx and
PLLA/PLLB/AUDIOPLL. This makes the DT be able to fully specify (assign)
clock parents when needed.

First patch simplifies clock table allocation. Next two update the table
with missing clock pointers and IDs.


Michał Mirosław (3):
  clk: at91: optimize pmc data allocation
  clk: at91: allow setting PCKx parent via DT
  clk: at91: allow setting all PMC clock parents via DT

 drivers/clk/at91/at91rm9200.c    | 12 ++++++---
 drivers/clk/at91/at91sam9260.c   | 13 +++++++---
 drivers/clk/at91/at91sam9g45.c   | 10 +++++---
 drivers/clk/at91/at91sam9n12.c   | 12 ++++++---
 drivers/clk/at91/at91sam9rl.c    | 10 +++++---
 drivers/clk/at91/at91sam9x5.c    | 10 +++++---
 drivers/clk/at91/pmc.c           | 44 ++++++++++++--------------------
 drivers/clk/at91/pmc.h           |  8 ++++--
 drivers/clk/at91/sam9x60.c       | 10 +++++---
 drivers/clk/at91/sama5d2.c       | 12 ++++++---
 drivers/clk/at91/sama5d3.c       | 10 +++++---
 drivers/clk/at91/sama5d4.c       | 10 +++++---
 include/dt-bindings/clock/at91.h |  4 +++
 13 files changed, 106 insertions(+), 59 deletions(-)

-- 
2.20.1

