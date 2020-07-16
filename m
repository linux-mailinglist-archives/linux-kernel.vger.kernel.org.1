Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F86F2224B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 16:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgGPOBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 10:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgGPN7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:59:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633EBC08C5DF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so11699017wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ocpmprgzmWGZxJ5zL5R7ftXluU21C0wPbP88cIep754=;
        b=CZneTPsXS9uqp5nPgc28Vz17b6BEQDi442w3rkHr9tDiPIC8oXfbXnyy5t0zYJaeSB
         iPDQM+PZ7JnYsCFI9kgXY3Wl7QIXxII1h6qVnp3QscfnTSPsOHYxia4UuunI1tgrvD0G
         gayKddwj1Ga4q7iyZP6r/sc5mExi2zmxJZbOE3goJHrkJkHeTrecbIABUECTmnB8ztby
         4vVwtqub+b1iscTXmg4GlsQb5AQdEwTwB1OMqlOHyEWIJR/uHfH4mFJlhQnhDGGtVEMo
         E94XWJGhZP5zbino255dTYXeR1G8COZK0D2sNNWTFgm/ee0VffX8nkeSIyb5VYy8n82/
         cDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ocpmprgzmWGZxJ5zL5R7ftXluU21C0wPbP88cIep754=;
        b=cEd9ENxpF3wE3nWvbrVMMxOrEBQqXu81zkXkw3n8OgkueNbcPtMzaLOGK29vlEoTF7
         Z3UimxNwvjs5Q5uV4/l98pCM6ABv6/69vn2K191Scud6yHB+tstewcmleQ1zgKpEXyoJ
         yhZHoBWhNpG2kh4tCCsHqlaFcqIQlNWQeEVxeiM3Bv0hSEFojqb4PWukrtLuUTpoMDcw
         WCWqD22TlGHIBWXqbNNzBT8fcwekW7tocI/xiZLFhqnXSnkLpgN+9y048xqls29eN3c0
         bzB5239HBaV1zl+f7f3PLvEvHQ950VvO51yj6Yld8qUrs+R8ogD2G4PUtgMfstSIMLLk
         Mvqw==
X-Gm-Message-State: AOAM5315T35/sjpC6XiZrE1SVr1nUY3ZthD6Sxsb7fKSw9HvQsCytvqf
        kdPYKxnq+zRujstwSSeNI2jH/w==
X-Google-Smtp-Source: ABdhPJysvKtOyj2iTio5knKzxJhexTSe2SR/RxB3NYtbN7/a417Z2IcOI3EZ8WcHL2WI8hxW0dYezQ==
X-Received: by 2002:a05:600c:2219:: with SMTP id z25mr4828299wml.154.1594907988041;
        Thu, 16 Jul 2020 06:59:48 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 13/30] iio: dummy: iio_simple_dummy_events: Demote file header and supply descriptions for val2 params
Date:   Thu, 16 Jul 2020 14:59:11 +0100
Message-Id: <20200716135928.1456727-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File headers are not good candidates for kerneldoc.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dummy/iio_simple_dummy_events.c:21: warning: Incorrect use of kernel-doc format:  * iio_simple_dummy_read_event_config() - is event enabled?
 drivers/iio/dummy/iio_simple_dummy_events.c:34: warning: Function parameter or member 'indio_dev' not described in 'iio_simple_dummy_read_event_config'
 drivers/iio/dummy/iio_simple_dummy_events.c:34: warning: Function parameter or member 'chan' not described in 'iio_simple_dummy_read_event_config'
 drivers/iio/dummy/iio_simple_dummy_events.c:34: warning: Function parameter or member 'type' not described in 'iio_simple_dummy_read_event_config'
 drivers/iio/dummy/iio_simple_dummy_events.c:34: warning: Function parameter or member 'dir' not described in 'iio_simple_dummy_read_event_config'
 drivers/iio/dummy/iio_simple_dummy_events.c:123: warning: Function parameter or member 'val2' not described in 'iio_simple_dummy_read_event_value'
 drivers/iio/dummy/iio_simple_dummy_events.c:146: warning: Function parameter or member 'val2' not described in 'iio_simple_dummy_write_event_value'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dummy/iio_simple_dummy_events.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_events.c b/drivers/iio/dummy/iio_simple_dummy_events.c
index b3abaaca6f5ef..63a2b844be508 100644
--- a/drivers/iio/dummy/iio_simple_dummy_events.c
+++ b/drivers/iio/dummy/iio_simple_dummy_events.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (c) 2011 Jonathan Cameron
  *
  * Event handling elements of industrial I/O reference driver.
@@ -107,6 +107,7 @@ int iio_simple_dummy_write_event_config(struct iio_dev *indio_dev,
  * @dir: direction of the vent whose value is being read
  * @info: info type of the event whose value is being read
  * @val: value for the event code.
+ * @val2: unused
  *
  * Many devices provide a large set of events of which only a subset may
  * be enabled at a time, with value registers whose meaning changes depending
@@ -136,6 +137,7 @@ int iio_simple_dummy_read_event_value(struct iio_dev *indio_dev,
  * @dir: direction of the vent whose value is being set
  * @info: info type of the event whose value is being set
  * @val: the value to be set.
+ * @val2: unused
  */
 int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
 				       const struct iio_chan_spec *chan,
-- 
2.25.1

