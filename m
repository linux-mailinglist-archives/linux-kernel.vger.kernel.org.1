Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C563526BDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgIPHUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:20:08 -0400
Received: from foss.arm.com ([217.140.110.172]:54778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgIPHUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:20:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9FEC101E;
        Wed, 16 Sep 2020 00:20:07 -0700 (PDT)
Received: from e110176-lin.kfn.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C2C53F68F;
        Wed, 16 Sep 2020 00:20:06 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] add optional cache params from DT
Date:   Wed, 16 Sep 2020 10:19:48 +0300
Message-Id: <20200916071950.1493-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the setting of AXI bus cache parameters, including
optionally allowing setting them from device tree

Gilad Ben-Yossef (2):
  dt-bindings: crypto: update ccree optional params
  crypto: ccree - add custom cache params from DT file

 .../bindings/crypto/arm-cryptocell.txt        |  4 +
 drivers/crypto/ccree/cc_driver.c              | 89 +++++++++++++++----
 drivers/crypto/ccree/cc_driver.h              |  4 +-
 drivers/crypto/ccree/cc_pm.c                  |  2 +-
 4 files changed, 81 insertions(+), 18 deletions(-)

-- 
2.27.0

