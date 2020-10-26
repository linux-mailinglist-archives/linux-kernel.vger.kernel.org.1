Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F933299200
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785179AbgJZQMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1785066AbgJZQLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:11:15 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 476B4239D2;
        Mon, 26 Oct 2020 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603728675;
        bh=CH50HAM4PlMVHgQRIyhS1lHWEDSIk2N0QYJde/V6JlE=;
        h=From:To:Cc:Subject:Date:From;
        b=c7ONOeJavp0HrPGRm0lIkbDsZtAdTfCFDTzf4cxTajrgbHAezVwknaXEvk7917Ztr
         GNv5VU8SjKhkWcKaUswh2Rp3YqQFpMx4WB34In20GIJptXcKvJ2+kHdcSG75mmje7V
         tAQpAdZ8fk4QWZ5l824PTv1qtkZz+vKeRqo+sCzY=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        Petr Mladek <pmladek@suse.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] seq_buf: avoid type mismatch for seq_buf_init
Date:   Mon, 26 Oct 2020 17:10:58 +0100
Message-Id: <20201026161108.3707783-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with W=2 prints a number of warnings for one function that
has a pointer type mismatch:

linux/seq_buf.h: In function 'seq_buf_init':
linux/seq_buf.h:35:12: warning: pointer targets in assignment from 'unsigned char *' to 'char *' differ in signedness [-Wpointer-sign]

Change the type in the function prototype according to the type in
the structure.

Fixes: 9a7777935c34 ("tracing: Convert seq_buf fields to be like seq_file fields")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/seq_buf.h   | 2 +-
 include/linux/trace_seq.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index fb0205d87d3c..9d6c28cc4d8f 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -30,7 +30,7 @@ static inline void seq_buf_clear(struct seq_buf *s)
 }
 
 static inline void
-seq_buf_init(struct seq_buf *s, unsigned char *buf, unsigned int size)
+seq_buf_init(struct seq_buf *s, char *buf, unsigned int size)
 {
 	s->buffer = buf;
 	s->size = size;
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 6c30508fca19..5a2c650d9e1c 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -12,7 +12,7 @@
  */
 
 struct trace_seq {
-	unsigned char		buffer[PAGE_SIZE];
+	char			buffer[PAGE_SIZE];
 	struct seq_buf		seq;
 	int			full;
 };
@@ -51,7 +51,7 @@ static inline int trace_seq_used(struct trace_seq *s)
  * that is about to be written to and then return the result
  * of that write.
  */
-static inline unsigned char *
+static inline char *
 trace_seq_buffer_ptr(struct trace_seq *s)
 {
 	return s->buffer + seq_buf_used(&s->seq);
-- 
2.27.0

