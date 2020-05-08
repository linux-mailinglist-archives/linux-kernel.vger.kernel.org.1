Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669C71CA7C0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 12:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHKBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 06:01:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58504 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgEHKBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:01:15 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 048A19e7113081;
        Fri, 8 May 2020 05:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588932069;
        bh=2JOZvdIqVLBdPCm4Zk9ICOns/DaGylLushk2AFkk0Kk=;
        h=From:To:CC:Subject:Date;
        b=c5Jr8BkiXrF2uCTMZjn0AML9xGM511SEyO2HfDnurKEY99naTLC6DJtPq0KHbU9vy
         /NGSmBt5NZc8mZHza7W7OoQOOzFpXEQ2GxFU8iRg7Ejm08LEbLeYhxYVDhBMx35nRt
         G8a4fCaD0SGrGByG1Wn8Z4vvUgIK6SBCQx+8JaOE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 048A19t1071341;
        Fri, 8 May 2020 05:01:09 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 May
 2020 05:01:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 May 2020 05:01:09 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 048A18ii102915;
        Fri, 8 May 2020 05:01:08 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>, <devicetree@vger.kernel.org>
CC:     Dave Gerlach <d-gerlach@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v3 0/2] soc: ti: add k3 platforms chipid module driver
Date:   Fri, 8 May 2020 13:00:58 +0300
Message-ID: <20200508100100.20740-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series introduces TI K3 Multicore SoC platforms chipid module driver
which provides identification support of the TI K3 SoCs (family, revision)
and register this information with the SoC bus. It is available under
/sys/devices/soc0/ for user space, and can be checked, where needed,
in Kernel using soc_device_match().
It is also required for introducing support for new revisions of
K3 AM65x/J721E SoCs.

Example J721E:
  # cat /sys/devices/soc0/{machine,family,revision}
  Texas Instruments K3 J721E SoC
  J721E
  SR1.0

Example AM65x:
  # cat /sys/devices/soc0/{machine,family,revision}
  Texas Instruments AM654 Base Board
  AM65X
  SR1.0

Changes in v3:
 - add handling of kasprintf() fail

Changes in v2:
 - pr_debug() replaced with pr_info() to show SoC info on init
 - minor format change
 - split series on driver and platform changes
 - add Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

v2: https://lkml.org/lkml/2020/5/5/1193
v1: https://lwn.net/Articles/818577/

Grygorii Strashko (2):
  dt-bindings: soc: ti: add binding for k3 platforms chipid module
  soc: ti: add k3 platforms chipid module driver

 .../bindings/soc/ti/k3-socinfo.yaml           |  40 +++++
 drivers/soc/ti/Kconfig                        |  10 ++
 drivers/soc/ti/Makefile                       |   1 +
 drivers/soc/ti/k3-socinfo.c                   | 140 ++++++++++++++++++
 4 files changed, 191 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
 create mode 100644 drivers/soc/ti/k3-socinfo.c

-- 
2.17.1

