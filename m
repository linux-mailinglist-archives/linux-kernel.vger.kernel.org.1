Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C942D4D3B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 23:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388458AbgLIWF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 17:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388437AbgLIWFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 17:05:02 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6F8C061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 14:04:22 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id p4so2078099pfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 14:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1cejsIcZLseHYK63Fvaj59f3q4suFE7vRtGd0lpkzUk=;
        b=DSziPw0o3aFSd0+SpaTtBzBiLJ+BW3CWWbjH+Uf6Et3hrEogWU3Y55tkPgtUZOyi4m
         1fNS4eaYk5ox1PA5z4/TppDWUJf+qsBgjyFcUxf1OphRqNMNJLCblUUTupT5igMi/zmZ
         5A0ZQaBigqRw5ByIKL5cj0nhP0Rrg4nFw3r1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1cejsIcZLseHYK63Fvaj59f3q4suFE7vRtGd0lpkzUk=;
        b=bWWG+OinfQ43JvmUZpB3hSv+nOUY+opU9o+WdFFDJYZFLevHFqwbpLNyZdp+SOBQME
         TmnU8hS1Lt+0+XdKBrZfKpDFjtWAaXNi8ZJuHRmrlkFrTEQCd8Tu2Gbm3X9/wUQOrofJ
         UTVhmQjh6jDLjtIvvgE4NNFVPdViK5L3DqxjHQiRZt37//OXbXXsEG5q1HL55kt9Z8qm
         5Y5W8kPHH3dtKuNhONh8ffIyu1l7P5J30+FXJ+rpNuOa0AMYmVPnFb9dG5gGuQvBAqF2
         TOjiAfrR4wwPdBAK5fMKeq4y5qYbtbQv/G0pwfJQ3AzvDTPLiM3kSLBb0BnsXtlIfxfo
         q7fA==
X-Gm-Message-State: AOAM5305IBvKm0xFPNz2YNNE1V20Nkkdb+btQBNSKTSJte8dbKqQNbqJ
        sEWr+ER3aqXXPczNwTJx7PUlEWmlyrV32Q==
X-Google-Smtp-Source: ABdhPJxVTUaoO0RBoih6dgR6TEIMeORkDAvRm4OUX5KNffqC5Ex6Rxjb9Vmaqd16XtQ0pCHePvz4rA==
X-Received: by 2002:a63:af50:: with SMTP id s16mr3841833pgo.448.1607551461727;
        Wed, 09 Dec 2020 14:04:21 -0800 (PST)
Received: from linux.australia-southeast1-a.c.zinc-computer-272222.internal. (181.178.197.35.bc.googleusercontent.com. [35.197.178.181])
        by smtp.gmail.com with ESMTPSA id u25sm3361123pfn.170.2020.12.09.14.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 14:04:21 -0800 (PST)
From:   Evan Benn <evanbenn@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     briannorris@chromium.org, Evan Benn <evanbenn@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 2/2] platform/chrome: cros_ec_proto: Add LID and BATTERY to default mask
Date:   Wed,  9 Dec 2020 22:03:55 +0000
Message-Id: <20201209220306.2.I3291bf83e4884c206b097ede34780e014fa3e265@changeid>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201209220306.1.I6133572c0ab3c6b95426f804bac2d3833e24acb1@changeid>
References: <20201209220306.1.I6133572c0ab3c6b95426f804bac2d3833e24acb1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 'platform/chrome: cros_ec_proto: Use EC_HOST_EVENT_MASK not BIT'
some of the flags are not quite correct.
LID_CLOSED is used to suspend the device, so it makes sense to ignore that.
BATTERY events are also frequent and causing spurious wakes on elm/hana
mt8173 devices.

Fixes: c214e564acb2ad9463293ab9c109bfdae91fbeaf
Signed-off-by: Evan Benn <evanbenn@chromium.org>
---

 drivers/platform/chrome/cros_ec_proto.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 4e442175612d..ea5149efcbea 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -526,9 +526,11 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 		 * power), not wake up.
 		 */
 		ec_dev->host_event_wake_mask = U32_MAX &
-			~(EC_HOST_EVENT_MASK(EC_HOST_EVENT_AC_DISCONNECTED) |
+			~(EC_HOST_EVENT_MASK(EC_HOST_EVENT_LID_CLOSED) |
+			  EC_HOST_EVENT_MASK(EC_HOST_EVENT_AC_DISCONNECTED) |
 			  EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY_LOW) |
 			  EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY_CRITICAL) |
+			  EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY) |
 			  EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU) |
 			  EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY_STATUS));
 		/*
-- 
2.20.1

