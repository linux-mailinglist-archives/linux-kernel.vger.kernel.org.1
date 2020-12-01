Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C60D2C9FE3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbgLAKfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:35:33 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:24196 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgLAKfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:35:32 -0500
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 0B1AYKHf001992;
        Tue, 1 Dec 2020 19:34:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 0B1AYKHf001992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1606818862;
        bh=vxNOmjnE2Q8XUTZRqrq4YwyDHWncDyyWUqu6+/iHq3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1xVk2u+cWbQfDXWWm4VAHedcterADfb+IalZAMfAYnjhfucOVNQvUtVLgi7aBAVD
         m6nLIOoirE9hjR3ZRBOH56/qcoX5LGY2ehfXNLjH3ajV9Nx7m/HE2ZxHDqlKCZdSsr
         dj3Gx0Pn31RsgT2PtBY4qBEVcvM4o8KP74P/EikHI1leG9QLNGTsR8E745wtFrFG77
         lAoGp6dbw/akJl/sC6FqlwVlhf+A5rrbt/CdY97XoPaU+DcdP6IoAIQ2ZAWkeIRAph
         7Iam8+vI/+y735IQVwuPIWNOy9vBLCD1jxZp8qf86yZm+6SCYu2dFirMlBJc/W+7iL
         7V5gJCTjfeM+Q==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Quentin Perret <qperret@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] modpost: turn missing MODULE_LICENSE() into error
Date:   Tue,  1 Dec 2020 19:34:16 +0900
Message-Id: <20201201103418.675850-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201201103418.675850-1-masahiroy@kernel.org>
References: <20201201103418.675850-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not create modules with no license tag.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 43e00867623a..d55d7e5ef111 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2018,7 +2018,7 @@ static void read_symbols(const char *modname)
 	if (!mod->is_vmlinux) {
 		license = get_modinfo(&info, "license");
 		if (!license)
-			warn("missing MODULE_LICENSE() in %s\n", modname);
+			error("missing MODULE_LICENSE() in %s\n", modname);
 		while (license) {
 			if (license_is_gpl_compatible(license))
 				mod->gpl_compatible = 1;
-- 
2.27.0

