Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06935286B88
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 01:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgJGXby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 19:31:54 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15464 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgJGXbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 19:31:53 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7e4f7c0000>; Wed, 07 Oct 2020 16:30:04 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 7 Oct
 2020 23:31:53 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 7 Oct 2020 23:31:53 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] Documentation: filesystems: better locations for sysfs-pci, sysfs-tagging
Date:   Wed, 7 Oct 2020 16:31:51 -0700
Message-ID: <20201007233151.490953-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602113404; bh=E7vpDOD4gxqXLsuZsi7hTD94dOIXP2RUKkySHzQpRT8=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=bB7+fcU3Jtj5cwQqrmHTz9zotIY3TwJMuEMq5n6trsRShAKCX2QlL/x0mw8RGe/9C
         QmYkDu9iLWJDYsanChxjkYnCTKy9aDuRKniRX5RNxiXXahMm334qDeDaCJM61BaK8Q
         7uOHJUtyaqp6AwaDUC8uRIuAaGrKZtufpItk0gHHPOI2fMbDC79QIsNr+IAvCoSMwG
         /EZv2FhCTw8wEazFQkArh9OrxqYrbcVDNL+5Lix906F17uzA1JXGpECrNHC1Ut1nfG
         7TOzcPhF6YOTSAc3ippwjqQn45XaM0VnkbMmyTe0vWK03yZKMJLCq/sGnK7+Xl3Af5
         krIMxddp/YZHQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs-pci and sysfs-tagging were mis-filed: their locations with
Documentation/ implied that they were related to file systems. Actually,
each topic is about a very specific *use* of sysfs, and sysfs *happens*
to be a (virtual) filesystem, so this is not really the right place.

It's jarring to be reading about filesystems in general and then come
across these specific details about PCI, and tagging...and then back to
general filesystems again.

Move sysfs-pci and sysfs-tagging to a location under the sysfs topic.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

I'm not sure if the "toctree, maxdepth: 1" is the ideal way to do this,=20
but the output in the browser looks about right to me, anyway.

thanks,
John Hubbard
NVIDIA

 Documentation/filesystems/index.rst |  2 --
 Documentation/filesystems/sysfs.rst | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystem=
s/index.rst
index 4c536e66dc4c..98f59a864242 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -34,8 +34,6 @@ algorithms work.
    quota
    seq_file
    sharedsubtree
-   sysfs-pci
-   sysfs-tagging
=20
    automount-support
=20
diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystem=
s/sysfs.rst
index ab0f7795792b..39da2f5c235f 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -416,3 +416,17 @@ ABI between the kernel and user space. As for any ABI,=
 it is important that
 this ABI is stable and properly documented. All new sysfs attributes must =
be
 documented in Documentation/ABI. See also Documentation/ABI/README for mor=
e
 information.
+
+sysfs and PCI
+~~~~~~~~~~~~~
+.. toctree::
+   :maxdepth: 1
+
+   sysfs-pci
+
+sysfs and tagging
+~~~~~~~~~~~~~~~~~
+.. toctree::
+   :maxdepth: 1
+
+   sysfs-tagging
--=20
2.28.0

