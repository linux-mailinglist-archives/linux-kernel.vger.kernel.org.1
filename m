Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384D8256BE0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 07:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgH3F6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 01:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgH3F6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 01:58:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5312AC061573
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 22:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ni4ZAX7mBz7wHUuLSwAf8RGxkD+trrGNFVnH+gQlqKA=; b=vpWRroDdpfmRDiatgs92Kf87rj
        QN85Xej+hPFFYHAx0mD9RuBsDqIFa/JJMDQkzNWZaiIlA/+xJgbDGu63Jbzc+/sM8x3xb0YBENkt/
        /v8n3LZShafXJIQhMwcPJ5N94BFx4TiaWKmwJxPTw1JreWLPYoh8zeYGOfRtBwQMvrHlMzFsmj0zS
        blKEp1X5jK+BrIo45akeovYBSE6AlPnZi6sDqcZdS2reYvW/VSgd/oF4QCZb7sX+snnlLgeZXv7FE
        N3TZ+4q/WUe8FSMdmPtE7yroK8aeWd5qE2H5+gKDW2RdCQ7mxAkGdkj6BUgDFfefc4t+PEPHBT4yp
        TbTIku8w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCGLi-0000vl-Hl; Sun, 30 Aug 2020 05:57:54 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH trivial] xtensa: fix Kconfig typo
Message-ID: <b91f2285-48b1-67bd-69b2-85fd9decafcf@infradead.org>
Date:   Sat, 29 Aug 2020 22:57:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Correct trivial typo (ful -> full).

Fixes: 76743c0e0915 ("xtensa: move kernel memory layout to platform options")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Cc: Jiri Kosina <trivial@kernel.org>
---
 arch/xtensa/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200828.orig/arch/xtensa/Kconfig
+++ linux-next-20200828/arch/xtensa/Kconfig
@@ -537,7 +537,7 @@ config MEMMAP_CACHEATTR
 	    2: cache bypass,
 	    4: WB cached,
 	    f: illegal.
-	  For ful MMU:
+	  For full MMU:
 	    bit 0: executable,
 	    bit 1: writable,
 	    bits 2..3:

