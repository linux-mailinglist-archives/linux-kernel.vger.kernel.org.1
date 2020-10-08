Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AA8287189
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgJHJbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:31:41 -0400
Received: from out28-122.mail.aliyun.com ([115.124.28.122]:49084 "EHLO
        out28-122.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgJHJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:31:41 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2499754|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0117215-0.00453429-0.983744;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.IgbT2aG_1602149484;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IgbT2aG_1602149484)
          by smtp.aliyun-inc.com(10.147.40.2);
          Thu, 08 Oct 2020 17:31:38 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] Add dmaengine bindings for the JZ4775 and the X2000 SoCs.
Date:   Thu,  8 Oct 2020 17:30:58 +0800
Message-Id: <20201008093100.88405-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dmaengine bindings for the JZ4775 SoC and the X2000 SoC from Ingenic.

周琰杰 (Zhou Yanjie) (2):
  dt-bindings: dmaengine: Add JZ4775 bindings.
  dt-bindings: dmaengine: Add X2000 bindings.

 include/dt-bindings/dma/jz4775-dma.h | 44 +++++++++++++++++++++++++++++
 include/dt-bindings/dma/x2000-dma.h  | 54 ++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 include/dt-bindings/dma/jz4775-dma.h
 create mode 100644 include/dt-bindings/dma/x2000-dma.h

-- 
2.11.0

