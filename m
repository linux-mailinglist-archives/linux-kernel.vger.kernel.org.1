Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D279C2CF938
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 04:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgLEDuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 22:50:14 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:40448 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLEDuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 22:50:14 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 1A4412B617; Fri,  4 Dec 2020 22:49:32 -0500 (EST)
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Michael Ellerman" <mpe@ellerman.id.au>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Joshua Thompson" <funaho@jurai.org>,
        linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Message-Id: <fbac2cd8632bb719f48cd1368910abd310548a0e.1607139987.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] MAINTAINERS: Update 68k Mac entry
Date:   Sat, 05 Dec 2020 14:46:27 +1100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two files under drivers/macintosh are actually m68k-only. I think that
patches for these files should be reviewed in the appropriate forum and
merged via the appropriate tree, rather than falling to the powerpc
maintainers to deal with. Update the "M68K ON APPLE MACINTOSH" section
accordingly.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Joshua Thompson <funaho@jurai.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 867157311dc8..e8fa0c9645d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10322,6 +10322,8 @@ L:	linux-m68k@lists.linux-m68k.org
 S:	Maintained
 W:	http://www.mac.linux-m68k.org/
 F:	arch/m68k/mac/
+F:	drivers/macintosh/adb-iop.c
+F:	drivers/macintosh/via-macii.c
 
 M68K ON HP9000/300
 M:	Philip Blundell <philb@gnu.org>
-- 
2.26.2

