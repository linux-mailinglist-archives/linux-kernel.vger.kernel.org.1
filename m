Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989C5257E28
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 18:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgHaQEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 12:04:35 -0400
Received: from mx4.wp.pl ([212.77.101.12]:49763 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728251AbgHaQEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:04:31 -0400
Received: (wp-smtpd smtp.wp.pl 6944 invoked from network); 31 Aug 2020 18:04:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1598889865; bh=Wso2RTwzDw3uAYjb34dIRt37gGCLNnOWKMz9bQ3PYPY=;
          h=From:To:Cc:Subject;
          b=d3UfzPiWnYREinUtTS7/DhxIJrPfO/T7mFpQz549+xt2YNW2ndVRIIwSzBFt7H4/L
           pyX2vv/mEHLZh5uxrnCPIN1zgxn2gcIkpACIuLpJv+fCZZCcr7rRUs4e6zXVCuiQt2
           slH+1P4XoO8buUcBZn76z/c4flISxDtBXt0c1gYg=
Received: from 188.146.234.2.nat.umts.dynamic.t-mobile.pl (HELO localhost) (antoni.przybylik@wp.pl@[188.146.234.2])
          (envelope-sender <antoni.przybylik@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <gregkh@linuxfoundation.org>; 31 Aug 2020 18:04:25 +0200
From:   antoniprzybylik <antoni.przybylik@wp.pl>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        antoniprzybylik <antoni.przybylik@wp.pl>
Subject: [PATCH] staging: gdm724x: fixed two macros by adding brackets
Date:   Mon, 31 Aug 2020 18:03:32 +0200
Message-Id: <20200831160332.8507-1-antoni.przybylik@wp.pl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                      
X-WP-MailID: 72389e197ba179900ee91c9ac8f34ac3
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [oXN8]                               
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added brackets to two macros.

Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
---
 drivers/staging/gdm724x/gdm_tty.c   | 3 +--
 drivers/staging/gdm724x/netlink_k.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 6e813693a766..5cd94347bf78 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -27,7 +27,7 @@
 
 #define MUX_TX_MAX_SIZE 2048
 
-#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
+#define GDM_TTY_READY(gdm) ((gdm) && (gdm)->tty_dev && (gdm)->port.count)
 
 static struct tty_driver *gdm_driver[TTY_MAX_COUNT];
 static struct gdm *gdm_table[TTY_MAX_COUNT][GDM_TTY_MINOR];
@@ -323,4 +323,3 @@ void unregister_lte_tty_driver(void)
 		}
 	}
 }
-
diff --git a/drivers/staging/gdm724x/netlink_k.c b/drivers/staging/gdm724x/netlink_k.c
index 7902e52a699b..399b7b4b536f 100644
--- a/drivers/staging/gdm724x/netlink_k.c
+++ b/drivers/staging/gdm724x/netlink_k.c
@@ -20,7 +20,7 @@ static DEFINE_MUTEX(netlink_mutex);
 #define ND_NLMSG_DATA(nlh)	((void *)((char *)NLMSG_DATA(nlh) + \
 						  ND_IFINDEX_LEN))
 #define ND_NLMSG_S_LEN(len)	(len + ND_IFINDEX_LEN)
-#define ND_NLMSG_R_LEN(nlh)	(nlh->nlmsg_len - ND_IFINDEX_LEN)
+#define ND_NLMSG_R_LEN(nlh)	((nlh)->nlmsg_len - ND_IFINDEX_LEN)
 #define ND_NLMSG_IFIDX(nlh)	NLMSG_DATA(nlh)
 #define ND_MAX_MSG_LEN		(1024 * 32)
 
-- 
2.28.0

