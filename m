Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF423048CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 20:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388240AbhAZFjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbhAYK6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:58:51 -0500
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B7DC061794
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 02:58:10 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id C857AADD4CA; Mon, 25 Jan 2021 11:58:05 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, cyril@debamax.com,
        Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH] cmd_dtc: Enable generation of device tree symbols
Date:   Mon, 25 Jan 2021 11:57:57 +0100
Message-Id: <20210125105757.661240-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the -@ switch to dtc results in the binary devicetrees containing
a list of symbolic references and their paths. This is necessary to
apply device tree overlays e.g. on Raspberry Pi as described on
https://www.raspberrypi.org/documentation/configuration/device-tree.md.

Obviously the downside of this change is an increas of the size of the
generated dtbs, for an arm out-of-tree build (multi_v7_defconfig):

	$ du -s arch/arm/boot/dts*
	101380	arch/arm/boot/dts-pre
	114308	arch/arm/boot/dts-post

so this is in average an increase of 12.8% in size.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 213677a5ed33..0683a5808f7f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -319,7 +319,7 @@ $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
 
 quiet_cmd_dtc = DTC     $@
 cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
-	$(DTC) -O $(patsubst .%,%,$(suffix $@)) -o $@ -b 0 \
+	$(DTC) -@ -O $(patsubst .%,%,$(suffix $@)) -o $@ -b 0 \
 		$(addprefix -i,$(dir $<) $(DTC_INCLUDE)) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
 	cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
-- 
2.29.2

