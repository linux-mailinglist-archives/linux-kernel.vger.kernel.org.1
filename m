Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336BC2DF4EE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 10:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgLTJvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 04:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgLTJvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 04:51:08 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCBDC0617B0;
        Sun, 20 Dec 2020 01:50:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d13so7629968wrc.13;
        Sun, 20 Dec 2020 01:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IWuhldxwHU0GrGepZfTUu2uv7Uiis+sD+/VmSDV/jZc=;
        b=flS0PQkk6kf4/B/P1RwX6xggHhh/J/p5x4O6LkGu5G92KwODjXHQvdpR2T9stjD2kP
         cKXHrDSUHwrQsO8m+LrZbkwkmo96y6jZ2/hSB+qsObt3e3iHUkriQOy6elIs2sjTnwJi
         jlqDDRlD84oo8LNkYCMWAw3qkRhtXrO+n7KH6xhKNVnuBctquKfJksNiTMGOMyLWmBeL
         zrmb35BrKe02BRofDGSYgib7r2klnsVBbdifM7brRYBsuE+414Qfz2woJtItFB4lhr7P
         g0aKO8mPguC+mc3M4xuW8KoOux/d/bzzBv+tphmi4w3oUh214/q0KdS9oCTCeZr5+QnK
         +vGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IWuhldxwHU0GrGepZfTUu2uv7Uiis+sD+/VmSDV/jZc=;
        b=YYtRoVOk7SR+rsFVscrFs7FS8sOog5yIPZkwtUC7PvmlfcPRVGwNK6jB+6ZzqibNmZ
         yJ7YWT97ZSoWOlGoSFMkk0xFWIdsJZwk+S0YZvrK9f5ned6ysSBOg1HOtRxA8wxXpmJ/
         lasKpUHItGmpV1WpTwz9OLAh4Yy0Pj1quP2rrdvOLY8WBE0dxVBssgGMZlQJJN7k/2z0
         xTXRR6hZ4FpDxMO+0qAPT1QNXFx/5R0snX43Mgme+jrNNDjYNr1q9FW7NDwMj9eFhha1
         gz6kmycNSkneWzPWAXAEeV1r83ewzLW3/KXchSFL7YV7aOBhvWqRnGosLj+UjNxSSCPE
         8zaQ==
X-Gm-Message-State: AOAM532QBOBieoNy5aRi/OV3FXp7yQHtouSin/9+UdsiL2JmXXze16JR
        G9VeV2+me1qaOkHRf5O5L+Q=
X-Google-Smtp-Source: ABdhPJwLzKdnNDNZnOI2lSWTMWsv0L9VyT6d7TevaODXX1DuA8FAG6f8Z0qqGNWhk17jIfMTpK9TnA==
X-Received: by 2002:adf:d0c6:: with SMTP id z6mr12994986wrh.10.1608457826835;
        Sun, 20 Dec 2020 01:50:26 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2de5:4000:d8f2:de32:a0d6:1baa])
        by smtp.gmail.com with ESMTPSA id y68sm20402475wmc.0.2020.12.20.01.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 01:50:26 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Gabriele Paoloni <gabriele.paoloni@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: mark dca driver orphan
Date:   Sun, 20 Dec 2020 10:50:10 +0100
Message-Id: <20201220095010.20227-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dca driver did not have any maintainer section since its inclusion.
As discussed with Dan Williams, there is no maintainer for this driver
since the initial developers moved away.

Introduce a new DIRECT CACHE ACCESS (DCA) DRIVER section and mark the
driver orphan.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20201218 and current master

Dan, please pick this trivial clarification patch.

 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5eafee83bc6..c8cc5e1a759f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5223,6 +5223,11 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-diolan-u2c.c
 
+DIRECT CACHE ACCESS (DCA) DRIVER
+S:	Orphan
+F:	drivers/dca/
+F:	include/linux/dca.h
+
 DIRECTORY NOTIFICATION (DNOTIFY)
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
-- 
2.17.1

