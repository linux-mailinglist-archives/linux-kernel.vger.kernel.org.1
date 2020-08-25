Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA6C2513FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 10:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgHYIR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 04:17:58 -0400
Received: from out28-145.mail.aliyun.com ([115.124.28.145]:51304 "EHLO
        out28-145.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHYIRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:17:55 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.250105|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.077471-0.000474437-0.922055;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03279;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.INYD1yr_1598343458;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.INYD1yr_1598343458)
          by smtp.aliyun-inc.com(10.147.41.158);
          Tue, 25 Aug 2020 16:17:52 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenwenjin@gmail.com, sernia.zhou@foxmail.com,
        yanfei.li@ingenic.com, rick.tyliu@ingenic.com,
        aric.pzqi@ingenic.com, dongsheng.qiu@ingenic.com
Subject: [PATCH 0/1] Fix static checker warning.
Date:   Tue, 25 Aug 2020 16:16:53 +0800
Message-Id: <20200825081654.18186-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the warning that appears during Static analysis.

周琰杰 (Zhou Yanjie) (1):
  USB: PHY: JZ4770: Fix static checker warning.

 drivers/usb/phy/phy-jz4770.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

-- 
2.11.0

