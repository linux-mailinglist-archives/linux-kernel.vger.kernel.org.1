Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6086725FF11
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 18:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbgIGQ03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 12:26:29 -0400
Received: from gw.c-home.cz ([89.24.150.100]:42059 "EHLO dmz.c-home.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729821AbgIGQZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:25:59 -0400
Received: from ubuntu1804.c-home.cz (unifi.c-home.cz [192.168.1.239])
        by dmz.c-home.cz (8.14.4+Sun/8.14.4) with ESMTP id 087GP1f1019439;
        Mon, 7 Sep 2020 18:25:07 +0200 (CEST)
From:   Martin Cerveny <m.cerveny@computer.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Martin Cerveny <m.cerveny@computer.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 0/2] ARM: dts: sun8i: v3s: Enable crypto engine
Date:   Mon,  7 Sep 2020 18:24:56 +0200
Message-Id: <20200907162458.23730-1-m.cerveny@computer.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for crypto engine (sun4i-ss) for Allwinner V3s.
Functionality like A33 so add only compatible and enable
in device tree.

Regards.

Changes since v2:
- reduced to device tree only with A33 compatibility

Changes since v1:
- splitting to patch series

martin Cerveny (2):
  dt-bindings: crypto: Add compatible for V3s
  ARM: dts: sun8i: v3s: Enable crypto engine

 .../bindings/crypto/allwinner,sun4i-a10-crypto.yaml   |  3 +++
 arch/arm/boot/dts/sun8i-v3s.dtsi                      | 11 +++++++++++
 2 files changed, 14 insertions(+)

-- 
2.17.1
