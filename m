Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF522DAEF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 02:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGZAk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 20:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgGZAkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:40:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B507C08C5C0;
        Sat, 25 Jul 2020 17:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hj6fPJPFhSaIyoK62tm1SSTyASZw8ZRWMVC1gTX5CpE=; b=wL6ABgVmV9aTRq53COsS2qHv3P
        k4G8PXT3MDboIf9nskE/8C4KyILFkysaUjUkzC5T7RUQSU/Qc/lZfp4MpIHMk0aZpc+axatMgTYOo
        NQx9ve5zqWZ3Ke7B3jSm39lrAB/ukC9EnodfH+HcD6zk13TKMK2TASGw5LSasBoYp6C+OqVQ1eE4k
        jngXx6hexFGJ7Rids3XxxvOfw3jaP174R8hd/IaiTLECeAX1dDyqlgGrGoa6iujPyDXCjNsEpr85Q
        7iRBvIi0QaSk5A72daJtUra/hSgFnmHAWFRfAXYdG5bU0Xr2EGRln7afMNEoqyykk+4HUG2vaMv0U
        OtlrHi5A==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUiE-0003NC-73; Sun, 26 Jul 2020 00:40:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH 3/5] ia64: spinlock.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:40:11 -0700
Message-Id: <20200726004013.20534-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726004013.20534-1-rdunlap@infradead.org>
References: <20200726004013.20534-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/include/asm/spinlock.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/ia64/include/asm/spinlock.h
+++ linux-next-20200720/arch/ia64/include/asm/spinlock.h
@@ -26,7 +26,7 @@
  * the queue, and the other indicating the current tail. The lock is acquired
  * by atomically noting the tail and incrementing it by one (thus adding
  * ourself to the queue and noting our position), then waiting until the head
- * becomes equal to the the initial value of the tail.
+ * becomes equal to the initial value of the tail.
  * The pad bits in the middle are used to prevent the next_ticket number
  * overflowing into the now_serving number.
  *
