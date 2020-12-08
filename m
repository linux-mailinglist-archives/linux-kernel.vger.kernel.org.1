Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EA32D211E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgLHCsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726830AbgLHCsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607395637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JHm7VOf4vG5fW9dqcix1M4Ga8GJuy8GIXJPeBhURP8Y=;
        b=fsXJRz7t2ELwtUJnMINzPzkhECThtijO2HhwEqQOqvXBq/zEUxo7X84+l56ckt79F5QSvO
        mgWPS16z23L8OfIncWhRbl2nAn1ZgQgwmoTW7NrLneCc+wApQm2iv+JoUeZwkYpl0c61jM
        DIXgjFZJYA01NQsBqOywIA2QyrM/ThE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317--N2EKV4uPX-gSkBGe4X9ZQ-1; Mon, 07 Dec 2020 21:47:15 -0500
X-MC-Unique: -N2EKV4uPX-gSkBGe4X9ZQ-1
Received: by mail-qt1-f200.google.com with SMTP id z43so167963qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 18:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JHm7VOf4vG5fW9dqcix1M4Ga8GJuy8GIXJPeBhURP8Y=;
        b=kVjpfDaKs1MgvQOVTbSXCsBTXJFo+hR79X9q1WhpvifdV8jOJPY+rk9HW1tAW4ZmD5
         4J0eAoRsI0m5uBY6UkKtJPHU8DLjy97pGIYmUPb9sYiTQ62rBJu9QYeZbvDD5myY5XGh
         ZDRPEY2z2UNzIuF5JKEi9IJUOScaz8/umn/IILYduUg/BBvO8s8YUIoiNj1GpWf6Acla
         M5B93i7QQ1MhVMuuD9eJ6U6vlqBgztHXlCUgvxygYplQFkBLrC+2RlZEY0U70lo7krBB
         0mM054x40Q3+M9meRFF8pyL+qTLTyI8LAsQZ0qYFONkTlT5m7/d/334yoG+4O1Rc3Nws
         C6wQ==
X-Gm-Message-State: AOAM531SOT5R3VRe8wQfr6TgqRrwEKQ5BK/Id+y8mCY9R4CAWmwcFqyj
        9ZuwNd8rV3lnFqT8EhYfW35S1diKhwGvt+9VM90MvD/w4DvMcUqkQeQtEAR56zt190WAWRf184D
        7i9kgUcsvaksVgglIsT7S00n18SmHh53Fo3y9YFIjkxHUaZrSRRk8eX4Lridm+1uwscb3dwW9tw
        ==
X-Received: by 2002:ad4:524d:: with SMTP id s13mr24676869qvq.19.1607395634961;
        Mon, 07 Dec 2020 18:47:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBZN0PrBHURyXeqoNeBbqq9BCmFz5EFAExrc7GKN1qoYPwkrbI06U6+ZHVzQbzcNsGNsjMLQ==
X-Received: by 2002:ad4:524d:: with SMTP id s13mr24676846qvq.19.1607395634725;
        Mon, 07 Dec 2020 18:47:14 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id n95sm13778744qte.43.2020.12.07.18.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 18:47:14 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 2/3] userfaultfd/selftests: Fix retval check for userfaultfd_open()
Date:   Mon,  7 Dec 2020 21:47:08 -0500
Message-Id: <20201208024709.7701-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201208024709.7701-1-peterx@redhat.com>
References: <20201208024709.7701-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

userfaultfd_open() returns 1 for errors rather than negatives.  Fix it on all
the callers so when UFFDIO_API failed the test will bail out.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 31f470d12d0b..f0647bfda366 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -993,7 +993,7 @@ static int userfaultfd_zeropage_test(void)
 	if (uffd_test_ops->release_pages(area_dst))
 		return 1;
 
-	if (userfaultfd_open(0) < 0)
+	if (userfaultfd_open(0))
 		return 1;
 	uffdio_register.range.start = (unsigned long) area_dst;
 	uffdio_register.range.len = nr_pages * page_size;
@@ -1038,7 +1038,7 @@ static int userfaultfd_events_test(void)
 
 	features = UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_EVENT_REMAP |
 		UFFD_FEATURE_EVENT_REMOVE;
-	if (userfaultfd_open(features) < 0)
+	if (userfaultfd_open(features))
 		return 1;
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
@@ -1101,7 +1101,7 @@ static int userfaultfd_sig_test(void)
 		return 1;
 
 	features = UFFD_FEATURE_EVENT_FORK|UFFD_FEATURE_SIGBUS;
-	if (userfaultfd_open(features) < 0)
+	if (userfaultfd_open(features))
 		return 1;
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
@@ -1170,7 +1170,7 @@ static int userfaultfd_stress(void)
 	if (!area_dst)
 		return 1;
 
-	if (userfaultfd_open(0) < 0)
+	if (userfaultfd_open(0))
 		return 1;
 
 	count_verify = malloc(nr_pages * sizeof(unsigned long long));
-- 
2.26.2

