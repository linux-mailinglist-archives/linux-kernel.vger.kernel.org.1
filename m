Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD221D1436
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 15:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733236AbgEMNNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 09:13:04 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57690 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733082AbgEMNNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:13:04 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04DDD3wk021680
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589375583;
        bh=5qiZMMWm9MPQ0iNMJY+yrGJJFGOJBKwwSI59Q3ucWFo=;
        h=From:To:CC:Subject:Date;
        b=yaZR6jHy9iTKtbKHm1UtDX0P4DD4zR58WddLlQJE9R69xgYT5QNRgCNc67n4X2HGI
         rwHhkBGiLA5sER5kUwcppciMKfWAPP9EnrZ9m5hDE0a2MyOxqeCDO4bZhvxG+Sc40y
         ckB55em5Ljpfmq0uA4R/mH/SGoFn/BSBRHY4OKJI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04DDD3ZO020149
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:13:03 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 08:13:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 08:13:03 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DDD16c043420;
        Wed, 13 May 2020 08:13:02 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <vigneshr@ti.com>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/2] phy: ti: am654: Add USB super-speed support
Date:   Wed, 13 May 2020 16:12:52 +0300
Message-ID: <20200513131254.10497-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

This series adds USB3.0 support to am654-serdes PHY driver.

cheers,
-roger

Roger Quadros (2):
  phy: ti: am654: show up in regmap debugfs
  phy: ti: am654: add support for USB super-speed

 drivers/phy/ti/phy-am654-serdes.c | 104 +++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

