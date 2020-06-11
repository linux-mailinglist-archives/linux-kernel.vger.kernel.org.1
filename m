Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B5B1F6AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 17:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgFKP1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 11:27:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55252 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFKP1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:27:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jjP6i-0006HN-DI; Thu, 11 Jun 2020 15:27:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] char/mwave: remove redundant initialization of variable bRC
Date:   Thu, 11 Jun 2020 16:27:08 +0100
Message-Id: <20200611152708.927344-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable bRC is being initialized with a value that is never read
and it is being updated later with a new value.  The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/char/mwave/smapi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/mwave/smapi.c b/drivers/char/mwave/smapi.c
index 691f5898bb32..f8d79d393b69 100644
--- a/drivers/char/mwave/smapi.c
+++ b/drivers/char/mwave/smapi.c
@@ -126,7 +126,7 @@ static int smapi_request(unsigned short inBX, unsigned short inCX,
 
 int smapi_query_DSP_cfg(SMAPI_DSP_SETTINGS * pSettings)
 {
-	int bRC = -EIO;
+	int bRC;
 	unsigned short usAX, usBX, usCX, usDX, usDI, usSI;
 	static const unsigned short ausDspBases[] = {
 		0x0030, 0x4E30, 0x8E30, 0xCE30,
@@ -497,7 +497,7 @@ int smapi_set_DSP_cfg(void)
 
 int smapi_set_DSP_power_state(bool bOn)
 {
-	int bRC = -EIO;
+	int bRC;
 	unsigned short usAX, usBX, usCX, usDX, usDI, usSI;
 	unsigned short usPowerFunction;
 
-- 
2.27.0.rc0

