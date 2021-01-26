Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8144304EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405124AbhA0BdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731971AbhAZSho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:37:44 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86407C06178C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:35:32 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s15so10233566plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vdH6zS43Uh1xLUVirUD1G6mrrWUijLO9wl7HWhhmt7g=;
        b=iKdXBNV4CeeaDytwPHx45WzE9t58NE6pbbesPsoW1ml0vM4Q04xdAQOL9D634qvI8W
         yEX5OVMg32jH7U8qU+8uK2J5xLJtdJJNsJEs5T2bb/OWEKCcs1/CeTId2/DY79NJiZ2K
         XXEJuSY0VBey+HGi7P4foFtOJeu3lztqgc637rTlNfd0fP2mt4H40Bm2YLiZ4Ij0P35J
         TAIEcRH+tu65eTbSTecmuEXyR2n9giFJBuxR8sUAbp/ncN6nl7SPaLr/1qoAWvu3xCbB
         fJqv27i0uVG2kOI7WmHVshjrMGeNOojZBNEGzL6DtwnFIulrTyUcknGlrGX3GruCFYm1
         vsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdH6zS43Uh1xLUVirUD1G6mrrWUijLO9wl7HWhhmt7g=;
        b=ZoRzJP3pkedr2qRWUya3XW83o+KQwNU5jhbnynCDa9DJYmgky3xXybDlmmgKikwnkY
         qgNHawNel/vzJZrfOzEuns4jZEJBWB9D2c13d9Sye/g6n0XdwBqYsM5cM2/d+2D6ZaMJ
         KE1VfxVBvFI+mqWrZ/vdzKqyRTocLNny1uKLRO5murmIpCLMgAIkEJ65p9n9te756klv
         PHNTLGcHCwT4f5x8VQb1SXvZhZKVG9bE9MMacXKSYARzut3i1kAr35k3v14cGKXjgMfl
         vRPp6yfi81hBe1yt4d+Rq1u7zWO8nwtWWZG5tDHM8spoGrtRMMuUHayhg9KZ0id6J7+z
         I90Q==
X-Gm-Message-State: AOAM530ltnjQccllldP/2hzStJQ6N0T0vX42fwgk6ov5r+0IhgczqEdm
        hh6Pg/2YQWA0MiCNN7UhVTI=
X-Google-Smtp-Source: ABdhPJyDk3bnM+aGCU0UA/6LlXwIXWP2f/m2rpsWhOOtzxsmPNbrpUqcec7c9L0c7jLNAhxd+1airg==
X-Received: by 2002:a17:902:8b89:b029:e0:6c0:dea8 with SMTP id ay9-20020a1709028b89b02900e006c0dea8mr7500631plb.28.1611686132071;
        Tue, 26 Jan 2021 10:35:32 -0800 (PST)
Received: from localhost.localdomain ([49.37.2.129])
        by smtp.gmail.com with ESMTPSA id a31sm19713654pgb.93.2021.01.26.10.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:35:31 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH RFC 3/3] docs: add documentation for checkpatch
Date:   Wed, 27 Jan 2021 00:05:21 +0530
Message-Id: <20210126183521.26535-4-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126183521.26535-1-dwaipayanray1@gmail.com>
References: <20210126183521.26535-1-dwaipayanray1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link checkpatch.rst to the dev-tools index for sphinx.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 Documentation/dev-tools/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 1b1cf4f5c9d9..43d28998118b 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -14,6 +14,7 @@ whole; patches welcome!
 .. toctree::
    :maxdepth: 2
 
+   checkpatch
    coccinelle
    sparse
    kcov
-- 
2.30.0

