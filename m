Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D042220425
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 06:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgGOE5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 00:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgGOE5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 00:57:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FA1C061755;
        Tue, 14 Jul 2020 21:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UusgCWUIBaDBSccSzVJ4Jc8kH/9t+4uHWQgs2V1hKbs=; b=FvmKO3KDSprDGSCLjdu0hfQ2J/
        RRRCi5K6UJ3SZ0lhLcws7TCwEoHIgDOzi2o2fs2tYarcgoZc4Exyy9SBABAjeTcA9jcIIpF+9OBWV
        K7KoK7l80q28N36mQElfJu0j5EER/YtlpQTuXPzdqpUxFx14n8z8wSd5HVMhZawEvMj2OQVRzJfS7
        5xgTxpthhXiVoo6tO53V1+UoyMp2c7iQYqte7/MwztzCTAyNz613LZnuAjswsfzsyDGazcRxVTy+Q
        IuTHpKsy4Nk4Mz7K5RPvirxv004hNg1jYVllz2zZkQKaujwTZIYreGN0QmarZCa7J7fs277vNQszX
        PdifSOeg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvZTg-0005gJ-85; Wed, 15 Jul 2020 04:57:08 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 3/4] usb: linux/usb/pd_vdo.h: drop duplicated word in comment
Date:   Tue, 14 Jul 2020 21:57:00 -0700
Message-Id: <20200715045701.22949-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715045701.22949-1-rdunlap@infradead.org>
References: <20200715045701.22949-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "all" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 include/linux/usb/pd_vdo.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/usb/pd_vdo.h
+++ linux-next-20200714/include/linux/usb/pd_vdo.h
@@ -249,7 +249,7 @@
  * SVDM Discover SVIDs request -> response
  *
  * Request is properly formatted VDM Header with discover SVIDs command.
- * Response is a set of SVIDs of all all supported SVIDs with all zero's to
+ * Response is a set of SVIDs of all supported SVIDs with all zero's to
  * mark the end of SVIDs.  If more than 12 SVIDs are supported command SHOULD be
  * repeated.
  */
