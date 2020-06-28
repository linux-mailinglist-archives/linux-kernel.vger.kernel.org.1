Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E71820C92C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 19:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgF1RSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 13:18:18 -0400
Received: from out28-221.mail.aliyun.com ([115.124.28.221]:58010 "EHLO
        out28-221.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgF1RSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 13:18:17 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4525175|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0220848-0.000517743-0.977398;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03307;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.Hu3fckw_1593364687;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Hu3fckw_1593364687)
          by smtp.aliyun-inc.com(10.147.42.197);
          Mon, 29 Jun 2020 01:18:13 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        paul@crapouillou.net, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v2 0/3] Add functions to operate USB PHY related clock.
Date:   Mon, 29 Jun 2020 01:15:40 +0800
Message-Id: <20200628171543.51478-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
1.Use "WARN()" instead "BUG()".
2.Move the reformat part ot the new patch.
3.Remove unnecessary get_parent/set_parent functions.

周琰杰 (Zhou Yanjie) (3):
  clk: JZ4780: Add functions for enable and disable USB PHY.
  clk: JZ4780: Reformat the code to align it.
  clk: X1000: Add support for calculat REFCLK of USB PHY.

 drivers/clk/ingenic/jz4780-cgu.c | 155 ++++++++++++++++++++-------------------
 drivers/clk/ingenic/x1000-cgu.c  |  85 ++++++++++++++++++++-
 2 files changed, 165 insertions(+), 75 deletions(-)

-- 
2.11.0


