Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB89C2DDC32
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 00:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgLQX47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 18:56:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgLQX47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 18:56:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] checkpatch: add warning for non-lore mailing list URLs
Date:   Thu, 17 Dec 2020 17:56:15 -0600
Message-Id: <20201217235615.43328-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
as lore.kernel.org because they use different styles, add advertising, and
may disappear in the future.  The lore archives are more consistent and
more likely to stick around, so prefer https://lore.kernel.org URLs when
they exist.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
Sample commits for testing with "checkpatch -g":

  bd82d4bd2188 www.spinics.net/lists/arm-kernel/msg716956.html
  fdec2a9ef853 www.spinics.net/lists/kvm-arm
  1cdca16c043a www.spinics.net/lists/linux-mmc
  48ea02184a9d www.spinics.net/lists/linux-pci
  f32ae8a5f131 www.spinics.net/lists/netdev
  b7dca6dd1e59 lkml.org
  265df32eae58 lkml.org/lkml/
  4a9ceb7dbadf marc.info/?l=linux-kernel&m=155656897409107&w=2.
  c03914b7aa31 marc.info/?l=linux-mm
  f108c887d089 marc.info/?l=linux-netdev
  7424edbb5590 marc.info/?t=156200975600004&r=1&w=2
  dabac6e460ce https://marc.info/?l=linux-rdma&m=152296522708522&w=2
  b02f6a2ef0a1 www.mail-archive.com/linux-kernel@vger.kernel.org
  5e91bf5ce9b8 lists.infradead.org/pipermail/linux-snps-arc/2019-May
  3cde818cd02b mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144761.html
  a5448fdc469d http://lists.infradead.org/pipermail/linux-nvme/2019-June/024721.html
---
 scripts/checkpatch.pl | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 00085308ed9d..ac8e99285b2a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -564,6 +564,17 @@ sub find_standard_signature {
 	return "";
 }
 
+our $obsolete_archives = qr{(?xi:
+	freedesktop.org/archives/dri-devel|
+	lists.infradead.org|
+	lkml.org|
+	mail-archive.com|
+	mailman.alsa-project.org/pipermail|
+	marc.info|
+	ozlabs.org/pipermail|
+	spinics.net
+)};
+
 our @typeListMisordered = (
 	qr{char\s+(?:un)?signed},
 	qr{int\s+(?:(?:un)?signed\s+)?short\s},
@@ -3101,6 +3112,12 @@ sub process {
 			}
 		}
 
+# Check for mailing list archives other than lore.kernel.org
+		if ($line =~ /(http|https):\/\/\S*$obsolete_archives/) {
+			WARN("PREFER_LORE_ARCHIVE",
+			     "Use lore.kernel.org archive links when possible; see https://lore.kernel.org/lists.html\n" . $herecurr);
+		}
+
 # Check for added, moved or deleted files
 		if (!$reported_maintainer_file && !$in_commit_log &&
 		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
-- 
2.25.1

