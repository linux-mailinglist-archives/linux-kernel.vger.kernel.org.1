Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8692714E8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 16:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgITORM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 10:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITORK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 10:17:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385AAC061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 07:17:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id j11so14300719ejk.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5FMcTfB8bTNiA4IO/9hnI5vPpMpLqnjxtoFBZxrk7cE=;
        b=HmmNZIZZZaq+HVtTbpnhCSx2GGWeZBSkgDQD/ojGBX936B0rBnQrBVe6a2jwUBD/id
         AEfc0Advl1q8swChQgrrhZ8gJZWT+faIQ0qGqMEv6Tf8RzPn+sefcdbWUDA5UgDdo4qe
         kAV1v3RLqfMmCzB/wFc/Sokc1OsRVn6Fnaqfq9SsLsHtseK02ygfBrtAcyvdCHTzTa6b
         OgSJptZy0z58441qrpTmGXgw5NmIRIp+YepIvq6c/7eYU6XmJs3eIEHl+nY9bMw8r6Ck
         DXu+2EaFpk6W5HPx2qHkh10ALrfelFmWKJm+ASfUDGMTUkjxHcw5mpje/906twR4ANim
         7a+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5FMcTfB8bTNiA4IO/9hnI5vPpMpLqnjxtoFBZxrk7cE=;
        b=pImC/70uRgSoHbqjpmOFeABHNwrRG7jkDjxwYrTRwGw7jL2zwhm4SsKvGE36EHqZFd
         QDK3UXZl5Tlit07IsmOAqcIqU7DVtlvAEh982JI5fJA9hV0nucq4rVrLamd6b1qVAS8c
         8oJ3XY8pYTENoMsw5XdZ0jy0E7CNINBba9aGyVKvmx4M8Cx2GoueqkNZJ7yperYkijoO
         i+vGfl505lfl1ccUrKzDrP5GMm4Qml4YF9QHngMniHBeFzRBSgAZ3yQmjNKO/2jiQjyM
         /1uguanXfJe/NpgaLmSlz8bcP8JlrkgdFxbVFUXe3GhTxad8Gu+EH/aMcbyRNTyHxTG3
         DjHw==
X-Gm-Message-State: AOAM531RSIaVeU980Jmw2KJNEa9Ay7f5wCJy/A+O+etnk4yliKurtTEs
        CqGRTANJq7xzsj+fnsgvW742Zg==
X-Google-Smtp-Source: ABdhPJx0dxb5cXtiOZJrCkM5emj4ROEkQ/MFc/4rDyfqAef1IS06joaSvNmlbdT/jHmvQ4+Do4m39Q==
X-Received: by 2002:a17:906:358c:: with SMTP id o12mr44535867ejb.406.1600611428669;
        Sun, 20 Sep 2020 07:17:08 -0700 (PDT)
Received: from localhost.localdomain ([88.207.4.31])
        by smtp.googlemail.com with ESMTPSA id g11sm6631594edt.88.2020.09.20.07.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 07:17:08 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v4 0/2] net: mdio-ipq4019: add Clause 45 support
Date:   Sun, 20 Sep 2020 16:16:51 +0200
Message-Id: <20200920141653.357493-1-robert.marko@sartura.hr>
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

