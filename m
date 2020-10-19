Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E865292DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbgJSTBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730564AbgJSTBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603134063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=XwLMs+G9acmS2aakBMTMjzc5I3FvZvwGMkn+7uLCDjA=;
        b=FwM0yecZ3U/uHP0oFU5Xrg1WyFdWGZ8kuO4fxYQK8lH9vD9LFK9WUY6cGHZNXKjXHElLTh
        JI6iANPrJxLgejWZvgH7gZ2xmNgCY6q0Z7HjTrVVQrW6sHpEY0dfeUEMjt2nC+/MUf7NIG
        7rcOFkok1iUt8KVCl9Nii7JfUDaZZvk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-2EMkjPSjNPqyHves3WqnmQ-1; Mon, 19 Oct 2020 15:01:01 -0400
X-MC-Unique: 2EMkjPSjNPqyHves3WqnmQ-1
Received: by mail-qk1-f198.google.com with SMTP id n125so374442qke.19
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XwLMs+G9acmS2aakBMTMjzc5I3FvZvwGMkn+7uLCDjA=;
        b=XrRQ9a7rerWOUi2iAg7T1HV9sHGq90yWuKSemWH3uYDcULesDY7F+gyQEhrtk2D8ak
         PFD+yhjPBuFmM5SZexYmFoeI4aBEeM4aPyLf7CvWKg1eYnZwsbAkbFkw5iWi6GfSuNf+
         0Yy3vprXzt/U8j1CRjaMb0JYvLZEChExqb/FY2QNdq0RIkogBwZ5IShh1Ygx5oSvjNkI
         4svkMrjFiRxslZXOTYCI59LtnWjNDi3s4VM0Kfo7Cf7ZSfphh5kShSc5reQOUNqdIBZZ
         g45BA2/2JmRMwCb5C9TxNbiJG5npxa7k8Wflc7xmfgB1TEKhix/gBbWVkE35p/AUfYGh
         5rEQ==
X-Gm-Message-State: AOAM5301itRNHwCQ/lC8NnKjn3POJQzKJBBWQkbJKdtjtMjwoHokHAfa
        QRJGXyP2a42tGZ2YLAFDYesx+JrMHl/xEZYP5lsdsewfJlXOmh0meisSC7LpCzrhuJZIyjsRSJO
        yTf+ozVEX2l5PNDHg4qpW1xmw
X-Received: by 2002:a37:2dc6:: with SMTP id t189mr1048636qkh.394.1603134061005;
        Mon, 19 Oct 2020 12:01:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzErTIxJNieTSDYoXo5Y00wXQUVggwoT0V7lhKV2TN8og4s019OyWS/oIKDVfNG0iHfaiHwQQ==
X-Received: by 2002:a37:2dc6:: with SMTP id t189mr1048611qkh.394.1603134060763;
        Mon, 19 Oct 2020 12:01:00 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id n3sm307910qta.10.2020.10.19.12.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:01:00 -0700 (PDT)
From:   trix@redhat.com
To:     kgene@kernel.org, krzk@kernel.org, tomasz.figa@gmail.com,
        s.nawrocki@samsung.com, linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] pinctrl: remove unneeded break
Date:   Mon, 19 Oct 2020 12:00:55 -0700
Message-Id: <20201019190055.7371-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
index 5e24838a582f..2223ead5bd72 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
@@ -108,19 +108,14 @@ static int s3c24xx_eint_get_trigger(unsigned int type)
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 		return EINT_EDGE_RISING;
-		break;
 	case IRQ_TYPE_EDGE_FALLING:
 		return EINT_EDGE_FALLING;
-		break;
 	case IRQ_TYPE_EDGE_BOTH:
 		return EINT_EDGE_BOTH;
-		break;
 	case IRQ_TYPE_LEVEL_HIGH:
 		return EINT_LEVEL_HIGH;
-		break;
 	case IRQ_TYPE_LEVEL_LOW:
 		return EINT_LEVEL_LOW;
-		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.18.1

