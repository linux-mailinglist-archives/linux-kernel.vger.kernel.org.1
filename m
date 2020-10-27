Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38E229C9F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1831044AbgJ0UO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47641 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1831045AbgJ0UOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603829692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=tF9++WwQg6cQ8ITD7V7/Vt6x+InCx00EmcD89mL3eyc=;
        b=FWO0m/D18wDG98Po7X8MoNT01Fp/aQt1rXKYCNSZZZwGAdgdH2dGQ8+kxQujxdel6FLvyb
        4sPkVRtaybij5DdAalX3/oqOBFfLnBl/C2Cy0lcbzRLi7IDnEFZSRqWZjjnkSLLQnX28RW
        BS7wL3D9iEGQdkx4eNSvaaMIwCnpHlA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-s4VhvaY6MWOQJ0h2ICl3uw-1; Tue, 27 Oct 2020 16:14:50 -0400
X-MC-Unique: s4VhvaY6MWOQJ0h2ICl3uw-1
Received: by mail-oo1-f72.google.com with SMTP id e142so1304160oob.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 13:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tF9++WwQg6cQ8ITD7V7/Vt6x+InCx00EmcD89mL3eyc=;
        b=Dst+6PMvw9Xnfj6EbbXXYcD8lgyFjhuhwdavNOgZ1MGCdiHUSksWympnx0b/DtktOd
         29gihSvxhxRsQfB6KJMCO6lkaeG5lP733CqqewLNpntqT12WcGU+qrm3eD6amlOCbzRM
         UzhIr2c6iisY2JEoYDzISGonEOahdEyRIFWHRZTskWuBX3cznVQzm3/lAbk5z2H49pEI
         wGkTEaFNP/tl7oZ/jX4nsoB7FB6BVOoDSMWr6SLtn/ZJoWjPZ14QqnSrmRxeMPUOM9g8
         6C45s4pli5zGG4OBp8ZqFe/d3P6Ca0qSAwBHbG1e5n/FwAuWAlDqwC7+2/xCRTbdxXCL
         J9ag==
X-Gm-Message-State: AOAM531HSRud65Kj+98/HGqqGxEwulCdw6mg0gs89b6QvfCF2LFDnrzm
        X4UuBanRzAD1NfXA8Q0mgdbbkbhLoKKmPcvtLqzrvvb2KPv8yjjGLSdaGEPDLBzy8pv2PrzhLos
        6LZErPQKAnuoFl37GlgXgx2JK
X-Received: by 2002:aca:47cc:: with SMTP id u195mr2193430oia.83.1603829689603;
        Tue, 27 Oct 2020 13:14:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdPYJAKhiib2dLfRpsridr517hmHhi+755qXgffr1bWQRiifi9uJtbkou/BqGwafFiBmivQg==
X-Received: by 2002:aca:47cc:: with SMTP id u195mr2193418oia.83.1603829689445;
        Tue, 27 Oct 2020 13:14:49 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 104sm1473139otu.81.2020.10.27.13.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:14:48 -0700 (PDT)
From:   trix@redhat.com
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        alexandru.ardelean@analog.com, linus.walleij@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: light: apds9960: remove unneeded semicolon
Date:   Tue, 27 Oct 2020 13:14:36 -0700
Message-Id: <20201027201436.1597726-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/light/apds9960.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 9afb3fcc74e6..547e7f9d6920 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -561,7 +561,7 @@ static int apds9960_write_raw(struct iio_dev *indio_dev,
 		}
 	default:
 		return -EINVAL;
-	};
+	}
 
 	return 0;
 }
-- 
2.18.1

