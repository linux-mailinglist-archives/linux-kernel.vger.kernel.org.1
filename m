Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076692F09F9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 22:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbhAJV7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 16:59:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27381 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726432AbhAJV7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 16:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610315889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3eVTM/WNkAqgnImqOE9gVZKZvkeANNt1RNH+SQOg+Dg=;
        b=JzfB34Qu4C+iJjfFvPHiNSlc+cVLFWbLakT6RIKqbH6tuNR9mZgMKdZxAR3rHOFyoBHo53
        t3h8QWbfwvHsNIQuE8ye5TaHy1O6/rjLWAWUGlE+dDRclSKFnUsGgaxTAlfeEWKqXeudWf
        SmlCPyr/3mcrU51qaO5PBka9QAOY3xU=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-3KklEeiRM-q0GtxosnOO1g-1; Sun, 10 Jan 2021 16:58:07 -0500
X-MC-Unique: 3KklEeiRM-q0GtxosnOO1g-1
Received: by mail-il1-f197.google.com with SMTP id q3so495515ilv.16
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 13:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3eVTM/WNkAqgnImqOE9gVZKZvkeANNt1RNH+SQOg+Dg=;
        b=EDvowfy0FlkrNWw0A3wxbkf7ygmyT3X75LnBJwJA/KmwgHyNQYVn23rww5LlzhVw/X
         uEmdb1fzuh+lXT83G7tj58qp7shSnnVn0SrcCRy3VHZUG/X+Ou4JuE5mO/lsALZ/SGRU
         IFpulWhTTPa5+8Q9U6zAnpOXFDfblsncMSJF6dKPOeFBv2q7S9uTwQEtSvTuk88KSMcq
         EeOOMP2du7cQ7zf978XazAPhtYV9kyjrvfIwspSqogfcKCJjwoRdif6u3RI+Zoz3LBVt
         NqQ2rkaCS64BeH81wW3KQI4qj1a9pTeVnPAvcrEXgkdaBLfE5OXkhS0e5f4aiLhue/8X
         MJzQ==
X-Gm-Message-State: AOAM5333+15Vn5WkowHUsnTTUE0Wm1qy0B/BszIdK0LESNO57MIHugI8
        sVg2Lmvkcthq5p1r8wHkONdoiWnEZHZh/ROkr2FsAJ9TK6ihQkkDzdV5Loo6gAwQ7KNPvjQmTyz
        gDLl2XrLteBm0qqzcDNS46lqJ
X-Received: by 2002:a6b:3bc3:: with SMTP id i186mr12800070ioa.192.1610315886932;
        Sun, 10 Jan 2021 13:58:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhXHAmjJbP70famD48l8MmAZeIccDPOkMoTViCj28iRQ6f8vgQrbgucsrH02pgV72MBdd4cQ==
X-Received: by 2002:a6b:3bc3:: with SMTP id i186mr12800067ioa.192.1610315886747;
        Sun, 10 Jan 2021 13:58:06 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e19sm10014698ioh.15.2021.01.10.13.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 13:58:06 -0800 (PST)
From:   trix@redhat.com
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        axboe@kernel.dk, natechancellor@gmail.com, ndesaulniers@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>
Subject: [PATCH] block/rnbd-clt: improve find_or_create_sess() return check
Date:   Sun, 10 Jan 2021 13:57:26 -0800
Message-Id: <20210110215726.861269-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem

rnbd-clt.c:1212:11: warning: Branch condition evaluates to a
  garbage value
        else if (!first)
                 ^~~~~~

This is triggered in the find_and_get_or_create_sess() call
because the variable first is not initialized and the
earlier check is specifically for

	if (sess == ERR_PTR(-ENOMEM))

This is false positive.

But the if-check can be reduced by initializing first to
false and then returning if the call to find_or_creat_sess()
does not set it to true.  When it remains false, either
sess will be valid or not.  The not case is caught by
find_and_get_or_create_sess()'s caller rnbd_clt_map_device()

	sess = find_and_get_or_create_sess(...);
	if (IS_ERR(sess))
		return ERR_CAST(sess);

Since find_and_get_or_create_sess() initializes first to false
setting it in find_or_create_sess() is not needed.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/block/rnbd/rnbd-clt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 96e3f9fe8241..251f747cf10d 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -919,6 +919,7 @@ static struct rnbd_clt_session *__find_and_get_sess(const char *sessname)
 	return NULL;
 }
 
+/* caller is responsible for initializing 'first' to false */
 static struct
 rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
 {
@@ -934,8 +935,7 @@ rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
 		}
 		list_add(&sess->list, &sess_list);
 		*first = true;
-	} else
-		*first = false;
+	}
 	mutex_unlock(&sess_lock);
 
 	return sess;
@@ -1203,13 +1203,11 @@ find_and_get_or_create_sess(const char *sessname,
 	struct rnbd_clt_session *sess;
 	struct rtrs_attrs attrs;
 	int err;
-	bool first;
+	bool first = false;
 	struct rtrs_clt_ops rtrs_ops;
 
 	sess = find_or_create_sess(sessname, &first);
-	if (sess == ERR_PTR(-ENOMEM))
-		return ERR_PTR(-ENOMEM);
-	else if (!first)
+	if (!first)
 		return sess;
 
 	if (!path_cnt) {
-- 
2.27.0

