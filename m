Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F9A212F4D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 00:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgGBWLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 18:11:33 -0400
Received: from www.zeus03.de ([194.117.254.33]:35408 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgGBWLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 18:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=5btLRlWL6iYuvqAdGsI7N+8PtXM
        bcnVFh0+PrBTZDDk=; b=C1su7Y9TMYahK457HQd3ofWh4Rz31/AQ81RQcEUk4S7
        cpudONwbw+klegQAxEqNuHv1Nd7BA4uX5Br2y/SazLBHqYAkHX7w3rI1wFrgeSqv
        BGdHSU8HXriYmJ55fHtrhPyODIpJKAbRlXlWIbI6omaVL+5R7PNc85NHFShostGg
        =
Received: (qmail 1030335 invoked from network); 3 Jul 2020 00:11:30 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jul 2020 00:11:30 +0200
X-UD-Smtp-Session: l3s3148p1@HFTBsHyprsAgAwDPXwopAMEIVZ8qCmOC
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2] firmware: improve description of firmware_request_nowarn
Date:   Fri,  3 Jul 2020 00:11:07 +0200
Message-Id: <20200702221107.6562-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The doubled 'however' is confusing. Simplify the comment a little and
reformat the paragraph.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
---

Changes since v1:
 * removed uneeded empty line (sorry!)
 * added Luis' ack

 drivers/base/firmware_loader/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index ca871b13524e..9da0c9d5f538 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -838,12 +838,12 @@ EXPORT_SYMBOL(request_firmware);
  * @name: name of firmware file
  * @device: device for which firmware is being loaded
  *
- * This function is similar in behaviour to request_firmware(), except
- * it doesn't produce warning messages when the file is not found.
- * The sysfs fallback mechanism is enabled if direct filesystem lookup fails,
- * however, however failures to find the firmware file with it are still
- * suppressed. It is therefore up to the driver to check for the return value
- * of this call and to decide when to inform the users of errors.
+ * This function is similar in behaviour to request_firmware(), except it
+ * doesn't produce warning messages when the file is not found. The sysfs
+ * fallback mechanism is enabled if direct filesystem lookup fails. However,
+ * failures to find the firmware file with it are still suppressed. It is
+ * therefore up to the driver to check for the return value of this call and to
+ * decide when to inform the users of errors.
  **/
 int firmware_request_nowarn(const struct firmware **firmware, const char *name,
 			    struct device *device)
-- 
2.27.0

