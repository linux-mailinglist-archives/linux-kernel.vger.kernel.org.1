Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13046292DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 20:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbgJSS7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 14:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727681AbgJSS7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 14:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603133985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=b/sUnb6rArzO5JYs8f7grTfGvXTYQE7KJk/4fSRw0as=;
        b=FnJIBwLe5H696rwoR1cnVqdxhEr927m7TSl+4TTyh3bIjVLQ8Ug7vZ878DshmveLSoPnZi
        vHQZ6TIRVtrYinLAaNTmNA7XBAgA8Ka05kK+padhJ4RwDuANCLEDkTPjXF9Wi3vK5CNKws
        A/KR2MLI0OU+TTUR2xIztTumgdPKmDo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-wSYxN0EDNt26vf8sDmr_NQ-1; Mon, 19 Oct 2020 14:59:43 -0400
X-MC-Unique: wSYxN0EDNt26vf8sDmr_NQ-1
Received: by mail-qk1-f200.google.com with SMTP id m126so380320qkd.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 11:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b/sUnb6rArzO5JYs8f7grTfGvXTYQE7KJk/4fSRw0as=;
        b=PJZ0s6t15bQGSicRnYII6IAdqp6AbHoXZrVyhbdFfmc0jQWG/Ogrua47oqhQFY/SaK
         eHuwNzYekHKBsj/eTBCYb0+8wDoVR0vH8iY6jMnzkC6IC2XyTE4eXNNSPj771bq69ruM
         AON4X48J1XEErqioJwE53zHioyFqmcC28LlvDswKN6y3U/BUN4tfApaUMPKKmQaWHh6n
         yRLFsvp7cb3DZf2F4U4JYSQAGdDxpvE3aW1wMNpcuH0Qul/rbYHZYu5DG1cUKFVHTR7o
         cbc5xVFbUP2+iAjVu1vcN/js+IxGw172LMw5YzQb+HHwS9xuAt+zbp2wN6tp2Dff8PEL
         jOzQ==
X-Gm-Message-State: AOAM532PuVn25hHLI5Lf6Wt3zRlbEmT5l4u6tS3bOuvVhHj0sxCjtXIY
        35zwhLmUy5Zlm5tLbqq5FS7tS/7zAm0ncO7YkEJPCXoac+nkioxiE2RYIAMrQAhRtSbbNLZMm+Y
        3znuLL2ydMuqMDAiEiN2mmR/M
X-Received: by 2002:a37:72c1:: with SMTP id n184mr971810qkc.73.1603133983154;
        Mon, 19 Oct 2020 11:59:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqxXjjF+uyMK7oy1Eylp+8IT030YWO/UDVX9qPo/Yrc+Bmt4eDIFSR8q0sSRiT+9AYftQatQ==
X-Received: by 2002:a37:72c1:: with SMTP id n184mr971792qkc.73.1603133982894;
        Mon, 19 Oct 2020 11:59:42 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x75sm395252qka.59.2020.10.19.11.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 11:59:42 -0700 (PDT)
From:   trix@redhat.com
To:     sre@kernel.org
Cc:     patches@opensource.cirrus.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] power: remove unneeded break
Date:   Mon, 19 Oct 2020 11:59:37 -0700
Message-Id: <20201019185937.7012-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a goto

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/power/supply/wm831x_power.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/wm831x_power.c b/drivers/power/supply/wm831x_power.c
index 18b33f14dfee..4cd2dd870039 100644
--- a/drivers/power/supply/wm831x_power.c
+++ b/drivers/power/supply/wm831x_power.c
@@ -668,7 +668,6 @@ static int wm831x_power_probe(struct platform_device *pdev)
 		fallthrough;
 	case -EPROBE_DEFER:
 		goto err_bat_irq;
-		break;
 	}
 
 	return ret;
-- 
2.18.1

