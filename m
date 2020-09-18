Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C018A270780
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgIRUwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIRUwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:52:32 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCEBC0613D0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:52:31 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e11so7459495wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5FMcTfB8bTNiA4IO/9hnI5vPpMpLqnjxtoFBZxrk7cE=;
        b=xZbdn2brp8iJKt3mCiCe80a1m4D8Lb5T70pNABO2DKRoI+Br9p6grk2AdI3QUBUGH2
         YOog8mw90sa9mYVJz75XfhY1Bn7/c/jcWPSOnjvpPnQCq7kS9AX/1MXQPj7Gw4SPyiVj
         CXbQH6EYHJgGD0Eg5/Nmur2erzRkJ2CFwM/rughEpsc8ouzngFNj1DnT1RNvlhge5T/J
         wkouoURDrYk0U8YQQeV0j+sAUu7Ex8vHgbvi7ACtNnRFD02UhFkA6DzAqcLcJzF04gvT
         XYAI7CC1JQyTGFYwVtJsBX6cu91CrzeMPBVHEHVyDYMqAOxfkXVCBI4e9LLl1z2lHCXh
         0zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5FMcTfB8bTNiA4IO/9hnI5vPpMpLqnjxtoFBZxrk7cE=;
        b=bSsbwKrG3O8bIYrEyCf8t6rn8c4wafyrAi1IutTGx8nPTcgCGjMdXPuUJJD7HWHRIG
         a7MKRlXBdhjZPjbucsEHn0dC6OOuU0Oj5r6htaJgj0XKmpl/xmCOpuVs1oBRhwx+7Mei
         W1rHUpcUtfI6Oia8IISFOI1vrAHeAcGgWpz/55E9y6vD2BvbgCoFgsC3zDzbMXks8ygk
         Rk8kF5FNF1Uheoholtb6t/FsjQIBzP2IBGnfEB+WqEfUJsx/9TbOf09YVn+C+Zs4a10s
         cNSSJvZd7kuYsVV5XFqID5lAw4O8MqIdx2ShDQSdgr3IHuwqiilqMuP2W2dod8lGgnDr
         +Gag==
X-Gm-Message-State: AOAM5326vqbxkbpRvKjlYYF6SCWuv1hbIuJw5B0VKtk9pX1EKnr4/k1k
        X2dhGZlbGJJfHZghtCdN5pUtTg==
X-Google-Smtp-Source: ABdhPJz1s7iaFLlprcjzI6+V5+IneVUiLhkPjcqU9oGnTUsJuwN91xmDsjAo3grsZUsi2FAriERYNA==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr18211963wmb.155.1600462350313;
        Fri, 18 Sep 2020 13:52:30 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-14.xnet.hr. [88.207.97.14])
        by smtp.googlemail.com with ESMTPSA id z19sm6694041wmi.3.2020.09.18.13.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 13:52:29 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 0/2] net: mdio-ipq4019: add Clause 45 support
Date:   Fri, 18 Sep 2020 22:52:20 +0200
Message-Id: <20200918205222.2698102-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Clause 45 to the driver.

While at it also change some defines to upper case to match rest of the driver.

Changes since v1:
* Drop clock patches, these need further investigation and
no user for non default configuration has been found

Robert Marko (2):
  net: mdio-ipq4019: change defines to upper case
  net: mdio-ipq4019: add Clause 45 support

 drivers/net/phy/mdio-ipq4019.c | 109 ++++++++++++++++++++++++++++-----
 1 file changed, 92 insertions(+), 17 deletions(-)

-- 
2.26.2

