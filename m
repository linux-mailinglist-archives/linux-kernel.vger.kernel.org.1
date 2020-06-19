Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE652201B59
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 21:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389537AbgFSTeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 15:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389119AbgFSTeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:34:12 -0400
Received: from mail.halogenos.org (halogenos.org [IPv6:2a02:c207:2037:5246::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666C2C061794
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:34:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30B2E1500CEA;
        Fri, 19 Jun 2020 21:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=superboring.dev;
        s=dkim; t=1592595249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uq0xrum51HmWn3xiHXygblxWgDkAasvA84OM1An3Zuk=;
        b=lcSigGO6Oc1jyiOTI7wQrJXQEiQ8k3vjSqkvoOX3vsJX+U648BcxKWqMkDNWzheshZeosC
        1qqhYJQ7gyfKk2Km9QeuHImxLt3xIETY8lwzT5otvJctbriImIxEasC/BWGql0YR2VKFdK
        OGSBUomAo9UzZ6IzuzgtEn/GdOa8a2nPzsgTto0Wtyj/1ZZO3VU37ZwJBJVX1K0494knY1
        afX8r5+VbT2XeA4LtvrUaumEBkKq3kVyqYSKJH2TXDFteE+mAl364v6RtBf5v6S9GSj7Bb
        4H7JKJ86MS667a7NrVHqVdWOk/zh8B1OXn6AzE4N6CQGWhArFpvjhM/ePZpOBw==
From:   Simao Gomes Viana <devel@superboring.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Simao Gomes Viana <devel@superboring.dev>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 8/9] drivers: cdrom: change unsigned to unsigned int
Date:   Fri, 19 Jun 2020 21:33:40 +0200
Message-Id: <20200619193341.51209-8-devel@superboring.dev>
In-Reply-To: <20200619193341.51209-1-devel@superboring.dev>
References: <20200619180834.8032-1-devel@superboring.dev>
 <20200619193341.51209-1-devel@superboring.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by scripts/checkpatch.pl

Signed-off-by: Simao Gomes Viana <devel@superboring.dev>
---
 drivers/cdrom/cdrom.c | 4 ++--
 drivers/cdrom/gdrom.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 6ff8da08230c..d96458de1cb3 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1633,7 +1633,7 @@ void init_cdrom_command(struct packet_command *cgc, void *buf, int len,
 #define copy_key(dest, src) memcpy((dest), (src), sizeof(dvd_key))
 #define copy_chal(dest, src) memcpy((dest), (src), sizeof(dvd_challenge))
 
-static void setup_report_key(struct packet_command *cgc, unsigned agid, unsigned type)
+static void setup_report_key(struct packet_command *cgc, unsigned int agid, unsigned int type)
 {
 	cgc->cmd[0] = GPCMD_REPORT_KEY;
 	cgc->cmd[10] = type | (agid << 6);
@@ -1655,7 +1655,7 @@ static void setup_report_key(struct packet_command *cgc, unsigned agid, unsigned
 	cgc->data_direction = CGC_DATA_READ;
 }
 
-static void setup_send_key(struct packet_command *cgc, unsigned agid, unsigned type)
+static void setup_send_key(struct packet_command *cgc, unsigned int agid, unsigned int type)
 {
 	cgc->cmd[0] = GPCMD_SEND_KEY;
 	cgc->cmd[10] = type | (agid << 6);
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 1b4fd34f2687..a52d515408ee 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -508,7 +508,7 @@ static unsigned int gdrom_bdops_check_events(struct gendisk *disk,
 }
 
 static int gdrom_bdops_ioctl(struct block_device *bdev, fmode_t mode,
-	unsigned cmd, unsigned long arg)
+	unsigned int cmd, unsigned long arg)
 {
 	int ret;
 
-- 
2.27.0

