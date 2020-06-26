Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EBA20B637
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 18:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgFZQtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 12:49:23 -0400
Received: from out28-123.mail.aliyun.com ([115.124.28.123]:54003 "EHLO
        out28-123.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgFZQtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:49:23 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.7045184|0.7968284;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_system_inform|0.0798443-0.0411612-0.878994;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.HsyHo9F_1593190149;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HsyHo9F_1593190149)
          by smtp.aliyun-inc.com(10.147.41.137);
          Sat, 27 Jun 2020 00:49:16 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        paul@crapouillou.net, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH 0/2] Add functions to operate USB PHY related clock.
Date:   Sat, 27 Jun 2020 00:48:42 +0800
Message-Id: <20200626164844.25436-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add functions for enable and disable USB PHY in JZ4780.
2.Add support for calculat REFCLK of USB PHY in X1000.

周琰杰 (Zhou Yanjie) (2):
  clk: JZ4780: Add functions for enable and disable USB PHY.
  clk: X1000: Add support for calculat REFCLK of USB PHY.

 drivers/clk/ingenic/jz4780-cgu.c | 124 +++++++++++++++++++++++++--------------
 drivers/clk/ingenic/x1000-cgu.c  | 113 +++++++++++++++++++++++++++++++++++
 2 files changed, 193 insertions(+), 44 deletions(-)

-- 
2.11.0


