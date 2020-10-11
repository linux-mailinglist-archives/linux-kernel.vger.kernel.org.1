Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB8A28A4C9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 02:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbgJKAPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 20:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387435AbgJKAPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 20:15:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF47C0613D0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 17:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=La+hgOGsGMA3Kx+VM0lI4dSj89AujdojmWxtXn2mHKA=; b=jJ8X+331yYT4zhgG8vaA/dKgOi
        ErJOowD+ny7HBeWVvjuD1WHj5SIlfwKmCOjqjdqcrKEkKWP243c/5WVslXlU9i81i68HDEe9BVWjk
        mD1z0H6E/TmnIISbh+/S6d2r1OrGmoy3NY7c8o/CRoozHFtGcq4y7Oq02767cKIHpw+UAXyzMD0rj
        HXH+vBAAsZlWC8PTHNR4ZC1oNCcs2NHeFzQdLe8BtX+2HJkPwGYfDMdV8QfWkqIfNVB9Qcm61TdCW
        rz6Yns/MDlonvNChGX4pCWNcIEQabsXZVVwFeYM09lce4mbUOuMpN1gZNVDo0PYWH1YFVAkBXF5el
        Dh/q+fGw==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRP19-0003Ve-6m; Sun, 11 Oct 2020 00:15:15 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kernel: acct.c: fix some kernel-doc nits
Message-ID: <b4c33e5d-98e8-0c47-77b6-ac1859f94d7f@infradead.org>
Date:   Sat, 10 Oct 2020 17:15:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc notation to use the documented Returns: syntax
and place the function description for acct_process() on the
first line where it should be.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 kernel/acct.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- linux-next-20201009.orig/kernel/acct.c
+++ linux-next-20201009/kernel/acct.c
@@ -263,12 +263,12 @@ static DEFINE_MUTEX(acct_on_mutex);
  * sys_acct - enable/disable process accounting
  * @name: file name for accounting records or NULL to shutdown accounting
  *
- * Returns 0 for success or negative errno values for failure.
- *
  * sys_acct() is the only system call needed to implement process
  * accounting. It takes the name of the file where accounting records
  * should be written. If the filename is NULL, accounting will be
  * shutdown.
+ *
+ * Returns: 0 for success or negative errno values for failure.
  */
 SYSCALL_DEFINE1(acct, const char __user *, name)
 {
@@ -586,9 +586,7 @@ static void slow_acct_process(struct pid
 }
 
 /**
- * acct_process
- *
- * handles process accounting for an exiting task
+ * acct_process - handles process accounting for an exiting task
  */
 void acct_process(void)
 {

