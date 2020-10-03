Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47B32824A3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgJCOUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgJCOUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:20:18 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DAEC061787
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 07:20:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g29so2852488pgl.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+w9ezZ2ptMY0SEs0AzmqlyanFEZQPYlxJrLop71X20k=;
        b=iAIi+FfMfWxojLoPAoAXwS/dJfs5LrMu/Chc2ZBEQ5AEAAxfAdfhgNaEeIHV/VkiQf
         ZRf2SsBDgdGMsrEUcQg73G4h4MLt1tgn74JNcvv5m0wTfYn0mIDpFBMNOSeve4CkzZw6
         WZY0za93fZYDjPBX8BdtmZJfLi1U7SRB4EgGUmpczKjbomqetD6Wo8O9UBjGHmd3fGyZ
         Im69K/yDwk60pLKrDcXGwhJcC6W8xeYG0AW9bFQsiBIjEaDjJ+v79dhYnfph+sDi7EAJ
         Mzy/gWtH0ndR7zw6dkCuLBwnvHlzRZury6zn4ezNoIDDL4Co9BFgqnPIhrvX1auNXchz
         XGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+w9ezZ2ptMY0SEs0AzmqlyanFEZQPYlxJrLop71X20k=;
        b=maU8lo9GkZNLJxzqedx+f4D2gYEFItH3cwgznQWcr6UN2qzkbayj/7Bj+VrldX5AF4
         ngQNavLRwV4l+tEKsiE0qwGFa8dqoeoaixlze9Ui2v8yTMmqJ/4u61YfV8lTjbPZxLSQ
         2Xqze76/WaBlE84P2T8ez6KzIoW5w6mKJX92FCX8/2qteQ59zWxJnjoSjsz54tph09tb
         09U81nlv815xT1i0INQg/rU+Wq/+eA6GoO3EkisUWh9Cm6TXFcgzimrixrjBfb1V4RaU
         oKwgAho8Erk/Kb2XQWLF15DWeIVxWKkiDem3JjdCsdNqWiV1SjJkCeBD29vx46LjIvbN
         OI5g==
X-Gm-Message-State: AOAM533DiXspbq+rGyhDXMCV+/bTdpCxYwm+ki+awhCu4vHyeTCJTUe8
        +0aHGJsxfnVfA4QASOAr6pTpNe10ZNp9nQ==
X-Google-Smtp-Source: ABdhPJy/T1TvH67o58xShETdWKTcRzBWZOkfXQARvntQW7B02hxDkS53+FAeaAQ05OJr++cOmodwCQ==
X-Received: by 2002:a63:1f03:: with SMTP id f3mr6501658pgf.381.1601734817379;
        Sat, 03 Oct 2020 07:20:17 -0700 (PDT)
Received: from adolin ([49.207.201.114])
        by smtp.gmail.com with ESMTPSA id l14sm5764255pfc.170.2020.10.03.07.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 07:20:16 -0700 (PDT)
Date:   Sat, 3 Oct 2020 19:50:12 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: coccicheck: Refactor display messages on coccinelle
 start up
Message-ID: <20201003142012.idwudlhqiv3a4mjj@adolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, coccinelle starts by printing
	"When using "patch" mode, carefully review the
patch before submitting it."

Modify coccicheck to print this message only when the user has
explicitly selected "patch"  or "chain" mode.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 scripts/coccicheck | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..07d1b5831bf6 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -118,7 +118,9 @@ fi
 if [ "$ONLINE" = "0" ] ; then
     echo ''
     echo 'Please check for false positives in the output before submitting a patch.'
-    echo 'When using "patch" mode, carefully review the patch before submitting it.'
+    if [ "$MODE" = "patch" -o "$MODE" = "chain" ] ; then
+        echo 'When using "patch" mode, carefully review the patch before submitting it.'
+    fi
     echo ''
 fi
 
-- 
2.25.1

