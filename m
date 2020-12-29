Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA652E6F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 09:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgL2Iwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 03:52:53 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:37529 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL2Iww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 03:52:52 -0500
Received: from localhost.localdomain ([93.22.37.45])
        by mwinf5d25 with ME
        id A8r32400F0ySWMH038r4gt; Tue, 29 Dec 2020 09:51:06 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 29 Dec 2020 09:51:06 +0100
X-ME-IP: 93.22.37.45
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: Intel: common: Fix some typos
Date:   Tue, 29 Dec 2020 09:51:03 +0100
Message-Id: <20201229085103.192715-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/apci/acpi/

Turn an ICL into a TGL because it is likely a cut'n'paste error

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/intel/common/soc-acpi-intel-ehl-match.c | 2 +-
 sound/soc/intel/common/soc-acpi-intel-tgl-match.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-ehl-match.c b/sound/soc/intel/common/soc-acpi-intel-ehl-match.c
index badafc1d54d2..5c7a1214403d 100644
--- a/sound/soc/intel/common/soc-acpi-intel-ehl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-ehl-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * soc-apci-intel-ehl-match.c - tables and support for EHL ACPI enumeration.
+ * soc-acpi-intel-ehl-match.c - tables and support for EHL ACPI enumeration.
  *
  * Copyright (c) 2019, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
index 98196e9fad62..4933184df5f5 100644
--- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * soc-apci-intel-tgl-match.c - tables and support for ICL ACPI enumeration.
+ * soc-acpi-intel-tgl-match.c - tables and support for TGL ACPI enumeration.
  *
  * Copyright (c) 2019, Intel Corporation.
  *
-- 
2.27.0

