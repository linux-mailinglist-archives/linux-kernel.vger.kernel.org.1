Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6CF29FEDD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgJ3HnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgJ3HlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:05 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFECD22255;
        Fri, 30 Oct 2020 07:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043663;
        bh=xZL+H15izrbGtr5KqY6QX8NVwThRYtTxS7Af3m3hYcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CyosOInF3V42KLcajhq/WMYy6wk7LkGZ/SfzxiuJlPfD3ZpQiWxX1K1paLIEN2Lgw
         KLBEVwhvAjX13vgic7uX2fpRf1a2LFjwJzc1BVwFObl3GNd4lXJiAoCenZEWX7mkb7
         AHKEdDPNpzcVjqxCf478xzYCnI6bLP/zKdibe1NI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1w-004Ofz-Q6; Fri, 30 Oct 2020 08:41:00 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/39] docs: add ABI documentation to the admin-guide book
Date:   Fri, 30 Oct 2020 08:40:36 +0100
Message-Id: <5651482b06500e69a1acdf92152f90a203e6521d.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we don't want a generic Sphinx extension to execute commands,
change the one proposed to Markus to call the abi_book.pl
script.

Use a script to parse the Documentation/ABI directory and output
it at the admin-guide.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/abi-obsolete.rst | 10 ++++++++++
 Documentation/admin-guide/abi-removed.rst  |  4 ++++
 Documentation/admin-guide/abi-stable.rst   | 13 +++++++++++++
 Documentation/admin-guide/abi-testing.rst  | 19 +++++++++++++++++++
 Documentation/admin-guide/abi.rst          | 11 +++++++++++
 Documentation/admin-guide/index.rst        |  2 ++
 Documentation/conf.py                      |  3 ++-
 7 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/abi-obsolete.rst
 create mode 100644 Documentation/admin-guide/abi-removed.rst
 create mode 100644 Documentation/admin-guide/abi-stable.rst
 create mode 100644 Documentation/admin-guide/abi-testing.rst
 create mode 100644 Documentation/admin-guide/abi.rst

diff --git a/Documentation/admin-guide/abi-obsolete.rst b/Documentation/admin-guide/abi-obsolete.rst
new file mode 100644
index 000000000000..cda9168445a5
--- /dev/null
+++ b/Documentation/admin-guide/abi-obsolete.rst
@@ -0,0 +1,10 @@
+ABI obsolete symbols
+====================
+
+Documents interfaces that are still remaining in the kernel, but are
+marked to be removed at some later point in time.
+
+The description of the interface will document the reason why it is
+obsolete and when it can be expected to be removed.
+
+.. kernel-abi:: $srctree/Documentation/ABI/obsolete
diff --git a/Documentation/admin-guide/abi-removed.rst b/Documentation/admin-guide/abi-removed.rst
new file mode 100644
index 000000000000..497978fc9632
--- /dev/null
+++ b/Documentation/admin-guide/abi-removed.rst
@@ -0,0 +1,4 @@
+ABI removed symbols
+===================
+
+.. kernel-abi:: $srctree/Documentation/ABI/removed
diff --git a/Documentation/admin-guide/abi-stable.rst b/Documentation/admin-guide/abi-stable.rst
new file mode 100644
index 000000000000..7495d7a35048
--- /dev/null
+++ b/Documentation/admin-guide/abi-stable.rst
@@ -0,0 +1,13 @@
+ABI stable symbols
+==================
+
+Documents the interfaces that the developer has defined to be stable.
+
+Userspace programs are free to use these interfaces with no
+restrictions, and backward compatibility for them will be guaranteed
+for at least 2 years.
+
+Most interfaces (like syscalls) are expected to never change and always
+be available.
+
+.. kernel-abi:: $srctree/Documentation/ABI/stable
diff --git a/Documentation/admin-guide/abi-testing.rst b/Documentation/admin-guide/abi-testing.rst
new file mode 100644
index 000000000000..5c886fc50b9e
--- /dev/null
+++ b/Documentation/admin-guide/abi-testing.rst
@@ -0,0 +1,19 @@
+ABI testing symbols
+===================
+
+Documents interfaces that are felt to be stable,
+as the main development of this interface has been completed.
+
+The interface can be changed to add new features, but the
+current interface will not break by doing this, unless grave
+errors or security problems are found in them.
+
+Userspace programs can start to rely on these interfaces, but they must
+be aware of changes that can occur before these interfaces move to
+be marked stable.
+
+Programs that use these interfaces are strongly encouraged to add their
+name to the description of these interfaces, so that the kernel
+developers can easily notify them if any changes occur.
+
+.. kernel-abi:: $srctree/Documentation/ABI/testing
diff --git a/Documentation/admin-guide/abi.rst b/Documentation/admin-guide/abi.rst
new file mode 100644
index 000000000000..3b9645c77469
--- /dev/null
+++ b/Documentation/admin-guide/abi.rst
@@ -0,0 +1,11 @@
+=====================
+Linux ABI description
+=====================
+
+.. toctree::
+   :maxdepth: 1
+
+   abi-stable
+   abi-testing
+   abi-obsolete
+   abi-removed
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index ed1cf94ea50c..4e0c4ae44acd 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -18,6 +18,8 @@ etc.
    devices
    sysctl/index
 
+   abi
+
 This section describes CPU vulnerabilities and their mitigations.
 
 .. toctree::
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 7ee05fd4cb17..ed2b43ec7754 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -38,7 +38,8 @@ needs_sphinx = '1.3'
 # ones.
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
-              'maintainers_include', 'sphinx.ext.autosectionlabel' ]
+              'maintainers_include', 'sphinx.ext.autosectionlabel',
+              'kernel_abi']
 
 #
 # cdomain is badly broken in Sphinx 3+.  Leaving it out generates *most*
-- 
2.26.2

