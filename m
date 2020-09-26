Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7AC279C79
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 22:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgIZUwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 16:52:35 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:36381 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIZUwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 16:52:35 -0400
Received: by mail-ej1-f65.google.com with SMTP id e23so3243241eja.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 13:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8Oh61VDkKJm8ATQ6jeOPbqJJMPXYpW1qx7rAsBes8k=;
        b=FoEyBxX8MVQw/cz9tgXNqWdd4uIE2Zuuxe5PDwax/uuRqanU99A8fuPP17dDQw2t27
         6cEC2MeNbJRwo0voSXQ3yUUuL0M83JLqKjCH0Hqwq9DjMggT8JB/3mEKULLH9Yifw6LU
         G1oo7alMAmhfMBp44mdIH+CoVKeJs8UR6EZCO4QB0DBn604scisOHK3oiBF37iMXsrV4
         OXdbDViA3l6KPL1gwYL3Ig+zHShGlz6HOh5QQocHR+R6Bu134anyBN5JQyYwgnGf6PvE
         L0EhksqWipDd9PU1fU9/DP3JPE2G/m/DZNYdQJA77WBrkvcIUmobtv4x5IsOjbUU67zW
         +AIg==
X-Gm-Message-State: AOAM531dDNMSz31/bCMLyvRKq8BaZEYabMoWolQuw+XHufeg2U+kQkgk
        F/A6Q+mAfevWmM/nO70caVlqUg==
X-Google-Smtp-Source: ABdhPJy70ndEkfLf/+WblrSk/UwDwosqtjfmRLEbzIM2w+dXQYJKs0F5avEWRJwBwLIFK8CxgFh61A==
X-Received: by 2002:a17:907:264c:: with SMTP id ar12mr9129730ejc.80.1601153552469;
        Sat, 26 Sep 2020 13:52:32 -0700 (PDT)
Received: from x1-carbon.localdomain (dynamic-2a01-0c22-a405-1400-4d77-6706-ca6f-bab0.c22.pool.telefonica.de. [2a01:c22:a405:1400:4d77:6706:ca6f:bab0])
        by smtp.gmail.com with ESMTPSA id p1sm5064178edx.4.2020.09.26.13.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 13:52:31 -0700 (PDT)
From:   gary@apache.org
Cc:     Gary Yao <gary@apache.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: media: atomisp: clean up block comment style issues
Date:   Sat, 26 Sep 2020 22:50:58 +0200
Message-Id: <20200926205103.189041-1-gary@apache.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gary Yao <gary@apache.org>

Clean up block comment style issues to follow kernel coding style
and clear checkpatch warnings.

WARNING: Block comments use * on subsequent lines
WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: Gary Yao <gary@apache.org>
---
 .../pci/isp/modes/interface/isp_types.h       | 41 +++++++++++--------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/isp/modes/interface/isp_types.h b/drivers/staging/media/atomisp/pci/isp/modes/interface/isp_types.h
index ae273c826808..d1c42c77fa50 100644
--- a/drivers/staging/media/atomisp/pci/isp/modes/interface/isp_types.h
+++ b/drivers/staging/media/atomisp/pci/isp/modes/interface/isp_types.h
@@ -1,26 +1,29 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
-Support for Intel Camera Imaging ISP subsystem.
-Copyright (c) 2010 - 2015, Intel Corporation.
-
-This program is free software; you can redistribute it and/or modify it
-under the terms and conditions of the GNU General Public License,
-version 2, as published by the Free Software Foundation.
-
-This program is distributed in the hope it will be useful, but WITHOUT
-ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-more details.
-*/
+/*
+ * Support for Intel Camera Imaging ISP subsystem.
+ * Copyright (c) 2010 - 2015, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
 
 #ifndef _ISP_TYPES_H_
 #define _ISP_TYPES_H_
 
-/* Workaround: hivecc complains about "tag "sh_css_3a_output" already declared"
-   without this extra decl. */
+/*
+ * Workaround: hivecc complains about "tag "sh_css_3a_output" already declared"
+ * without this extra decl.
+ */
 struct ia_css_3a_output;
 
-/* Input stream formats, these correspond to the MIPI formats and the way
+/*
+ * Input stream formats, these correspond to the MIPI formats and the way
  * the CSS receiver sends these to the input formatter.
  * The bit depth of each pixel element is stored in the global variable
  * isp_bits_per_pixel.
@@ -37,8 +40,10 @@ enum sh_stream_format {
 };
 
 struct s_isp_frames {
-	/* global variables that are written to by either the SP or the host,
-	   every ISP binary needs these. */
+	/*
+	 * Global variables that are written to by either the SP or the host,
+	 * every ISP binary needs these.
+	 */
 	/* output frame */
 	char *xmem_base_addr_y;
 	char *xmem_base_addr_uv;
-- 
2.26.2

