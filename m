Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306412D1AB4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgLGUkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:40:42 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:50767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLGUkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:40:42 -0500
Received: from orion.localdomain ([95.114.88.149]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MSbt9-1kblMp2nub-00Sv8x for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020
 21:38:10 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v3] drivers: gpio: put virtual gpio device into their own submenu
Date:   Mon,  7 Dec 2020 21:38:09 +0100
Message-Id: <20201207203809.18187-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:O/pUk4LyfxAbG39WNks3Vbb8ERrhg6Cxmx1flqb83Cq5A3JridE
 YmLu87xX5Hvudnqqa8RQXj8UKJz6lv6pcRRKdV/8BIERUd6RBS3HVRY7vup18kLeeHPWsmp
 gbNtd46yzDlcb4QZVaQl6dP3Y+xr+gLrZPJ5Z3tCozkJ9SzyZkLXwK2VtNIj36zB774lbVS
 bHUXBJ1Dag/V/LpyiRJQA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pJxDEHjybfI=:4+Lohec+CP7MNQWYsflCiL
 iuzaQHRppkrYTALc2TwEwpoCXfewmIS8hN6sSRC6ETnHBSFYmznS6R8yB792Fb2MCpJKFvYH8
 xzpbUFwO+8OP1KbK47cr21nSepCq4kimFMn+CcxojRq3MAkHrVZzZcv4lqmaixoBmxRX6MoNh
 qmB56y55unqHIzy4xSalAyh2t/zLwCBGKr6T3FCZB5UWaxRwu+YQ9lAkMs/JBkDDEe7Q/tn9J
 VLl5sovocZDay6exMrDcAp3T/XU7NTOGohWl7tdWx0KO3k8043mCBnWY0iIk3+RKvoopCeGxh
 MIXJLVKkCDSt7fzzUy66KWmnHgIPB2yEiXk8YrCJfZ3jHT1354EXppqgKMXcj+vBUTsZ5OFqD
 qN6z4ibypxCt+X9VIGrOcB1tG4wsGmAc2IusYhZAAXLLArgo30ukJcL0g4WPo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we already have a few virtual GPIO drivers, and more to come,
this category deserves its own submenu.

changes v2: fixed menu title (replaced "devices" by "drivers")
changes v3: added patch changelog

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 5d4de5cd6759..8596f9320971 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1590,6 +1590,8 @@ config GPIO_VIPERBOARD
 
 endmenu
 
+menu "Virtual GPIO drivers"
+
 config GPIO_AGGREGATOR
 	tristate "GPIO Aggregator"
 	help
@@ -1613,4 +1615,6 @@ config GPIO_MOCKUP
 	  tools/testing/selftests/gpio/gpio-mockup.sh. Reference the usage in
 	  it.
 
+endmenu
+
 endif
-- 
2.11.0

