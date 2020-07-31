Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F18233CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 03:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbgGaBmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 21:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731106AbgGaBmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 21:42:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51352C061574;
        Thu, 30 Jul 2020 18:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MFGXvn4NH0QXVaicEnP47nXZHotozTzHnc/uZ6PUbu4=; b=co3ghb39SFO6yUSILUQ3N88wAr
        QkMw3Ra/8ZiZ+FpA4inV+DdhwqU/eyXP+k/gkqSDIRbDP8TiO9SQCTSk0YmL1WxSMYrTPMgIOhV6d
        C5ZvOILuSgaFAxWMp35XQjxZ6Q8YqL7jzpGcj8KhJ2sG9yWLE6eQH5my/FNh2PgNDe6N7U2mzrnVd
        B8UriyLyVL1ACxOUGF7xC77q/OshWDVsOyfY0DqnEXieJjF3O7DMWa8osyt9B4tXBqTgQLXDDZXZj
        0QfhK15hLMY5MQeknbxS/HWxZjrr88d2ophEczYdvFoRXl1Bo1DlZ8+L966CBAShUAPstksQVWPQq
        nIAfKKlA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1K4M-0006bc-UV; Fri, 31 Jul 2020 01:42:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH 4/7] block: genhd: delete duplicated words
Date:   Thu, 30 Jul 2020 18:42:30 -0700
Message-Id: <20200731014233.6418-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200731014233.6418-1-rdunlap@infradead.org>
References: <20200731014233.6418-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "to" in multiple places.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/genhd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200730.orig/block/genhd.c
+++ linux-next-20200730/block/genhd.c
@@ -1773,7 +1773,7 @@ EXPORT_SYMBOL(__alloc_disk_node);
 
 /**
  * get_disk_and_module - increments the gendisk and gendisk fops module refcount
- * @disk: the struct gendisk to to increment the refcount for
+ * @disk: the struct gendisk to increment the refcount for
  *
  * This increments the refcount for the struct gendisk, and the gendisk's
  * fops module owner.
@@ -1802,7 +1802,7 @@ EXPORT_SYMBOL(get_disk_and_module);
 
 /**
  * put_disk - decrements the gendisk refcount
- * @disk: the struct gendisk to to decrement the refcount for
+ * @disk: the struct gendisk to decrement the refcount for
  *
  * This decrements the refcount for the struct gendisk. When this reaches 0
  * we'll have disk_release() called.
@@ -1819,7 +1819,7 @@ EXPORT_SYMBOL(put_disk);
 
 /**
  * put_disk_and_module - decrements the module and gendisk refcount
- * @disk: the struct gendisk to to decrement the refcount for
+ * @disk: the struct gendisk to decrement the refcount for
  *
  * This is a counterpart of get_disk_and_module() and thus also of
  * get_gendisk().
