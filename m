Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED5120E9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 02:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgF3AJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 20:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgF3AJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:09:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D00C03E97A;
        Mon, 29 Jun 2020 17:09:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so9083256pgq.1;
        Mon, 29 Jun 2020 17:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b+IGZ6PpnygOrvzFHrSSaDrACHYYVu9vYgrcmIAaoTc=;
        b=NuiSCbQ0oSqAv7iiF5qikfnPTsQDbEqi6aWPQHuzs/QkcqQ98qHp6wBqkD6XbBmDWk
         e82jReIUedwdHPM2bp/XHgPj8lOQUCRvzlE5Fpg93YgFr7BXdMuQmLA9Auf0CnmqCfnm
         JqZ9ExcPRomIBC5CqFQUyzTuF8/X+2uGLVZykeKD/ezb5WDzVxA3GJnQa5tSDieA2l3W
         /b/GVoFztFSupMHDyP84VziMeiYX9O2gKaU//U6xfzhxTVQ/nkULYGYsHI7BeVlJqsUG
         SJ8ynf2K3TM5BEJl5vWtijOHjiEHHk5dLXkHbfdj0QIOLkyxwKTidE+OD8Lqy/D5SjOV
         RQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b+IGZ6PpnygOrvzFHrSSaDrACHYYVu9vYgrcmIAaoTc=;
        b=lx1V8irN/cGEZ+rHdKEZuhLOZ0WdYw0y7aFBHBT2fDRrbsMFOlq2Rfilygvf6yxwkK
         j+qpSUIbe64RREa0ghk0uNoocPO0cxl74jB3vBHxBwe6v2JPJcTA3wz5XrTFIFWy7Rqd
         EuwPKQa3mdQrwjDkRgNikTkjECemSZmkSTLVNKM4AB8bjtQk/LF8dmZ1PRGTsqjX3ZGx
         COHGFuK3YV/GX6TxepGgzGIuV5B1ulKY8HiY+9wMMuF9o0pMQtRiHvp/+ZzAGkawBhC2
         lQbEFf+TKOGsHEg0WJELvBUyR0AWzTjHP6LZBwpY/xfmMyLWIgYatRbsaCCrWssB69No
         oi6Q==
X-Gm-Message-State: AOAM530XtjthSuB8FNg3zB4EQ3THFeaLUwvbhaEoLeaVWHMYBLX74nND
        ne89VF3TwGcQt/ggqpY7mhI=
X-Google-Smtp-Source: ABdhPJxJlzhlDCwbl4BKRLwMmmx7nhtrQm6pzWRE2A58IuRaPXG5n4u144jDdYNAnyapV80N6ZKJag==
X-Received: by 2002:a65:63ca:: with SMTP id n10mr12762077pgv.252.1593475745495;
        Mon, 29 Jun 2020 17:09:05 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id m9sm754600pgq.61.2020.06.29.17.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 17:09:05 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 3/3] ARM: dts: aspeed: wedge40: enable pwm_tacho device
Date:   Mon, 29 Jun 2020 17:08:51 -0700
Message-Id: <20200630000851.26879-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630000851.26879-1-rentao.bupt@gmail.com>
References: <20200630000851.26879-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Enable pwm_tacho device for fan control and monitoring in Wedge40.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../boot/dts/aspeed-bmc-facebook-wedge40.dts  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
index 1049cfa80ac2..8ac23ff6b09e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -135,3 +135,32 @@
 &adc {
 	status = "okay";
 };
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default
+		     &pinctrl_pwm1_default
+		     &pinctrl_pwm6_default
+		     &pinctrl_pwm7_default>;
+
+	fan@0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00 0x01>;
+	};
+
+	fan@1 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02 0x03>;
+	};
+
+	fan@6 {
+		reg = <0x06>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04 0x05>;
+	};
+
+	fan@7 {
+		reg = <0x07>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x06 0x07>;
+	};
+};
-- 
2.17.1

