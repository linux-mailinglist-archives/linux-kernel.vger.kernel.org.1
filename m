Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A355202B89
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 18:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgFUQSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 12:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730411AbgFUQSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 12:18:01 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B0AC061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 09:18:01 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l12so15404119ejn.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tesTH4G8U5e6uxrTRKBwwbsmKxaMsyGX6X+lmfzYxHY=;
        b=h0YeuDrTyUP0zOpqI50pCPegH/QuVJ5KqrEFRHa0klK1ReD+NdRplRhuUNFFgTOPNt
         Nk8PuosipEjambeJzyoa0+rK7ksKpEP0eQ1ovNLDK1647Muyqy49/LU09b/KUxghX9PL
         mSMk5yEJrSbj7TewgXhi8F0jOhPFQyCvc6vWPWmZJoOnuHXSJTDrqDN6POBj1HpnU4XN
         XlTUwJOeqqUgtnRoVoqjxETrNhtw4vqHqhQ1PmWDW/X4eh2aCAL41Vypx7gfnRevpK48
         IqkWaHPybWyf6Gch/d6e9fF9cgmWDKdxXtIiyr++s+Jacdl7usaMB3JKVfRIMiLzog4K
         UfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tesTH4G8U5e6uxrTRKBwwbsmKxaMsyGX6X+lmfzYxHY=;
        b=AfgTvIp60b1MjpwpNVhDcMl3KsvAYPDFxHGfuEaenSnOOKmLuzuMsb/S0GbtCVG9bP
         HgQtoJhcYm0BFomoz6Hkp/62SqNlrYW+VGeUglk2Rc7KTt3fZMqAkuSFAs0P1awp7hoF
         Bl9uGBRNlxMPT6TIaymShRvOJOpfK2lQR67Y15j9dxa3GBTkImxk6X0OtqzYNJKrPyke
         RQ5QcykXux8cqcUjt+6t7rfrCk4tq398FcBTVXKtOditC5sev89gcMVZQ+CdPyD243R6
         RoTGVagUmkm/tD87upElDyFf2q3/9qQHlynzV3WGb4FHNwsLBH/R4qr47EMnEpKtlmuJ
         oeyQ==
X-Gm-Message-State: AOAM5331eB562bG399XHvl/wv63yzU2930c3zTZlzrmCGlC8zc1gRy0V
        e8evdDteyjdmeinyQvDY7AI=
X-Google-Smtp-Source: ABdhPJzZ/GyTOLJ7SsaI0pP78asp3de3FmOvXsB9fOvh7td0w7mxKQgbBiw8wAA6r1YnEo41hATs8g==
X-Received: by 2002:a17:907:b03:: with SMTP id h3mr13002880ejl.367.1592756280331;
        Sun, 21 Jun 2020 09:18:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:c981:717d:11f2:31a3])
        by smtp.gmail.com with ESMTPSA id ew9sm9660313ejb.121.2020.06.21.09.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 09:17:59 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] lib/generic-radix-tree.c: remove unneeded __rcu
Date:   Sun, 21 Jun 2020 18:17:45 +0200
Message-Id: <20200621161745.55396-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct __genradix is defined as having its member 'root'
annotated as __rcu. But in the corresponding API RCU is not used.
Sparse reports this type mismatch as:
	lib/generic-radix-tree.c:56:35: warning: incorrect type in initializer (different address spaces)
	lib/generic-radix-tree.c:56:35:    expected struct genradix_root *r
	lib/generic-radix-tree.c:56:35:    got struct genradix_root [noderef] <asn:4> *__val
with 6 other ones.

So, correct root's type by removing this unneeded __rcu.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/linux/generic-radix-tree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
index 02393c0c98f9..bfd00320c7f3 100644
--- a/include/linux/generic-radix-tree.h
+++ b/include/linux/generic-radix-tree.h
@@ -44,7 +44,7 @@
 struct genradix_root;
 
 struct __genradix {
-	struct genradix_root __rcu	*root;
+	struct genradix_root		*root;
 };
 
 /*
-- 
2.27.0

