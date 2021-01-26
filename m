Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A56303A91
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392038AbhAZKlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:41:49 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:48945 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732031AbhAZCDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:03:33 -0500
X-Greylist: delayed 637 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jan 2021 21:03:32 EST
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 14A1283646;
        Tue, 26 Jan 2021 14:52:02 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1611625922;
        bh=oP2TIidX81eGT1h2x2myyqVlxaXwQ5UVYXVVX5Ngep0=;
        h=From:To:Cc:Subject:Date;
        b=h+YiTMWssfTinGHD8tqDCQYgSS5axw4LFeegeYEH4pU+Ro3vr63wmG4O5Sregpto7
         sqAXeHBp/7uTcONZcXDLRojaXsApegUg4n+zFkVGlMGtK2oQBj0wJrgXViOuP0OA2A
         oPUQsoMMqy6jbLZWdEVDGCCQqeXZ4XqE8p5YkoY/OP3AWZ+vDf0ze9LduqCv/mq+vP
         THoZAimk3DyIKaegsBOpHMukbNdL8oGNPGv2N+z/0hHyfLetUt+aCYKAVtD2MMJtQW
         KNfXSO0m39xZSV5mwOZZQE1VYA2EKVXsMOax2dA4kJjOU/Z69QXjae5bCIqJrayk+5
         Nuj4Gp+joQFdA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B600f75c10000>; Tue, 26 Jan 2021 14:52:01 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id E3FD013EECA;
        Tue, 26 Jan 2021 14:52:03 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id D2917288C85; Tue, 26 Jan 2021 14:52:01 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, frowand.list@gmail.com, arch0.zheng@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] of/fdt: Check against '/chosen' in early_init_dt_scan_chosen
Date:   Tue, 26 Jan 2021 14:51:59 +1300
Message-Id: <20210126015159.23923-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_scan_flat_dt() passes the name of the visited node to the iterator.
In the case of '/chosen' this includes the leading '/'. Update
early_init_dt_scan_chosen() to expect this.

Fixes: 7536c7e03e74 ("of/fdt: Remove redundant kbasename function call")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/of/fdt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index feb0f2d67fc5..861aedf0bb7c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1043,7 +1043,10 @@ int __init early_init_dt_scan_chosen(unsigned long=
 node, const char *uname,
 	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
=20
 	if (depth !=3D 1 || !data ||
-	    (strcmp(uname, "chosen") !=3D 0 && strcmp(uname, "chosen@0") !=3D 0=
))
+	    (strcmp(uname, "chosen") !=3D 0 &&
+	     strcmp(uname, "chosen@0") !=3D 0 &&
+	     strcmp(uname, "/chosen") !=3D 0 &&
+	     strcmp(uname, "/chosen@0") !=3D 0))
 		return 0;
=20
 	early_init_dt_check_for_initrd(node);
--=20
2.30.0

