Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0A527079A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgIRU4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgIRU4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:56:41 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8566C0613D0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:56:40 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so6841087wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5FMcTfB8bTNiA4IO/9hnI5vPpMpLqnjxtoFBZxrk7cE=;
        b=qcmtt6kWrvx7k2QXabW17gKwfCLKlGN7MuLc+YURLF3y8JXAUupyBXOWPXzkOgERbd
         heeBiEW3ckdFgeef0CSxlO0KtTGJyCZaSvzAhOvhG3zYvWbJPbI5yMwKN8nZrtOObvNU
         EFfpfdmivw7K23hKCFr3u8dgqBnonLw60yviyWEGBRhij5x2Sh2mshRSDU8YePF1rOSX
         aufFYW2i4xmv1RqpXOiLpN3mPPuFd2/A7rSbYVdI7KpyYVyCeVMFBJhWxma+qfnzw4W+
         ZkxjFzBtR43RbJ84MAq6elE6PZsg7F2l2Xv5N12JZ8zDFv4ME7WO/RHJNwQ9F42D5ifI
         scbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5FMcTfB8bTNiA4IO/9hnI5vPpMpLqnjxtoFBZxrk7cE=;
        b=NdX64f0sDv0Ss5v4vbSQtELGrVviSJOk9jRx1tlhYcrhYu+E+PjHjcOJqu13V5HH4+
         /6niwoLZlN8enqwmeflStvZh5FLagv2m9oGlSgU/I60AJQw4V40uuYlvYxbxyRjGjxN8
         RUVNnlm1V8r6PiGewgTQ1Zg0gqqowsxxTInee6V0D2ALxNnGsqaY06XB1GY9TLr90FvI
         ru7p3BtM0f7pPS3BoHENw8XSe13UnH/cgPE9Bv37w3/+vv4WdlboXUcuahdEIz9DLGvb
         TNNvYZy8YAYl91e2ks5lXv2y7vmLUa8b+WObcFxY2bpcQ9a/kSTHjjDjLaWURGAqG16W
         hTyw==
X-Gm-Message-State: AOAM532mCxndbixh5IhW7AKtaBIp/SsOoHAvyuv9Qh8CtSdnur38ZFJ4
        IoM6LAG1XQse6b9TfqTRZmSvpw==
X-Google-Smtp-Source: ABdhPJzhy9TPwdBBkuXxPyaO8NB4E6vvhIn4upUGvLx5IuAD7USpHZ5JEqUfW7aw5bNhdX0/RP/s0g==
X-Received: by 2002:a1c:f20b:: with SMTP id s11mr17966461wmc.144.1600462599324;
        Fri, 18 Sep 2020 13:56:39 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-14.xnet.hr. [88.207.97.14])
        by smtp.googlemail.com with ESMTPSA id a17sm7661875wra.24.2020.09.18.13.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 13:56:38 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 0/2] net: mdio-ipq4019: add Clause 45 support
Date:   Fri, 18 Sep 2020 22:56:31 +0200
Message-Id: <20200918205633.2698654-1-robert.marko@sartura.hr>
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

