Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04EE2AFE40
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgKLFgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgKLDV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 22:21:57 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E17BC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 19:21:56 -0800 (PST)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 26F6B806A8;
        Thu, 12 Nov 2020 16:21:52 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1605151312;
        bh=45jFnjPQvGx+d5OYv1TMsUNV7V//9FDJa3Kw/rOB8XA=;
        h=From:To:Cc:Subject:Date;
        b=xI8P+jV4o2n7LGU3dInAAZuwH3B7UFZF5Tw/ybWNxW562RAf18d+hSs92tLQSilZR
         F560bQJsM/btdKkFZz1v9f5VqVSA1WZRBuEyEoNvZgDlu/SawTDeqXE5MTOpRUheIx
         0LKNOQre2qJWmGYPqaoDiHvYFvvPmOOwguaJl0sYfLXi7SRlx9bjePHCGVa125Wrx+
         2imH0WBxXvPNzzyfJHudCo9qr4qDqaQF2T/kWAMmxBm23DRtr036FssWUE86EL2iNf
         5dvu9scZpu5CI7S1T3fDNfhEijM8Iqit5tZeiO8o/dqQvP0uF6HuabHhJP/zhaKK8U
         k5YhYQNjaDzKQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5facaa4f0000>; Thu, 12 Nov 2020 16:21:51 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 2A52813EE9C;
        Thu, 12 Nov 2020 16:21:51 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id E4319280958; Thu, 12 Nov 2020 16:21:51 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     akpm@linux-foundation.org, rppt@kernel.org,
        thomas.petazzoni@free-electrons.com, arnd@arndb.de,
        jason@lakedaemon.net
Cc:     linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] bus: mvebu-mbus: make iounmap() symmetric with ioremap()
Date:   Thu, 12 Nov 2020 16:21:49 +1300
Message-Id: <20201112032149.21906-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make coccicheck complains:

  ./drivers/bus/mvebu-mbus.c:1113:2-8: ERROR: missing iounmap; ioremap on=
 line 1106 and execution via conditional on line 1111

It took some staring but I don't think there is a problem because the
file global `mbus_state` is passed mvebu_mbus_common_init() as the
`mbus` parameter so `mbus_state.mbuswins_base` and `mbus->mbuswins_base`
are the same thing. But this is confusing for anyone reading the code
and one less complaint from coccicheck would be nice so lets fix it.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
I haven't included

Fixes: fddddb52a6c4 ("bus: introduce an Marvell EBU MBus driver")

because that commit is quite old and it's probably not worth bothering
the stable trees with what is essentially a no-op.

 drivers/bus/mvebu-mbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 2519ceede64b..dd9e7343a5e3 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -1111,7 +1111,7 @@ static int __init mvebu_mbus_common_init(struct mve=
bu_mbus_state *mbus,
=20
 	mbus->sdramwins_base =3D ioremap(sdramwins_phys_base, sdramwins_size);
 	if (!mbus->sdramwins_base) {
-		iounmap(mbus_state.mbuswins_base);
+		iounmap(mbus->mbuswins_base);
 		return -ENOMEM;
 	}
=20
--=20
2.29.2

