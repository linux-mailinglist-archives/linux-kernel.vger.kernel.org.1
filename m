Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC49267FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 16:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgIMOdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 10:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgIMOdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 10:33:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055B3C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 07:33:00 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id c196so10560247pfc.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 07:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Btcqa7Ss3wf3T8okzeIRJbVGIc22VxkWA4t/qIPR/qo=;
        b=L7/07/Vsg5gGavDTQRKWXGASQ+FYDur7bs0PoRHt9QtLFrHpdPGXA3TdjfmFF/vKZq
         fN4dTm1NWx+5Dlu/Av64tCCz6dvCwejsZ915Y/n9+4gozzMjXwk7NqT6Qm/kPUwrjNgq
         3Gzp/EXa52oRwgXOm55fIgpzaYn1LAnvokbQH9ySNkYXUSFh3T+7dVqPRrlQYhG+/R5B
         lNtKZzgVaiHCwzNS3AX7AclHXxu3e4H1MPpXLYdSKZJddySCccBcP1pFpCRlLx73TLTO
         l2HUEtu/f6voLE1oHEJN+1zJ5mC+Za7QqHGfTrY8a9Oe4Ks9ilqYk1xRk0I1ukbEcX4O
         j32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Btcqa7Ss3wf3T8okzeIRJbVGIc22VxkWA4t/qIPR/qo=;
        b=RvjMdSBSBGJf4S1W7TwUeqRFfGr5m3H1vsIUrW6IGExzKzcaJr4I+Cnp5xBLDgBpSW
         k+TNDsdP6rR9aFoO/Pc3yLKrjn9Sa2bBpyy5qZrC0faXasGGQbHelxUvKZ4drMSdUddR
         MXrCuPEavAUpx186dea8nV+NRUyWYcoOEWwYs4yTIBC3XUcD8tXrVrSPcb7G6VxmW7o8
         XHRcLYe2xsNytPN27DJLLmd+7+Y7NsA5iy1qeiRKf42k4Q7tY3U6NyP56Oe62csvHTPD
         tCcOFh+ROEfEfCqXhnmIi5dc5CUy929WfKifGqVNl9jFtbeqcGUQ5ybyxsorPwvNAiW6
         UyAg==
X-Gm-Message-State: AOAM532spqmoqOJ8NZvmTalrdIaB6IeRjgp6CthtWqs1aUKWEv4i/+9x
        q4jlEqN3abixdIdwPaLcRcw=
X-Google-Smtp-Source: ABdhPJyfAoM3KarB7tR3PpDmlCTkqwRplEb+zNL5euQnSSlq4Xn8xqqwZLSSyO7V+f84QzsjBhjdMg==
X-Received: by 2002:a63:5663:: with SMTP id g35mr8121830pgm.163.1600007579345;
        Sun, 13 Sep 2020 07:32:59 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.167.45.202])
        by smtp.gmail.com with ESMTPSA id kf10sm6618257pjb.2.2020.09.13.07.32.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Sep 2020 07:32:58 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] mm/gup.c: Handling ERR within unpin_user_pages()
Date:   Sun, 13 Sep 2020 20:02:35 +0530
Message-Id: <1600007555-11650-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that a buggy caller of unpin_user_pages()
(specially in error handling path) may end up calling it with
npages < 0 which is unnecessary.

This can be fixed by adding extra check inside unpin_user_pages().

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 0b5c308b..2e19bd6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -328,6 +328,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
 {
 	unsigned long index;
 
+	if (WARN_ON_ONCE(npages < 0))
+		return;
+
 	/*
 	 * TODO: this can be optimized for huge pages: if a series of pages is
 	 * physically contiguous and part of the same compound page, then a
-- 
1.9.1

