Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298991A89DA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504150AbgDNSll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 14:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729777AbgDNSlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:41:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DBEC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:41:32 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a81so15411272wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engebretsen.ch; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T5w85/Anw13tnbFJIsbgQbaUb8qEVJINnyZH/cS+SFA=;
        b=jsnljtSlvswR2ovcKd+fXLvdcJQndwCSqeK0GipEcGER4ywfKTkpnJNqj4mcZqIpMR
         2o5ibNYzD0C7iHDKnfXG7hhjArAkjF6s+im2cJuvtdrA3h+9ZlzV5cM/lJo33et812yJ
         IUESe4hIAw6xyL0FSzSgPhcYz4Zi9Gjv4z8Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T5w85/Anw13tnbFJIsbgQbaUb8qEVJINnyZH/cS+SFA=;
        b=AtukCZ/cwp/WKROFL+4udmIv6eTuTPO3Fhmc0L/asqwb3QJBD6VIQQDuQ3fsUyoWmA
         kWaBQ/iLg2Qiu9VXEsgWC8Tsg2SPogoBgskh600LkRYmTOlxlBlPyFhnK//ad8sQStcF
         +ekVMU+bsl/w7MCA+k0AJhSjEoeI42l2bhfDLfn+132AlGyr3kKRRX/Jhd/Xuqh+dZXJ
         O61NIzA20FdGZAZP4FqtC9OidIhvyIpCBhvyubMHu2yMMWPm0CGI8RzjP9i3+7ddt5TQ
         F4HZCNw0nWTd5Xxfq0ATqOHTU1i/HVL7xU6mq1ClEfoRl3IAU292Dy7vEY8lyabpcyjH
         l9vA==
X-Gm-Message-State: AGi0PuZptA4kx+XuRJOkwrUPJ+4fPhQvYdpLeO3gfaTQghCbOsO76GhF
        s5JRbmAEV9322Q+Uv4ayGgdM4w==
X-Google-Smtp-Source: APiQypL+0lwar/HungBo6Fq2I5YAeBElDe10v88NDnRwHd8hW/C6LhUu7ylWSAU9d6M5gPmbyZufuQ==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr1108996wmi.64.1586889691181;
        Tue, 14 Apr 2020 11:41:31 -0700 (PDT)
Received: from server.home ([2a02:120b:2c74:f040:98c9:7cd5:92ab:c7f4])
        by smtp.gmail.com with ESMTPSA id d7sm20095555wrr.77.2020.04.14.11.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 11:41:30 -0700 (PDT)
From:   Lars Engebretsen <lars@engebretsen.ch>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic@kernel.org, Lars Engebretsen <lars@engebretsen.ch>
Subject: [PATCH] iio: core: remove extra semi-colon from devm_iio_device_register() macro
Date:   Tue, 14 Apr 2020 20:41:28 +0200
Message-Id: <20200414184128.22957-1-lars@engebretsen.ch>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lars Engebretsen <lars@engebretsen.ch>
---
 include/linux/iio/iio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index d63884a54939..76ba7c9fd3e0 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -597,7 +597,7 @@ void iio_device_unregister(struct iio_dev *indio_dev);
  * 0 on success, negative error number on failure.
  */
 #define devm_iio_device_register(dev, indio_dev) \
-	__devm_iio_device_register((dev), (indio_dev), THIS_MODULE);
+	__devm_iio_device_register((dev), (indio_dev), THIS_MODULE)
 int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 			       struct module *this_mod);
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
-- 
2.17.1

