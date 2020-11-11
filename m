Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70752AF33A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgKKONN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:13:13 -0500
Received: from foss.arm.com ([217.140.110.172]:54752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgKKOMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:12:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5C9A31B;
        Wed, 11 Nov 2020 06:12:15 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD02F3F718;
        Wed, 11 Nov 2020 06:12:13 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] add optional cache params override from DT
Date:   Wed, 11 Nov 2020 16:11:35 +0200
Message-Id: <20201111141138.836-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the setting of cache parameters, including
optionally allowing overiding the defaults from device tree

Changes from v1:
- As per Rob Herring's suggestions, lose the distinction between
  read and write and limit options to a few that make sense.
  Also use strings to make the meaning of the setting clearer.

Gilad Ben-Yossef (2):
  dt-bindings: crypto: update ccree optional params
  crypto: ccree - add custom cache params from DT file

 .../bindings/crypto/arm-cryptocell.txt        |   4 +
 drivers/crypto/ccree/cc_driver.c              | 100 +++++++++++++++---
 drivers/crypto/ccree/cc_driver.h              |   4 +-
 drivers/crypto/ccree/cc_pm.c                  |   2 +-
 4 files changed, 92 insertions(+), 18 deletions(-)

-- 
2.29.2

