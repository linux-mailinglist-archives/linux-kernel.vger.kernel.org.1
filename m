Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E6C1A616A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 04:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgDMCBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 22:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgDMCBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 22:01:36 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E9DC0A3BE0;
        Sun, 12 Apr 2020 19:01:36 -0700 (PDT)
Received: from oscar.flets-west.jp (softbank060142179096.bbtec.net [60.142.179.96]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03D2168W004103;
        Mon, 13 Apr 2020 11:01:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03D2168W004103
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1586743267;
        bh=EA/9hQHvqlSNL9Mk9ru4doPHnzdLNfO1YTTXQLdfKBk=;
        h=From:To:Cc:Subject:Date:From;
        b=iqt/rTHq5QHpUXCz9fD+GGP3Ad4AKApI6PGmjTXa8XMJVGJyAL2J4uUGtoxLZLb8G
         N4DqwbDRH36dRyEZlkE0UL6S0oFibR+NtiAH7bBLNUp0v7WRqrDkfu3dhU6lC/W8zm
         QRx2T6tS8zGET67Isp6/vHS2hrRGxHu5K5/60DTntYGbxh7qsmpRjbInoixiqlKMzj
         pibk2RYcJXbkgvBDWcPgV71J9hWSzoOV+6OFG+sHGQUcRNEKWgucycBbiwp/yWRMfh
         bYep8J4eX6YpYp60ERoBBKdOv69jy59bzpWejebG/BVq6H5OHuAVvw9vto3QgmxdEy
         AHAMEM8ZvPRXw==
X-Nifty-SrcIP: [60.142.179.96]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH] h8300: set stdout-path to a string, not a phandle
Date:   Mon, 13 Apr 2020 11:00:57 +0900
Message-Id: <20200413020057.30808-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stdout-path must be a node path, not a phandle.

DTC warns like follows:

  DTC     arch/h8300/boot/dts/h8s_sim.dtb
arch/h8300/boot/dts/h8s_sim.dts:11.3-25: Warning (chosen_node_stdout_path): /chosen:stdout-path: property is not a string

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/h8300/boot/dts/h8300h_sim.dts | 2 +-
 arch/h8300/boot/dts/h8s_sim.dts    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/h8300/boot/dts/h8300h_sim.dts b/arch/h8300/boot/dts/h8300h_sim.dts
index 595398b9d018..e1d4d9b7f6b4 100644
--- a/arch/h8300/boot/dts/h8300h_sim.dts
+++ b/arch/h8300/boot/dts/h8300h_sim.dts
@@ -8,7 +8,7 @@ / {
 
 	chosen {
 		bootargs = "earlyprintk=h8300-sim";
-		stdout-path = <&sci0>;
+		stdout-path = &sci0;
 	};
 	aliases {
 		serial0 = &sci0;
diff --git a/arch/h8300/boot/dts/h8s_sim.dts b/arch/h8300/boot/dts/h8s_sim.dts
index 932cc3c5a81b..4848e40e607e 100644
--- a/arch/h8300/boot/dts/h8s_sim.dts
+++ b/arch/h8300/boot/dts/h8s_sim.dts
@@ -8,7 +8,7 @@ / {
 
 	chosen {
 		bootargs = "earlyprintk=h8300-sim";
-		stdout-path = <&sci0>;
+		stdout-path = &sci0;
 	};
 	aliases {
 		serial0 = &sci0;
-- 
2.25.1

