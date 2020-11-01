Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396942A1E75
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 15:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgKAOJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 09:09:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20399 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726370AbgKAOJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 09:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604239758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=FtJu5viXRiWAragdM4sGytq5nhMsF7DPJXYjp/+7e9I=;
        b=DdYHa41C2rAQScCy9BRdt9hK+sZIltOKxKIxdseIdnx0RPbc3C2Tcs6OmPNL9zrDwAmxH/
        tnaTZmJpUCJPKUGsKi82w1mIbhyfwTJOzYqIwy8HHkmpmICzYzEcDrjY0m51bQ9hF/W9Ln
        JZIMAm/X/KYBi3kTXkp0WwmwgC84BAA=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-Ck0efhFBMyO6CM1Y6vG3ZA-1; Sun, 01 Nov 2020 09:09:17 -0500
X-MC-Unique: Ck0efhFBMyO6CM1Y6vG3ZA-1
Received: by mail-ot1-f70.google.com with SMTP id k103so4761733otk.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 06:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FtJu5viXRiWAragdM4sGytq5nhMsF7DPJXYjp/+7e9I=;
        b=lFabwhj3KmP9xM9kf4b1EIFy8RNnJBglk2m0HnN65hoV3qLXbX0XCajHJYYmdfX6z0
         lDMsfbWhh84MhNkjmU3EdMjkOx0UVRxBNsoval296M0tCZou5d2TMAAn4yWl21CF8d78
         DDyyav9tnDXzHJPhZNvCNWNdWhnIrbYc3u7BGfdf6mEWmKuS+kmzXOLLEoZElOXOVNYw
         AZBzvmkN5ZUQPMvcBMqlEzlmWVBSpSNcnUwdurtVUpA2414xP62TD20fUIAlToxludB3
         QChe27zKAH/Ac402gcbVHFrBUKIkWe7zm1fcpr8xUfn6ManqThlKxv7u0YJHIU+4QiOb
         iRoA==
X-Gm-Message-State: AOAM530xzPqoOWaYsAqLn6Vg5zVn62OW0E6VbT0tV3F4+C+sUqO/uQIp
        0pOywUSFbr2oti/1/3VuXTaQyCBowGlGdeR9ye4EQGFNSJoItSx6JjGY95aIUkJltXmHa0t4xBb
        aBgXMEUdeM9LJp1IyzCpIy3Om
X-Received: by 2002:a9d:6a0a:: with SMTP id g10mr9007325otn.44.1604239756201;
        Sun, 01 Nov 2020 06:09:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhb4taNtmoBfA8FLCEMNs2fuRmmlHn8iafqln5wwbv/JVDLJMZYFI8QIOBsIwa6Ob4RtMItA==
X-Received: by 2002:a9d:6a0a:: with SMTP id g10mr9007317otn.44.1604239756051;
        Sun, 01 Nov 2020 06:09:16 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c128sm2778508oob.23.2020.11.01.06.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 06:09:15 -0800 (PST)
From:   trix@redhat.com
To:     paul@crapouillou.net, sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] power: supply: ingenic: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 06:09:10 -0800
Message-Id: <20201101140910.2280370-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/power/supply/ingenic-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/supply/ingenic-battery.c
index 32dc77fd9a95..8b18219ebe90 100644
--- a/drivers/power/supply/ingenic-battery.c
+++ b/drivers/power/supply/ingenic-battery.c
@@ -52,7 +52,7 @@ static int ingenic_battery_get_property(struct power_supply *psy,
 		return 0;
 	default:
 		return -EINVAL;
-	};
+	}
 }
 
 /* Set the most appropriate IIO channel voltage reference scale
-- 
2.18.1

