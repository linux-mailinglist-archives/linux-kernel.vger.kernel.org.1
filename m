Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF942292E86
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgJSTeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:34:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55507 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730956AbgJSTeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603136042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Kq5VxBu2z8uXUidFjxUtgnQ0vBBkojXZgIAYG1rS13k=;
        b=XwisfWL1yDp8tjCx3C/o+yb35YDUfpHhNmDHKMMQkvlo618NOvPKmtzxfz6QEub/6HtMRK
        jNmJ8pOvBxib7By4WeSp4UzijpIGxoVMj65CfurmiHc3JF7imWUIcQ36NKXZghuY9IKTkr
        QuA44Tm7WOqehGyB+ui2W+woWrrqzOc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-jLt2kfnlOfqs3uMiGpmVog-1; Mon, 19 Oct 2020 15:34:00 -0400
X-MC-Unique: jLt2kfnlOfqs3uMiGpmVog-1
Received: by mail-qt1-f199.google.com with SMTP id b41so687653qtk.21
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kq5VxBu2z8uXUidFjxUtgnQ0vBBkojXZgIAYG1rS13k=;
        b=JXpO8X7IQWFGZw0FXSrxbyQD61gZSGmS115ihn7yky19mrNXX1BjJPH9OK9sH/dQlu
         8FOul+3LKijODiCAWHxi4I+6+bH6lLcLnhHCDtUVoLVZMVo6rusWh7x8ADSJHrQq2Y7U
         krwkJpWCtlAy6pqG+Sd+dnDcvZJxa0Avv8PzGedTpRoFVIfa47qfylLCm6IanwRV1WHc
         cfZQ6O8om6suDVkBCJ1tEw4VIGXTHhApGm23QoeioPtjgh+D+ieGCFzvBj2VjnrqRHWb
         /WtLrTT3Q2t5qLZIOk/wsucXxNJJYZChjraGtlVKI6VJpP76hoKG5hoDKqfqv+vmsHXs
         eaMA==
X-Gm-Message-State: AOAM532Aqglh8XvMVLWxOIwDY4fFR8sEmEJHAWzAiMtBPfA4bLxopk2q
        fyRo0hjb1fqR2tGHAc8yWhoTGfgKphLCfzuK9lHzF/q42v4+SQ9ObWwoDPPaamPxlD8Mn+bgWps
        lVurWn2ZnjTmeUmMzK4Mt0IOo
X-Received: by 2002:a05:620a:998:: with SMTP id x24mr1093532qkx.160.1603136040061;
        Mon, 19 Oct 2020 12:34:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRBOMiv5G17G7LD/7F/VAfAiG22qRDwWAIDg5xLV1iQptDtvpB+4Rtxa35qcp0KfqWXbJFEQ==
X-Received: by 2002:a05:620a:998:: with SMTP id x24mr1093513qkx.160.1603136039870;
        Mon, 19 Oct 2020 12:33:59 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h8sm358550qto.46.2020.10.19.12.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:33:59 -0700 (PDT)
From:   trix@redhat.com
To:     matti.vaittinen@fi.rohmeurope.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com
Cc:     linux-power@fi.rohmeurope.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] gpio: bd70528: remove unneeded break
Date:   Mon, 19 Oct 2020 12:33:53 -0700
Message-Id: <20201019193353.13066-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpio/gpio-bd70528.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpio/gpio-bd70528.c b/drivers/gpio/gpio-bd70528.c
index 45b3da8da336..931e5765fe92 100644
--- a/drivers/gpio/gpio-bd70528.c
+++ b/drivers/gpio/gpio-bd70528.c
@@ -71,17 +71,14 @@ static int bd70528_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 					  GPIO_OUT_REG(offset),
 					  BD70528_GPIO_DRIVE_MASK,
 					  BD70528_GPIO_OPEN_DRAIN);
-		break;
 	case PIN_CONFIG_DRIVE_PUSH_PULL:
 		return regmap_update_bits(bdgpio->chip.regmap,
 					  GPIO_OUT_REG(offset),
 					  BD70528_GPIO_DRIVE_MASK,
 					  BD70528_GPIO_PUSH_PULL);
-		break;
 	case PIN_CONFIG_INPUT_DEBOUNCE:
 		return bd70528_set_debounce(bdgpio, offset,
 					    pinconf_to_config_argument(config));
-		break;
 	default:
 		break;
 	}
-- 
2.18.1

