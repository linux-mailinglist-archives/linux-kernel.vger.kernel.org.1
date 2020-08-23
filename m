Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8082A24F088
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 01:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgHWXmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 19:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgHWXmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 19:42:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11241C061573;
        Sun, 23 Aug 2020 16:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Jy0vzNYy+s6HE2SSzuYgcZY2sl8odgHtqPcJjLTSJAw=; b=Bviw/rEJ5FyF2LVx/xWlz6jh5U
        28IH6U2RYsc2vgowT/ArXe12w1lJvbvi6CwYBwaETS89g6K/b9UwOQqnGWky9GnGF7m7SFi/daklR
        f7zaaftXjfgGjsAPBgQVfNWa0is/0NU2ZORfo78/FJXaJowV0igxfYFY51jZ/ewhSB4Am5yJo0T/g
        YD3FEr0GO2xKNyij8GlbNyLX0twRxLEmUfGrrJaD+N6r0YDV7r6D5GV5snYe0Ip/xhDp9KINlo8fz
        F4gmkCcs50oKL6MddSk686Q0WCF7J3pU9xBEJKERSRXzFT0eE1IthF4F+s/TGAilLJu1qAtpBrN6R
        UWTh0QBQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9zch-0001XS-GA; Sun, 23 Aug 2020 23:42:03 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: fix dma-buf.rst underline length warning
Message-ID: <1b22d4c3-4ea5-c633-9e35-71ce65d8dbcc@infradead.org>
Date:   Sun, 23 Aug 2020 16:41:59 -0700
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

/home/rdunlap/lnx/lnx-59-rc2/Documentation/driver-api/dma-buf.rst:182: WARNING: Title underline too short.
Indefinite DMA Fences
~~~~~~~~~~~~~~~~~~~~

Fixes: 72b6ede73623 ("dma-buf.rst: Document why indefinite fences are a bad idea")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
---
 Documentation/driver-api/dma-buf.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-59-rc2.orig/Documentation/driver-api/dma-buf.rst
+++ lnx-59-rc2/Documentation/driver-api/dma-buf.rst
@@ -179,7 +179,7 @@ DMA Fence uABI/Sync File
    :internal:
 
 Indefinite DMA Fences
-~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~
 
 At various times &dma_fence with an indefinite time until dma_fence_wait()
 finishes have been proposed. Examples include:

