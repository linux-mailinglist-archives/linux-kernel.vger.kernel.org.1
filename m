Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C15C252BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 12:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgHZKsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 06:48:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728666AbgHZKrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:47:43 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE5E22080C;
        Wed, 26 Aug 2020 10:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598438863;
        bh=c9UUejGHlSQk9tZf9sDZeFpAo8r7qRhD6WXMRzwa+KE=;
        h=From:To:Cc:Subject:Date:From;
        b=GcBBo5VSefraifkVkVQOv2OGtis+Tdl7yEQ7NlHpXDOLqulygei2j4LEfyHsm07aY
         BAkb/YKUhNC5CYomFzsRKDk+LX4gm1r3uLKMVD7tghVWVcosiJt20ky7kQBLW14NlD
         5J8h2mrdJ3S9poc9vA38GjMWzzeluGxx5P0Ob/LA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kAsxw-002ESJ-VX; Wed, 26 Aug 2020 12:47:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] tools: docs: memory-model: fix references for some files
Date:   Wed, 26 Aug 2020 12:47:40 +0200
Message-Id: <20200826104740.532184-1-mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- The sysfs.txt file was converted to ReST and renamed;
- The control-dependencies.txt is not at
  Documentation/control-dependencies.txt. As it is at the
  same dir as the README file, which mentions it, just
  remove Documentation/.

With that, ./scripts/documentation-file-ref-check script
is now happy again for files under tools/.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/memory-model/Documentation/README       | 2 +-
 tools/memory-model/Documentation/ordering.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
index 16177aaa9752..004969992bac 100644
--- a/tools/memory-model/Documentation/README
+++ b/tools/memory-model/Documentation/README
@@ -55,7 +55,7 @@ README
 Documentation/cheatsheet.txt
 	Quick-reference guide to the Linux-kernel memory model.
 
-Documentation/control-dependencies.txt
+control-dependencies.txt
 	A guide to preventing compiler optimizations from destroying
 	your control dependencies.
 
diff --git a/tools/memory-model/Documentation/ordering.txt b/tools/memory-model/Documentation/ordering.txt
index 4b2cc551103a..5a87d7384758 100644
--- a/tools/memory-model/Documentation/ordering.txt
+++ b/tools/memory-model/Documentation/ordering.txt
@@ -347,7 +347,7 @@ o	Accessing RCU-protected pointers via rcu_dereference()
 
 	If there is any significant processing of the pointer value
 	between the rcu_dereference() that returned it and a later
-	dereference(), please read Documentation/RCU/rcu_dereference.txt.
+	dereference(), please read Documentation/RCU/rcu_dereference.rst.
 
 It can also be quite helpful to review uses in the Linux kernel.
 
-- 
2.26.2

