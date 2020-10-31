Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755042A188C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 16:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgJaP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 11:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728041AbgJaP1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 11:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604158039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=qCvPcYJMYe/YC12xdcjZu7zLl7oGmMt2L3Rdu5ytYE4=;
        b=ew3LgPnoPm9I5g0Y22HTuX1Ew/q5KcX21bohDa1NvrxzH0iUhxz/cC92Ml/A+eXe3j4JI0
        pLR7oTkjn6D5kWltWmv1TN+No0MgrXYRTkJA5jZ6R4FvlkYoUxT5B+qDg6YGcvqjRdjk9t
        /JUSvOsTaMcFJSvdjiU0ZfC4SoJFfYQ=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-9TgCvxj9MI-UKLtdapNUuA-1; Sat, 31 Oct 2020 11:27:15 -0400
X-MC-Unique: 9TgCvxj9MI-UKLtdapNUuA-1
Received: by mail-ot1-f72.google.com with SMTP id t19so3891436otc.17
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 08:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qCvPcYJMYe/YC12xdcjZu7zLl7oGmMt2L3Rdu5ytYE4=;
        b=C4RzTZ2HWLJI9zSJPsEOmo8TdL9KF48knwTyObnIX1buqr0GiSbJmFZI8tlG80WA2j
         W/EXYVmtmYey7pRjUVZtXFvbmIsiEj3Z+i/jxkEmMr+xCWgX4syUqIihkpFhmu/A2tSg
         EUdLVGVlr/lpvxjWPNJRfsAUL7+62OQILKDU2UHXjUenW++Q+BYPU+yCqr9VvT25DS3W
         kIJyTlMYByjOMmV3XSr0ntdxYbvWCeDR10Tq1WxI6s1Q5SFuhpOEoocw2705rSzsiQZv
         CEEAm4bmkI/eRNNEmSvGuXT9vDHRPi5u8cuPuYjveQXOZ1xRfJESKV7vbIkUuLuwkMK0
         d4kQ==
X-Gm-Message-State: AOAM533ZXbMb4yOkRiuiHbe0UCvJc7f9POv6WV2hwgaEv3IZZxZ5xOqS
        0uLOHszwUHVzN+bRHNndB7aS3SCKmdi2Z7j2KQ4ya/1cfX9/q75kIm9dtysTeo7AP7mVIpm6pno
        FyDJwM6UZhm/nbXm6kTAHPA1B
X-Received: by 2002:a05:6808:57c:: with SMTP id j28mr4898826oig.63.1604158034318;
        Sat, 31 Oct 2020 08:27:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL0KyGC8s/0/4hyz3KjpuX5EYAblzdMoedM6xdT6woIB/4tDjZgpbipZCN5rJQFo8fPWn8JA==
X-Received: by 2002:a05:6808:57c:: with SMTP id j28mr4898817oig.63.1604158034180;
        Sat, 31 Oct 2020 08:27:14 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i18sm2254038oik.7.2020.10.31.08.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 08:27:13 -0700 (PDT)
From:   trix@redhat.com
To:     ulf.hansson@linaro.org, krzk@kernel.org,
        wsa+renesas@sang-engineering.com, dianders@chromium.org,
        gustavoars@kernel.org, mirq-linux@rere.qmqm.pl
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] mmc: davinci: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 08:27:08 -0700
Message-Id: <20201031152708.2146690-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/mmc/host/davinci_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 90cd179625fc..2a757c88f9d2 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -290,7 +290,7 @@ static void mmc_davinci_start_command(struct mmc_davinci_host *host,
 		default:
 			s = ", (R? response)";
 			break;
-		}; s; }));
+		} s; }));
 	host->cmd = cmd;
 
 	switch (mmc_resp_type(cmd)) {
-- 
2.18.1

