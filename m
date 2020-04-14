Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FFC1A8C07
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 22:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632742AbgDNUNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 16:13:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47822 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632762AbgDNUMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:12:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5F0812A1B70
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org
Subject: [PATCH] platform/chrome: cros_usbpd_logger: Add __printf annotation to append_str()
Date:   Tue, 14 Apr 2020 22:12:39 +0200
Message-Id: <20200414201239.1506922-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the compiler to verify the format strings vs the types of
the arguments. Also, silence the warning (triggered by W=1):

  cros_usbpd_logger.c:55:2: warning: function ‘append_str’ might be a
  candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_usbpd_logger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
index 7de3ea75ef46..d16931203d82 100644
--- a/drivers/platform/chrome/cros_usbpd_logger.c
+++ b/drivers/platform/chrome/cros_usbpd_logger.c
@@ -46,6 +46,7 @@ static const char * const fault_names[] = {
 	"---", "OCP", "fast OCP", "OVP", "Discharge"
 };
 
+__printf(3, 4)
 static int append_str(char *buf, int pos, const char *fmt, ...)
 {
 	va_list args;
-- 
2.25.1

