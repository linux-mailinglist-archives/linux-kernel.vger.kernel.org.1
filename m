Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527002D5D64
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbgLJOUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbgLJOUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:20:09 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1816C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:19:27 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w16so4332111pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/N/xrIL/qZ8kXAOOwh9PJuTQPNefKxYIgxBhEc6/Fr8=;
        b=V6MqVsjQ9RpFTpapEh2g7Y/yEAavHtL4sLgK0t8huY1ail3nVcrcWfpIhDoyzlvTFE
         ilfB7udGzJ/dYy6mKL3tduWf7zeCNn7qIkiegSnVdE8/gWBSOxPJWDSNI5zoZpHCI2qs
         B0AaA3JQZE3i3BnrNmwitMh7Yi5MqW3nR937PxSIHoAaLF147rO48a9+vcHqSxEkP1Mb
         5YpauCU6UlK4C/MRYTvEs25x28qUjiBLiALy/WPX/PX+E+J20bF+XED1PklZkzQvT1nu
         FDjTVOA067l3tzMfmX0HKulou7jxmEwWT85pxu/ULGVvTYEUes8hLivBpNcdxCqB1qFE
         ydTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/N/xrIL/qZ8kXAOOwh9PJuTQPNefKxYIgxBhEc6/Fr8=;
        b=Ct6jfGp02uzQeK7/zxBtHMOZ371Gi3VTU043HKVUUXNNY918Wl1YYOEftnmgq9gcbT
         N7vhW/VTh2xkbPqfMNcVjPJThwFh16TS+KVGoOs78fhSlpCQokhxrtQ/6xnHEKlfwu/C
         SM7Lbv+RQENbLk307yEV6beBeYVaOvEejDs6VoDkGsfZ7iQkN8xSGDU9ogHdBAyxFeEL
         jn4xlB6tcIr+HOFGp71X+Jm5cgUC7p1vCrKCRh9tmLQWMOPuI4S5vqarV5NMlQLY7mTg
         gR3sXCvkKIQ2IJrZiDEaXs9xijx3DvaYmHQNLZK/3Fo+4kFtIJ/mRL9PhOs2ELXFQ3c8
         KHSg==
X-Gm-Message-State: AOAM530HTTSohioLAUAtVrcpWBFz+YRlCjTCKfUYzjR9NykGjiOfIwpI
        qYnh0Qfl5SMn9tFZcf2I8jwQGIWU2yFqrJkK
X-Google-Smtp-Source: ABdhPJxs6SxvHaEuUlMtfsSppZKvcnr1ThQcH044478prOqOuyELkp9jt5/X5IgbFKtZX5//ftyqIA==
X-Received: by 2002:a63:ec57:: with SMTP id r23mr6666865pgj.315.1607609967095;
        Thu, 10 Dec 2020 06:19:27 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:681b:efb7:be26:4d99:7d44])
        by smtp.gmail.com with ESMTPSA id x12sm6579964pfj.25.2020.12.10.06.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 06:19:26 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH] checkpatch: add --fix option to IS_ENABLED_CONFIG check
Date:   Thu, 10 Dec 2020 19:49:03 +0530
Message-Id: <20201210141903.72327-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/process/coding-style.rst specifies the use of
IS_ENABLED macro:

Within code, where possible, use the IS_ENABLED macro to convert a Kconfig
symbol into a C boolean expression, and use it in a normal C conditional:

	if (IS_ENABLED(CONFIG_SOMETHING)) {
		...
	}

checkpatch correspondingly has a check for IS_ENABLED() without
CONFIG_<FOO>.
Add a --fix option to the check to automatically correct the argument.

Macros like:
 #if IS_ENABLED(THERMAL)

is corrected to:
 #if IS_ENABLED(CONFIG_THERMAL)

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b086d1cd6c2..751cd13622b9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6877,8 +6877,11 @@ sub process {
 
 # check for IS_ENABLED() without CONFIG_<FOO> ($rawline for comments too)
 		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^${CONFIG_}/) {
-			WARN("IS_ENABLED_CONFIG",
-			     "IS_ENABLED($1) is normally used as IS_ENABLED(${CONFIG_}$1)\n" . $herecurr);
+			if (WARN("IS_ENABLED_CONFIG",
+				 "IS_ENABLED($1) is normally used as IS_ENABLED(${CONFIG_}$1)\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\bIS_ENABLED\s*\(\s*(\w+)\s*\)/IS_ENABLED(${CONFIG_}$1)/;
+			}
 		}
 
 # check for #if defined CONFIG_<FOO> || defined CONFIG_<FOO>_MODULE
-- 
2.27.0

