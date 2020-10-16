Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E08C29059F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 14:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407917AbgJPM7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 08:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395329AbgJPM7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:59:16 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0A2C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 05:59:15 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id v6so2696822lfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QskU2jKYuIV2PkAqqrC1eswLmoY8gP4EeJ4XVgA384U=;
        b=ZpEn7SMYQ0e9QC6e95fu3NR7MthennBKxsk3Fl0+ciAfQXNuTv8fy4zehey7SOQgKP
         WYopCS+rp8JhNMtzs0AooHaPVsCuE93euAmm2sPCI8YVI0bhl7GBSjRrppIQD7saDx0/
         VPtlAxJQfvY4jBAVqxRlna9cbFcTAXaSkjN50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QskU2jKYuIV2PkAqqrC1eswLmoY8gP4EeJ4XVgA384U=;
        b=A2WP+k6RGYS3HL98z7GgUq4auW1+zAiUThcGdoOKi2EqJvnlsmQ+gLTyo5ioo1bYEF
         COuxy9Aw3UczZmhekpartuuXQ3FGVsNTsnsXOXetvsVCjSOFUSBlhSLhwYVs6pBIGrmO
         kTIg2zY5M0+CAenItdK3/FjnR6ObD8F1UbI18cNNBjcOdO89w5699lTp5CVaKDf1xGum
         k3i6ETGY4hq3obM2wDDKK7DeSrvhXGZa/ciJ95PrkI3sUmhmDmSOcXekYPQh1UipDlMP
         6QMfQlkb5v/kZaQYkf2TeIlwvlg4x6WGbkWgMmSAFGBoPGXg4GlXKDG4fvzQjk+Z8GbN
         Sz9A==
X-Gm-Message-State: AOAM530cmTWzMnvapUUtV1zI5oqgbuiqUeALO040fD7wsqqO2Gir1HjH
        FVHMd67s2Qc47RgZAFjTwJUgdw==
X-Google-Smtp-Source: ABdhPJwPL4sxJoqOIIX6rp6HWa59jbRSOvCsoIA9bVDjugS20ljvbzOaZ+HGlVq2ZgN5Et3xkspxXQ==
X-Received: by 2002:ac2:4dad:: with SMTP id h13mr1344981lfe.351.1602853154334;
        Fri, 16 Oct 2020 05:59:14 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id v4sm802467lfn.6.2020.10.16.05.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 05:59:13 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Kbuild.include: remove leftover comment for filechk utility
Date:   Fri, 16 Oct 2020 14:58:46 +0200
Message-Id: <20201016125846.8156-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 43fee2b23895 ("kbuild: do not redirect the first
prerequisite for filechk"), the rule is no longer automatically passed
$< as stdin, so remove the stale comment.

Fixes: 43fee2b23895 ("kbuild: do not redirect the first prerequisite for filechk")
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 scripts/Kbuild.include | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 83a1637417e5..08e011175b4c 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -56,8 +56,6 @@ kecho := $($(quiet)kecho)
 # - If no file exist it is created
 # - If the content differ the new file is used
 # - If they are equal no change, and no timestamp update
-# - stdin is piped in from the first prerequisite ($<) so one has
-#   to specify a valid file as first prerequisite (often the kbuild file)
 define filechk
 	$(Q)set -e;						\
 	mkdir -p $(dir $@);					\
-- 
2.23.0

