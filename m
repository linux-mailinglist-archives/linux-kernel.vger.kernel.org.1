Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073592C6BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 20:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgK0TLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 14:11:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52215 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730231AbgK0TH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606504035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=I6Zs1ppjgvsb9FmTfYHegzS9VUFA58Y2RT71kFALmk0=;
        b=VBH9ASjJElAT9K/uFs6cuitbwv5K/cEyKjlvgkhrjxnQsqZLv2JA8ljIyAB5rc1nPMAOH5
        m8WL9wsemYQ1OFnKXP5aTh0K+E9+XBajd7haIt8fQ8UQOpx9cN7FdqJfrcL4dQo0SYZQHp
        8rWM2BUhHkEBmGCjIV0tm1L+q6fyDLA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-cYbGYOlZM1OH88V7slaRTw-1; Fri, 27 Nov 2020 14:07:13 -0500
X-MC-Unique: cYbGYOlZM1OH88V7slaRTw-1
Received: by mail-qv1-f70.google.com with SMTP id i11so3539706qvo.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I6Zs1ppjgvsb9FmTfYHegzS9VUFA58Y2RT71kFALmk0=;
        b=ZNNtoYYWovh7wW9986iRiUNUxzs13BXHPq9grw7GVPga0XJNZBh9bmhEHrSDE3Jj8S
         SYuhWogmKEblSoF+FbMWLf7x3jA5MyXHe2DM2Ku/xvX4uHPbx2Owf82mF5FeIAJ40Tsw
         OYFoq8Y1FloaEygSE5t8HLj+OXTKn3ZB/KjVKQLqhzj+yZAS6fGkW+5gbalcTrrFlLYA
         O7Kv87znEVakzl5MIhUXBmuwmvoyk0XA5TM4me4+j6smSn2mdci/0+TC4oDJkPQNGWwS
         Hl4eagtkcQSOzF6Q1GtmdbdIwASBwHzYup1IuUmIiFm4PClZ6dKoKJdmJaX5eApgZsZl
         Y/cQ==
X-Gm-Message-State: AOAM531hC++a6LrWIrCifmGFTEv6FMfvYSQUH9BTf7FwGNqOe2Ku2G7p
        xDqHMWU1tX8YWtLTkE4a4fKBv4Zd6H/dIyJxHp58CRzma2Ug5J4pIKgGTmZGE4OSaZbx6VudoQ3
        AdMMsrTClcUXOMKtiKwmZcnIk
X-Received: by 2002:a05:620a:b0e:: with SMTP id t14mr9965066qkg.484.1606504033304;
        Fri, 27 Nov 2020 11:07:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvj5eobwkEJNyqoVShHJCJxrseRSWu+CqEGkPc1azciUrLyazjZjBInigD5gj1nmHkBnKw5w==
X-Received: by 2002:a05:620a:b0e:: with SMTP id t14mr9965049qkg.484.1606504033139;
        Fri, 27 Nov 2020 11:07:13 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l10sm7065821qti.37.2020.11.27.11.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:07:12 -0800 (PST)
From:   trix@redhat.com
To:     jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] locks: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 11:07:07 -0800
Message-Id: <20201127190707.2844580-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/fcntl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 05b36b28f2e8..96a65758c498 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -526,7 +526,7 @@ SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
 	(dst)->l_whence = (src)->l_whence;	\
 	(dst)->l_start = (src)->l_start;	\
 	(dst)->l_len = (src)->l_len;		\
-	(dst)->l_pid = (src)->l_pid;
+	(dst)->l_pid = (src)->l_pid
 
 static int get_compat_flock(struct flock *kfl, const struct compat_flock __user *ufl)
 {
-- 
2.18.4

