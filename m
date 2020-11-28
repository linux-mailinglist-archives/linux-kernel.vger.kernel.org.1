Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684372C6E05
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 01:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbgK1Ayb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 19:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731947AbgK1AwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 19:52:20 -0500
Received: from mail-oi1-x261.google.com (mail-oi1-x261.google.com [IPv6:2607:f8b0:4864:20::261])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7DDC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 16:45:32 -0800 (PST)
Received: by mail-oi1-x261.google.com with SMTP id v202so7617956oia.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 16:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=J/RUqOLrtG/yyp8LIFv88+rY6UY1ibdpQZmu4ra8MIc=;
        b=NwcWu3Dn+7J31LulCNEb8sfGRew7LV15BVccEBmzBPELzHoQ5PetqiagK3Qfu/Sn6A
         vHiKKWfgnUrCy+eYmTaBnJvuFMvzfU7Bta1y9gbIodIefPoJZ24Xs/JIiZL7ajtlvt7N
         Q1bT6Fsdn3l30EDxKo2oI1d1TSXF24SgUq/bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J/RUqOLrtG/yyp8LIFv88+rY6UY1ibdpQZmu4ra8MIc=;
        b=JT2iQkwFy6Dg5K6/lMhLZPNuiVv8x099PJPZ3vpMIHMs+5RS0XPLH8iRCMLjpnwFeJ
         N0WmSs9TTmHyC2TC7/mqobz2qDL+SbzBOL4HNEg41nLIwKDr1mbe+SKdXRjkJGzbzf1T
         onxGhX++jtI8XDT6ST10V9ILNYyI0ERyJB4FidS2QDRXoVWFvduxQ/7CqBq05C6iHW6F
         JJsyIVnkj/mvv270gLDY9JBTb/4akrgMrQAuttaSt0hE8A4VbFWD/hfZv/ulXEhjer6W
         ktK/xwyi6bVDpwJUk1OP0LNHtR2Z/LDvUhOtdFu9I9LLC8GGUA4jV2PrlIc/rWnlK6lN
         gW3w==
X-Gm-Message-State: AOAM532XJ895sRfnhsxnFooTx39Bn+Gw709E0V8i9/eCuhmzeljj88Fs
        Pf/OCp22lVVUVbNmaYJHHrpmF9AClpCfAxeU3xJwELjXq+fT
X-Google-Smtp-Source: ABdhPJwN+hE5UZQLPsQy5ABrV6RyrZ19iaTfdyCDSc1RUvOwSOWWyBjQETK4623l5Z/bNJWP+c+XgjUCHRZu
X-Received: by 2002:aca:f03:: with SMTP id 3mr7552629oip.92.1606524331466;
        Fri, 27 Nov 2020 16:45:31 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id v26sm1302459oth.8.2020.11.27.16.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 16:45:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, bruce.ashfield@gmail.com,
        Bruce Ashfield <bruce.ashfield@windriver.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Michal Marek <mmarek@suse.cz>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] menuconfig,mconf-cfg: Allow specification of ncurses location
Date:   Fri, 27 Nov 2020 16:45:05 -0800
Message-Id: <20201128004505.27619-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bruce Ashfield <bruce.ashfield@windriver.com>

In some cross build environments such as the Yocto Project build
environment it provides an ncurses library that is compiled
differently than the host's version.  This causes display corruption
problems when the host's curses includes are used instead of the
includes from the provided compiler are overridden.  There is a second
case where there is no curses libraries at all on the host system and
menuconfig will just fail entirely.

The solution is simply to allow an override variable in
check-lxdialog.sh for environments such as the Yocto Project.  Adding
a CROSS_CURSES_LIB and CROSS_CURSES_INC solves the issue and allowing
compiling and linking against the right headers and libraries.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
cc: Michal Marek <mmarek@suse.cz>
cc: linux-kbuild@vger.kernel.org
Signed-off-by: Bruce Ashfield <bruce.ashfield@windriver.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 scripts/kconfig/mconf-cfg.sh | 8 ++++++++
 1 file changed, 8 insertions(+)
 mode change 100755 => 100644 scripts/kconfig/mconf-cfg.sh

diff --git a/scripts/kconfig/mconf-cfg.sh b/scripts/kconfig/mconf-cfg.sh
old mode 100755
new mode 100644
index aa68ec95620d..32448bc198a5
--- a/scripts/kconfig/mconf-cfg.sh
+++ b/scripts/kconfig/mconf-cfg.sh
@@ -4,6 +4,14 @@
 PKG="ncursesw"
 PKG2="ncurses"
 
+if [ "$CROSS_CURSES_LIB" != "" ]; then
+    echo libs=\'$CROSS_CURSES_LIB\'
+    if [ x"$CROSS_CURSES_INC" != x ]; then
+	echo cflags=\'$CROSS_CURSES_INC\'
+    fi
+    exit 0
+fi
+
 if [ -n "$(command -v pkg-config)" ]; then
 	if pkg-config --exists $PKG; then
 		echo cflags=\"$(pkg-config --cflags $PKG)\"
-- 
2.17.1

