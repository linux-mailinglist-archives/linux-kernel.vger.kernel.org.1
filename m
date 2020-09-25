Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8772D278A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgIYOJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:09:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728963AbgIYOJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:09:01 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4865998FC9D03104DFCE;
        Fri, 25 Sep 2020 22:08:56 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 25 Sep 2020 22:08:49 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH RESEND 0/4] crypto: hisilicon/zip - misc clean up
Date:   Fri, 25 Sep 2020 22:06:13 +0800
Message-ID: <1601042777-26150-1-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fix some bug:
patch 1:clear the debug registers when remove driver
patch 2:intercept invalid input when using decompress
patch 3:replace the return value '-EBUSY' with '-EAGAIN' when
    device is busy
patch 4:initialize the 'curr_qm_qp_num' when probe device

Resend this patch series because it depends on
https://patchwork.kernel.org/cover/11760159/
(crypto: hisilicon/zip - misc clean up).
Now the patch series has been applied.

Hao Fang (1):
  crypto: hisilicon/zip - fix the uncleared debug registers

Sihang Chen (1):
  crypto: hisilicon/zip - fix the uninitalized 'curr_qm_qp_num'

Yang Shen (1):
  crypto: hisilicon/zip - fix the return value when device is busy

Zhou Wang (1):
  crypto: hisilicon/zip - fix zero length input in GZIP decompress

 drivers/crypto/hisilicon/zip/zip_crypto.c | 26 +++++++++++++++++++-------
 drivers/crypto/hisilicon/zip/zip_main.c   | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+), 7 deletions(-)

--
2.7.4

