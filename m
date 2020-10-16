Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCC7290643
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407353AbgJPN1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405622AbgJPN1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:27:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7C5C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=N5KU+PO7l0gAVT/dpNICfEXTr/hmyrV7Zc0zK3h/bOc=; b=BTS5xVgDt5cGF+T5OkGaJBDfWE
        hvgOmNieNHi8FAsSO9lXc0RhY/HyyVzhBfyx9nKQP5THro7C8Ld9LcZ/x4XS6jA+wB5yEnkoCxb+7
        sTib5EFkakiPtnr2D6Tf8WwdhbviUqbNB2F95fBoFTO9R2GSQ+AoSOLx9X87QcsbYVhX9BYwkEHww
        7bI99derRJZWxMeRqTftAQ8Wiy6eS9tXMQfyO72pF4EWnod8m37Mwg+gZLOPcPHfNsPxIuMSupQHg
        WCZp0Gqp7zIrOlI0X7wEwa0hhO3S2Sh+hazj2t2oAezZPuHJlfeOHH5PFYg/4bQzicOcoGOJl9Yqp
        zV+JqZ+g==;
Received: from 213-225-9-134.nat.highway.a1.net ([213.225.9.134] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTPlS-000376-Tp; Fri, 16 Oct 2020 13:27:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] pstore/blk: update the command line example
Date:   Fri, 16 Oct 2020 15:20:40 +0200
Message-Id: <20201016132047.3068029-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016132047.3068029-1-hch@lst.de>
References: <20201016132047.3068029-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the human readable device name instead of the device number, and
add the required best_effort parameter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/admin-guide/pstore-blk.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pstore-blk.rst b/Documentation/admin-guide/pstore-blk.rst
index 296d5027787ac2..d9ec8b0572d3b2 100644
--- a/Documentation/admin-guide/pstore-blk.rst
+++ b/Documentation/admin-guide/pstore-blk.rst
@@ -35,7 +35,7 @@ module parameters have priority over Kconfig.
 
 Here is an example for module parameters::
 
-        pstore_blk.blkdev=179:7 pstore_blk.kmsg_size=64
+        pstore_blk.blkdev=/dev/mmcblk0p7 pstore_blk.kmsg_size=64 best_effort=y
 
 The detail of each configurations may be of interest to you.
 
-- 
2.28.0

