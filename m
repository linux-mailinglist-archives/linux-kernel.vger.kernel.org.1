Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0799B26873F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgINIdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:33:19 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:2644 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgINIdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600072394; x=1631608394;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=67+8Mcp8HGIKVw3yZR5E3lj2tesKy4EU97y81UYj9g8=;
  b=D1+1THibgm/jCtCErZZQj+xy4Eo3hn/ks5NVWku3f3nJr4OfDQWk+GsJ
   a+I8TJ3Yjmziqx6h7Ctl1NTqxZzLYgifntNk3M0SfGc6YJrjvci1shBfi
   1HlWCXFstHMOdtBfByc2mhAcdEG5ksBGlf6lVgaDGajejs/Wm3MNR+Y28
   OkAnnzWRFekRXtNAQYEyW7ZkHK7RFuMMb4VWgEu3rqrdNfLN78SQmcwh7
   GqinAISxFtuaEzna1SpvAPJDC6/I1w+9TEc9saiE0rgEgwWlo4AIbUrHD
   tsILHumsJH+wmsocWh01Ms+5OQ9ILWS5U8lBVAdVobEY4t9vMDslucp9U
   Q==;
IronPort-SDR: L3GT1I+JWrHedXvh6GZMUO9aEoEuGkOWIqZ/QfmYSnssPcGJnZHDUF6ypmiVHtLQTU7xqzIBRn
 kSvi4syqGbDLipvAY9n7RNiFYC6YzxS27rKBoSNC91HslCqbMLMy0pUdpmG90lBEmgMzCphCx1
 5BI7ytidjxVcf/rvJpnFWYH6RAytX6rufuUABUNOpqPdASM1aTXXq/pX6BGMkxZ2KRXxeuvYxH
 G7wcFRUYlNrPmSwOwq+axWwkDHm0e9YPhIezM+A2vbicfKSFcNu7kv5VGs+FoUjr/uvb34Y/N+
 Gls=
X-IronPort-AV: E=Sophos;i="5.76,425,1592895600"; 
   d="scan'208";a="91680571"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2020 01:33:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 14 Sep 2020 01:33:11 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 14 Sep 2020 01:33:10 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Add git tree for Sparx5
Date:   Mon, 14 Sep 2020 10:32:57 +0200
Message-ID: <20200914083257.11080-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a git tree for maintaining the Sparx5 SoC from.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..eda3c051b13c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2136,6 +2136,7 @@ M:	Steen Hegelund <Steen.Hegelund@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
+T:	git git://github.com/microchip-ung/linux-upstream.git
 F:	arch/arm64/boot/dts/microchip/
 N:	sparx5
 
-- 
2.27.0

