Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F05D224585
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 23:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGQVAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 17:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgGQVAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 17:00:21 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FBBC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 14:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qYoU5Y/zLsrXkJq9U4RfXTDC4zNRBe8Z7Hb20eSgPnQ=; b=AwxyDNiB6H5WBPPp7/Avl8CTcU
        fnaotue3qZeyoXrwpReCXm0S5MGXyUmikphXpWA5uyoO/14KCjV3vuTZo5IaeaCwIwZiyMUGkUQuP
        WPgZr5wDxXYpyQZypc//Zbds8CGN0KiyfNSg5yRc8HlBaG5oieq5Ug80BmQ+liokmM1g=;
Received: from p200300ccff0b8f001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0b:8f00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jwXSs-0007vJ-32; Fri, 17 Jul 2020 23:00:18 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1jwXSr-000788-KQ; Fri, 17 Jul 2020 23:00:17 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org, phh@phh.me,
        stefan@agner.ch, b.galvani@gmail.com
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] mfd: rn5t618: Fix caching of battery related registers
Date:   Fri, 17 Jul 2020 23:00:02 +0200
Message-Id: <20200717210002.27366-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Battery status changes dynamically, so the corresponding registers
need to be considered volatile. Affected registers are:
- fuel gauge
- battery status
- battery interrupt

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/rn5t618.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 232de50562f9..55c47e555dd8 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -44,6 +44,9 @@ static bool rn5t618_volatile_reg(struct device *dev, unsigned int reg)
 	case RN5T618_INTMON:
 	case RN5T618_RTC_CTRL1 ... RN5T618_RTC_CTRL2:
 	case RN5T618_RTC_SECONDS ... RN5T618_RTC_YEAR:
+	case RN5T618_CHGSTATE:
+	case RN5T618_CHGCTRL_IRR ... RN5T618_CHGERR_MONI:
+	case RN5T618_CONTROL ... RN5T618_CC_AVEREG0:
 		return true;
 	default:
 		return false;
-- 
2.20.1

