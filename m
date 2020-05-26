Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737F21B6457
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 21:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgDWTQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 15:16:29 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:53460 "EHLO
        8.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgDWTQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:16:29 -0400
X-Greylist: delayed 1809 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Apr 2020 15:16:28 EDT
Received: from player796.ha.ovh.net (unknown [10.110.171.173])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id BE17C12D3A6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 20:37:12 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player796.ha.ovh.net (Postfix) with ESMTPSA id DBDDC11A47C5D;
        Thu, 23 Apr 2020 18:37:06 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH 1/3] docs: sysctl/kernel: document cad_pid
Date:   Thu, 23 Apr 2020 20:36:49 +0200
Message-Id: <20200423183651.15365-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16165670866134453637
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrgeelgdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the implementation in kernel/sysctl.c (the proc_do_cad_pid()
function), kernel/reboot.c, and include/linux/sched/signal.h.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 55b24eada13c..82bfd5892663 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -116,6 +116,16 @@ run. The statistics can be seen using ``bpftool``.
 = ===================================
 
 
+cad_pid
+=======
+
+This is the pid which will be signalled on reboot (notably, by
+Ctrl-Alt-Delete). Writing a value to this file which doesn't
+correspond to a running process will result in ``-ESRCH``.
+
+See also `ctrl-alt-del`_.
+
+
 cap_last_cap
 ============
 

base-commit: 7b9121040d83eb9e332f7dbc140eca17643d3586
-- 
2.20.1

