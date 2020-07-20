Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61042254E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 02:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGTAOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 20:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgGTAOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 20:14:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B6FC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2dh8AOT7UBejhzDs0je1RvMA+wqI08Hnfik6pq9eHmI=; b=u7ypevrSS/liCDXHKATmNWeiYd
        P8vIMAe8N9zXYf3KZgMtH59AfOOrD9xBynppXXHlTLs5DNRGq+giVXYfnUPWmzP/a6XT+2C9T8Orj
        n8ktQDW0WhgZnQmdRPXhYnvG7lAzHRrO+RrTzjV7F2mQRAkj1WCus1cElOIztiy7Ox/CcLmIy6Ui9
        5yxwy0qj1fVsPwL1bumZV8q265g4e0F2ZZVHptq0KXXcXtMJPakus9u/E69KPu+i/XIl8x/coW6cb
        8M9l6dx3Yy5aeeEFPyVPfz4w7v9H6+qn83J+jMkgaRk8XOcICjtPu9AZqM6e9Fs/lrDwp43EkNXZk
        5FtIDQzA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxJSC-000416-Al; Mon, 20 Jul 2020 00:14:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] ubifs: misc.h: delete a duplicated word
Date:   Sun, 19 Jul 2020 17:14:44 -0700
Message-Id: <20200720001444.30972-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "as" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org
---
 fs/ubifs/misc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/fs/ubifs/misc.h
+++ linux-next-20200717/fs/ubifs/misc.h
@@ -121,7 +121,7 @@ static inline const char *ubifs_compr_na
  * ubifs_wbuf_sync - synchronize write-buffer.
  * @wbuf: write-buffer to synchronize
  *
- * This is the same as as 'ubifs_wbuf_sync_nolock()' but it does not assume
+ * This is the same as 'ubifs_wbuf_sync_nolock()' but it does not assume
  * that the write-buffer is already locked.
  */
 static inline int ubifs_wbuf_sync(struct ubifs_wbuf *wbuf)
