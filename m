Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1745C270184
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgIRQBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRQBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:01:48 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73333C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 09:01:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d15so6653706lfq.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tSk+YlDCjGoukvgJMkBk/WrFVc0NKEjKrwScxDLtmew=;
        b=Ycxqx3VC0OTdID4Ifzex+FgT5vRjS8++a/n4GrAC02k2k0vj4qgFrycBIhoL7DFyC2
         EbE9bNXAvZtz3nhRLTRkTi9KWpIYIlYEhAoq/XFN19q3SCIHh4xc4ncuruM0I9+Dm4sk
         2ExMHT7VBsENLH2LYGsZjWeDQ2zTWUuNWT661lvwnTP1uBreTT1SJ+yWTCivWnyNBnog
         AhtKHrBNey7rN8cWU7jWaWmS3a2pvA6GEKzYKQUU8WqMl/qiYUTm8dZJwNIJQbnZ7zbW
         E57vMrQWbGdCFqSzmUnNqE4X8eH/Pfhw1ICFi1Em7vA8LshkhMfT1uCjC4cbvOfCnoYO
         nWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tSk+YlDCjGoukvgJMkBk/WrFVc0NKEjKrwScxDLtmew=;
        b=K+6rgAWlUaou+v1JOf+C7FVfQJ70N70fT5B7bVEbYE9BqN8ZyJ4Kmv9yCUFQL6x29s
         +49uyJdmCuMLaggkwpMNywGfI7ArnykukiKCHFgOfR2kf/3eXXowcMIjV3Xa4K1OiV+Y
         +Os8W9m1pGgQdEPKmm9J65yNEv1PJntDjimvCgXa85jPtLQjIQKcgGJ+vkPyUhVCL9Yb
         R1wLQwwcKUtetggxOdMAjDxEWaFWrrtFfnNN7uQTmXrEDEfqFcXpCZBGoMQsuTKKaaMM
         0+m4VbTjYgxcLttT4pFcPMwoV7787nzDfr8fCiIN6V5T5wDFeXf3a3spYc7KzGnPwhmS
         Ik/A==
X-Gm-Message-State: AOAM531x/LzgM1/oZ6jDOv7F8bhdJHQxlYEe+Wv47A0kx7A7LJAPeYoV
        E9JRETzLc65kPRpQ3B+IoqRF+JBwzpzSoQ==
X-Google-Smtp-Source: ABdhPJzIjcdJwTpNamSYQ4DBWTtzTaNU33f+VI37W6l5C0sYPfHSUYqVND0gHl5LgIbz1UaUWvNF+w==
X-Received: by 2002:a19:650a:: with SMTP id z10mr9726020lfb.9.1600444905032;
        Fri, 18 Sep 2020 09:01:45 -0700 (PDT)
Received: from eriador.lan ([94.25.229.20])
        by smtp.gmail.com with ESMTPSA id s11sm681267ljh.56.2020.09.18.09.01.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 09:01:44 -0700 (PDT)
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: add map all old entries to me
Date:   Fri, 18 Sep 2020 19:01:42 +0300
Message-Id: <20200918160142.2984348-1-dbaryshkov@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change back surname to new (old) one. Map several odd entries to main
identity.

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 .mailmap | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a780211468e4..3bcfa33fc268 100644
--- a/.mailmap
+++ b/.mailmap
@@ -81,7 +81,10 @@ Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@gmail.com>
 Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@imgtec.com>
 Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@mips.com>
 <dev.kurt@vandijck-laurijssen.be> <kurt.van.dijck@eia.be>
-Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
+Dmitry Baryshkov <dbaryshkov@gmail.com>
+Dmitry Baryshkov <dbaryshkov@gmail.com> <[dbaryshkov@gmail.com]>
+Dmitry Baryshkov <dbaryshkov@gmail.com> <dmitry_baryshkov@mentor.com>
+Dmitry Baryshkov <dbaryshkov@gmail.com> <dmitry_eremin@mentor.com>
 Dmitry Safonov <0x7f454c46@gmail.com> <dima@arista.com>
 Dmitry Safonov <0x7f454c46@gmail.com> <d.safonov@partner.samsung.com>
 Dmitry Safonov <0x7f454c46@gmail.com> <dsafonov@virtuozzo.com>
-- 
2.28.0

