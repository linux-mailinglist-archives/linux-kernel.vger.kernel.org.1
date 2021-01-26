Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F220E304FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhA0D1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbhAZVQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:16:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586FDC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:15:54 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611695752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZILipp3AuPz1TxG9s7TLwJquSmPIKBU4CGdRXmRGJI=;
        b=FBRhbZFufbyJGN8orW/gRWdKbB2KeDrHxVcIJC/X1ivZcdcQ+bzMr1+NMu06+BGGKpdxl0
        PcIT06/z6qTE2FX680fKnz4OsXEfsJGNgxG9Te1+BQQsTKK/BWPn6sVILQA5h/Im4qe7Ze
        KuoFGyqOHumsA3kVS1kQ5CqGKwYSMNzA2AciHaAmvuTu65vVJDURcMRkq+/NIwEj5aKVai
        op2Q0xhX36Il0zSXVEuP9+Vn/uyKM6xQLLFHnJQYeKXyzv2sPe4Us7WO80ugy1t2mGqIkC
        AP9hRzlJSHVz5vJH27okihPVcQWR6RHkUE5mlMBwUXBVXugEnA/qqg5svLQahQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611695752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZILipp3AuPz1TxG9s7TLwJquSmPIKBU4CGdRXmRGJI=;
        b=Ymmiwk6JXnviG+e8UnmwmFrGPVbkd7x9Y28RSUwRgXLjqMys7eBvplgPxg5yPnXIoFryeY
        ddFXAP4YO15ZXqBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 01/12] printk: kmsg_dump: remove unused fields
Date:   Tue, 26 Jan 2021 22:21:40 +0106
Message-Id: <20210126211551.26536-2-john.ogness@linutronix.de>
In-Reply-To: <20210126211551.26536-1-john.ogness@linutronix.de>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct kmsg_dumper still contains some fields that were used to
iterate the old ringbuffer. They are no longer used. Remove them
and update the struct documentation.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/kmsg_dump.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index 3378bcbe585e..da98846098b5 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -36,6 +36,9 @@ enum kmsg_dump_reason {
  * 		through the record iterator
  * @max_reason:	filter for highest reason number that should be dumped
  * @registered:	Flag that specifies if this is already registered
+ * @active:	Flag that specifies if this is currently dumping
+ * @cur_seq:	The record to dump (private)
+ * @next_seq:	The first record of the next block (private)
  */
 struct kmsg_dumper {
 	struct list_head list;
@@ -45,8 +48,6 @@ struct kmsg_dumper {
 	bool registered;
 
 	/* private state of the kmsg iterator */
-	u32 cur_idx;
-	u32 next_idx;
 	u64 cur_seq;
 	u64 next_seq;
 };
-- 
2.20.1

