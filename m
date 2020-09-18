Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F86526EA07
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 02:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgIRAl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 20:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIRAl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 20:41:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5659BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 17:41:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k15so2305310pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 17:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sa4f3KUKbFfHC9H+o6K9qCWAfNguS2M+cMh+58HiehE=;
        b=k6rbRnnXtRLDdzxYrZuxmN6E9EH7w5EMuBK9NUM7xUYbL99v6WmllVGt9Mqs/4A5sG
         NPeHr8XzNBMhovyvB8BhXw6ZsL1TQaBgijSwCjPRq2wKuRU4AZEdCI+aflBK0HBIN/32
         sDg1BSUWCeMXA2eRgLE28nU/55zr2i3TgqR24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sa4f3KUKbFfHC9H+o6K9qCWAfNguS2M+cMh+58HiehE=;
        b=Mm+tJqHFeVNlmkGeex3PW/f3qKIsMgNPG4hkJ7zhetsrhtt7FXyYu8NSzZX78XSsF2
         BrelndE3mwo24qXoElZ6rJ2+CAjWHGgKznNuLzpOtfXss9zzCaMBhpL5lt53IcarPMba
         N58jXCLg2V2r1VWmJE20Pupe5fIV1WNLbtpZR7h75teNY1DHj1VD9fs5WWaoXEKboCJj
         TfMcIJtwpgdoLnT+kVwoLeAiQcSsSyH9GcVGn2B9vXCnMNJBpKEWXuxrWev+fvQ/OqtB
         OAYZsljYhjshoxEi9otI+kGK+tkorVeCMWJ/Tp7Ug19WNlrUAyXEXEe6+p1Y7JdoWv+8
         XAow==
X-Gm-Message-State: AOAM532gFGNcot/wAGtJ1LShFA7vkAokL4K5xdDu4whEen/C1ZC+EtBJ
        Bbm/CBu+QGfYIdBiwla/8wFBgg==
X-Google-Smtp-Source: ABdhPJwBVfRjKls8EFDAVBlMgl2WqaXPUU8sgH89J6w0jiNm3tnyvZBRW0KpSYh7CUlcwHAaZKV8eQ==
X-Received: by 2002:a63:d04b:: with SMTP id s11mr24273845pgi.241.1600389686843;
        Thu, 17 Sep 2020 17:41:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id c9sm833613pfn.78.2020.09.17.17.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 17:41:26 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     sonnyrao@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] zram: Failing to decompress is WARN_ON worthy
Date:   Thu, 17 Sep 2020 17:41:20 -0700
Message-Id: <20200917174059.1.If09c882545dbe432268f7a67a4d4cfcb6caace4f@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we fail to decompress in zram it's a pretty serious problem.  We
were entrusted to be able to decompress the old data but we failed.
Either we've got some crazy bug in the compression code or we've got
memory corruption.

At the moment, when this happens the log looks like this:

  ERR kernel: [ 1833.099861] zram: Decompression failed! err=-22, page=336112
  ERR kernel: [ 1833.099881] zram: Decompression failed! err=-22, page=336112
  ALERT kernel: [ 1833.099886] Read-error on swap-device (253:0:2688896)

It is true that we have an "ALERT" level log in there, but (at least
to me) it feels like even this isn't enough to impart the seriousness
of this error.  Let's convert to a WARN_ON.  Note that WARN_ON is
automatically "unlikely" so we can simply replace the old annotation
with the new one.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9100ac36670a..a6e2f0980aff 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1268,7 +1268,7 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 	zram_slot_unlock(zram, index);
 
 	/* Should NEVER happen. Return bio error if it does. */
-	if (unlikely(ret))
+	if (WARN_ON(ret))
 		pr_err("Decompression failed! err=%d, page=%u\n", ret, index);
 
 	return ret;
-- 
2.28.0.681.g6f77f65b4e-goog

