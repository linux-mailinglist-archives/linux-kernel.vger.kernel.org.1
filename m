Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7450D303644
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbhAZGEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:04:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbhAYMth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:49:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D80B322472;
        Mon, 25 Jan 2021 12:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611577449;
        bh=61aLXnewGYT9pW69xQYb5+pJ+KbuONrN6DKFyYDPFOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=sxpg1Z0P1BDyGQORROsgzEAv87fhNu0NhIOxsa9G9N//mYQ/Z1/9rvYANgnJ/bYGP
         iHZOJzXdK89VJj3DL/38vZAYlSkf02YLEAl9cqX+Acme98VSbl6gEWp9LxyhTECUDF
         K/RMRNPDt+ESva8julDgcZwqUlmB+eNf+Rs/GqfCzGnZN+R2uQpu2RoJs+c3cnKwmP
         lU6ykNqHRJLTIczgSuV5Yrd7ml5vQDsvrKrX8xvq1qGKHWEVC91QfOSjcxBs53moKe
         h+wFuTCoj/7UNN+PK2p1IuW2Y84Ce3PDxXxJyGk4kmRY8YYXdb0XqMF0DBwtWYeh0T
         QoLbwE5pi97sA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nirmoy Das <nirmoy.das@amd.com>,
        Will Deacon <will@kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Roman Li <Roman.Li@amd.com>,
        Joshua Aberback <joshua.aberback@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] amdgpu: fix clang build warning
Date:   Mon, 25 Jan 2021 13:23:20 +0100
Message-Id: <20210125122402.4036126-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang warns about the -mhard-float command line arguments
on architectures that do not support this:

clang: error: argument unused during compilation: '-mhard-float' [-Werror,-Wunused-command-line-argument]

Move this into the gcc-specific arguments.

Fixes: e77165bf7b02 ("drm/amd/display: Add DCN3 blocks to Makefile")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile  | 6 ++++--
 drivers/gpu/drm/amd/display/dc/dcn301/Makefile | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn302/Makefile | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index c20331eb62e0..dfd77b3cc84d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -32,8 +32,8 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
 
 
 ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -msse
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -msse
 endif
 
 ifdef CONFIG_PPC64
@@ -45,6 +45,8 @@ ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
 endif
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mhard-float
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -mhard-float
 endif
 
 ifdef CONFIG_X86
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
index 3ca7d911d25c..09264716d1dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
@@ -14,7 +14,7 @@ DCN301 = dcn301_init.o dcn301_resource.o dcn301_dccg.o \
 		dcn301_dio_link_encoder.o dcn301_hwseq.o dcn301_panel_cntl.o dcn301_hubbub.o
 
 ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn301/dcn301_resource.o := -mhard-float -msse
+CFLAGS_$(AMDDALPATH)/dc/dcn301/dcn301_resource.o := -msse
 endif
 
 ifdef CONFIG_PPC64
@@ -25,6 +25,7 @@ ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
 endif
+CFLAGS_$(AMDDALPATH)/dc/dcn301/dcn301_resource.o += -mhard-float
 endif
 
 ifdef CONFIG_X86
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
index 8d4924b7dc22..101620a8867a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
@@ -13,7 +13,7 @@
 DCN3_02 = dcn302_init.o dcn302_hwseq.o dcn302_resource.o
 
 ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -msse
+CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -msse
 endif
 
 ifdef CONFIG_PPC64
@@ -24,6 +24,7 @@ ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
 endif
+CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -mhard-float
 endif
 
 ifdef CONFIG_X86
-- 
2.29.2

