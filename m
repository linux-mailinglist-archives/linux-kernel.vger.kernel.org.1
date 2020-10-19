Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE54292F17
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgJSUDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:03:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34110 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726385AbgJSUDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603137818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=F3+eVVhD9pRO1Lc4WB7w+1NvqWHmj8ke9+eowsdGJTU=;
        b=WO5fy13qdnCy+BB06xFJb8lTqb4Cr5nOdkWGVqJ4ZHUKFoALy3H6IK7nRXx4nHAtIRDyna
        9KS+ZeuYQEooHxBKiZTBtKJkwxZr+pHp8Uxzyot0PMsM4FIiUwlxUqK2MiWYrx9G28VkFl
        VxDq7G2GVyHntxMpCNcZzOjdM7s4lW0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-dPxV_IEDMNS_pLqbnp7akg-1; Mon, 19 Oct 2020 16:03:37 -0400
X-MC-Unique: dPxV_IEDMNS_pLqbnp7akg-1
Received: by mail-qk1-f200.google.com with SMTP id x5so576936qkn.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F3+eVVhD9pRO1Lc4WB7w+1NvqWHmj8ke9+eowsdGJTU=;
        b=BotPRCYc/TIyTq4eXgivo4gGipGM4wRxWTJAJ5cEsAmFulTHmoqXN9ZQCmWIAWVcJ/
         TWEUJwyz9iHhabXWX3NMgjHfkpUuvI94MqREg0aBMlTdy3Xqh8fCIrTRxkOkZ6Jvr0ku
         hzqTeoonQlT41tx3nIn8Qsx7oYgQawGbYg6K26TxnLH9wMDtDAB/cD1LBZYGudl1aIY9
         hbBtYVmgx5+aSdEESSvM1TiRhtwWGNP2NfhU484IVQaWa9HCSFSt89Wuo8TsJ/cUaf9Z
         Cz5ZcJYgqffN6p8UUQFCwfSlk9zKFyhEJirf+KpD74Lg6SvYsOPQjSWlwaPasHPZeU9D
         FfWQ==
X-Gm-Message-State: AOAM53103mQ570VwSO/cj+sticez7olqdXAzzfg1bCbcvBO6nk4vKHNM
        wbFXXeX3gNIw3MKBevd72DcTzI+8waUcw1byMLyk2HF3sCmgiCu6psGRlHK82CHtzAajti3QzNW
        BBI3wU3304lIkHheFtVr/VNlp
X-Received: by 2002:a05:622a:208:: with SMTP id b8mr1115071qtx.101.1603137816587;
        Mon, 19 Oct 2020 13:03:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXb/rxXb4baPbjkHkFnR27pl71Et9H9wJy5V10S3g9lhcLq1MOxErN1KlNZHkIc8VzD/YJ0A==
X-Received: by 2002:a05:622a:208:: with SMTP id b8mr1115049qtx.101.1603137816368;
        Mon, 19 Oct 2020 13:03:36 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e19sm451471qkl.94.2020.10.19.13.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:03:35 -0700 (PDT)
From:   trix@redhat.com
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] PM: sleep: remove unneeded break
Date:   Mon, 19 Oct 2020 13:03:30 -0700
Message-Id: <20201019200330.16629-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/base/power/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 205a06752ca9..c7ac49042cee 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -363,7 +363,6 @@ static pm_callback_t pm_op(const struct dev_pm_ops *ops, pm_message_t state)
 	case PM_EVENT_THAW:
 	case PM_EVENT_RECOVER:
 		return ops->thaw;
-		break;
 	case PM_EVENT_RESTORE:
 		return ops->restore;
 #endif /* CONFIG_HIBERNATE_CALLBACKS */
-- 
2.18.1

