Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220F41E0030
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbgEXPsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 11:48:11 -0400
Received: from out28-219.mail.aliyun.com ([115.124.28.219]:59289 "EHLO
        out28-219.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgEXPsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:48:07 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4019592|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0908685-0.00108902-0.908042;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07447;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.HcyTzUM_1590335272;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HcyTzUM_1590335272)
          by smtp.aliyun-inc.com(10.147.44.118);
          Sun, 24 May 2020 23:47:58 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: Add support for the X1830 and fix bugs for X1000 v9.
Date:   Sun, 24 May 2020 23:47:22 +0800
Message-Id: <20200524154729.30958-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v8->v9:
Add Paul Cercueil's Reviewed-by, somehow his emails are not displayed
on the mailing list and patchwork of clock framework subsystem.

