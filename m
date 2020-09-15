Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956C626B807
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIPAep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:34:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgIONkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:40:43 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EADA222BA;
        Tue, 15 Sep 2020 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600177219;
        bh=zQdpBHvdP+GFbHzUjQoK7Yi9IhuH282IzC/8JJUQeaY=;
        h=From:To:Cc:Subject:Date:From;
        b=KKuAtd+Bh9rRv9G6oyxxjqZw2gK6U3kuYK1vz0FK0vEZiE8Ydpr5U/cUjADBy+L+K
         J9B03Mr+FRiOacKawMmDuYm9CYJTjezgJElx8ZPpap7wu8/2WzRBdOnxl2rtFmUT0s
         pRJ85vKfnPDyWb0bgCYdd963usMycziHcq4GeF8I=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kIBBx-00C1TP-Bc; Tue, 15 Sep 2020 14:40:17 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        kernel-team@android.com
Subject: [PATCH 0/2] irqchip/gic: Fix handling of Samsung's non-standard GIC
Date:   Tue, 15 Sep 2020 14:39:42 +0100
Message-Id: <20200915133944.1285456-1-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, m.szyprowski@samsung.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marek pointed out that the new IPI code broke the two ancient A9
platforms that use the dreaded Franken-GIC (not the official name), as
it appears it is even more broken than we though 9 years ago.

The fix isn't nice, although it allows for some further cleanup.

Marek, could you please give these another spin on your boards? For
convenience, I've stashed them as part of [1].

Thanks,

	M.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/ipi-as-irq

Marc Zyngier (2):
  irqchip/gic: Handle non-standard SGI deactivation on Samsung's
    Franken-GIC
  irqchip/gic: Cleanup Franken-GIC handling

 drivers/irqchip/irq-gic.c | 67 +++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 24 deletions(-)

-- 
2.28.0

