Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF671A866B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437024AbgDNQ63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391939AbgDNQ4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:56:17 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD7972076C;
        Tue, 14 Apr 2020 16:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586883376;
        bh=iNHsOYaudU7piKTYdPXN9OqrGseo3i9c8R6Deur42Rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVtet4CRfJLIpClvFCsKWnSkyUHYIu3OAQJSsRUWPF1JQj5SvN+sJgcWXBMBstZmv
         2HW9NMOMLYOzIs5IR+dE8VVR+ZH0Uur7bD6mFhD0pfE4g3g7U/uKQ8ariUW+VU7JtY
         9mVFdai9Fxrk5eRkmQQQOC+XHAmVlQRqKgUI/t8s=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOr9-0068yc-2D; Tue, 14 Apr 2020 18:56:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tim Bird <Tim.Bird@sony.com>
Subject: [PATCH v2 3/6] scripts: sphinx-pre-install: fix a dependency hint with Ubuntu 16.04
Date:   Tue, 14 Apr 2020 18:56:10 +0200
Message-Id: <912b664a8ca54e8c5c5767c3fe9171973eeddd6b.1586883286.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586883286.git.mchehab+huawei@kernel.org>
References: <cover.1586883286.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid the scripts to keep asking to install fonts-noto-cjk
on Ubuntu 16.04.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 6d6d2849fbb1..ba750f7b9127 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -349,7 +349,8 @@ sub give_debian_hints()
 				   "fonts-dejavu", 2);
 
 		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc",
-				   "/usr/share/fonts/opentype/noto/NotoSerifCJK-Regular.ttc"],
+				    "/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc",
+				    "/usr/share/fonts/opentype/noto/NotoSerifCJK-Regular.ttc"],
 				   "fonts-noto-cjk", 2);
 	}
 
-- 
2.25.2

