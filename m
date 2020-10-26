Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4B429991D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 22:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390957AbgJZVvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 17:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390944AbgJZVvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 17:51:44 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C0C2084C;
        Mon, 26 Oct 2020 21:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603749103;
        bh=pdHcRLWzqUaa0qQ6CJaa/u0ZAnIZEXLVDHCAe2fOTqo=;
        h=From:To:Cc:Subject:Date:From;
        b=z1i7YGIwDkMWCtN7K+mf+Bnc0LXqi9uirQ+g6TbK9i9UyojDTa23e3TiDqxINPFjS
         5SEtXGWg2stWPC7yuoDGOzqJ/nJNXgQUUdsBgtpPvOF8ApEjItwKRYjlKjLIu/KYXk
         62y22tVeUA/bKzxF0Pc+OMfqkiAI0s5VVqZklglE=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: fix function type cast warning
Date:   Mon, 26 Oct 2020 22:51:27 +0100
Message-Id: <20201026215138.3893732-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc -Wextra complains about a suspicious cast:

rivers/firewire/core-cdev.c:985:8: warning: cast between incompatible function types from ‘void (*)(struct fw_iso_context *, dma_addr_t,  void *)’ {aka ‘void (*)(struct fw_iso_context *, long long unsigned int,  void *)’} to ‘void (*)(struct fw_iso_context *, u32,  size_t,  void *, void *)’ {aka ‘void (*)(struct fw_iso_context *, unsigned int,  long unsigned int,  void *, void *)’} [-Wcast-function-type]

The behavior is correct in the end, but this is more clearly
expressed using a transparent union.

Fixes: 872e330e3880 ("firewire: add isochronous multichannel reception")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firewire/core-cdev.c |  6 +++---
 drivers/firewire/core-iso.c  |  2 +-
 include/linux/firewire.h     | 17 ++++++++---------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index fb6c651214f3..8d85d52b02ca 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -970,7 +970,7 @@ static int ioctl_create_iso_context(struct client *client, union ioctl_arg *arg)
 		if (a->speed > SCODE_3200 || a->channel > 63)
 			return -EINVAL;
 
-		cb = iso_callback;
+		cb.sc = iso_callback;
 		break;
 
 	case FW_ISO_CONTEXT_RECEIVE:
@@ -978,11 +978,11 @@ static int ioctl_create_iso_context(struct client *client, union ioctl_arg *arg)
 		    a->channel > 63)
 			return -EINVAL;
 
-		cb = iso_callback;
+		cb.sc = iso_callback;
 		break;
 
 	case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
-		cb = (fw_iso_callback_t)iso_mc_callback;
+		cb.mc = iso_mc_callback;
 		break;
 
 	default:
diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index af70e74f9a7e..ddada648775a 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -145,7 +145,7 @@ struct fw_iso_context *fw_iso_context_create(struct fw_card *card,
 	ctx->channel = channel;
 	ctx->speed = speed;
 	ctx->header_size = header_size;
-	ctx->callback.sc = callback;
+	ctx->callback = callback;
 	ctx->callback_data = callback_data;
 
 	return ctx;
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index aec8f30ab200..59b5e02a6d42 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -431,11 +431,13 @@ void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer, struct fw_card *card);
 size_t fw_iso_buffer_lookup(struct fw_iso_buffer *buffer, dma_addr_t completed);
 
 struct fw_iso_context;
-typedef void (*fw_iso_callback_t)(struct fw_iso_context *context,
-				  u32 cycle, size_t header_length,
-				  void *header, void *data);
-typedef void (*fw_iso_mc_callback_t)(struct fw_iso_context *context,
-				     dma_addr_t completed, void *data);
+typedef union {
+	void (*sc)(struct fw_iso_context *context, u32 cycle,
+		   size_t header_length, void *header, void *data);
+	void (*mc)(struct fw_iso_context *context, dma_addr_t completed,
+		   void *data);
+} __attribute__ ((__transparent_union__)) fw_iso_callback_t;
+
 struct fw_iso_context {
 	struct fw_card *card;
 	int type;
@@ -443,10 +445,7 @@ struct fw_iso_context {
 	int speed;
 	bool drop_overflow_headers;
 	size_t header_size;
-	union {
-		fw_iso_callback_t sc;
-		fw_iso_mc_callback_t mc;
-	} callback;
+	fw_iso_callback_t callback;
 	void *callback_data;
 };
 
-- 
2.27.0

