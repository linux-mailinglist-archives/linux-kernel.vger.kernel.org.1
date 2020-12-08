Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310942D3451
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbgLHUgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgLHUgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:36:22 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2293CC061794;
        Tue,  8 Dec 2020 12:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/DyOBoLOqAhQxAxeB3gv8SslfqThYQTnekcdauSyF8E=; b=eclshOGA8AQxjO7k4z6TbvPjul
        2v4/mP20Q3YHTbbo4ykJtyOfhlcvVIpvFzCizjov1HdftKQ9TMI/jDMo2x83Frx5Cbwq10cwAunYK
        Wjpp8mtGKZfJq1p4GaAcXbtYv6odtis66bb8yAO/4mkMFfNtd1lvHw+doYzA/yJDSJ5HaURsqgDGf
        teEY3b2DlnWoHR5LpEWKl8+9Qzq+M9SNBHadiNKJcqm9txzplu+Aa5Yt6WoadI1xZ5gB0sXwlUjVh
        Y5t82sbyRrssYU70ohY1qg5RhoiHHZevWvmd4tj31W5Zpoi1dURauWWGhrTb5Fo+nh0XQ/I/hQo5y
        ARdowvmQ==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmj5J-0000Vp-47; Tue, 08 Dec 2020 19:55:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Chen <peter.chen@nxp.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@ti.com>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH -next] usb: cdns3: fix build when PM_SLEEP is not set
Date:   Tue,  8 Dec 2020 11:55:35 -0800
Message-Id: <20201208195535.30024-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error when CONFIG_PM_SLEEP is not enabled by adding
stubs for the PM_SLEEP functions.

../drivers/usb/cdns3/cdns3-plat.c: In function ‘cdns3_controller_resume’:
../drivers/usb/cdns3/cdns3-plat.c:246:2: error: implicit declaration of function ‘cdns_resume’; did you mean ‘cdns_remove’? [-Werror=implicit-function-declaration]
  cdns_resume(cdns, !PMSG_IS_AUTO(msg));
  ^~~~~~~~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Chen <peter.chen@nxp.com>
Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/core.h |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-next-20201208.orig/drivers/usb/cdns3/core.h
+++ linux-next-20201208/drivers/usb/cdns3/core.h
@@ -127,5 +127,10 @@ int cdns_remove(struct cdns *cdns);
 #ifdef CONFIG_PM_SLEEP
 int cdns_resume(struct cdns *cdns, u8 set_active);
 int cdns_suspend(struct cdns *cdns);
+#else /* CONFIG_PM_SLEEP */
+static inline int cdns_resume(struct cdns *cdns, u8 set_active)
+{ return 0; }
+static inline int cdns_suspend(struct cdns *cdns)
+{ return 0; }
 #endif /* CONFIG_PM_SLEEP */
 #endif /* __LINUX_CDNS3_CORE_H */
