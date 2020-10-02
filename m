Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A4D281832
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbgJBQpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:45:54 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34438 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbgJBQpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:45:54 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 092Gjk3D097798;
        Fri, 2 Oct 2020 11:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601657146;
        bh=QfZxwdh0vwMGrB4xdzhLmrZ5TQHoPWNHjBxqVPOuzkQ=;
        h=From:To:CC:Subject:Date;
        b=a6R3ZOtT7hFaJCob+k7M+Eo6XFMXCrLVCpRV4pBP6YZx5UciDlnTSVPUI3tdZODK9
         B8tHqSEs7EWDJoY7RMdSaiThjQOhYhyn3IdLDPvU9hFSv+CwYPJNq91Rv2TO+9BWxS
         wRJ2h1Azqp7NMBPNFPeXkTTNFLQOs1tBl0w6YU0Y=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 092GjkKY072967
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Oct 2020 11:45:46 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 2 Oct
 2020 11:45:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 2 Oct 2020 11:45:44 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 092GjaKY042820;
        Fri, 2 Oct 2020 11:45:38 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <will@kernel.org>, <catalin.marinas@arm.com>, <nm@ti.com>,
        <t-kristo@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 0/2] Enable GPIO and I2C configs for TI's J721e platform
Date:   Fri, 2 Oct 2020 22:15:33 +0530
Message-ID: <20201002164535.9920-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches enable configs in the arm64 defconfig to support
GPIO and I2C support on TI's J721e platform.

Faiz Abbas (2):
  arm64: defconfig: Enable OMAP I2C driver
  arm64: defconfig: Enable DAVINCI_GPIO driver

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.17.1

