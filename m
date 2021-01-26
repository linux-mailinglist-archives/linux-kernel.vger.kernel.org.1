Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632AC303B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392104AbhAZLNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389276AbhAZHfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:35:54 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515CBC06174A;
        Mon, 25 Jan 2021 23:25:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d13so3561619plg.0;
        Mon, 25 Jan 2021 23:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pNUJBlrIwi/dx2gLwcZE95T1Xw6o1KcL98iYN5h+rPw=;
        b=mC2XAGiULOqSDQRQWOUNbJ+KdLYw/HxF0Vki9oXHJJ5CO5p03G3b2bYyvUtrEUp6Uu
         oMd+K5xG2/t7pgFoco1dLPu9cqdf/ZSqy+W1Fzw2JfBmLlFFs/tSplFQi8Ro3churlHW
         jM6OdcUaaw2gvbKuIkRZh+bqVPZGHjxzF5HZ17m7fAiI6xYLGNyTfJetj/jGfLAQf/uK
         jQoNw/rnPNhS1Ezdw4ku3+8FRBs90n6/Dpxj4j1ACnONrl328ixzhX3fBCze0dhEEgGH
         bBTvvtJHU/gg4i6tcgyB/ayXidxHtQm1KfIHGji5nvJvyr9ls3Zax+eisW7p7qWPqEic
         buWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNUJBlrIwi/dx2gLwcZE95T1Xw6o1KcL98iYN5h+rPw=;
        b=TBHjiAYPyhKhKLeFjnKY6wbFLaZgr9GRER9whI/NoJyOm5eBNn0FWubGssV2NAa+/3
         IW9aymHCT/MTcpaaIHKlH/2y+hujXOQ+HszP0AkNZshFE5wsWaJ7iTCyQlPqm8XbWB7j
         A+8JbTX+y7pRUImJ/b8LsWi4aWtZy03Y7StwP3iqOfYTRdDeXHfd+CduPNP0gcL9Q5qZ
         dyTJfr1kpuXkr79aQveAoig8LMAV1NMUPdUKmJe4hYkkn/WJ0hMBbcLjoW1mrN/BFhvn
         RXv1S1Aub8SasxdRMtP8oZGPHUO5DTSU5J1+qJmKO3pKkO3qjUkQrf+VLZXeiEMVSdqv
         rNoQ==
X-Gm-Message-State: AOAM531+AGbjsn9czNYyaNJgdDoOh0XVSMXP3ayRCRjmR5MyzxtAv+fP
        O2stYi94UHr/h3l/E2BXeR1SU7bhhpfn6YT/rM0=
X-Google-Smtp-Source: ABdhPJwN6N+i/src3tUgwYpbR6iYzv3n+68WQY9iCrP+P8PpFtw00crvusYOns/r06xXOs1rZ9sUng==
X-Received: by 2002:a17:90a:d249:: with SMTP id o9mr4663673pjw.78.1611645925892;
        Mon, 25 Jan 2021 23:25:25 -0800 (PST)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l12sm1320256pjg.54.2021.01.25.23.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 23:25:25 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     corbet@lwn.net, vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] docs: path-lookup: update follow_managed() part
Date:   Tue, 26 Jan 2021 15:24:32 +0800
Message-Id: <20210126072443.33066-2-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126072443.33066-1-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No follow_managed() anymore, handle_mounts(),
traverse_mounts(), will do the job.
see commit: 9deed3ebca244663530782631834e706a86a8c8f

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index c482e1619e77..e778db767120 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -448,8 +448,8 @@ described.  If it finds a ``LAST_NORM`` component it first calls
 filesystem to revalidate the result if it is that sort of filesystem.
 If that doesn't get a good result, it calls "``lookup_slow()``" which
 takes ``i_rwsem``, rechecks the cache, and then asks the filesystem
-to find a definitive answer.  Each of these will call
-``follow_managed()`` (as described below) to handle any mount points.
+to find a definitive answer.  In ``step_into()``, ``handle_mount()`` will be 
+called to handle any mount point.
 
 In the absence of symbolic links, ``walk_component()`` creates a new
 ``struct path`` containing a counted reference to the new dentry and a
@@ -536,7 +536,7 @@ tree, but a few notes specifically related to path lookup are in order
 here.
 
 The Linux VFS has a concept of "managed" dentries which is reflected
-in function names such as "``follow_managed()``".  There are three
+in function names such as "``traverse_mounts()``".  There are three
 potentially interesting things about these dentries corresponding
 to three different flags that might be set in ``dentry->d_flags``:
 
-- 
2.30.0

