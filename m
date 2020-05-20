Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688801DBAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 19:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgETRHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 13:07:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57017 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726835AbgETRHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589994467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h8s8eLV7Rc+UskCAa0sA5YpsdyL5CTF8FfVq7I1LuUs=;
        b=CAW4kdbNc6OspzFZ8q9qLx121a6CHcGMMTQ3NZa5LevvFXosXKuV7lWHHWG4XWm8ptwe5H
        24O9Zf9zLzri2FAAIXFrjo01FjBSd8wkk7u9yT4IZbZGs8n30GC43/vv/h2kAXjJkApCcu
        Pzvwow2PLO0NmIws8b6okETG758ARd0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-INsAV-zpOO6Sns0liO_eVQ-1; Wed, 20 May 2020 13:07:45 -0400
X-MC-Unique: INsAV-zpOO6Sns0liO_eVQ-1
Received: by mail-wm1-f69.google.com with SMTP id q6so1090270wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h8s8eLV7Rc+UskCAa0sA5YpsdyL5CTF8FfVq7I1LuUs=;
        b=YETMb8Kr6/W7cfw0sWi64WnZsuvfsIA+I0WFIS+e3eEQXCji7aVPJILqUmSK2TopbW
         gfHnMayk8lNgApHXUskXWrq4xiRGRpmBAV5ip9qXqCrk7ohjnffdBfEvfjJsJU9jeg5i
         nu4LmpJSw98UBlbWntzH/Oqf8vlC8EdqfFYw5ksU6u7amChyigpgCui5+c7W2AvyewFc
         7yGyaYHCeG3PG9F0O5pUH1P7AfQxjARefWet1j/+c41xsYW5n/bi/Oygk4irkqoExO2j
         wokhez7WYNj5CXRx2egx2cayAfewAK+4FyJGH5LoNpV2A3hDKJneQifNImFhMN/4zNLv
         VWMQ==
X-Gm-Message-State: AOAM531Vh1HKCOcNCLLCGtdoHSmX5rPlI4ADEEBcTSM3eOJ0WEu38a1E
        E6qP7kM3W4BIlHsGtIzfEWVxELjVFo+UJoYglm3wPNadGZRZwiGUxLMvgsvW8iNQXYMr7ml5F5p
        hiJfyfRC9cUbdldaiv90jZ9yv
X-Received: by 2002:a1c:29c2:: with SMTP id p185mr5106268wmp.7.1589994461626;
        Wed, 20 May 2020 10:07:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXwz+s1k2t4Yt/PPpgCx537sWFWIohMV+6cLRupqxNVklTI9TSnTh39ma356x642wRy6d4eA==
X-Received: by 2002:a1c:29c2:: with SMTP id p185mr5106256wmp.7.1589994461441;
        Wed, 20 May 2020 10:07:41 -0700 (PDT)
Received: from steredhat.redhat.com (host108-207-dynamic.49-79-r.retail.telecomitalia.it. [79.49.207.108])
        by smtp.gmail.com with ESMTPSA id s8sm522512wrg.50.2020.05.20.10.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:07:40 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: [PATCH liburing v2 4/5] man/io_uring_register.2: add IORING_CQ_EVENTFD_DISABLED description
Date:   Wed, 20 May 2020 19:07:13 +0200
Message-Id: <20200520170714.68156-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200520170714.68156-1-sgarzare@redhat.com>
References: <20200520170714.68156-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 man/io_uring_register.2 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/man/io_uring_register.2 b/man/io_uring_register.2
index e64f688..5022c03 100644
--- a/man/io_uring_register.2
+++ b/man/io_uring_register.2
@@ -168,6 +168,14 @@ must contain a pointer to the eventfd file descriptor, and
 .I nr_args
 must be 1. Available since 5.2.
 
+An application can temporarily disable notifications, coming through the
+registered eventfd, by setting the
+.B IORING_CQ_EVENTFD_DISABLED
+bit in the
+.I flags
+field of the CQ ring.
+Available since 5.8.
+
 .TP
 .B IORING_REGISTER_EVENTFD_ASYNC
 This works just like
-- 
2.25.4

