Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93BE2A181E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 15:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgJaOZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 10:25:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726042AbgJaOZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 10:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604154317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=CZZDYsM4yr5f6C7zqA86aLBpezdgQujjpLHyEcl2FVU=;
        b=KpDxLmFe0RhbPxaP2S4xoPftsAjAVmOtO/4eeyaRvbPuaUr3ArfTY584HulexDiG0mGTvw
        otEX+soJXzZ7hmS0uDhK6Q77sf+a8znsN1gP+f0QZLtIDHD97LBCdilemEopSMEgVFrApV
        +kPsZarUPlIGJLkO1cmYFoFiat1lSH8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-RnxRH6UzNE6cRYMurVsoQA-1; Sat, 31 Oct 2020 10:25:15 -0400
X-MC-Unique: RnxRH6UzNE6cRYMurVsoQA-1
Received: by mail-ot1-f71.google.com with SMTP id g22so3807384otp.23
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 07:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CZZDYsM4yr5f6C7zqA86aLBpezdgQujjpLHyEcl2FVU=;
        b=J/Am8FXUAzaCL1SgeQGQANfuoaOBbUtYybGoGVI8F4V1KVvR0WXxYUte7Lgl7K+e0I
         EcR4e7Niw9Jk+sNl6iCv9GFqdle9ZimIG//xbV1h0zT9sBGmpovd5+COd+UbDZCH5dEF
         iphxJpCkI0tkY1ZbVddIcxijxhrwBaRRXlwTzeLYceEdtZBaozFCyd7Fan4wDAxF4AN6
         6JivxIc2NlE0QIYyJRfJ0l4ulTUiSEvUFMieasb5a6lQkJiPzo07MBxV2+RlEb0gs6n9
         ZI6tCgCGL8qKOboktFzVI0FT1+0UAE7JskEeF4lJTqsVXYtoKt3wgGCXi9lqzfyUnYzF
         IREQ==
X-Gm-Message-State: AOAM533lBRfIyZ+uBNZ0PgSVGL+Qt47LeYZBvwnBcJ/u/fWUA5DT/qor
        EXwS3MK+jAxPOzK9A9y5NsdNF3pYDB6J18FaLdKUrhLdaq6XmiPSKKbwXD4LiKckhHqapNYEH+1
        38r4oszifkgRvv7OYVPJa/jOr
X-Received: by 2002:a9d:4b10:: with SMTP id q16mr5508884otf.274.1604154314724;
        Sat, 31 Oct 2020 07:25:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDZXUwyVDrgQ8lV8rA33RPNGnqnjxHnBVv9j31G0UFSyzWIAER6R0Hh+NvjC1SOe7+vHvEwg==
X-Received: by 2002:a9d:4b10:: with SMTP id q16mr5508877otf.274.1604154314527;
        Sat, 31 Oct 2020 07:25:14 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s21sm2191276otd.5.2020.10.31.07.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 07:25:13 -0700 (PDT)
From:   trix@redhat.com
To:     maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org,
        kvalo@codeaurora.org, jgg@ziepe.ca, leon@kernel.org,
        chao@kernel.org, gustavoars@kernel.org, colin.king@canonical.com,
        vaibhavgupta40@gmail.com, keescook@chromium.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] memstick: jmb38x_ms: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 07:25:05 -0700
Message-Id: <20201031142505.2139539-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/memstick/host/jmb38x_ms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index e83c3ada9389..f9a93b0565e1 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -748,7 +748,7 @@ static int jmb38x_ms_set_param(struct memstick_host *msh,
 				      clock_delay);
 		host->ifmode = value;
 		break;
-	};
+	}
 	return 0;
 }
 
-- 
2.18.1

