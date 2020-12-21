Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACB22DF830
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 05:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgLUEG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 23:06:59 -0500
Received: from casper.infradead.org ([90.155.50.34]:38508 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgLUEG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 23:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=P8nHHuR/iBwJg/MkbvTHdfdWMSVvCXUnXhlTOqjk0eE=; b=II0KGtY3p1hqmCxVBTcuFDALGx
        AWmnCg23N6/wnvxDfkk+Bpy3s+qDqB4CdnlAiIP8T3sFwoeFCUAW9S+g7m/q+gf+pdaa0QSGOL+l9
        /FoTSxuZqkhsn+pS3oBbbplGgBeTquioiw861bGMmL/Ba1DJMzgJ1vevW2edHViYHqpcLr7RAmc4a
        Xj1DSDQTgsFxs34pmjLZXNOMXa4P07jyRCg6EVWYAh3OJHBEjv0IQBd+wPkhOZNoITwX3ShRRrzAl
        JZqMs4WiyzI3M8TMrbFKEp5nAPRPQIiGqJy9sjSIbe7SRTJ38sO1l8xi4AJxiexy6F6o60IGAzrID
        BY/2m31Q==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krCSc-00010h-46; Mon, 21 Dec 2020 04:06:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [PATCH] lib/linear_ranges: fix repeated words & one typo
Date:   Sun, 20 Dec 2020 20:06:10 -0800
Message-Id: <20201221040610.12809-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change "which which" to "for which" in 3 places.
Change "ranges" to possessive "range's" in 1 place.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 lib/linear_ranges.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20201218.orig/lib/linear_ranges.c
+++ linux-next-20201218/lib/linear_ranges.c
@@ -128,7 +128,7 @@ EXPORT_SYMBOL_GPL(linear_range_get_value
  * @selector:	address where found selector value is updated
  * @found:	flag to indicate that given value was in the range
  *
- * Return selector which which range value is closest match for given
+ * Return selector for which range value is closest match for given
  * input value. Value is matching if it is equal or smaller than given
  * value. If given value is in the range, then @found is set true.
  *
@@ -168,11 +168,11 @@ EXPORT_SYMBOL_GPL(linear_range_get_selec
  * @selector:	address where found selector value is updated
  * @found:	flag to indicate that given value was in the range
  *
- * Scan array of ranges for selector which which range value matches given
+ * Scan array of ranges for selector for which range value matches given
  * input value. Value is matching if it is equal or smaller than given
  * value. If given value is found to be in a range scanning is stopped and
  * @found is set true. If a range with values smaller than given value is found
- * but the range max is being smaller than given value, then the ranges
+ * but the range max is being smaller than given value, then the range's
  * biggest selector is updated to @selector but scanning ranges is continued
  * and @found is set to false.
  *
@@ -209,7 +209,7 @@ EXPORT_SYMBOL_GPL(linear_range_get_selec
  * @selector:	address where found selector value is updated
  * @found:	flag to indicate that given value was in the range
  *
- * Return selector which which range value is closest match for given
+ * Return selector for which range value is closest match for given
  * input value. Value is matching if it is equal or higher than given
  * value. If given value is in the range, then @found is set true.
  *
