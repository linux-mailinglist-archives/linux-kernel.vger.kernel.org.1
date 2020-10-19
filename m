Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F29292D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgJSRxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:53:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729691AbgJSRxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603130029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=LLjblUCn7iRKFxxThjG5nVwBVGOxZRHJPdIXJgYV+lc=;
        b=e5RBa8fk+rhNZfbuPo3kr9+xksPu0vd3ZLt739vJGQdvAW6fRHq8hT4l/ibhw9HJXEpfVU
        oXbKqmP3vtzbj6CCe9ACMx6OLDfOl23c1QJE9QB76GVCmXs/SjYyhBk2M9p8qogHCqtWu/
        dEIcOsZMomUOeRMYGdB7hvJ9/AgvEWk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-oL14JSiKNhOIq92-AlpXvg-1; Mon, 19 Oct 2020 13:53:47 -0400
X-MC-Unique: oL14JSiKNhOIq92-AlpXvg-1
Received: by mail-qk1-f200.google.com with SMTP id y77so201938qkb.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LLjblUCn7iRKFxxThjG5nVwBVGOxZRHJPdIXJgYV+lc=;
        b=PCZEsQUDx+hLaijCKLR2E5eN0tH2SohehNVOwmyde5VGqEeR1isqHFM6b4AM+f6ZRp
         npJ8hDBZYXHOguBnnSWWb+D03V8XAWIblPwv3Xuwnskb5P1veLWRyJBZICCclrIYHASH
         JJJ6R6h1H50yI38B0v86JCTJY5rJvT++/2PfOIGxwFodon/M8kRnsIFR7p86DX3u+eL+
         19Dp6xTPmK5Rm1obxll32jmaZfwq5ecgFwTYAnNsXHeSoN4U/HYfdger3EIxjgXp1i9U
         Y3UphC0F0/tPISogHHkMeod2jklxfcMHGzUrrf3pyqiJO1rSLMxP6TpTI0Qfpde9xWaS
         CJIQ==
X-Gm-Message-State: AOAM5306gG5mCNWKrRkuG2Ex+9GVNb8I+00dFto+b/S341l5A0hmA/L4
        wjXftDJZqs/QXC5cgTJQUGM6DmqQmuw6vISCigYT5wvpg7tJj8Vx5XDMCivjhySUBzbfmgufrKv
        7QT78rumIP7qqQ6kBp0837oLF
X-Received: by 2002:a0c:b741:: with SMTP id q1mr913662qve.37.1603130027084;
        Mon, 19 Oct 2020 10:53:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT6/EwoAVbW9h2rP+cuwpdug2dOx3Zy6Bv3kP/mm4k7veTPYuqu5gpuCfaMtgkdu05aMzUQA==
X-Received: by 2002:a0c:b741:: with SMTP id q1mr913643qve.37.1603130026889;
        Mon, 19 Oct 2020 10:53:46 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f185sm314128qkb.35.2020.10.19.10.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:53:46 -0700 (PDT)
From:   trix@redhat.com
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] watchdog: remove unneeded break
Date:   Mon, 19 Oct 2020 10:53:42 -0700
Message-Id: <20201019175342.2646-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/watchdog/geodewdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/geodewdt.c b/drivers/watchdog/geodewdt.c
index 83418924e30a..0b699c783d57 100644
--- a/drivers/watchdog/geodewdt.c
+++ b/drivers/watchdog/geodewdt.c
@@ -150,8 +150,6 @@ static long geodewdt_ioctl(struct file *file, unsigned int cmd,
 	case WDIOC_GETSUPPORT:
 		return copy_to_user(argp, &ident,
 				    sizeof(ident)) ? -EFAULT : 0;
-		break;
-
 	case WDIOC_GETSTATUS:
 	case WDIOC_GETBOOTSTATUS:
 		return put_user(0, p);
-- 
2.18.1

