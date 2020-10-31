Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562E92A13D3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 07:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgJaGgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 02:36:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6678 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgJaGgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 02:36:13 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CNTw91WQmz15PfP;
        Sat, 31 Oct 2020 14:36:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Sat, 31 Oct 2020 14:36:00 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <yumeng18@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] crypto: hisilicon/hpre - add something for 'Kunpeng 930'
Date:   Sat, 31 Oct 2020 14:34:23 +0800
Message-ID: <1604126068-29195-1-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add initial settings, version and new type to adapt 'Kunpeng 930';
2. Add algorithms(ECDH and CURVE25519) in 'Kunpeng 930';

Hui Tang (1):
  crypto: hisilicon/hpre - add initial settings adapt to 'Kunpeng 930'

Meng Yu (4):
  crypto: hisilicon/hpre - add version adapt to new algorithms
  crypto: hisilicon/hpre - add algorithm type
  crypto: hisilicon/hpre - add 'ECDH' algorithm
  crypto: hisilicon/hpre - add 'CURVE25519' algorithm

 drivers/crypto/hisilicon/hpre/hpre.h        |   25 +-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 1190 ++++++++++++++++++++++++++-
 drivers/crypto/hisilicon/hpre/hpre_main.c   |  105 ++-
 drivers/crypto/hisilicon/qm.c               |    4 +-
 drivers/crypto/hisilicon/qm.h               |    4 +-
 drivers/crypto/hisilicon/sec2/sec.h         |    4 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c  |    4 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.h  |    4 +-
 drivers/crypto/hisilicon/zip/zip.h          |    4 +-
 drivers/crypto/hisilicon/zip/zip_crypto.c   |    4 +-
 10 files changed, 1285 insertions(+), 63 deletions(-)

-- 
2.8.1

