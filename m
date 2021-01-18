Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCA12FA546
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405858AbhARPy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405905AbhARPxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:53:33 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BA7C061757;
        Mon, 18 Jan 2021 07:52:52 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hs11so22020109ejc.1;
        Mon, 18 Jan 2021 07:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6NAvJviXVZqdWGL+2+dI4d8031tgmcjGj8ZKOUc0HB8=;
        b=rWYkNV5HGZ5dU9sQCsht4/cxGBzMDcOf1sp4XBycj3BiD6FU3KOV3sbPeEVjD75rWc
         /DNHtNSJB7eII5qvyYyabeXL3FcIz98InMwGyHBs9mhtpspEK//FQ0lEqO3aO3nJ/Awx
         zFcTa97JWMC7MqL18mI6Fuj59PdQAY5au1I4t3qnBnie10AV9iE8fKhEsC6WqY9efPQG
         DWo418IkDLmwUE/QEUuyBelqX2OvOcQfNzPmCIRBIB49BXG2LJ3cqC/a6H45NG91mVCy
         HXLIM9v+1pIoTVc04Q9gwsX8mOAPv60CBw6jyKWg+Wlp4G9ALl7yZgSdtDjAu/yIkm7r
         5Q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6NAvJviXVZqdWGL+2+dI4d8031tgmcjGj8ZKOUc0HB8=;
        b=t/fQUcN6dB0lmqS7cRUgNdNseBZzKvJAy6mYeZcwc8Hg0uXaR4H/SmULvLDc2s/luv
         fCVOzzFj+4dYdiP4uFmULqTxFDibnEAX1geSuB+vh/fkspf4Vm9r8hVFe4Jahs4TETJG
         Duahi3xMFTUoejq5oMqDSBPAny+nFMLO3e7Lf/SjrX7XOe9Xa6PTOamE07Egw1FvU+Ws
         BCTnY0gEmigVY1EEfGQODV2IC430ymtQ9/p37RY3wqaGCVBs4YVBkTc2NiPndeIWL1/j
         4eogNR+eo5CBByjT52ZZGmEBiY+4RaMRIOaVC1MVa9C4+oBzxY7qehzibmPK2zUUunsZ
         3ZpQ==
X-Gm-Message-State: AOAM533JcwW2E+a/cKfBZOshacKkviIhkQiJrnFsmbUxTb10wJxq/fvI
        7rgPMShlDErMm21vT85Y3bY=
X-Google-Smtp-Source: ABdhPJzQXHpE4mBL3eBAs7p3pXkRjMXNWmwTKN+Fsv5dFw3ptmhIIaEeAmwQLKPO45KskZDycYJbJA==
X-Received: by 2002:a17:906:ca08:: with SMTP id jt8mr220991ejb.368.1610985171523;
        Mon, 18 Jan 2021 07:52:51 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f13sm9561694ejf.42.2021.01.18.07.52.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 07:52:50 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ARM: dts: rockchip: assign a fixed index to mmc devices on rv1108 boards
Date:   Mon, 18 Jan 2021 16:52:39 +0100
Message-Id: <20210118155242.7172-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210118155242.7172-1-jbx6244@gmail.com>
References: <20210118155242.7172-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently introduced async probe on mmc devices can shuffle block IDs.
Pin them to fixed values to ease booting in environments where UUIDs are
not practical. Use newly introduced aliases for mmcblk devices from [1].
The sort order is based on reg address.

[1] https://patchwork.kernel.org/patch/11747669/

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rv1108.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index bec47e0be..a754851f4 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -19,6 +19,9 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
+		mmc0 = &emmc;
+		mmc1 = &sdio;
+		mmc2 = &sdmmc;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
-- 
2.11.0

