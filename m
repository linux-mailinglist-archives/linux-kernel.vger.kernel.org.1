Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043AA2DF42B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 07:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgLTGKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 01:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgLTGKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 01:10:17 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4ECC0613CF;
        Sat, 19 Dec 2020 22:09:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d13so7343840wrc.13;
        Sat, 19 Dec 2020 22:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+vi/EMPNQpAUmGFczW04M1A/3Hf36lRGmcJFQyCGv5c=;
        b=uG/RZRR1X26VzpZBAb5mMXPGIEZZO7ffoFwP+DN0KGOjkm6CfOTNeZC173Dp/oXKQx
         iT8/DTVWxXmTxV0//SL7xziZzIAL9HwyblTYSjQQZcm+ynSemvBL6n0S0ZHnnxH+U1EK
         mr1bJ2yoe0WeFpL0O+77iz/X767lKnByC//6a3XPUyEu+rKbBfvCjl1oyk7UuY2DcGRp
         It/HrQmtYb/kfVo0WWoplcebVTW8chx1Iw2lg7pCM7qvenkf2Qxt3XaUa3GI/5SR3QUM
         /0QKU5K4n+zvYzas8M8Hky3d/ia1cLFagxrVSySASIn1nM2gTLgdY81RHuk3qq25F68z
         KTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+vi/EMPNQpAUmGFczW04M1A/3Hf36lRGmcJFQyCGv5c=;
        b=mB/R0NTStgECopIJ5ebg0Kjme3DOoTwXbQoK+a0swMR9yL8hhD/902IEQXkSDZ6M8v
         vfVxie6ROAdy1M2KfdnmEjRy5ykvBq9mkeGwjDVKFM+DJ7j/G9sserZkcZ2wN+qqaHUP
         hW/D5dV497JsvQTLSXTQs2/OtI3qI/XWkqT2pcDFR0UMg90u++oIIv7AxRC7FLTvsabp
         xm/Bhhy/FnU5V81MkfAvkGVD9TkXNd+DlEbSmjdYdlIWWlbu/H3w078ZaoJer1P2Z1No
         oqGhIY0zOwMiM6mCxLxQDSvSnFzWOcVj68h7obvrZPm4xjWouNUx+eB7o1W9AS8hoRka
         WNxw==
X-Gm-Message-State: AOAM531myq+Oo9XxSnhTznux+1AUs0/Br5pQlcNpVdnQJL+fauA+HcA2
        XcQw8Q3qiZ7uqBMKsHY3kz8=
X-Google-Smtp-Source: ABdhPJxPQVgy7EAwDsY5UZTQO2gnYZwYYAMvkyYqIz8om1CeuoE8CvG9UH2l2CSqa8yl1JscV2VL5Q==
X-Received: by 2002:adf:f344:: with SMTP id e4mr12199835wrp.25.1608444575426;
        Sat, 19 Dec 2020 22:09:35 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2de5:4000:d8f2:de32:a0d6:1baa])
        by smtp.gmail.com with ESMTPSA id m18sm21164952wrw.43.2020.12.19.22.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 22:09:34 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] atomic: remove further references to atomic_ops
Date:   Sun, 20 Dec 2020 07:09:27 +0100
Message-Id: <20201220060927.21582-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f0400a77ebdc ("atomic: Delete obsolete documentation") removed
./Documentation/core-api/atomic_ops.rst, but missed to remove further
references to that file.

Hence, make htmldocs warns:

  Documentation/core-api/index.rst:53: WARNING:
  toctree contains reference to nonexisting document 'core-api/atomic_ops'

Also, ./scripts/get_maintainer.pl --self-test=patterns warns:

  warning: no file matches    F:    Documentation/core-api/atomic_ops.rst

Remove further references to ./Documentation/core-api/atomic_ops.rst.

Fixes: f0400a77ebdc ("atomic: Delete obsolete documentation")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---

Peter, please pick this quick minor fix on top of your commit above.

 Documentation/core-api/index.rst | 1 -
 MAINTAINERS                      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 69171b1799f2..f1c9d20bd42d 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -53,7 +53,6 @@ How Linux keeps everything from happening at the same time.  See
 .. toctree::
    :maxdepth: 1
 
-   atomic_ops
    refcount-vs-atomic
    irq/index
    local_ops
diff --git a/MAINTAINERS b/MAINTAINERS
index f5eafee83bc6..4ea4ef9ec5d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10280,7 +10280,6 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
 F:	Documentation/atomic_bitops.txt
 F:	Documentation/atomic_t.txt
-F:	Documentation/core-api/atomic_ops.rst
 F:	Documentation/core-api/refcount-vs-atomic.rst
 F:	Documentation/litmus-tests/
 F:	Documentation/memory-barriers.txt
-- 
2.17.1

