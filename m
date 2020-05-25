Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974321E0480
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 03:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbgEYBwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 21:52:38 -0400
Received: from gateway30.websitewelcome.com ([192.185.152.11]:26985 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388054AbgEYBwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 21:52:37 -0400
X-Greylist: delayed 1334 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 May 2020 21:52:37 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id D795646F3
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 20:30:21 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id d1wbjPPvH8vkBd1wbj2VJG; Sun, 24 May 2020 20:30:21 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qyCTWA8alWH3T1OHxtqJqh8fX9ZMRzay2l/chLycdQ8=; b=DjVcPAoGwpjHhJk9TrOvDCpKVf
        jXKI0r2K8HNoSNHSe4EqDW6qZZDhs+Mr5WcqDss632tc5TxaUzLYBJmiSwNVGTgLd7Ef67aDKlXwR
        MTq2OXMn2bzE03r6xMGH3WhTvayuHz5HoJBj718I1j/XSV5J+FoCSzaE7TyMxan8LaLbkWQjdqZmh
        TYOCx1acl0DD9YYAEBwOfwYQsA8xh9PkZ8JRAogjrNyhWCv2pr3u4CCPzSn+OFjKvNGoNmCGIxl5m
        SXznW2rLj8z0G2Z1sCsHgmiQV13pQtNJMHMqnEMvUa+ghIHg9/paOw1yiScvuLMBP+r+rN0AMVI9J
        Kevli81A==;
Received: from [191.31.196.240] (port=34284 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1jd1wb-004Dik-8u; Sun, 24 May 2020 22:30:21 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v5 0/3] Add Caninos Loucos Labrador CoM and Base Board Device Tree
Date:   Sun, 24 May 2020 22:30:05 -0300
Message-Id: <20200525013008.108750-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.196.240
X-Source-L: No
X-Exim-ID: 1jd1wb-004Dik-8u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.196.240]:34284
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 2
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay.
Thanks Andreas, Mani and Rob for your time reviewing it.

Changes since v4:
(Suggested by Rob Herring)
- Fix issues with yaml indentation

Changes since v3:
(Suggested by Andreas Färber)
- Fix sort on actions.yaml
- Change the file owl-s500-labrador-bb.dts to owl-s500-labrador-base-m.dts
- Add description for both the SoM and Base Board
- Add Model description for both the SoM and Base Board

Matheus Castello (3):
  dt-bindings: Add vendor prefix for Caninos Loucos
  dt-bindings: arm: actions: Document Caninos Loucos Labrador
  ARM: dts: Add Caninos Loucos Labrador

 .../devicetree/bindings/arm/actions.yaml      |  5 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 .../arm/boot/dts/owl-s500-labrador-base-m.dts | 34 +++++++++++++++++++
 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi   | 22 ++++++++++++
 5 files changed, 64 insertions(+)
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-base-m.dts
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi

--
2.26.2

