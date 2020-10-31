Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F8E2A17B4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 14:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgJaNnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 09:43:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727460AbgJaNng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 09:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604151815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=xpsTtMH9ntXfVKcj//i9QDM7KI2/8ennQA3napfR6+M=;
        b=fKsArutbOor34MFAbnxm5xN/5OOc9HffWmun8l2PDACoQZd0TdwGfGVgiPSXgUVCmWzJ2l
        dZzDIZhGED5CRdvoHmgXYChaa4nvL6vcxZ0QF0+LH+zZyvvm/nWpnHW8YhhEWUOiIfNzbY
        aNrrfkNGyVcHEGkTx0xF/cccKxqn4gg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-bCsUSFMcORyMW5mp5qI0Mg-1; Sat, 31 Oct 2020 09:43:33 -0400
X-MC-Unique: bCsUSFMcORyMW5mp5qI0Mg-1
Received: by mail-oi1-f197.google.com with SMTP id p78so3795372oic.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 06:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xpsTtMH9ntXfVKcj//i9QDM7KI2/8ennQA3napfR6+M=;
        b=blKr6co/CCgIgk8h7zftNl98zEtEqYLk7cm5MSdcwLu8xRkNQ2ogwOUVvG6kUnYB52
         1NNELMaA8uhCeq80g+FtJRrtsugRuXyeRzv1QzBmHuYI5tLFHxcAMsRL9MEo/JHbJpII
         bjvN/aAAZaLKAbev6I6NDm1INzo6vwu6S3yt0mqQ2Vm7lXSOL5JNzFSrEFMhfo9hQgCv
         C+zVMWXeDwr0yP5FNCRx/N0d85BDTzXiuPXvGznVtuOogvGyOn+8A+IpmtyU7CNAjjSd
         yuxczz4xKfEkfN2iLLSAnWdnEo28Knyb9DEsXpGXKZiOzroS/dX4tbmI9ez1sXYROxuh
         v4xQ==
X-Gm-Message-State: AOAM533/vVp9CnCay98YG4wJ6jEplsGlmQA3IAmBDp9+63BJ9Y8E9pn0
        79CcFEnaHSIcxy2w/AOppBukM0zI/L78SJKtlsKx1qlSc5kk3kvCd2a/MHYvf3E/0NTBQ5lWX8f
        ees5pk/3YWYzCineS0Z8UrVn9
X-Received: by 2002:aca:6206:: with SMTP id w6mr4952156oib.121.1604151812494;
        Sat, 31 Oct 2020 06:43:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcfxMeR+vmw/c5zsmF0ELbs7FL/idSETkEZq5uw+VXQElduuJ0iys97bvRMt5GCPdWN2p37g==
X-Received: by 2002:aca:6206:: with SMTP id w6mr4952145oib.121.1604151812322;
        Sat, 31 Oct 2020 06:43:32 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t4sm2104972oov.15.2020.10.31.06.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 06:43:31 -0700 (PDT)
From:   trix@redhat.com
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        alexandru.ardelean@analog.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: magnetometer: bmc150: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 06:43:19 -0700
Message-Id: <20201031134319.2134314-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index fc6840f9c1fa..73e55ec815ec 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -190,7 +190,7 @@ static bool bmc150_magn_is_writeable_reg(struct device *dev, unsigned int reg)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static bool bmc150_magn_is_volatile_reg(struct device *dev, unsigned int reg)
-- 
2.18.1

