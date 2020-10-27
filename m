Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C69229A2FA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439338AbgJ0DK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:10:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37374 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439192AbgJ0DK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:10:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id 126so81891pfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ggrCrrOmIGShBF925Jr9ht3p0sf/ZpOgGfgHeELSUDk=;
        b=OXnuLvFnuFXTHLaM31j3wZeO0dSbDUReJejwsZ91yFLm37d2oWMEA/8VhzBHUqB26t
         GHR/bhoUTVxb8PjUscvqkDqrZbJ3NGiKZUUbEQUfiEwpD0WyAgQ+ncX5qL7CVx+KCXyt
         K7xp/jSOsTdNfiAxh9EsletEHzS2/RKo6D4YzFl+w56wUh1iu/+B6ka5G0bPOkLRbcEq
         UTPTijvbEnqvHi/Sma2q7GOupZXTRwctpI7xGvmlla1oxKy4+wWyqOZNnzkil1NIsv7M
         /BONzDBGmUNqVp3OWvSRGP3GZsiUhS4sF48taBnwPB5j3c5rw7zOh9GZR4MG+NuNHvUJ
         +LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ggrCrrOmIGShBF925Jr9ht3p0sf/ZpOgGfgHeELSUDk=;
        b=TuPn4gojvVU9fVZZymPx2dMhI0SqoMRhUVcRHbX3ysuG+6wqx7VKwLZdTosbq0dzHf
         xsN0JLN9Kykm60NiUwIE7FrKa+nM6biMtQtWOtJkQJAvROeLj1XaCwpNH13hHZ1vuunE
         GeGy58mDOPLuQ3mSU5LBLXzoCPSprD4SSx8wpDwH6XtDNNHyNxQUYtzPqiSX3PSbd4lv
         CTjk6g63lufbU6KvhQ0y8w/s8ykRNEgc8wROmgUoa+cJv6iJnvOJTPceSsU9Hv2ygXmj
         ceB4KhG7GcplCoiATAqaAgOZZ+gznrPHmoes3LVYRzI35L6DJMWH8fPbsCFw/nP0O0K3
         2jDw==
X-Gm-Message-State: AOAM532/3wLohs+IeJLNTGT/XQfHe0hutIkFzmn+DDokJVhHxQRSEIvG
        bxVOXJ7nqLtJvxw7KLrUY5ZLIA==
X-Google-Smtp-Source: ABdhPJxSizMG3mX5BfHmMTWj2DYVyRO/UhF/3V+PPiAFsxMKjrh388AWFdmx3Hab79poxErholAoGw==
X-Received: by 2002:a62:92c8:0:b029:152:1703:2da9 with SMTP id o191-20020a6292c80000b029015217032da9mr182893pfd.60.1603768226357;
        Mon, 26 Oct 2020 20:10:26 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id cv6sm176450pjb.2.2020.10.26.20.10.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:10:25 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 04/21] perf arm-spe: Refactor arm_spe_get_events()
Date:   Tue, 27 Oct 2020 11:09:00 +0800
Message-Id: <20201027030917.15404-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function arm_spe_get_events(), the event packet's 'index' is assigned
as payload length, but the flow is not directive: it firstly gets the
packet length from the return value of arm_spe_get_payload(), the value
includes header length (1) and payload length:

  int ret = arm_spe_get_payload(buf, len, packet);

and then reduces header length from packet length, so finally get the
payload length:

  packet->index = ret - 1;

To simplify the code, this patch directly assigns payload length to
event packet's index; and at the end it calls arm_spe_get_payload() to
return the payload value.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 06b3eec4494e..f1b4cb008837 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -136,8 +136,6 @@ static int arm_spe_get_timestamp(const unsigned char *buf, size_t len,
 static int arm_spe_get_events(const unsigned char *buf, size_t len,
 			      struct arm_spe_pkt *packet)
 {
-	int ret = arm_spe_get_payload(buf, len, packet);
-
 	packet->type = ARM_SPE_EVENTS;
 
 	/* we use index to identify Events with a less number of
@@ -145,9 +143,9 @@ static int arm_spe_get_events(const unsigned char *buf, size_t len,
 	 * LLC-REFILL, and REMOTE-ACCESS events are identified if
 	 * index > 1.
 	 */
-	packet->index = ret - 1;
+	packet->index = arm_spe_payload_len(buf[0]);
 
-	return ret;
+	return arm_spe_get_payload(buf, len, packet);
 }
 
 static int arm_spe_get_data_source(const unsigned char *buf, size_t len,
-- 
2.17.1

