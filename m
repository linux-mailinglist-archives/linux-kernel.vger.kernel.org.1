Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7522DF13B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 20:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgLSTNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 14:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgLSTNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 14:13:08 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB3DC0611C5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 11:11:33 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id x16so8016900ejj.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 11:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W7MQknUNgfLi/fumFEQOeiLKRWIy/aG8D1EJYUy6tL8=;
        b=JxoBhYkTL2ZHpGI0Ze8E4247eAu83x00wW3etACBj6rJ6kRaZ3IM31SrX2Im0jgzm4
         DtolModXybBqIsRpgO5soGVkCddReHwa45NQKna8wF3i90a1pCL0ZBCElRVfNI+rtO0E
         4l6BIQp1KGCvT5Ml3w/343xjYUs/VupLFoBQ0XvCZkd56XH3ysXsHpso1Gvjp6SM6fWv
         IdGFMPBndXolvI1W6klpXS2+fkY/d2Y9aDQSY/5e7VO9iFLv5GZS9MPxcwp+YIczDH54
         m8CFQF29dB6rGLip59peeUAqmr1BWkRId6d2ZliJFVNtVxF5A/8XpkURpCy0EGanBo63
         REkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W7MQknUNgfLi/fumFEQOeiLKRWIy/aG8D1EJYUy6tL8=;
        b=hZkS7k95f7tqJcjELWGcIa+7KL8NJsdmumSN1T5p55Jxhg8VdvFB98mgsRror128NZ
         F45VjpDqr9fOFHIC/dj3seS73ijuvs2o7g+zz3vDt/SNc3HhofysXu1ZZJtkr0Bc17b8
         zZfrS28eUwYo13P5iKQTHc8LAzlrYns0bFt94EiMunlGTQjjcbOxb7G3cogVDd+fhkjr
         CvgHMeVeP/7C1pQwcDee2qT5fWiESo3D+sUfzdxIl+cK3zVNvgry6MjuysZeB9bDdfcU
         hlRKjfK6WeRbYTm+Rw8mQVgLVC6AlIwP/AEKwFVKVO+4AfP/FiIUzWUmQP9os56D49/4
         557g==
X-Gm-Message-State: AOAM533gxygcURBy5I6JpNssvYEpWybspHFuFAJsI58Xn7CEn1dsTGsO
        oluv+p0RfG7OM2w0ZjixT6meqg==
X-Google-Smtp-Source: ABdhPJzDphxy2HHNe5npeVq3Rsq94sKB2aYn/L2GQrQHnieu1+ACIFt0Wd7e26z95PzpRlgxz4YS0w==
X-Received: by 2002:a17:906:7c49:: with SMTP id g9mr9495383ejp.185.1608405091966;
        Sat, 19 Dec 2020 11:11:31 -0800 (PST)
Received: from localhost.localdomain ([88.207.4.44])
        by smtp.googlemail.com with ESMTPSA id o10sm7081955eju.89.2020.12.19.11.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 11:11:31 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH v2 3/3] MAINTAINERS: Add entry for Texas Instruments TPS23861 PoE PSE
Date:   Sat, 19 Dec 2020 20:11:21 +0100
Message-Id: <20201219191121.85142-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201219191121.85142-1-robert.marko@sartura.hr>
References: <20201219191121.85142-1-robert.marko@sartura.hr>
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

