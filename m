Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D052629C9C0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830935AbgJ0UJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439401AbgJ0UJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603829341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=z/P9Z9C4PZYkgeQZNMgEmbQXDB2+FuX6dF3cY8iv250=;
        b=evyKLhS1evX0Jz06yLQ/v7sktAatJeWnhSlFblXH16LlJZwkVe6qua5ITlNutM3i5/1sv7
        0Kxx5cN5Lhln25tLJ4YQrFHpqNxHoZoQo6/l15v0S26ac1jjoPe+fNGbZ8EadLPjHqmSOk
        UJVvgHJBsBHkn1l625w1tOdGa3gsaTs=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-qRPMa94IMs-dsDAD5HX_gA-1; Tue, 27 Oct 2020 16:08:59 -0400
X-MC-Unique: qRPMa94IMs-dsDAD5HX_gA-1
Received: by mail-oi1-f198.google.com with SMTP id y8so1185830oie.22
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 13:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z/P9Z9C4PZYkgeQZNMgEmbQXDB2+FuX6dF3cY8iv250=;
        b=QVvvwolRZatravUL+Jvjf5gI4vFy+6VZjbUaoHp7xky55ZJ1j9PZUj+nEUxroS9U3l
         VUFGp9doRRS1DQ8b1Cp5Y/+g2+Z8LFAnaCpo1pUsu6VIzSkpUChyjXHL32W7Lfwdoz8k
         pU43U3S6W1p3+/NAu8LCuxx52nW7ztKBHPpg4gn453hIqUSA+jwRfnZukMFyzZ3xqcmC
         zN4WYJO+NdIBdUPzdMNvEx5XYsA/Lti19HgKj0o2PZKEdevNC6/0OYDAZVnqHvpElGFw
         c77iWg84rnlqprVDLxc4Ad2dXDPigYQ12vy0vwjiWKll3a+jMIuVeQ+DOS1ntzHL3Jgw
         Ds9Q==
X-Gm-Message-State: AOAM530QVywGBZFRzH2ARTNjcaqqQjBh+yKJUnNtvuxwR0asAErwmtds
        ZeErsSf1I6iJw9dnvQhMJSysiPyv4FYeKD4W+4nm4JYEQqhSOWjzF3xUbw9u8YNer1BOkhYxD6r
        WeuDTutgZtcbMaNPn3ldXn1eK
X-Received: by 2002:aca:f203:: with SMTP id q3mr2607474oih.148.1603829339028;
        Tue, 27 Oct 2020 13:08:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmZlAqkfP+7v4p/ymWn6FF+T+HagSo905aTYq4mMxXC7QSKxlykrccxT4DOK0XZZxlvlgsig==
X-Received: by 2002:aca:f203:: with SMTP id q3mr2607462oih.148.1603829338877;
        Tue, 27 Oct 2020 13:08:58 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u186sm1921539oia.30.2020.10.27.13.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:08:58 -0700 (PDT)
From:   trix@redhat.com
To:     eugen.hristev@microchip.com, jic23@kernel.org, lars@metafoo.de,
        pmeerw@pmeerw.net, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: adc: at91-sama5d2_adc: remove unneeded semicolon
Date:   Tue, 27 Oct 2020 13:08:53 -0700
Message-Id: <20201027200853.1596699-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index b917a4714a9c..56cb9a8521be 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1472,7 +1472,7 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 		return 0;
 	default:
 		return -EINVAL;
-	};
+	}
 }
 
 static void at91_adc_dma_init(struct platform_device *pdev)
-- 
2.18.1

