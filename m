Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D922F947B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 19:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbhAQSR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 13:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729972AbhAQSQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 13:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610907329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kLX4rjXMuZVOcW60dYfHUGcg3ri1M4DH6zvIU3aqXdA=;
        b=EHrRWcTl5z79p+e9rGdsp21TE2djxaasZyGFygwTRhKa0HogF/Sn5He3Rslx/IDX0Q1Bq/
        txm/ctCmdCIe+S/ImxdWzLP636y+niD0aMzARS+iz9mAtNKUk9xEI4G9AUd28C0Jr89XwF
        UYZI8MqgBbmNlWdsTty3UE3FdVcAkQk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-jdMByf4qPBussY1cjgcxRQ-1; Sun, 17 Jan 2021 13:15:25 -0500
X-MC-Unique: jdMByf4qPBussY1cjgcxRQ-1
Received: by mail-qv1-f69.google.com with SMTP id c2so14105241qvs.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 10:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kLX4rjXMuZVOcW60dYfHUGcg3ri1M4DH6zvIU3aqXdA=;
        b=FIYCSdwe9tdBz6El3X3PSLblgDJzSqwLarM1NjEpHprpabqeV2Hnj7faZHaTnWjCbs
         /3+XhqLMMgtwmt0NIKS0h9D2Bh9qq9lUp3G2DdfCxawejhVW8du8TIJFBnPqSCdyadHG
         qYvgb4ce1pzHiAsIrqEyeOVZ5IHvnpSOIA6FgabfsfNchcqhlDfUtgZragnlSWws2klQ
         Q4nc2MzcWJBcMgRcU8OM3ORp1smF6PvqcU1GrgvidFhBXplZh4G5H/rTLBMYuRrf0Ubk
         rzrZeutX4nZ1s2i8yNQKVHv7DGVmLCAq8Nv96uvNQfQ2VIgYAFTZfE6HOUNkWh3H9+55
         2R0Q==
X-Gm-Message-State: AOAM533QDJOW2XSi2P1zRINVww45jdrVcgSdxqfefHQ4dyAzmbEBZOI5
        NHvRPoabIz/JmhZIYgMYFHZzvr+JgWJnbf8nalvrmmeXMKBrEeZH6hWBQ9quk5O0AlkeEnyKGI2
        YMhx1nGk6HKzn4yEUZ1V+Dp3m
X-Received: by 2002:ac8:5cd0:: with SMTP id s16mr19657117qta.309.1610907325208;
        Sun, 17 Jan 2021 10:15:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHA5Uu0gpa8XxDScZXYLEIxNiq80IwCQ7L2RmuyrJGlG8Qx5Pax5Bfhqa3+05laLR+7+KNtA==
X-Received: by 2002:ac8:5cd0:: with SMTP id s16mr19657095qta.309.1610907325012;
        Sun, 17 Jan 2021 10:15:25 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l191sm9315956qke.7.2021.01.17.10.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 10:15:24 -0800 (PST)
From:   trix@redhat.com
To:     m.grzeschik@pengutronix.de, davem@davemloft.net, kuba@kernel.org,
        joe@perches.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] arcnet: fix macro name when DEBUG is defined
Date:   Sun, 17 Jan 2021 10:15:19 -0800
Message-Id: <20210117181519.527625-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

When DEBUG is defined this error occurs

drivers/net/arcnet/com20020_cs.c:70:15: error: ‘com20020_REG_W_ADDR_HI’
  undeclared (first use in this function);
  did you mean ‘COM20020_REG_W_ADDR_HI’?
       ioaddr, com20020_REG_W_ADDR_HI);
               ^~~~~~~~~~~~~~~~~~~~~~

From reviewing the context, the suggestion is what is meant.

Fixes: 0fec65130b9f ("arcnet: com20020: Use arcnet_<I/O> routines")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/arcnet/com20020_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/arcnet/com20020_cs.c b/drivers/net/arcnet/com20020_cs.c
index cf607ffcf358..81223f6bebcc 100644
--- a/drivers/net/arcnet/com20020_cs.c
+++ b/drivers/net/arcnet/com20020_cs.c
@@ -67,7 +67,7 @@ static void regdump(struct net_device *dev)
 	/* set up the address register */
 	count = 0;
 	arcnet_outb((count >> 8) | RDDATAflag | AUTOINCflag,
-		    ioaddr, com20020_REG_W_ADDR_HI);
+		    ioaddr, COM20020_REG_W_ADDR_HI);
 	arcnet_outb(count & 0xff, ioaddr, COM20020_REG_W_ADDR_LO);
 
 	for (count = 0; count < 256 + 32; count++) {
-- 
2.27.0

