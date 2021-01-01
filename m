Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC4C2E85C6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 22:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbhAAVyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 16:54:08 -0500
Received: from mout.gmx.net ([212.227.15.15]:52395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbhAAVyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 16:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609537946;
        bh=XKGZ6IdJrisGNMLfOonvYytNJSk2tPaP8WnMXq1kJiU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=b7E49iaGfJhpLNIxLVLT33vD/B8gbMaMFMqlT0CZWeQWZcy8I3QKxeZ2e6b2fVNCC
         jnZhbd1DZjqCTmDyduCuJMKroWkA3F1VUtLtVSGPmwzMSCU7yRMw2rTPctoFaaV06f
         LSWOxha6XtFS26DQ3g7cUVNSnnoiGK+ZlXoglZO4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.57]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzay-1kUc6S0Y7e-00R3x1; Fri, 01
 Jan 2021 22:52:26 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: Include ext4 documentation via filesystems/
Date:   Fri,  1 Jan 2021 22:52:13 +0100
Message-Id: <20210101215215.1047826-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Czdc0YoODRSsVa3fBqyKOyvo0YgUP+rX8iwjgZ6TEChiaZI4QJi
 PyNLJdKvoLg8+FW54zU8qNpPHFW+OR1KjOuaB2ckA7OfmRLa3UsH77rhmxOkUy88/EJDoiB
 R21h2gamXtJksvphsrPGHbLfZokq28PLGy4FNI2Z+7iH9sdIh0o+D2KjIvwk/UOLut6XYFs
 ug7Su7D2CzOAAYIyAhJ4w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ry46sLP5EXg=:5IpYF6tcrTVzEh0CaYRojq
 nwhq52s0lD0VSKId9Zy1zj4N2lqGimXhU+gj/s5oILPzgr06oY9KGu4yA8c0bNBuvCVpNRMW1
 L2Y92ieXKXfch50qCLfO3vicSx/EgovH2JaDg5Xa/d0yisuAv7FQqEa6QY4H1hXEMcX65yIG8
 459UEKiWmZAi/+p+meJzClihPecJZnC41y4Ig66st7FcOr6r//E/LG499sPl1TCUcbLoMSEQ4
 I0+x8MvP2GmltZd6naO8u/6FWzDrdC3pyTzgpzbIZ7FH4te+DlxeE1TvRfVVqeNaawaae2rYq
 aD1JfGAOMLUzDV5KmOVT2NkbTqcDOnHAXiBNz2Ay7+WSRkcg0dx7Elh7Nap1KGSlsS3Cy/6px
 1wfN53mfUMkxtbRH9fhsBHovCT+/gRrQXWapQjJQSoYgOoIyUPjiKd4JyRVvfUrd5X3E8tvMR
 kJPdoLXGjbCucrfo2YCwHmNrk4wpEfnBPl4S2mqU0BSN9iQXppLKIrfuVTBBY4keTKEsXp3RF
 ftqrE0iWQtc7UJ6hIDaosmuArH6L15YjshIYRLAMISRHhzeuDhW+6w8kfBhg8qHJSHv3fVkDh
 gICQwOCJx7mi2z4s6SRkihzik5rixeWNP9KvF/0xSWeVMqmXyI/bQl4utcPH0pL//UptFwU8Z
 jtQKtpjzqGC5kr9VGoE1RRUnMb3QG5fWFwFDQNSoxkpl4Okh1SluqhIDt9LZYxiRqllE4eALJ
 u54OZzfW5XmazVHDu4xJNzhFmKlngPfORyey9QIjgSNhdh7iEBK9iUhJG+XbO0TPy+a8etCxL
 oyPnypYU2Gql1MpbWCuVDq3+1Y1tE5tBQYt1KJZnPsjyMSdSfMExKz1TrEaNKAu8E9hb2CVNZ
 ySqOcA8j5scsL7IzAIlw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for other filesystems is already included via
filesystems/index.rst. Include ext4 in the same way and remove it
from the top-level table of contents.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/filesystems/index.rst |  1 +
 Documentation/index.rst             | 11 -----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesyste=
ms/index.rst
index 7be9b46d85d9b..1f76b1cb33484 100644
=2D-- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -83,6 +83,7 @@ Documentation for filesystem implementations.
    erofs
    ext2
    ext3
+   ext4/index
    f2fs
    gfs2
    gfs2-uevents
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 5888e8a7272fd..31f2adc8542dc 100644
=2D-- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -171,17 +171,6 @@ implementation.
    x86/index
    xtensa/index

-Filesystem Documentation
=2D------------------------
-
-The documentation in this section are provided by specific filesystem
-subprojects.
-
-.. toctree::
-   :maxdepth: 2
-
-   filesystems/ext4/index
-
 Other documentation
 -------------------

=2D-
2.29.2

