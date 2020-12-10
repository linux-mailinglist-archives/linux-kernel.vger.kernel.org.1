Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083F52D513D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 04:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgLJDSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 22:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgLJDSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:18:33 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B275AC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 19:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=e3geagjLUbkfu555scHFBxhLDn64X8QU8MqLRKZIS1c=; b=nbcj+Qb9VE5T6TWfV+//6eWNBm
        CjvIWQ4J459HWNqeeM4J87K5b9sPtgzM5yQNQWxaOiKJSHoGewc4dwhzjGBp5b++DOq6SSkBmFbCr
        dTjp3kJQPcNUeJ4RgKC/wrsAHDe4gtnq2SVd4tgq/3OVBnObwpsQDfQIJS3o1Dn7Ce9mZ5Jc7SdIB
        L6nH3Gt2R706E9zzlbVexUrANij7GBUW0Q63ngHov2Yr093j8D0Apir0svI0xMmBs89Y0IZwX5dFf
        E9OagfZkMISDyLdVv8atnpEiB8Q34/7OJqWsSGoRBP4xGRqnwZDDQSrkC2TUSuJZX/l8Yq5zUZfAf
        1N9TzpMg==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knCSj-00020I-PN; Thu, 10 Dec 2020 03:17:50 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-c6x-dev@linux-c6x.org,
        Jens Axboe <axboe@kernel.dk>, Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Subject: [PATCH -next] c6x: fix build of signal.c using _TIF_SIGNALs
Date:   Wed,  9 Dec 2020 19:17:42 -0800
Message-Id: <20201210031742.14534-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/signal.c in arch/c6x/ needs <asm/asm-offsets.h> to build
since it contains _TIF_SIGNALfoobar #defines, so add it.

Placates these build errors:

../arch/c6x/kernel/signal.c: In function 'do_notify_resume':
../arch/c6x/kernel/signal.c:316:27: error: '_TIF_SIGPENDING' undeclared (first use in this function); did you mean 'TIF_SIGPENDING'?
  316 |  if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
      |                           ^~~~~~~~~~~~~~~
../arch/c6x/kernel/signal.c:316:27: note: each undeclared identifier is reported only once for each function it appears in
../arch/c6x/kernel/signal.c:316:45: error: '_TIF_NOTIFY_SIGNAL' undeclared (first use in this function); did you mean 'TIF_NOTIFY_SIGNAL'?
  316 |  if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
      |                                             ^~~~~~~~~~~~~~~~~~

Fixes: b7560cfc3f8a ("c6x: add support for TIF_NOTIFY_SIGNAL")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-c6x-dev@linux-c6x.org
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
---
 arch/c6x/kernel/signal.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20201209.orig/arch/c6x/kernel/signal.c
+++ linux-next-20201209/arch/c6x/kernel/signal.c
@@ -13,6 +13,7 @@
 #include <linux/syscalls.h>
 #include <linux/tracehook.h>
 
+#include <asm/asm-offsets.h>
 #include <asm/ucontext.h>
 #include <asm/cacheflush.h>
 
