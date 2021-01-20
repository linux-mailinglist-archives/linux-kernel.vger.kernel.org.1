Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F1E2FCB47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbhATHIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbhATHIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:08:23 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C09C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:07:43 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id v19so14570059pgj.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PYJHN29z38YJQy9+aRfXhxK7SVaDLVhX0WgONtRAors=;
        b=c2S19u75v9Chts0QzKMx+ZayKXIoNAlL8ZNL3dQyLlx3STuOpzebHm8DZqg1ADQi4X
         tQkAJpsSFnVkiU4O3W+lIDUNH4+ZgZg2jaIJl4iRr4C+6Z0nioL/8zVyD8moRU+Xkeaj
         NH76BrNCubz6XhRsPzTfuMZhfhipO1MoZQditsYpd7ppALsgjGALC33iMDONcHYylAWd
         e/y/VKma9J2vHDBeX7dg1C2R1ej9u3P4G2eVZfLkkytSd3N5UC5vo2lDvo0LQ+oL/I+k
         YNvRgEh9+i6XVkmBZXeCajH1xfaJSNxTLfozDVNzG6P4ZPjbcW4Rp7hre7l3AdtORYOI
         X3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PYJHN29z38YJQy9+aRfXhxK7SVaDLVhX0WgONtRAors=;
        b=FUSkvJang8PZLQB0NiOjTchG+v/tvM4IsoNC5D8YUZJ/xbfGJHISe33oTGaFXoldpY
         ZI+xY2NjnYOXnF3oNXZisq2i+fkzuYqui+YO+JsVYtMpg9DbKKcy+2ew046dYGDC7tH5
         C+n2vyG+JEnRQ6dMaC4E4Y0Wn6SUquDyfrAQNOQiZWN4tn4DPGmcdBlLq8nXeki6sUjp
         O6lWeVn9KO/ducKADyiaXC+8m1n7Su6Fr44KREZD+pfMnQ6Ey46cFI7juY/3uEfPU9xL
         WKPG5pKCYaIzMdVVTfifBGw0OKnx+hJysp8b8QO28WE0zw/Y9LR9482Tfceyie/2MtMV
         D+Og==
X-Gm-Message-State: AOAM533CwsAA+VhqCA6P9H+68TgdZBgWr1bUl+DEC9ND0qrn1V/WJDf3
        Tn1ICNEmpV9jtuLAPeVMhc2QWQ==
X-Google-Smtp-Source: ABdhPJzdkC+jsZ70UpYPYA7LIpEA5AYpkuoU3Y/7RHpSB5FsjgMt+4M03fg4o3GDqg4zjl8DI+/e8w==
X-Received: by 2002:a63:1401:: with SMTP id u1mr7879221pgl.229.1611126462652;
        Tue, 19 Jan 2021 23:07:42 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 17sm1146822pgy.53.2021.01.19.23.07.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 23:07:42 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
Subject: [PATCH V5 1/5] scripts: dtc: Fetch fdtoverlay.c from external DTC project
Date:   Wed, 20 Jan 2021 12:36:43 +0530
Message-Id: <41f7158a707f20980e71a8d254c1d7aed84ad371.1611124778.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611124778.git.viresh.kumar@linaro.org>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will start building overlays for platforms soon in the kernel and
would need fdtoverlay tool going forward. Lets start fetching it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 scripts/dtc/update-dtc-source.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/dtc/update-dtc-source.sh b/scripts/dtc/update-dtc-source.sh
index bc704e2a6a4a..32ff17ffd089 100755
--- a/scripts/dtc/update-dtc-source.sh
+++ b/scripts/dtc/update-dtc-source.sh
@@ -37,6 +37,7 @@ DTC_SOURCE="checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.c srcpos.c
 LIBFDT_SOURCE="fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
 		fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \
 		fdt_wip.c libfdt.h libfdt_env.h libfdt_internal.h"
+FDTOVERLAY_SOURCE=fdtoverlay.c
 
 get_last_dtc_version() {
 	git log --oneline scripts/dtc/ | grep 'upstream' | head -1 | sed -e 's/^.* \(.*\)/\1/'
@@ -54,7 +55,7 @@ dtc_log=$(git log --oneline ${last_dtc_ver}..)
 
 # Copy the files into the Linux tree
 cd $DTC_LINUX_PATH
-for f in $DTC_SOURCE; do
+for f in $DTC_SOURCE $FDTOVERLAY_SOURCE; do
 	cp ${DTC_UPSTREAM_PATH}/${f} ${f}
 	git add ${f}
 done
-- 
2.25.0.rc1.19.g042ed3e048af

