Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E028D2F5E77
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbhANKOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:14:03 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:33291 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbhANKOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:14:02 -0500
Received: from orion.localdomain ([77.7.60.217]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N332D-1m3Os10CiL-013R27; Thu, 14 Jan 2021 11:11:28 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org
Subject: [PATCH] of: base: improve error msg in of_phandle_iterator_next()
Date:   Thu, 14 Jan 2021 11:11:27 +0100
Message-Id: <20210114101127.16580-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:6l2KskMrJs48qKUSwYmCmHjD489n6FI/7d4iwdVSlNAkWFkXS2d
 5P1DRflrBpUallz5pybt8B6+48b5Ot7WqULDcA3ZD0GlgSRg3vl72FBc+24jUc51wAv8mcN
 aSvTC31OJ2x5PVIB4VsgF/c9YQEK3pDx847SZvp7AHdMNhje3VFbzIwBhIlWswt+f4WzgaZ
 UH+IwiSdzvGIaW9o9c0XQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8JdhkU5kt4Y=:m71J3DHObi+v6NPBqRxNHG
 0Ve1919mZXB/zaUC0dAWeTO2VedgklpudFv8xF4sIMBN62+kN1gp26B3lFGagrSJS+nCE1YGN
 e4c3uX70WsjMPbLurv92bLxd8Cj2KsCQBkFNV9XzwCUfvFrPGRx/UoThXFOFUB0AmOcVgUwFH
 eXlq5BKWfb5MrIBurGlOcSh+D/bgFnkWA+8ipd0iGx9HXbdW/IurRA5043p+nVjFlczP7zNot
 mTd7e1ifV6OCQ5wkiPxCH4a+/bKtkv5JcRdy/s+/ZN8Itrftb+xNo0vsqR1A5Jx+HOCNW8AEy
 cWtW23AMx14YX0MJGLxg/lTPn+sWBI+/5kzqY9MizadoLeaA3NVsVK0Inq4jlaVcHCp7YtFXh
 U455RR0aPtS3Ulvzwf/bFqx4/2IIbRkgTn3tGmuK69xMmMF1rSibUe1Gq8OxG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also print out the phandle ID on error message, as a debug aid.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/of/base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 161a23631472..8a348f0d3c5e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1297,8 +1297,8 @@ int of_phandle_iterator_next(struct of_phandle_iterator *it)
 
 		if (it->cells_name) {
 			if (!it->node) {
-				pr_err("%pOF: could not find phandle\n",
-				       it->parent);
+				pr_err("%pOF: could not find phandle %d\n",
+				       it->parent, it->phandle);
 				goto err;
 			}
 
-- 
2.11.0

