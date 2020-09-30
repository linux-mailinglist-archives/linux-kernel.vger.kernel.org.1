Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB2E27E9E3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbgI3N2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730111AbgI3NZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:20 -0400
Received: from mail.kernel.org (ip5f5ad5c4.dynamic.kabel-deutschland.de [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D264520888;
        Wed, 30 Sep 2020 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472320;
        bh=5SqZu/FS0fyxmD8g6z8jFT+IGN8LFs1MhhoS9xtfPHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tb2QDb9sYPlVAvKB3zQoKmHdM81OK8v0VFMDY2wXg4DleZEUkHfxlXya9THWRt1Ts
         fjxgdTcuU2m/3G3o9+7BWRJpKR82MPwHibBzJTOc6tIsRjXzIR4YmiMo3f2snJktZ2
         /BL48qbL5GXi5U6cUR8wj9mHrROjQuGQUVC4314U=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6f-001XJF-Rp; Wed, 30 Sep 2020 15:25:17 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/52] docs: kerneldoc.py: append the name of the parsed doc file
Date:   Wed, 30 Sep 2020 15:24:33 +0200
Message-Id: <857dc7471291ba56d966d1dd721eb5d5d698f128.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finding where an error like this was generated:
	../lib/math/div64.c:73: WARNING: Duplicate C declaration, also defined in 'kernel-api'.

Can take some time, as there's no glue about what kernel-doc
tag generated it. It is a way better to display it as:

	.../Documentation/core-api/kernel-api:171: ../lib/math/div64.c:73: WARNING: Duplicate C declaration, also defined in 'kernel-api'.
	Declaration is 'div_s64_rem'.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kerneldoc.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 4bcbd6ae01cd..6686955d1def 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -136,7 +136,8 @@ class KernelDocDirective(Directive):
                     lineoffset = int(match.group(1)) - 1
                     # we must eat our comments since the upset the markup
                 else:
-                    result.append(line, filename, lineoffset)
+                    doc = env.srcdir + "/" + env.docname + ":" + str(self.lineno)
+                    result.append(line, doc + ": " + filename, lineoffset)
                     lineoffset += 1
 
             node = nodes.section()
-- 
2.26.2

