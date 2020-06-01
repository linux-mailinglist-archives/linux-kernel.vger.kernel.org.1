Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA9A1E9B1F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 03:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgFABCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 21:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgFABCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 21:02:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF54EC061A0E;
        Sun, 31 May 2020 17:59:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u26so10963581wmn.1;
        Sun, 31 May 2020 17:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p7JqSuy5guwvsVASRKWUkdkC+BMRPjcb0/zpykmFsTI=;
        b=thXGumxNqnA6UtU0OTeobA3QkMtInY35ycdQzSPjb2RI2Ez9NEkragfLr2enPwv1np
         M/lu9y2342GQi6s0tg/wjdyMDhFIjCW6kGLSkpFfMHTxmNwlG/99+hjSkFzGB9aG2Pgx
         fRncNifuTuu7XXN9sQ8dMgCatU+jjznInQoKY7puskuByIcLR0ikY8frE6Ai0pM355jg
         tUiH3O3mEGZIdbsWyxFpQWs9HtV/ZftHldoPTCX1p8c4xHw9Smxq9VC4Tn1GRTI6TANF
         mElvdJMZY3f27r96aoIkxQZyQFW8W9ItZG7oPwylNJuACQb3JneOk+YoiDXMJTn67APk
         vusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p7JqSuy5guwvsVASRKWUkdkC+BMRPjcb0/zpykmFsTI=;
        b=mtnIosbe+2rh7ZoBNt7NnMMRguCqQdytHU0UjobSqEiZXz40lsa+dRkiqhCZpNHjN6
         lHIU6EMsVDZc0LoKT/Ecg0nv9ECg4mC+72MDtIKdH83TSGS/T/azdjk1N19SP+/3HcSn
         GSWz9AVcgHwrWzuV5Ro8wuHm16pJ69mUzSXmecEUFY5qgX2t09jGAVIyus9bqiLrM1qX
         /AvhP+TXYMZEApwEJjV9F/rlKbL/pWPoxJW4+aTnSiY8obL3KadKb0mmv1M6F/BaJSQc
         lAXvDGnEd+IxNyFelgD7F3zpZuGyestRTwzigqdNGxLZQdW6AQwxXcd+jyK8mTLD48b7
         0gGA==
X-Gm-Message-State: AOAM533k9i57ZjhYAFD7mfesgHf29rN1Q8l0thf6Wp5HDku/77kIT2zO
        topyjJlvKuiTwlBbOT5Of/8=
X-Google-Smtp-Source: ABdhPJzR27NBtRtknpJllfju9lJIwzq4sq7uCCNPCCDMRMsHwtggu3SFRdJCPEeDHWfQJbVEcE551A==
X-Received: by 2002:a1c:230f:: with SMTP id j15mr19943837wmj.100.1590973160384;
        Sun, 31 May 2020 17:59:20 -0700 (PDT)
Received: from localhost ([46.114.110.178])
        by smtp.gmail.com with ESMTPSA id h1sm10963737wme.42.2020.05.31.17.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 17:59:19 -0700 (PDT)
From:   Sedat Dilek <sedat.dilek@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH] zswap: docs/vm: Fix typo accept_threshold_percent in zswap.rst
Date:   Mon,  1 Jun 2020 02:59:11 +0200
Message-Id: <20200601005911.31222-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, I switched over from swap-file to zramswap.

When reading the Documentation/vm/zswap.rst file I fell over this typo.

The parameter is called accept_threshold_percent not accept_threhsold_percent
in /sys/module/zswap/parameters/ directory.

Fixes: 45190f01dd402 ("mm/zswap.c: add allocation hysteresis if pool limit is hit")
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---

Changes v1->v2:
- Changed subject line
- Resend to LKML with correct email-address

 Documentation/vm/zswap.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/vm/zswap.rst b/Documentation/vm/zswap.rst
index f8c6a79d7c70..d8d9fa4a1f0d 100644
--- a/Documentation/vm/zswap.rst
+++ b/Documentation/vm/zswap.rst
@@ -140,10 +140,10 @@ without any real benefit but with a performance drop for the system), a
 special parameter has been introduced to implement a sort of hysteresis to
 refuse taking pages into zswap pool until it has sufficient space if the limit
 has been hit. To set the threshold at which zswap would start accepting pages
-again after it became full, use the sysfs ``accept_threhsold_percent``
+again after it became full, use the sysfs ``accept_threshold_percent``
 attribute, e. g.::
 
-	echo 80 > /sys/module/zswap/parameters/accept_threhsold_percent
+	echo 80 > /sys/module/zswap/parameters/accept_threshold_percent
 
 Setting this parameter to 100 will disable the hysteresis.
 
-- 
2.27.0.rc2

