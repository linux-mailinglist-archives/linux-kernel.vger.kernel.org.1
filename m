Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BDD22B340
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 18:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgGWQPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 12:15:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54255 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGWQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:15:45 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jydsj-0003Zl-Ie; Thu, 23 Jul 2020 16:15:41 +0000
From:   Colin King <colin.king@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: max14577: remove redundant initialization of variable current_bits
Date:   Thu, 23 Jul 2020 17:15:41 +0100
Message-Id: <20200723161541.994669-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable current_bits is being initialized with a value that is
never read and it is being updated later with a new value. The
initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mfd/max14577.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index fd8864cafd25..be185e9d5f16 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -61,7 +61,7 @@ EXPORT_SYMBOL_GPL(maxim_charger_currents);
 int maxim_charger_calc_reg_current(const struct maxim_charger_current *limits,
 		unsigned int min_ua, unsigned int max_ua, u8 *dst)
 {
-	unsigned int current_bits = 0xf;
+	unsigned int current_bits;
 
 	if (min_ua > max_ua)
 		return -EINVAL;
-- 
2.27.0

