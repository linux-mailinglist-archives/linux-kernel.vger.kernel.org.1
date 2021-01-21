Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD7A2FF1A8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbhAURTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:19:30 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30]:37592 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388785AbhAURSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:18:33 -0500
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2021 12:18:32 EST
Received: from lbrmn-lnxub113.broadcom.net (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1A1BF2257C;
        Thu, 21 Jan 2021 09:07:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1A1BF2257C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611248863;
        bh=8XFqEBg6MOXtrlaSwjKTsCeoHs6q0ILUIphsmIehoac=;
        h=From:To:Cc:Subject:Date:From;
        b=djqWm+ysuGjN1gWZaQyO4KjRUF6m2WDGsF27UgJYoMc5Sc1DulvE9PKwgqWDb/don
         0F6lGe1aDTXDuwkSSycRM3uB+BJf526AVBDXIwnpCCG10/QQMxADdvmd5vpJzPJkUW
         KEviqRDG+ZINNu081HhbT4tR83lKvxoq3Dqgiwgo=
From:   Scott Branden <scott.branden@broadcom.com>
To:     Masahiro Yamada <masahiroy@kernel.org>, Finn Behrens <me@kloenk.de>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] diffconfig: use python3 instead of python in Shebang line
Date:   Thu, 21 Jan 2021 09:07:36 -0800
Message-Id: <20210121170736.2266-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use python3 instead of python in diffconfig Shebang line.
python2 was sunset January 1, 2000 and environments do not need
to support python any more.

Fixes: b24413180f56 ("tweewide: Fix most Shebang lines")
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 scripts/diffconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/diffconfig b/scripts/diffconfig
index 627eba5849b5..d5da5fa05d1d 100755
--- a/scripts/diffconfig
+++ b/scripts/diffconfig
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 #
 # diffconfig - a tool to compare .config files.
-- 
2.17.1

