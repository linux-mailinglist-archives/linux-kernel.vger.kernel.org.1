Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8961B289C96
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 02:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgJJAK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 20:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgJJAHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 20:07:08 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B5EC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 17:07:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k8so8214274pfk.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 17:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f6Qtf4j20P32iYlPfJ3sCZa+aUx1EvEQCeg0osTASKs=;
        b=XqQMwS8BpFsahTRaQtKviHaG0jSx9C1YbCh6x388sVg+AgRGghxUOl18x8plMihboJ
         5nCNaPFWT+ZPnlUhOdEU5TSqvLOLG8Bz/U2nAJVBIO0TdaBTbYRHAT8EanijQZ3q5k4p
         rJ/sUtVfJnucP1uCzevkO7VnvAeDaAao0K0+uSy8FFtdAy+7DgJ8JX/NL1di2j+YOm4S
         5gn3JjzlsYuOUdOBJO0CAVl1plIeWkjetz2kf3QAF1DmYOA63cMt5sa6bqZ9yg9bxykh
         +gk7saRM1gmw2Z+1kn+BbL0pg/m7mdH2zH2xE4QGf3qBZJ6M0/5OEDQ0/EfAnozHn5Dj
         6iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=f6Qtf4j20P32iYlPfJ3sCZa+aUx1EvEQCeg0osTASKs=;
        b=fjJnU8C86c699YNvLnCh31iiDugOGUktDDU+SVsjSFcIoZtm7zqV8DyR1DhtIGteD8
         pFBkQG9szWMHyo/qEOfeRyKaFiFM1Qvd5RYpyMpHM2dVkDpWKlsZ7eOKUl/TwkFwL1da
         RXRir5k16AQRFAp5d0LRmwwMB8Tn3nAAr+nrSfhsu9pIWqU2rH9u97TLOWlNIhRVf9vA
         uGS3y048N+MjXe7eRfgvdW/oUe/Q5tIuTUneCYR9lXfXr44wzLOrzY2noLJozJYBLbaO
         nRKmXZp/buaun3rbVVtkR6hvDG0VPL7r9oDdjnWSilZYUpKQv2ZpBbSE49C3Ln6MQH6P
         g6RQ==
X-Gm-Message-State: AOAM5328pKRge4wL/yMfbZml8rEJrrySn+JfsDo82oV+HWs44dXw+EMf
        7edpgUEnByl7DjSWS23grrs=
X-Google-Smtp-Source: ABdhPJzYSEzFUlseh7Pf1nVEMKpq+FrIDqYKAHMGUgoolPbXZr0zjisss8GDc05ySTcOgLwYEObcEw==
X-Received: by 2002:a62:7895:0:b029:152:2640:644f with SMTP id t143-20020a6278950000b02901522640644fmr14079663pfc.67.1602288424453;
        Fri, 09 Oct 2020 17:07:04 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id z12sm12307376pfr.197.2020.10.09.17.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 17:06:55 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm: validate inode in mapping_set_error
Date:   Fri,  9 Oct 2020 17:06:50 -0700
Message-Id: <20201010000650.750063-1-minchan@kernel.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The swap address_space doesn't have host. Thus, it makes kernel crash once
swap write meets error. Fix it.

[1] 735e4ae5ba28, vfs: track per-sb writeback errors and report them to syncfs
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/pagemap.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 17ba0fe59290..9cf540447e73 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -55,7 +55,8 @@ static inline void mapping_set_error(struct address_space *mapping, int error)
 	__filemap_set_wb_err(mapping, error);
 
 	/* Record it in superblock */
-	errseq_set(&mapping->host->i_sb->s_wb_err, error);
+	if (mapping->host)
+		errseq_set(&mapping->host->i_sb->s_wb_err, error);
 
 	/* Record it in flags for now, for legacy callers */
 	if (error == -ENOSPC)
-- 
2.28.0.1011.ga647a8990f-goog

