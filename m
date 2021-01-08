Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F872EF48E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbhAHPL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbhAHPLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:11:22 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598C5C0612EA;
        Fri,  8 Jan 2021 07:10:42 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id t16so14833870ejf.13;
        Fri, 08 Jan 2021 07:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vZOTFs+GSq43b4H42olR+ZkGo+YlvQdilb2TDtquzLE=;
        b=vVxqQk3bdtJksJdwvzMXejO7m0yN1/Vx06weqhblC8MsNr1fEMmK/oVBrLjmXxrsSV
         ml1MbGS+hBeV+J1lK6OcnabQwC6LOBbykCTlRDWuwUOUiJKvJSGl7hh4G32F8VNtwjl9
         fdCCtQO46S+2xgO0e6fSBh60PDVUvAZRtFhM8mr/jRey+wg/MsOWLP/p0i9tZqX0AA86
         TKP/B4jE1hsj4jkjnQ8U9GVvGBNcZ7DJsvmZ5TlTlkHMxk0afwfsd52IrqF43GAAdm+A
         bmBaerGtM7CRDiDcj73vAeMzht8XUCHsvXTA97bTYLyOnRdPQtK9mt89YOIgxwhJiMWe
         7zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZOTFs+GSq43b4H42olR+ZkGo+YlvQdilb2TDtquzLE=;
        b=Jo4vXoG9jXk+EDHx4qC8k8GFjf07C7zwijwGsC7zuDzvJDlHIyoxjZ/RoKgYbCYorn
         1FJ5ie7/C6/kEk+Hg1k7CJNnh+9b5ArGwZ5ib6tnhnvYoVaIf/BmyYo24zHHP5r4mrxP
         nxVqKfb235+tliOvYS7C9I7Y8CaFoGB5meg2hTTCorH4gBj0N1swjbAt1MHylVDnIOUD
         LwtC9naCb6Bj5TXHk4YffWkbdN9ixMdHmwIk5GboU7Z+vVJYATUSTqfVNk/QWQevR0L3
         NBUC1e+q7La0Ngs46Q1jE2cQe+Ubj73fdFaHyd6FTW76VH2u6CAaFIIRjXXGl6MnXvia
         XO5g==
X-Gm-Message-State: AOAM530qM5/37P7MN95+SMZYZ4xzNQb0iIYNJV8Xss5nyj/xrUlu2rJG
        9ijuGsBpIBbeze4gp15n/A==
X-Google-Smtp-Source: ABdhPJz236p0cdxk+4FzSFD+agoDp6O23F/mFGHfnmO5aftxpFsarP5XYeqVtFafYZ+n1yntMdagzg==
X-Received: by 2002:a17:906:81d6:: with SMTP id e22mr3026604ejx.476.1610118641153;
        Fri, 08 Jan 2021 07:10:41 -0800 (PST)
Received: from demetris-TA770E3.lan ([212.50.117.154])
        by smtp.gmail.com with ESMTPSA id oq7sm3669286ejb.63.2021.01.08.07.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 07:10:40 -0800 (PST)
From:   Demetris Ierokipides <ierokipides.dem@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Demetris Ierokipides <ierokipides.dem@gmail.com>
Subject: [PATCH 2/2] ARM: dts: rockchip: add extra cpu opp points to rk3288-miqi
Date:   Fri,  8 Jan 2021 17:10:36 +0200
Message-Id: <20210108151036.36434-3-ierokipides.dem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108151036.36434-1-ierokipides.dem@gmail.com>
References: <20210108151036.36434-1-ierokipides.dem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add extra 1.7GHz and 1.8GHz opp points to the MiQi device-tree to improve
performance.

Signed-off-by: Demetris Ierokipides <ierokipides.dem@gmail.com>
---
 arch/arm/boot/dts/rk3288-miqi.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-miqi.dts b/arch/arm/boot/dts/rk3288-miqi.dts
index 713f55e143c6..1b48855db6ff 100644
--- a/arch/arm/boot/dts/rk3288-miqi.dts
+++ b/arch/arm/boot/dts/rk3288-miqi.dts
@@ -96,6 +96,18 @@ &cpu3 {
 	cpu-supply = <&vdd_cpu>;
 };
 
+&cpu_opp_table {
+	opp-1704000000 {
+		opp-hz = /bits/ 64 <1704000000>;
+		opp-microvolt = <1350000>;
+	};
+
+	opp-1800000000 {
+		opp-hz = /bits/ 64 <1800000000>;
+		opp-microvolt = <1350000>;
+	};
+};
+
 &emmc {
 	bus-width = <8>;
 	cap-mmc-highspeed;
-- 
2.25.1

