Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC82C4D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 03:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbgKZCTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 21:19:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7682 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732380AbgKZCTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 21:19:52 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ChM004Lsyz15Qhx;
        Thu, 26 Nov 2020 10:19:28 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 26 Nov 2020
 10:19:44 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] crypto: hisilicon - add some new algorithms
Date:   Thu, 26 Nov 2020 10:18:01 +0800
Message-ID: <1606357086-9785-1-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the new Kunpeng930 supports some new algorithms,
the driver needs to be updated

Longfang Liu (4):
  crypto: hisilicon/sec - add new type of sqe for Kunpeng930
  crypto: hisilicon/sec - add new skcipher mode for SEC
  crypto: hisilicon/sec - add new AEAD mode for SEC
  crypto: hisilicon/sec - fixes some coding style

Meng Yu (1):
  crypto: hisilicon/hpre - add version adapt to new algorithms

 drivers/crypto/hisilicon/hpre/hpre.h        |   5 +-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c |   4 +-
 drivers/crypto/hisilicon/qm.c               |   4 +-
 drivers/crypto/hisilicon/qm.h               |   4 +-
 drivers/crypto/hisilicon/sec2/sec.h         |  19 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c  | 822 ++++++++++++++++++++++------
 drivers/crypto/hisilicon/sec2/sec_crypto.h  | 182 +++++-
 drivers/crypto/hisilicon/zip/zip.h          |   4 +-
 drivers/crypto/hisilicon/zip/zip_crypto.c   |   4 +-
 9 files changed, 860 insertions(+), 188 deletions(-)

-- 
2.8.1

