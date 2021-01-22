Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7382B2FFD33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbhAVHOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:14:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11475 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbhAVHNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:13:04 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DMVmH3gB0zjC3V;
        Fri, 22 Jan 2021 15:11:11 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Fri, 22 Jan 2021 15:12:09 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <yumeng18@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/7] add ECDH and CURVE25519 algorithms support for Kunpeng 930
Date:   Fri, 22 Jan 2021 15:09:48 +0800
Message-ID: <1611299395-675-1-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add some new elliptic curve parameters definitions, and reorder
   ECC 'Curves IDs';
2. Add interface to get elliptic curve by curve_id in
   "include/crypto/ecc_curve.h" by curve_id;
3. Add ECDH and CURVE25519 algorithms support for Kunpeng 930.

v6->v7:
- patch #4: add function interface to expose elliptic curve parameters
- patch #4: eliminate warning by 'kernel test robot'
- patch #5: add function interface to expose curve25519 parameters

v5->v6:
- patch #1: add a new patch (the first patch), which is the "depend on" patch before

v4->v5:
- patch #4: delete P-128 and P-320 curve, as the few using case in the kernel

v3 -> v4:
- patch #3: add new, move ecc_curve params to "include/crypto"

v2 -> v3:
- patch #5: fix sparse warnings
- patch #5: add 'CRYPTO_LIB_CURVE25519_GENERIC' in 'Kconfig'

v1 -> v2:
- patch #5: delete `curve25519_null_point'


Hui Tang (1):
  crypto: hisilicon/hpre - add some updates to adapt to Kunpeng 930

Meng Yu (6):
  crypto: hisilicon/hpre - add version adapt to new algorithms
  crypto: hisilicon/hpre - add algorithm type
  crypto: add ecc curve and expose them
  crypto: add curve 25519 and expose them
  crypto: hisilicon/hpre - add 'ECDH' algorithm
  crypto: hisilicon/hpre - add 'CURVE25519' algorithm

 crypto/ecc.c                                |  22 +-
 crypto/ecc.h                                |  37 +-
 crypto/ecc_curve_defs.h                     | 163 +++++-
 crypto/testmgr.h                            |  12 +-
 drivers/crypto/hisilicon/Kconfig            |   1 +
 drivers/crypto/hisilicon/hpre/hpre.h        |  25 +-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 861 +++++++++++++++++++++++++++-
 drivers/crypto/hisilicon/hpre/hpre_main.c   | 105 ++--
 drivers/crypto/hisilicon/qm.c               |   4 +-
 drivers/crypto/hisilicon/qm.h               |   4 +-
 drivers/crypto/hisilicon/sec2/sec.h         |   4 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c  |   4 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.h  |   4 +-
 drivers/crypto/hisilicon/zip/zip.h          |   4 +-
 drivers/crypto/hisilicon/zip/zip_crypto.c   |   4 +-
 include/crypto/ecc_curve.h                  |  60 ++
 include/crypto/ecdh.h                       |   5 +-
 17 files changed, 1191 insertions(+), 128 deletions(-)
 create mode 100644 include/crypto/ecc_curve.h

-- 
2.8.1

