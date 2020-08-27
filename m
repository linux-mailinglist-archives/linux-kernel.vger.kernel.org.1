Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4799E254577
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 14:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgH0MtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 08:49:17 -0400
Received: from crapouillou.net ([89.234.176.41]:42534 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729097AbgH0Mnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598532195; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=rDzVXd+3PKcewwf2mNEZ0MmfaCChGWVuexHP2Hb/JXw=;
        b=TQqPIETdQ8ngDu7lBLhSkUG4hp36/EevjKVFU9eBJxzVG4Tl4Ks/LMKk2Nm545NVxl8Tee
        rrh4CtOIcX2fZppAzQxoFwqx8SE+WDGYVCy2cqGF4oFpwMNKFYW4xmf8yoG7lb/jR5EKyG
        o/KUtMHc3kMvAb5ejKRMWzhu8tyU/Mc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        =?UTF-8?q?=E5=91=A8=E6=AD=A3?= <sernia.zhou@foxmail.com>,
        =?UTF-8?q?=E6=BC=86=E9=B9=8F=E6=8C=AF?= <aric.pzqi@ingenic.com>
Cc:     od@zcrc.me, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/1] USB: PHY: JZ4770: Next time, please test it
Date:   Thu, 27 Aug 2020 14:43:07 +0200
Message-Id: <20200827124308.71963-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a fix for the phy-jz4770 driver, which is broken in 5.9-rc2
starting from commit 2a6c0b82e651 ("USB: PHY: JZ4770: Add support for new Ingenic SoCs.").

I'm not amused by this, considering that this patch was obviously not
tested, yet it has a Tested-by tag. Next time, please test your patches
before sending them.

Thanks,
-Paul

Paul Cercueil (1):
  USB: PHY: JZ4770: Fix uninitialized value written to HW register

 drivers/usb/phy/phy-jz4770.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

-- 
2.28.0

