Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBC62F8654
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388709AbhAOUKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbhAOUJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:09:57 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111D1C061795
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:09:17 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id g10so8645788wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ruuzqVcibszll2eFO33TUxrB4tXdgXcWaZZEtfFtK0U=;
        b=K0QIJJrtbTVVGnm0417IN5WqEh5ppaxUlhR0OqXfdBdbiKbbRwer5uHYKYJTtXAktz
         gZZZbU8CVeAvuoa7EVilbQ8aU8UYprMBp5p4uFXlXWES8OaLPrh/7vL3XPX0+52nQF+u
         q9GKE9sELVG7doX8KkvQ0b023p8qEDOF8KJPtEERAgZnhE+A5t0UHh15EIcRYASV5oix
         HLry1ARTaBQiDDOB3mDQuMcltIu00Xjswrs8gGEQTjmXfkBz65sq1E82JK49LYpUh5wE
         QkXeVB5s/d03vawDvs/XAtoNa5DI0QNCH8+HYQTP2g5sg1Xt+5qJ2XKUJfHyxCQkhMX5
         WKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ruuzqVcibszll2eFO33TUxrB4tXdgXcWaZZEtfFtK0U=;
        b=UqEIa2aRIMuxBC115rIOCGQWk+z0269MPckqWjlXxY6BYO3sI7vP3GCSz/nEeC4ryl
         zSCDFhfjTlsJlXZz3UmjYXwT4c3vh462BvoDcf3DzROxIHclupX3Da8yYwVJgz3UXVsR
         eqOmGg7DK5pziion3aKdDuZue2WFQRfgnTS0gawQGJzElvoLFJuBWzXQX345m4uttVCH
         BPKkHVa3NJxcjzEJOSqqpKkpOeah0yFyOSFkHPr4F/7UCMI8sFp/1hyW2PcNEACTtgol
         riKmjMyhj7DJY8IwJvO5rNM2jqvSK2+WcBYrKVZxwHyLTiKbWPsfiEwYPNr33qok1Trw
         M76Q==
X-Gm-Message-State: AOAM530XO8MB0UdJW+5RM4YMKGH94GS6oYdDyyvhCKizCPYb3YhqJHTa
        dwP91IB+RaDywg5dUgv9KvT4jg==
X-Google-Smtp-Source: ABdhPJyIVEMVjS5hMhLba5F7K9JoJZEJMSH0rgqKM8y1qiS+nYVk9WQFhlY8h5yAtTzIG7AtQI2JNg==
X-Received: by 2002:a7b:c415:: with SMTP id k21mr8222932wmi.96.1610741355781;
        Fri, 15 Jan 2021 12:09:15 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id d85sm9187863wmd.2.2021.01.15.12.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:09:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Erik Stahlman <erik@vt.edu>,
        Peter Cammaert <pc@denkart.be>,
        Daris A Nevil <dnevil@snmc.com>,
        Russell King <rmk@arm.linux.org.uk>, netdev@vger.kernel.org
Subject: [PATCH 1/7] net: ethernet: smsc: smc91x: Fix function name in kernel-doc header
Date:   Fri, 15 Jan 2021 20:08:59 +0000
Message-Id: <20210115200905.3470941-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115200905.3470941-1-lee.jones@linaro.org>
References: <20210115200905.3470941-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/ethernet/smsc/smc91x.c:2200: warning: Function parameter or member 'dev' not described in 'try_toggle_control_gpio'
 drivers/net/ethernet/smsc/smc91x.c:2200: warning: Function parameter or member 'desc' not described in 'try_toggle_control_gpio'
 drivers/net/ethernet/smsc/smc91x.c:2200: warning: Function parameter or member 'name' not described in 'try_toggle_control_gpio'
 drivers/net/ethernet/smsc/smc91x.c:2200: warning: Function parameter or member 'index' not described in 'try_toggle_control_gpio'
 drivers/net/ethernet/smsc/smc91x.c:2200: warning: Function parameter or member 'value' not described in 'try_toggle_control_gpio'
 drivers/net/ethernet/smsc/smc91x.c:2200: warning: Function parameter or member 'nsdelay' not described in 'try_toggle_control_gpio'

Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Erik Stahlman <erik@vt.edu>
Cc: Peter Cammaert <pc@denkart.be>
Cc: Daris A Nevil <dnevil@snmc.com>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/ethernet/smsc/smc91x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 742a1f7a838c9..891b49281bc64 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -2191,7 +2191,7 @@ static const struct of_device_id smc91x_match[] = {
 MODULE_DEVICE_TABLE(of, smc91x_match);
 
 /**
- * of_try_set_control_gpio - configure a gpio if it exists
+ * try_toggle_control_gpio - configure a gpio if it exists
  * @dev: net device
  * @desc: where to store the GPIO descriptor, if it exists
  * @name: name of the GPIO in DT
-- 
2.25.1

