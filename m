Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE537304551
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbhAZR25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389325AbhAZHfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:35:54 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A433DC061756;
        Mon, 25 Jan 2021 23:25:27 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e9so1718811pjj.0;
        Mon, 25 Jan 2021 23:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yR1EmH+eKZ6/t9w/WD3ZQuNDO4ZpB1MOrJsEYZGHYPo=;
        b=aAgB8+/A5riE5/sQNJV6+YoZIYjGXSH0wMvqxPlK7GU2ipmhjnfB5fOu8dcwPgvIRT
         nRhNmY/zwDF5R6heDA9FpqeqjGT7eRSxg86XglEO5WzYgaXPyhR0SHMwrJ837K0M/c2L
         CCY6pxu0Wyqbk7JcVilN7ZZmERMHX+hKLM475ExRHx2vR5SFk4JP/xilm2VlqUNJMtQO
         LjuSyjfuO7Qct8n98ff7BEWpaLZrDQIZVKte+MP1N2QiqeLHyEbw5oovI2pe93cVIfl6
         tz42uKq6T6QpYFKV581lskjhw7iBrEalAO0AXMuG0NP9Lu7VSYy1PANXi2QakFh8eONG
         8Y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yR1EmH+eKZ6/t9w/WD3ZQuNDO4ZpB1MOrJsEYZGHYPo=;
        b=Te8s1ucOkL2n3bVOgPtTRvGJQq1XgU7uMfE8rLix9FE84m1NRxR9W5NtLPmgsy6soZ
         enIGxg4wb/U/ngwVp2KiblzOw6JaUeLbsU1MwcPuvDuWy5uOT0PWCM2jJfmcwQ7WF0/k
         NZvut+3scDZGZDGNdBJjVKigT6w1Ex+8cor3dxInCn0xMtfWBDpjH3o2T4bRDI8gPigr
         gAYl+xu9K8N7MVNcfoN7/TigzCCCs3F/g/2dWmq+bewDCi6SpdwJ7e/mj9eASttCyqj8
         +f/jnrp8+o5lCzxVthoNrv4YINZ8GXyhWXwF2A/TJatdqEGzRwvmBWUmNyFm7K6UJ0lE
         4Pmg==
X-Gm-Message-State: AOAM531Je8kJszTZei5SBcm8V5IRV0vdoWt2Ff1YBJzpVPFGL6x0XEiX
        5b0DOCDQ43qidhKFefYV2k8=
X-Google-Smtp-Source: ABdhPJytI4ZZMP1xm8zly9Ky4oN3ZLc3JerW0zo4pL01NzcP57McVlAZy36sfwV/k0MCZgFeX1IJFw==
X-Received: by 2002:a17:90b:3751:: with SMTP id ne17mr4818833pjb.174.1611645927251;
        Mon, 25 Jan 2021 23:25:27 -0800 (PST)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l12sm1320256pjg.54.2021.01.25.23.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 23:25:26 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     corbet@lwn.net, vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] docs: path-lookup: update path_to_nameidata() parth
Date:   Tue, 26 Jan 2021 15:24:33 +0800
Message-Id: <20210126072443.33066-3-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126072443.33066-1-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No path_to_namei() anymore, step_into() will be called.
Related commit: c99687a03a78775f77d57fe9b07af4c8ec3dd03c

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index e778db767120..2ad96e1e3c49 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -455,7 +455,7 @@ In the absence of symbolic links, ``walk_component()`` creates a new
 ``struct path`` containing a counted reference to the new dentry and a
 reference to the new ``vfsmount`` which is only counted if it is
 different from the previous ``vfsmount``.  It then calls
-``path_to_nameidata()`` to install the new ``struct path`` in the
+``step_into()`` to install the new ``struct path`` in the
 ``struct nameidata`` and drop the unneeded references.
 
 This "hand-over-hand" sequencing of getting a reference to the new
-- 
2.30.0

