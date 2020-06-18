Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACD41FF51A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 16:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbgFROol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 10:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730982AbgFROoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:44:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B79C061288
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v11so2999527pgb.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=KEZHLow75x1WGZauUbfw6ciLmnTzXmpQXtEtlinmygw=;
        b=HvZc/ixPovm/kRhvl4SJUiwM/PVM+gQUGpw4gn7GL1Ek48GAAcFBxFJBO4YBWLb0Y9
         Oiqk0i8f6vQ1Em168554rqM+AcEyk7rObxLac2g8tH1Pd6I83C8/2mPcrM6EC5HB+yuI
         ZQq+xXWBQ17rDR3i6if4Yr3L8h/fWDRW9Sjj870yRZqr2dNo7/szXK+hje9neRqzDGj1
         k+P4aQd8v6FJFSOymCFraV22X6dCtjZ03CNMccoXsgYKxxTrdgIEeGkBWmuwX9eMXQVf
         6oKU1HJcojpsQ/gOVihItBajLbiifqA4r48bx/wgZ3Vs2f3Le4J1aEEGs7KW+RdevsH2
         /nIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=KEZHLow75x1WGZauUbfw6ciLmnTzXmpQXtEtlinmygw=;
        b=Q+12PR5fr5DSnUPCcYbDh4eiWMU+ndQt9JyAAXcx6NHbi/tgdNAacJtRBRiFWBDg+i
         5Pn6D5qNXMyUbW6d4JE5x1uRpz2rPd2ccZ/enNAAyqCg3IECogeM5/PYHtjNHzKKlLHh
         m26/HpylkiZFhfV0oa5+98i40VESCzWQJ9Ii5WmoKERaOag3u2vc3/lsGHvjlActJJo3
         tjyaQgE9tqQbM/ABZonN7GCvvhQ7KTTN16tDpAVLrZMnEd0KGzZ+h9w1jhGdVz+gj7cC
         WakC70dW5m2khcBD6HlUPdvSMzuMGOsn0s+s+Cu+qp1T8ajzgMNNbuW+1DXG2GIKJYOp
         mmSw==
X-Gm-Message-State: AOAM533abOl5WGlXSCRaPsjSGcW3QrMLsxP9stwvg8YqAHqzrotU7FMc
        pzVsYOTpxi0oHCEXBEay5KUVtQ==
X-Google-Smtp-Source: ABdhPJybJIEFYk2ErRp3fvA+q2tyQLM9BD6LGpYjoii03ztTUTqqX4O2JwO+0Ij8wpxOd+bSneCDiQ==
X-Received: by 2002:a63:205b:: with SMTP id r27mr3555018pgm.326.1592491454092;
        Thu, 18 Jun 2020 07:44:14 -0700 (PDT)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g9sm3127197pfm.151.2020.06.18.07.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:44:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 11/15] xfs: flag files as supporting buffered async reads
Date:   Thu, 18 Jun 2020 08:43:51 -0600
Message-Id: <20200618144355.17324-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618144355.17324-1-axboe@kernel.dk>
References: <20200618144355.17324-1-axboe@kernel.dk>
Reply-To: "[PATCHSET v7 0/15]"@vger.kernel.org, Add@vger.kernel.org,
          support@vger.kernel.org, for@vger.kernel.org,
          async@vger.kernel.org, buffered@vger.kernel.org,
          reads@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XFS uses generic_file_read_iter(), which already supports this.

Acked-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 00db81eac80d..fdbff4860d61 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1080,7 +1080,7 @@ xfs_file_open(
 		return -EFBIG;
 	if (XFS_FORCED_SHUTDOWN(XFS_M(inode->i_sb)))
 		return -EIO;
-	file->f_mode |= FMODE_NOWAIT;
+	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return 0;
 }
 
-- 
2.27.0

