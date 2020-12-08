Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC082D211C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgLHCso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:48:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726830AbgLHCso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607395638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJW5IJGNOP6CMuFv2EzyZw9QmKSzTdQS44PAdYMNjXU=;
        b=g5upWyexM2bZOjnu5Iwc//jXTU29F7zMbcem0Qhl9c2aat8A+Huf6ni+d+J8OHgY+ysU+J
        NjZ/As3h2JskcUxEPmH1xnJuNsCgP/Sdmerpt+3hvZdCZJWSrQcIrZPQ0OpYC1mL3V67zo
        bsJ9ROebAft4oo+dn2rXMnidhuRvRmw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-JbxSHN-YOrqRm2h0JPOhaA-1; Mon, 07 Dec 2020 21:47:17 -0500
X-MC-Unique: JbxSHN-YOrqRm2h0JPOhaA-1
Received: by mail-qv1-f70.google.com with SMTP id j5so3662055qvu.22
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 18:47:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJW5IJGNOP6CMuFv2EzyZw9QmKSzTdQS44PAdYMNjXU=;
        b=lOzPlabN+d6Wj+WNugTXWBKxl7bjJQD7gwOIN80kMMtE2EnTxvrmBRdllSqnQHciII
         PMJ1k3Hlia1CaT7kmacIEvvKQuknWF/zUm4T+jp6dPfEBKf7AyGij/jyFZZKr/ddvygP
         XT+Hm4K4iTPoeyM+c7aGBjmQvlYda5FF+TS7BzqYi3/svuAVz+xAPi+C+g1e/7w7tAeY
         wh7lQrNNKNKNN4NbmHWwpKJugerxWeq3gfNfrqyHYcSDVe3t7H5tHjP9zda5+RYnS++l
         eiSzz87JGVBHGOqh+RVGfXt0EqoyyFf9eM/yQmdYMCfiDeuPTi0eNN+FGknIWE4BIRdO
         dKBw==
X-Gm-Message-State: AOAM532WePv6pJz8MWmPghSmiP8XVIGk36TbcRA4FIHPQLwz0nntaARd
        bD7R3glNWmsq1P0zbNS5sOXaIRmj99cWHnKrnHsjH5GlWkLiIjvKfYsKmMbLzQV5vRu3lVaeHee
        UY2UJ97SMVdEyDb0qBlD6kZBjIq3t8NJviK82kNlCvSDR79RR4mkmNzqasQCB0u3zZWlYOeIcoQ
        ==
X-Received: by 2002:ac8:3594:: with SMTP id k20mr27520683qtb.18.1607395636390;
        Mon, 07 Dec 2020 18:47:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyK/+FRKLaJf67qFnojJEv5Ns9Slni9W1KgjcqTZnfv18RXlSVAdRnY1kJAEB1cQ1aYreeo1w==
X-Received: by 2002:ac8:3594:: with SMTP id k20mr27520665qtb.18.1607395636145;
        Mon, 07 Dec 2020 18:47:16 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id n95sm13778744qte.43.2020.12.07.18.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 18:47:15 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 3/3] userfaultfd/selftests: Hint the test runner on required privilege
Date:   Mon,  7 Dec 2020 21:47:09 -0500
Message-Id: <20201208024709.7701-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201208024709.7701-1-peterx@redhat.com>
References: <20201208024709.7701-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now userfaultfd test program requires either root or ptrace privilege due to
the signal/event tests.  When UFFDIO_API failed, hint the test runner about
this fact verbosely.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index f0647bfda366..27a1709099d0 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -755,7 +755,8 @@ static int userfaultfd_open(int features)
 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = features;
 	if (ioctl(uffd, UFFDIO_API, &uffdio_api)) {
-		fprintf(stderr, "UFFDIO_API\n");
+		fprintf(stderr, "UFFDIO_API failed.\nPlease make sure to "
+			"run with either root or ptrace capability.\n");
 		return 1;
 	}
 	if (uffdio_api.api != UFFD_API) {
-- 
2.26.2

