Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F272C882F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgK3Ph0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:37:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbgK3PhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:37:25 -0500
Received: from mail.kernel.org (ip5f5ad5b3.dynamic.kabel-deutschland.de [95.90.213.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4A1D20725;
        Mon, 30 Nov 2020 15:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606750604;
        bh=cGFpEya2RTXzvKQBts0/IZkgnBCknYI8EbpBJ7DFjoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKH4UdntAIwq3qOQArLosTo1DoT/E1vk+aPbkFRPKkYnZEMvP/MDv9I8PgCocFOki
         rKgU9bRDPBAXVoTzzDNkN9gASMezHXrXeRz/RiIF1B5RSM2N+4r5cqYWsfFu+AMYNf
         kifa60oKzxHe90YCYjzAb7zfnxvP6JQd/tjPNEa4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kjlEI-00CjvR-GR; Mon, 30 Nov 2020 16:36:42 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] docs: admin-guide: add a features list
Date:   Mon, 30 Nov 2020 16:36:34 +0100
Message-Id: <f6c1e366fbc7ce1c9c94c7dc6c7852c6377cc0be.1606748711.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606748711.git.mchehab+huawei@kernel.org>
References: <cover.1606748711.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a feature list matrix at the admin-guide.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/features.rst | 3 +++
 Documentation/admin-guide/index.rst    | 1 +
 Documentation/conf.py                  | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/features.rst

diff --git a/Documentation/admin-guide/features.rst b/Documentation/admin-guide/features.rst
new file mode 100644
index 000000000000..8c167082a84f
--- /dev/null
+++ b/Documentation/admin-guide/features.rst
@@ -0,0 +1,3 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. kernel-feat:: $srctree/Documentation/features
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 4e0c4ae44acd..0245a8655b22 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -19,6 +19,7 @@ etc.
    sysctl/index
 
    abi
+   features
 
 This section describes CPU vulnerabilities and their mitigations.
 
diff --git a/Documentation/conf.py b/Documentation/conf.py
index ed2b43ec7754..26b54386a477 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -39,7 +39,7 @@ needs_sphinx = '1.3'
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel',
-              'kernel_abi']
+              'kernel_abi', 'kernel_feat']
 
 #
 # cdomain is badly broken in Sphinx 3+.  Leaving it out generates *most*
-- 
2.28.0

