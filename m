Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D5B2DE310
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 14:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgLRNFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 08:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgLRNE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 08:04:58 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F60EC061257
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 05:03:42 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g185so2468733wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 05:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W7MQknUNgfLi/fumFEQOeiLKRWIy/aG8D1EJYUy6tL8=;
        b=HGyhDl2UaSIO9RLlK8B99clY+T5Wo1ifMvC+HbSGiM+D6fE5cC5+YFiwGJDKus9dU8
         8UE6RB6oHdSqUjh54tsxi08f01JYQL8e6YfFgnjlIUhZs0mTioYca+OS8KiYDX0eHU0F
         jS+zA4FMt5yLgwDOQYIGWlhDGLvMQorSny2aKgFnc88dPKPSZIaP6rWSNI5R82iufUbU
         qXguz97wMjtxbnFNBk5MAGNQL70o+XdDvN2xQSBbHlvsrEbQcN1Y9Mv/usNC7JaB0fxU
         PqLDimdNfHYsZEZ3KTMB0c4zmuPIlH0TO3S39skzRFGdEZ7qdFNBQJuTlLuFd4DUs2JH
         fz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W7MQknUNgfLi/fumFEQOeiLKRWIy/aG8D1EJYUy6tL8=;
        b=Jqcz8Sk271VmcJ/e8iUuDnJF60HJcPDcEfJ8FJtlH9PYuDHhFiAlYr+8GaMlf2DFFW
         DNslwi1Ix1+S9qri94ZoHbX5Mvz1FF57W0fis+XEhN91KBVJgcqnXgS3F2Jt8F6QD882
         hZ3OIaJJk16EX2Cuh8B97VSqUhzKCUVTPlmUmn8U2A0n8aiN32yXQxVk/BOsDJtKFoMO
         4XUdInRHLezhXS73ZJpx+YkeRLV8H9z+hBoQtbkkWIYqEiAxtdvAywBi6qMcWGK1rpDC
         Rq6fb8gMnYsgknyEY88Jh/k+rW/sP775Jh5E4VCLemkOT8kcD8RHTJ+iRBrGOPs+ITBA
         mp4g==
X-Gm-Message-State: AOAM530lw6ye1EXUz3DXpbBtozcaOdo3srHc873zys3SbmPwWHU5M9if
        NVAQhPX0Zy/vAgpPWW62LDg+cQ==
X-Google-Smtp-Source: ABdhPJx2RV1GzhO+KSOtP2FIYANLwsmTin3968ImAOn9rJaC+fcjObllvyq2p6Oyn9BDPS4wO7dCNg==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr4065059wmi.83.1608296621351;
        Fri, 18 Dec 2020 05:03:41 -0800 (PST)
Received: from localhost.localdomain (dh207-99-82.xnet.hr. [88.207.99.82])
        by smtp.googlemail.com with ESMTPSA id l1sm13945720wrq.64.2020.12.18.05.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 05:03:40 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH 3/3] MAINTAINERS: Add entry for Texas Instruments TPS23861 PoE PSE
Date:   Fri, 18 Dec 2020 14:03:29 +0100
Message-Id: <20201218130329.258254-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218130329.258254-1-robert.marko@sartura.hr>
References: <20201218130329.258254-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers entry for the Texas Instruments TPS23861 PoE PSE driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 830244166a7c..5441be7a5c26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17336,6 +17336,14 @@ F:	include/dt-bindings/soc/ti,sci_pm_domain.h
 F:	include/linux/soc/ti/ti_sci_inta_msi.h
 F:	include/linux/soc/ti/ti_sci_protocol.h
 
+TEXAS INSTRUMENTS TPS23861 PoE PSE DRIVER
+M:	Robert Marko <robert.marko@sartura.hr>
+M:	Luka Perkov <luka.perkov@sartura.hr>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
+F:	drivers/hwmon/tps23861.c
+
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
-- 
2.29.2

