Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787E72E1A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 10:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgLWJFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 04:05:54 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:34949 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgLWJFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 04:05:53 -0500
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH7FjJ5/fxd"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 47.10.6 DYNA|AUTH)
        with ESMTPSA id U05a81wBN91p1Lt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 23 Dec 2020 10:01:51 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: [PATCH 0/2] mmc: remove unused struct component card_detect_irq
Date:   Wed, 23 Dec 2020 10:01:49 +0100
Message-Id: <cover.1608714110.git.hns@goldelico.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

card_detect_irq is not used anymore since v4.1.
Remove it.

H. Nikolaus Schaller (2):
  mmc: jz4740: remove unused struct component card_detect_irq
  mmc: omap: remove unused struct component card_detect_irq

 drivers/mmc/host/jz4740_mmc.c          | 1 -
 include/linux/platform_data/mmc-omap.h | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.26.2

