Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF2326F6C4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgIRHYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgIRHYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:24:13 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAF9C061756
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:24:12 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id j11so6805340ejk.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nn49EMKwoUXTVvg+SnbEDEZXy2/Hm4gqC83M8dg7Jls=;
        b=FyYDxlS+jvvESTkNk3flm3/fY76a0plFNUQKhMadD8N5wuMB+TLeqoIPe7d28KwgpG
         q9puDn81QNkbsFqyPdJ0Wc7HI+s7kEFLRWOOd6mhPvqj8oVYDKD4DP9sc2I2ow1hj6fR
         v7NnnFUGVeRK7fJjCLDxVkRNwGgbxxeJWjUqyqIoQDkm3UYvE+CIn4LWAhwAT0+o693Z
         1hZGUbssRSAnastEPj5E6HTYcWb3+3kvp6VpEzgxyki8VfEbhub8lCHpX1xZWpvWjKPR
         ajGqFt+vyzmqmp5vb1jQe3gp6qio8V1EIHHGJrgZOEJY3hNtP7/wH8iHlGbyw2127wsm
         lbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nn49EMKwoUXTVvg+SnbEDEZXy2/Hm4gqC83M8dg7Jls=;
        b=jYPVKfXAZn2LGPUDlyJbdyDY47uzIgWDF/mvGBZiH65KGzsNmOUV1w0nF9B6CjU0BH
         JnkJ6hgTGsX+fCEcJe21XXOMm0eqW8cv8EFmIWu+IKC5iuKp8LMstSk7YMSjcyXfDbS/
         jj4bNBNzwrE9vsBd0owswOapabIQS++j/XCX/7+BlZOYz39t6pAwZbbgjKyfiMeXVjUh
         WFrUDQ2B5hwNqNwDJL9mwGYkDBKqEsWIxv9YSyUJ+otV1uHGqV7wlmF2g1k1YzBpj/mo
         wuRw/5CtAnkLATh5d5BC/MPg33HYWaaBXVTpR1nC3+TtJz8yeTvGN9U02zcTvaCpzDjt
         dILA==
X-Gm-Message-State: AOAM533uB0JCssgc9R4G0A3Zne1H9jn+OoTmIZNYBNOWC9k+woWZr6HC
        Y46fUqzlCpErmce5UwtvKDuomg==
X-Google-Smtp-Source: ABdhPJysTlRbno5j02weCD9U+lfpTJbiZWtDxrvZAlG6HtOSKCImZnKMbZHW4ksa+qjNcDpDJSs97Q==
X-Received: by 2002:a17:906:4046:: with SMTP id y6mr36177362ejj.148.1600413851437;
        Fri, 18 Sep 2020 00:24:11 -0700 (PDT)
Received: from gkim-laptop.pb.local ([2001:1438:4010:2558:95ba:ffd7:f2c1:4736])
        by smtp.googlemail.com with ESMTPSA id w11sm1518960edx.81.2020.09.18.00.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 00:24:11 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@cloud.ionos.com>
X-Google-Original-From: Gioh Kim <gi-oh.kim@clous.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH] block/rnbd: send_msg_close if any error occurs after send_msg_open
Date:   Fri, 18 Sep 2020 09:23:56 +0200
Message-Id: <20200918072356.10331-1-gi-oh.kim@clous.ionos.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

After send_msg_open is done, send_msg_close should be done
if any error occurs and it is necessary to recover
what has been done.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index cc6a4e2587ae..4a24603d5224 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1520,7 +1520,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 			      "map_device: Failed to configure device, err: %d\n",
 			      ret);
 		mutex_unlock(&dev->lock);
-		goto del_dev;
+		goto send_close;
 	}
 
 	rnbd_clt_info(dev,
@@ -1539,6 +1539,8 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 
 	return dev;
 
+send_close:
+	send_msg_close(dev, dev->device_id, WAIT);
 del_dev:
 	delete_dev(dev);
 put_dev:
-- 
2.20.1

