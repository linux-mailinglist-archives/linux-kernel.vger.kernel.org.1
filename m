Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871452D18E6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgLGTAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:00:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgLGTAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:00:47 -0500
From:   Krzysztof Kozlowski <krzk@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] soc: fix comment for freeing soc_dev_attr
Date:   Mon,  7 Dec 2020 19:59:52 +0100
Message-Id: <20201207185952.261697-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The soc_dev_attr is stored soc_dev->attr during soc_device_register() so
it could be used till the cleanup call: soc_device_unregister().
Therefore this memory should not be freed prior, but after unregistering
soc device.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/base/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index d34609bb7386..0af5363a582c 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -168,7 +168,7 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
 }
 EXPORT_SYMBOL_GPL(soc_device_register);
 
-/* Ensure soc_dev->attr is freed prior to calling soc_device_unregister. */
+/* Ensure soc_dev->attr is freed after calling soc_device_unregister. */
 void soc_device_unregister(struct soc_device *soc_dev)
 {
 	device_unregister(&soc_dev->dev);
-- 
2.25.1

