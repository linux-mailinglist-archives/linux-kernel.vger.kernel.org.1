Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04931E0784
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 09:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbgEYHLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 03:11:03 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34052 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgEYHLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 03:11:02 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04P7AqLa068647;
        Mon, 25 May 2020 02:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590390652;
        bh=9cMDnQMDkejVvyUB8NrUL8tf/QLfFZ5QEEA4jkLIzuI=;
        h=From:To:CC:Subject:Date;
        b=PoymS4qGh5fkDNuO3UJTCJK6cWOTFLeFjUEE/gd7aTYyi2sFd7YcU5Crdc1KxcgPg
         ZyU6NinVZliDNFbuMLEa7BvzUC/3jmDY2S/kmEfwmsOZASnpc+NkzVOG+z9YuVEkSy
         XcKxkCwdsqf3ucpEsMQQYwp4xkDgYcKifmc37R2E=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04P7AqoK089500
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 May 2020 02:10:52 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 25
 May 2020 02:10:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 25 May 2020 02:10:52 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04P7AohU077897;
        Mon, 25 May 2020 02:10:50 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <vigneshr@ti.com>,
        <chunfeng.yun@mediatek.com>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 0/2] usb: dwc3: keystone: Turn on USB3 PHY before controller
Date:   Mon, 25 May 2020 10:10:46 +0300
Message-ID: <20200525071048.7738-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

This series prepares for Super-Speed support for AM654 SoC.

Patch 1 is already in your testing/next as commit d47b0062a8ad6c5060c84439745c3ce7d21d6bb9.
Please revert that and apply the revised version in which we make
the USB3.0 PHY optional. Thanks.

cheers,
-roger

Changelog:
v2:
- make USB3 PHY optional

Roger Quadros (2):
  dt-bindings: usb: ti,keystone-dwc3.yaml: Add USB3.0 PHY property
  usb: dwc3: keystone: Turn on USB3 PHY before controller

 .../bindings/usb/ti,keystone-dwc3.yaml        | 10 +++++
 drivers/usb/dwc3/dwc3-keystone.c              | 41 ++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

