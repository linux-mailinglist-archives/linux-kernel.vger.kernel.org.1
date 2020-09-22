Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AED4274299
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgIVNFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726705AbgIVNFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600779911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQNEKNy1qm9G5Lt+xVmHF5dIVECajNyf0rbZE3WivSA=;
        b=OGe2WBGDKaub2jmbO1OeOhrsWhfsqCz27rLkYaLkwkdhkFb3wbLEDicH8377LGC5+H6vaf
        5mbBY80l9IGHsNv1Qbxc7UZhHPKJ7RZvnmE3pXICHt9D6qhnptsX8L8wtIXFoHwHaejsMG
        3RrVgXXVQJKEB7j42pttmMRCJhT4A/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-NkVONMe4NVe_LOzI5PDQfQ-1; Tue, 22 Sep 2020 09:05:09 -0400
X-MC-Unique: NkVONMe4NVe_LOzI5PDQfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5B72801AE1;
        Tue, 22 Sep 2020 13:05:07 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EFD273670;
        Tue, 22 Sep 2020 13:05:05 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
        james.morse@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5 10/13] firmware: arm_sdei: Cleanup on cross call function
Date:   Tue, 22 Sep 2020 23:04:20 +1000
Message-Id: <20200922130423.10173-11-gshan@redhat.com>
In-Reply-To: <20200922130423.10173-1-gshan@redhat.com>
References: <20200922130423.10173-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This applies cleanup on the cross call functions, no functional
changes are introduced:

   * Wrap the code block of CROSSCALL_INIT inside "do { } while (0)"
     as linux kernel usually does. Otherwise, scripts/checkpatch.pl
     reports warning regarding this.
   * Use smp_call_func_t for @fn argument in sdei_do_cross_call()
     as the function is called on target CPU(s).
   * Remove unnecessary space before @event in sdei_do_cross_call()

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 drivers/firmware/arm_sdei.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 790bff70d169..786c1b6d4af3 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -78,11 +78,15 @@ struct sdei_crosscall_args {
 	int first_error;
 };
 
-#define CROSSCALL_INIT(arg, event)	(arg.event = event, \
-					 arg.first_error = 0, \
-					 atomic_set(&arg.errors, 0))
-
-static inline int sdei_do_cross_call(void *fn, struct sdei_event * event)
+#define CROSSCALL_INIT(arg, event)		\
+	do {					\
+		arg.event = event;		\
+		arg.first_error = 0;		\
+		atomic_set(&arg.errors, 0);	\
+	} while (0)
+
+static inline int sdei_do_cross_call(smp_call_func_t fn,
+				     struct sdei_event *event)
 {
 	struct sdei_crosscall_args arg;
 
-- 
2.23.0

