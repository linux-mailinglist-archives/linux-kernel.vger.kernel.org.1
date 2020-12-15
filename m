Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78C42DAF88
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgLOO4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:56:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730020AbgLOO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608044121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qd74pqXXAWk4/1pugQHgbmoI9O7DnKvJND+IdUuebOE=;
        b=D2aNvJa+jB+84tOtF9c7vcoPWQKSecjpqVRd+5C0YIUZ6pBMYCg/N1Uj0CgP31iuuQvskY
        cBoPRmB5f3GQJCwRcV+CAYI0I2L7TOvAfSKVbSQrBD2kV11QIshROmOlg7hARss5ZjWW5h
        5rdMWYwwOsEvOz2H9odd2F2RxyLqSUo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-P1MwTo9cNfqY8ScelqIPLg-1; Tue, 15 Dec 2020 09:55:17 -0500
X-MC-Unique: P1MwTo9cNfqY8ScelqIPLg-1
Received: by mail-qv1-f70.google.com with SMTP id c2so14427666qvs.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qd74pqXXAWk4/1pugQHgbmoI9O7DnKvJND+IdUuebOE=;
        b=JPqooFEEqkbqq7lTQriwUKRbNuCkDOpXsMgsmUihZsoH1aYAV5Yy5EhzO5uQSYz01e
         nhI0tU1y59DEdFH2gS19BTxEJXNps0wvShJJFvEYtlM/qY9azY3BK9jEsLDthd409q//
         g9PDEDvuhhLtJVfjQ4D2+5g3ZS7dWvMuv/TVI62MJ22eYXAvJ/+TyMHLYTEih7aPRs3g
         TgBQ1R/qJe134dfXhpjVf0whTNgRkoQqfqF5QXgu6DTn5d8c0UJXzXE4NSLV+srbA9BT
         EohHN9ZejToT6M1DuL8flFlZd7mZdFCfEbCQRWegOaj5Mx3dEN9SMbgJvTv/XgDGpmkR
         uLVQ==
X-Gm-Message-State: AOAM5328kJnJTdlp7q6NSTmUAp9UhtWpl4qChdKw3x+ii4IoJWphl/5o
        KrY40da7XKR4IghW/FeyAMFf7gFRrVH5PCv78AfQ5JcFX4nFxAR7a9yQ+lnKVboa5EJLgbGTgOs
        fhVQn8EX2MCVL/Zo63UZuQ7iT
X-Received: by 2002:ac8:7b9d:: with SMTP id p29mr29057552qtu.75.1608044117129;
        Tue, 15 Dec 2020 06:55:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnjJIF1rP8/8z6OurE/HZ5HWpDd/Q6ttloGxkqcxKH5Dphu7TL5uxkreadMHYK/dyJ6BYphQ==
X-Received: by 2002:ac8:7b9d:: with SMTP id p29mr29057535qtu.75.1608044116970;
        Tue, 15 Dec 2020 06:55:16 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b14sm16271740qtx.36.2020.12.15.06.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 06:55:16 -0800 (PST)
From:   trix@redhat.com
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] HID: uclogic: remove h from printk format specifier
Date:   Tue, 15 Dec 2020 06:54:54 -0800
Message-Id: <20201215145454.1905175-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

See Documentation/core-api/printk-formats.rst.
h should no longer be used in the format specifier for printk.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/hid/hid-uclogic-params.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index d26d8cd98efc..56406cee401f 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -90,7 +90,7 @@ static int uclogic_params_get_str_desc(__u8 **pbuf, struct hid_device *hdev,
 		goto cleanup;
 	} else if (rc < 0) {
 		hid_err(hdev,
-			"failed retrieving string descriptor #%hhu: %d\n",
+			"failed retrieving string descriptor #%u: %d\n",
 			idx, rc);
 		goto cleanup;
 	}
-- 
2.27.0

