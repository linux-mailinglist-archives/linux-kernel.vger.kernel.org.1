Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07CA24EB1C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 06:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgHWEF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 00:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHWEF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 00:05:27 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8A2C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 21:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=j76h/8s3zbu/6pglhNU5N8YHDCQcyj/KO4B+YtWJeCQ=; b=GqawuQK6btkCAU3MGJ+sJaUBoV
        gd4SYKel4l/mOAQpWZR3SH472XH1UHqKO4ozusDLeUdbYAShuy8qimEcM5DV3+bd6n8rUHaARNN64
        mQV+LiARd+24Ym4LapEfyjzBKJv6EoLHBPFeAfq5vYHqkLlWuv84e7/Cw0lM/82WYse2AOzsj3aja
        x9m3iuZ7ZTmvXLvAbiszzrmATo3krmHyAuGCKFuQ0pubpXZDBIUVp+ptpPIW6Yq18VqSbO6NbnBXS
        ZmwRa+7/ysFFjk7/4Tnayq2o6v38cRPw8d+d6LaFem2iyLOzxW+lnvESiMYlPQenWko6jeMeMOWId
        eXKS0w3A==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9hG0-0004sk-Ek; Sun, 23 Aug 2020 04:05:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] lib: test_sysctl: delete duplicated words
Date:   Sat, 22 Aug 2020 21:05:20 -0700
Message-Id: <20200823040520.1999-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
---
 lib/test_sysctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200730.orig/lib/test_sysctl.c
+++ linux-next-20200730/lib/test_sysctl.c
@@ -16,7 +16,7 @@
  */
 
 /*
- * This module provides an interface to the the proc sysctl interfaces.  This
+ * This module provides an interface to the proc sysctl interfaces.  This
  * driver requires CONFIG_PROC_SYSCTL. It will not normally be loaded by the
  * system unless explicitly requested by name. You can also build this driver
  * into your kernel.
