Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5504F2767A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgIXEUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgIXEUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:20:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6809CC0613CE;
        Wed, 23 Sep 2020 21:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=FcKdwf0I1J0dSJnjVNVYUAP29iwsDzFF5w1vapwwcAA=; b=vevxS8n1G81Umvz0FxewqlQIzC
        oTMh4mMU4Mo22Hmu1WM9gz5zRamGfnh7jaE+yzdhwO29+fkld3vCcxkNRW0JTamq7T/bNI22Aot5X
        MwzXTdfhH60Gs+5QCse5/YfmJh6rfYiZcxxlLVmN3VMpYLoOZN5/xtGV/0WcIGSGDip0ki/sQaLaM
        UVS2bLv9ljyJLEpPhw+F2QdPSnz/y5D/O/+NH56Tj4L2Mw67QkFeR3gaTUsvN/uQyfmzuYl6Dw+h0
        W7QFPFhvrY3yzNeaOu6iIVyBful2CKnQrPOLSNykhm9XcRnlOOERWJjiYQ+WuyObDx70GuIooyB6q
        3MIrcphA==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLIjj-0001sP-Er; Thu, 24 Sep 2020 04:20:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: switch defconfig from the legacy ide driver to libata
Date:   Thu, 24 Sep 2020 06:20:02 +0200
Message-Id: <20200924042002.521411-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from the soon to be removed legacy ide driver to libata.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/configs/defconfig | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/configs/defconfig b/arch/alpha/configs/defconfig
index 6293675db1644a..387174e2422f6b 100644
--- a/arch/alpha/configs/defconfig
+++ b/arch/alpha/configs/defconfig
@@ -26,13 +26,11 @@ CONFIG_PNP=y
 CONFIG_ISAPNP=y
 CONFIG_BLK_DEV_FD=y
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_IDE_GENERIC=y
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_ALI15X3=y
-CONFIG_BLK_DEV_CMD64X=y
-CONFIG_BLK_DEV_CY82C693=y
+CONFIG_ATA=y
+CONFIG_ATA_GENERIC=y
+CONFIG_PATA_ALI=y
+CONFIG_PATA_CMD64X=y
+CONFIG_PATA_CYPRESS=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
-- 
2.28.0

