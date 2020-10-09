Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A164E288962
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbgJIMzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:55:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44242 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbgJIMza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:55:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id b1so7202030lfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 05:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vaa2gki9lHlNHOZf+n4diLXX/JkJWpxYyjzMUffhof0=;
        b=b/ZgWGXhGVnt6AUW+hqfXyGSViweypEKAv0leWKSyCWXRLNgENfDQWpignR7cktELl
         0VECdz0F0Y1B5Q3yRjXoAyuZCDJ0QyaVcDqD4fAEngxpiGGlPSW9MUZqZBN9YmtzhNLG
         yOQqafbBdH0eFGyNrX7SjIFBSV4Bp7bJwckJQShWSaDBYe0s5X3NPLPfuPAH3djFrAvd
         2K+kxmzDqai0aVeYQLtGdUiFL55EW4XuO36RyeVY4DEOfZqyFtUGzKW0LjqS2JeMk3WO
         dfYFZcU57ZIvwy7XjESq57eUVvH7dXK5fdQNnoIMcC1cUNRx20dpCk//nldgmCOv9bJv
         8ETw==
X-Gm-Message-State: AOAM5319uKeHctLAlipe/rAmpEvrhPnvrHE4H54QTqEnGFS4mmszsylh
        2sXV0vq4VW4237c7tIBZNtA=
X-Google-Smtp-Source: ABdhPJz1uv7MF9SZwcCxoq4RFK+tbdV76yVtzdEs/H/O5j14hy0E1eruWWPcP9ZSTrMpAnaDRbMa+Q==
X-Received: by 2002:a05:6512:512:: with SMTP id o18mr4643809lfb.328.1602248128518;
        Fri, 09 Oct 2020 05:55:28 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id t21sm1538684ljh.65.2020.10.09.05.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 05:55:27 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     julia.lawall@inria.fr
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: api: kfree_sensitive: print memset position
Date:   Fri,  9 Oct 2020 15:54:53 +0300
Message-Id: <20201009125453.31217-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print memset() call position in addition to the kfree() position to
ease issues identification.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/kfree_sensitive.cocci | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/api/kfree_sensitive.cocci b/scripts/coccinelle/api/kfree_sensitive.cocci
index e4a066a0b77d..8d980ebf3223 100644
--- a/scripts/coccinelle/api/kfree_sensitive.cocci
+++ b/scripts/coccinelle/api/kfree_sensitive.cocci
@@ -85,14 +85,16 @@ type T;
 
 @script:python depends on report@
 p << r.p;
+m << r.m;
 @@
 
-coccilib.report.print_report(p[0],
-  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
+msg = "WARNING opportunity for kfree_sensitive/kvfree_sensitive (memset at line %s)"
+coccilib.report.print_report(p[0], msg % (m[0].line))
 
 @script:python depends on org@
 p << r.p;
+m << r.m;
 @@
 
-coccilib.org.print_todo(p[0],
-  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
+msg = "WARNING opportunity for kfree_sensitive/kvfree_sensitive (memset at line %s)"
+coccilib.org.print_todo(p[0], msg % (m[0].line))
-- 
2.26.2

