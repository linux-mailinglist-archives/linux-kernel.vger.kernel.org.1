Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD35625D5F9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 12:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbgIDKXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 06:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729930AbgIDKXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:23:36 -0400
Received: from mail.kernel.org (ip5f5ad59b.dynamic.kabel-deutschland.de [95.90.213.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0057B208C7;
        Fri,  4 Sep 2020 10:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599215016;
        bh=H5judmKvtDvTpmGDeQekonxfCALycmTHh4WX0CpT/iM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXXPN3dEQIUT6mUHBlEH7J/wTSOlllyNP6I5C9o6jKup72HkmikUbo9e7duqYURoN
         8if8LWjhE/112DnnqemwkIsqRK0kd89yefKV9HaHU0/tEjnPbDDKgmdml7W+AUPrbz
         9xsqILYzwMTLbn0C9cSHV+MZE/DRMrOAhewlsqfU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kE8sX-005SvK-SY; Fri, 04 Sep 2020 12:23:33 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC 07/10] MAINTAINERS: add myself as maintainer for Kirin 970 USB PHY
Date:   Fri,  4 Sep 2020 12:23:29 +0200
Message-Id: <2e0c38d7ea7d4c527d5c9d1e19e7ca81cb952a86.1599214329.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599214329.git.mchehab+huawei@kernel.org>
References: <cover.1599214329.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that this driver was added upsream, it needs a maintainer.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f497c7d659c..267ba0b7a52e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17711,7 +17711,7 @@ L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	drivers/usb/roles/intel-xhci-usb-role-switch.c
 
-USB IP DRIVER FOR HISILICON KIRIN
+USB IP DRIVER FOR HISILICON KIRIN 960
 M:	Yu Chen <chenyu56@huawei.com>
 M:	Binghui Wang <wangbinghui@hisilicon.com>
 L:	linux-usb@vger.kernel.org
@@ -17719,6 +17719,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
 F:	drivers/phy/hisilicon/phy-hi3660-usb3.c
 
+USB IP DRIVER FOR HISILICON KIRIN 970
+M:	Mauro Carvalho Chehab <mchehab@kernel.org>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/hisilicon,kirin970-usb3.yaml
+F:	drivers/phy/hisilicon/phy-kirin970-usb3.c
+
 USB ISP116X DRIVER
 M:	Olav Kongas <ok@artecdesign.ee>
 L:	linux-usb@vger.kernel.org
-- 
2.26.2

