Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7FB2A17F1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 14:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgJaNpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 09:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727460AbgJaNpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 09:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604151913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=814PgqQ2GaNYFANqzidfDl9rSrDeF/edtDaTRQDpiQw=;
        b=YUM5DCy39DCQHkryqsCJYHRuZAfEkt5fDh8tZhaH1lnsQs01PNnAT17ktAFgq+iaKEd6Zj
        zmAxHvt4E9Fi70h01I4sAyoffqXLAgGoj7pzLk/8EMOow9McQbaeXjxoRRFZGlS66uyYFP
        /fj9WtBbK8Vbf+Lfi3EzMgXhJqjeiM4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-f9hnQE4sPUizUPIZrrcyKA-1; Sat, 31 Oct 2020 09:45:12 -0400
X-MC-Unique: f9hnQE4sPUizUPIZrrcyKA-1
Received: by mail-oi1-f197.google.com with SMTP id r83so3779244oia.19
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 06:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=814PgqQ2GaNYFANqzidfDl9rSrDeF/edtDaTRQDpiQw=;
        b=h0lcumhxKjUZGqVsh5cZG/B9C8YpQRtFFDC0SN+mSV/erOv40xvowy9nQB81gL/iXK
         ZElcj7gEteh2DpwkHji2pgbZLPyJ8fcz5hkPFQhno313lyzkM+ccr9/e00R3bHYk1vA2
         k2KqoSg4nrFn4a5a93yqNOKiuQNCXJOYqEdk8GWn/AXyusB7WGP+InO05DaqIZ7//jSr
         ZNwEWwyRwDWt0SRYKXbLoURnPf8Ta2stupu6g6iJwuKzVNg8ZbCkgEe8wIHt92nlROh+
         jEqjxFwkHipzsbQNos/IoOhtMd+PXP7gAhdcefUeSVB3DlRJLvqvsfgyZ4hvRCR4cpiI
         JYAA==
X-Gm-Message-State: AOAM5311C8GuTYHBWJGuTuzebFKbTW3lFEavS1I9B5Trx+ft8gh6Yhbn
        SV2Fz6Gmx0fCXDmBhJbte3s7xG9TWDGu8DvTXzLkdukRQ1Q55WNFdbKT7my5yvYDChRLv1oisSJ
        eoU7RsqrPzyewAgzhlwGLn1Z5
X-Received: by 2002:a9d:4f15:: with SMTP id d21mr5349082otl.166.1604151911281;
        Sat, 31 Oct 2020 06:45:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNGYuiT8MQi6phj/4hR76hzlOqYTMJ0W/2+FDiH5m1ZtjDgTkddbT/43RAQikP9pzjidHtEg==
X-Received: by 2002:a9d:4f15:: with SMTP id d21mr5349070otl.166.1604151911094;
        Sat, 31 Oct 2020 06:45:11 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m65sm2182844otc.36.2020.10.31.06.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 06:45:10 -0700 (PDT)
From:   trix@redhat.com
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: pressure: bmp280: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 06:45:06 -0700
Message-Id: <20201031134506.2134698-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/pressure/bmp280-regmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
index 08c00ac32bda..da136dbadc8f 100644
--- a/drivers/iio/pressure/bmp280-regmap.c
+++ b/drivers/iio/pressure/bmp280-regmap.c
@@ -13,7 +13,7 @@ static bool bmp180_is_writeable_reg(struct device *dev, unsigned int reg)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static bool bmp180_is_volatile_reg(struct device *dev, unsigned int reg)
@@ -51,7 +51,7 @@ static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)
-- 
2.18.1

