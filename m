Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F04293D21
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407399AbgJTNPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407387AbgJTNPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603199729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=LjmPMVzXWf6DnC/UBBUMQlfucytTz/vlaecv5F/UKBM=;
        b=I85ytdlruZITuDD1yCZ3LdGYjijFSyAnRYoT7AnHyG9OZYxFiyL/Q7MnizqABrQn4ApxdN
        CcTG/ETN0V13pRVn7zQ57C1damLpP74ddsXVSLF39TOuehAyUwG53PD/ptMtuRsS+1z60o
        7RU180J9r89MKymbXCH9R8U355tDtpQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-rQbRXHRwPSOpKD0UEVOtDQ-1; Tue, 20 Oct 2020 09:15:26 -0400
X-MC-Unique: rQbRXHRwPSOpKD0UEVOtDQ-1
Received: by mail-qv1-f69.google.com with SMTP id l8so1350160qvz.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 06:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LjmPMVzXWf6DnC/UBBUMQlfucytTz/vlaecv5F/UKBM=;
        b=CdG8yj/VaHFPWkkBP95+5IdQaU3u7oV39OD9qug//PYJSbV7mKk/rcqbHKvlzept+H
         O7vEgIT0s+7fllPeZgBaY5uLur+5GNatICRkmD5osIAZGQOOdFDMBYeQXXrWmgVA7n6g
         t6RaB8nZPl88bWKQyYjpGxugvFrKDBnvDXtFcSYnY659WvGHa0yBc6H+3MpB1QCUckfk
         2RreGMQIjKoQNYK20lJQdHbVDFNHEX3od3QFgRcD380xA0Q49lkgZr6WSvMiGAZDi9Hw
         kjsBcsvmu64X/l557dorpdZMMqaz8gQFb4BXNyB2ucDLfKOHSWNEs1FFC9mghT8JA2rB
         UrzQ==
X-Gm-Message-State: AOAM53295w4YD2LCZhXSksE6S315zAmMlgENnzTgrR7aSiA9QsN2BRZW
        qlG2cTgwkkcwCLwcVxNRqKwSRq9G7Fkn+CNcgP9N1qEI8VcEhvRqnqEDq/QDmkVO7INRbLMBNlZ
        o4KXIpFxinPmnHffWbfqcqqx1
X-Received: by 2002:a37:6246:: with SMTP id w67mr2420714qkb.35.1603199725595;
        Tue, 20 Oct 2020 06:15:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxPR6bV4aLBGYacEtAaH/79e0HSmuiKtMeTJx0qcZazIVj5QKtDoi7jlYYjqw+n1IkdtGPIQ==
X-Received: by 2002:a37:6246:: with SMTP id w67mr2420695qkb.35.1603199725399;
        Tue, 20 Oct 2020 06:15:25 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s90sm713248qtd.15.2020.10.20.06.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 06:15:24 -0700 (PDT)
From:   trix@redhat.com
To:     kgene@kernel.org, krzk@kernel.org, tomasz.figa@gmail.com,
        s.nawrocki@samsung.com, linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] pinctrl: samsung: pinctrl-s3c24xx: remove unneeded break
Date:   Tue, 20 Oct 2020 06:15:20 -0700
Message-Id: <20201020131520.29117-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return.

Signed-off-by: Tom Rix <trix@redhat.com>
---

v2: Improve commit log

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

