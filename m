Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18EC24F165
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 05:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgHXDOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 23:14:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10314 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726635AbgHXDOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 23:14:22 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 83A993791F83814236E6;
        Mon, 24 Aug 2020 11:14:19 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 24 Aug 2020 11:14:13 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH RESEND 00/10] crypto: hisilicon/zip - misc clean up
Date:   Mon, 24 Aug 2020 11:11:39 +0800
Message-ID: <1598238709-58699-1-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset make some clean up:
patch 1:remove useless parameters
patch 4:replace 'sprintf' with 'scnprintf'
patch 7:fix static check warning
and the rest patch fix some coding style

Resend this patch series because it depends on
https://patchwork.kernel.org/cover/11715927/
(crypto: hisilicon/qm - misc fixes).
Now the patch series(crypto: hisilicon/qm - misc fixes) has been applied.
So this patch series will apply against cryptodev.

Shukun Tan (1):
  crypto: hisilicon/zip - modify debugfs interface parameters

Yang Shen (9):
  crypto: hisilicon/zip - remove some useless parameters
  crypto: hisilicon/zip - unify naming style for functions and macros
  crypto: hisilicon/zip - replace 'sprintf' with 'scnprintf'
  crypto: hisilicon/zip - use a enum parameter instead of some macros
  crypto: hisilicon/zip - add print for error branch
  crypto: hisilicon/zip - fix static check warning
  crypto: hisilicon/zip - move some private macros from 'zip.h' to
    'zip_crypto.c'
  crypto: hisilicon/zip - supplement some comments
  crypto: hisilicon/zip - fix some coding styles

 drivers/crypto/hisilicon/zip/zip.h        |  15 ----
 drivers/crypto/hisilicon/zip/zip_crypto.c | 126 ++++++++++++++++++++---------
 drivers/crypto/hisilicon/zip/zip_main.c   | 130 ++++++++++++++----------------
 3 files changed, 148 insertions(+), 123 deletions(-)

--
2.7.4

