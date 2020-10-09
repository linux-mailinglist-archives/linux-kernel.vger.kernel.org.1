Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D7D288329
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 09:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbgJIHBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 03:01:30 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19996 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJIHBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 03:01:30 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f800a910008>; Fri, 09 Oct 2020 00:00:33 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Oct
 2020 07:01:30 +0000
Received: from sandstorm.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 9 Oct 2020 07:01:30 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2] Documentation: better locations for sysfs-pci, sysfs-tagging
Date:   Fri, 9 Oct 2020 00:01:28 -0700
Message-ID: <20201009070128.118639-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602226833; bh=IKsshG2P8w9TQtkug7AHOInsxKiFv+rqEkEZux0T+u0=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=c7da8hc+S4k3uArBydiGgk0PrAt12ww3gbw8ireAydgXBrDcw2NTLZ7U4ypTH4ERF
         YePSgwGCs2xa9ifDRPQjhOY3XoYPIlA2tfuQzaHgZqgBOwCSq3ud4MfdL3WpreHCZY
         djw9QR1sCahqRWbTIXf1IyWg2um4LRY4Y2mVqCY3RxcfELuyY3vkV3WWyEK8dYleGA
         bv6Z5hAWDKIwslXXnYqR0TJ/5blvTRfw2100FcNamp1/9eGQudEEc7nkZX4yxKj9F5
         ZWTWqWFI/RtS8uz5VDGZO9KJsg9qpbU+9bHxfN8B3kYfYsus3ekrjYinPRNbx+DgNF
         eF1ECoMbiiOpA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs-pci and sysfs-tagging were mis-filed: their locations within
Documentation/ implied that they were related to file systems. Actually,
each topic is about a very specific *use* of sysfs, and sysfs *happens*
to be a (virtual) filesystem, so this is not really the right place.

It's jarring to be reading about filesystems in general and then come
across these specific details about PCI, and tagging...and then back to
general filesystems again.

Move sysfs-pci to PCI, and move sysfs-tagging to networking. (Thanks to
Jonathan Corbet for coming up with the final locations.)

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Changes since v1: moved sysfs-pci to PCI, and sysfs-tagging to
networking, and poked around in the generated HTML via Firefox.
It looks like the right place now.

thanks,
John Hubbard
NVIDIA


 Documentation/PCI/index.rst                                 | 1 +
 Documentation/{filesystems =3D> PCI}/sysfs-pci.rst            | 0
 Documentation/filesystems/index.rst                         | 2 --
 Documentation/networking/index.rst                          | 1 +
 Documentation/{filesystems =3D> networking}/sysfs-tagging.rst | 0
 5 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/{filesystems =3D> PCI}/sysfs-pci.rst (100%)
 rename Documentation/{filesystems =3D> networking}/sysfs-tagging.rst (100%=
)

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 8f66feaafd4f..c17c87af1968 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -12,6 +12,7 @@ Linux PCI Bus Subsystem
    pciebus-howto
    pci-iov-howto
    msi-howto
+   sysfs-pci
    acpi-info
    pci-error-recovery
    pcieaer-howto
diff --git a/Documentation/filesystems/sysfs-pci.rst b/Documentation/PCI/sy=
sfs-pci.rst
similarity index 100%
rename from Documentation/filesystems/sysfs-pci.rst
rename to Documentation/PCI/sysfs-pci.rst
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
diff --git a/Documentation/networking/index.rst b/Documentation/networking/=
index.rst
index c29496fff81c..611e4b130c1e 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -95,6 +95,7 @@ Contents:
    seg6-sysctl
    strparser
    switchdev
+   sysfs-tagging
    tc-actions-env-rules
    tcp-thin
    team
diff --git a/Documentation/filesystems/sysfs-tagging.rst b/Documentation/ne=
tworking/sysfs-tagging.rst
similarity index 100%
rename from Documentation/filesystems/sysfs-tagging.rst
rename to Documentation/networking/sysfs-tagging.rst
--=20
2.28.0

