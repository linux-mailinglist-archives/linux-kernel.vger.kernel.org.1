Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0075273919
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 05:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgIVDH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 23:07:57 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.196]:33494 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727511AbgIVDHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 23:07:54 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 10AF6110C02
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 21:45:37 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id KYJFkgRADPiqfKYJFkMaH3; Mon, 21 Sep 2020 21:45:37 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MnT3/FU25WEKijRCGEmb2THy7/7Yb3rTT3w1jz0YeGI=; b=Y98dKFKc7gDuaPVLPy4DtmxDPC
        4TNQtwVpyTH7SztNbx5K5zrqkwXO+/lE9s/Yib3lCsO6FQxl/PXKnvqmo37kD66tryvw9JxUn4ldp
        RXhKPdeE8E7LaKhr8zVUGe0OJlsIp6bpDYHI5UqQsBauIFJ95goDPL52s2ckVUhg7IpHVGVamk3lx
        OyjCx5fiilk/2C2/hkR2UqXRjoa+DTpeWYvWnzfhtCmkLJviM0X8VSUCKQd1rkvoJw5cx//l1sY/T
        xehiP+Dkxv20AGsMMGbr+QO776o7xlbAC03OYCshHpUivu/Hy1xMbM16iFKrF4k1Nx/xTYmpQOytw
        AqkyA+eA==;
Received: from 179-197-124-241.user.veloxzone.com.br ([179.197.124.241]:43534 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1kKYJE-000jSR-CU; Mon, 21 Sep 2020 23:45:36 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     manivannan.sadhasivam@linaro.org, afaerber@suse.de,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        helen.koike@collabora.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v7 0/4] Add Caninos Loucos Labrador CoM and Base Board Device Tree
Date:   Mon, 21 Sep 2020 23:42:58 -0300
Message-Id: <20200922024302.205062-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 179.197.124.241
X-Source-L: No
X-Exim-ID: 1kKYJE-000jSR-CU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.user.veloxzone.com.br (localhost.localdomain) [179.197.124.241]:43534
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 3
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm adding to the series the new Labrador v3, since it uses the same vendor
prefix. Thanks Andreas, Mani and Rob for your time reviewing it.

Changes since v6:
- Add new caninos,labrador-v3 CoM and caninos,labrador-base-m2 base board
- Improve Model description

Changes since v5:
(Suggested by Andreas Färber)
- Put caninos,labrador-v2 as const one level down

Matheus Castello (4):
  dt-bindings: Add vendor prefix for Caninos Loucos
  dt-bindings: arm: actions: Document Caninos Loucos Labrador
  ARM: dts: Add Caninos Loucos Labrador v2
  arm64: dts: Add Caninos Loucos Labrador v3

 .../devicetree/bindings/arm/actions.yaml      |  10 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../arm/boot/dts/owl-s500-labrador-base-m.dts |  35 +++++
 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi   |  22 ++++
 arch/arm64/boot/dts/actions/Makefile          |   2 +
 .../dts/actions/s700-labrador-base-m2.dts     |  34 +++++
 .../boot/dts/actions/s700-labrador-v3.dtsi    | 122 ++++++++++++++++++
 8 files changed, 228 insertions(+)
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-base-m.dts
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
 create mode 100644 arch/arm64/boot/dts/actions/s700-labrador-base-m2.dts
 create mode 100644 arch/arm64/boot/dts/actions/s700-labrador-v3.dtsi

--
2.28.0

