Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FCF273808
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgIVBYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729529AbgIVBYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7802F23A9F;
        Tue, 22 Sep 2020 01:24:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX34-001sHp-FS; Mon, 21 Sep 2020 21:24:50 -0400
Message-ID: <20200922012450.359064020@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 03/26] tools/bootconfig: Make all functions static
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Make all functions static except for main(). This is just a cleanup.

Link: https://lkml.kernel.org/r/159704850135.175360.12465608936326167517.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 78025267df20..eb92027817a7 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -99,7 +99,7 @@ static void xbc_show_list(void)
 }
 
 /* Simple real checksum */
-int checksum(unsigned char *buf, int len)
+static int checksum(unsigned char *buf, int len)
 {
 	int i, sum = 0;
 
@@ -111,7 +111,7 @@ int checksum(unsigned char *buf, int len)
 
 #define PAGE_SIZE	4096
 
-int load_xbc_fd(int fd, char **buf, int size)
+static int load_xbc_fd(int fd, char **buf, int size)
 {
 	int ret;
 
@@ -128,7 +128,7 @@ int load_xbc_fd(int fd, char **buf, int size)
 }
 
 /* Return the read size or -errno */
-int load_xbc_file(const char *path, char **buf)
+static int load_xbc_file(const char *path, char **buf)
 {
 	struct stat stat;
 	int fd, ret;
@@ -147,7 +147,7 @@ int load_xbc_file(const char *path, char **buf)
 	return ret;
 }
 
-int load_xbc_from_initrd(int fd, char **buf)
+static int load_xbc_from_initrd(int fd, char **buf)
 {
 	struct stat stat;
 	int ret;
@@ -254,7 +254,7 @@ static int init_xbc_with_error(char *buf, int len)
 	return ret;
 }
 
-int show_xbc(const char *path, bool list)
+static int show_xbc(const char *path, bool list)
 {
 	int ret, fd;
 	char *buf = NULL;
@@ -299,7 +299,7 @@ int show_xbc(const char *path, bool list)
 	return ret;
 }
 
-int delete_xbc(const char *path)
+static int delete_xbc(const char *path)
 {
 	struct stat stat;
 	int ret = 0, fd, size;
@@ -330,7 +330,7 @@ int delete_xbc(const char *path)
 	return ret;
 }
 
-int apply_xbc(const char *path, const char *xbc_path)
+static int apply_xbc(const char *path, const char *xbc_path)
 {
 	u32 size, csum;
 	char *buf, *data;
@@ -407,7 +407,7 @@ int apply_xbc(const char *path, const char *xbc_path)
 	return ret;
 }
 
-int usage(void)
+static int usage(void)
 {
 	printf("Usage: bootconfig [OPTIONS] <INITRD>\n"
 		"Or     bootconfig <CONFIG>\n"
-- 
2.28.0


