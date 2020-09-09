Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAE426332D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgIIQ6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:58:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730662AbgIIPvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:17 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37329221E3;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=+icd9iFPfE9J69QdGJrm2iSgwufEUYZ3m5WGuFBDVpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y9lRJtI2VAWUaEoZNeb0gjvYSEoK/9a8wTTAPSvXNgjlgXDlGxqysP21D4ECNps4Y
         cqo0v3e2bpOuYBAugSig6EeWVF1ZN/KebDjzK0jyaiijDQ35yb5gjwTwB2NQWtlO7v
         Udy5VGXkbX9PHYy8bYrpxn7TiC28LvH4e1DTxGts=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUX0-Bb; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/30] tools: docs: memory-model: fix references for some files
Date:   Wed,  9 Sep 2020 16:10:42 +0200
Message-Id: <0ff57854da54860ec0bc49368bf2bb215fff93b6.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
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
index 3d020bed8585..629b19ae64a6 100644
--- a/tools/memory-model/Documentation/ordering.txt
+++ b/tools/memory-model/Documentation/ordering.txt
@@ -346,7 +346,7 @@ o	Accessing RCU-protected pointers via rcu_dereference()
 
 	If there is any significant processing of the pointer value
 	between the rcu_dereference() that returned it and a later
-	dereference(), please read Documentation/RCU/rcu_dereference.txt.
+	dereference(), please read Documentation/RCU/rcu_dereference.rst.
 
 It can also be quite helpful to review uses in the Linux kernel.
 
-- 
2.26.2

