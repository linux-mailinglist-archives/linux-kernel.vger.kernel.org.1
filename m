Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6447E1D1459
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 15:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbgEMNRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 09:17:24 -0400
Received: from out28-99.mail.aliyun.com ([115.124.28.99]:53561 "EHLO
        out28-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgEMNRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:17:23 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.417985|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.046916-0.000501624-0.952582;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03306;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.HY0oTOn_1589375829;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HY0oTOn_1589375829)
          by smtp.aliyun-inc.com(10.147.41.120);
          Wed, 13 May 2020 21:17:18 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: Add support for the X1830 and fix bugs for X1000 v8.
Date:   Wed, 13 May 2020 21:16:37 +0800
Message-Id: <1589375804-78423-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v7->v8:
1.Rebase [3/6] on top of linux-next, because "ingenic,cgu.txt" has
been converted to "ingenic,cgu.yaml".

