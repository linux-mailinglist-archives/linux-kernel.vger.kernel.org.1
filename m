Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F8E2C74E3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgK1Vti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60696 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730592AbgK0TwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606506722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=d6G2nIxqhehmcqneDPM87NHHHaegmMSyQEpv2XH/rd0=;
        b=AHjfxDZvswEhfXFCFTrIKnbkBR01ls22Un7eTJk5MBJHjxs+4K6WredZs4nRPKlNtyZ9H4
        b7kaySKfjUATkpp1PB2Gh5qLIF/fGnwLZIoFu05ZfdFZYO4dqje1EKhth/iJcSuvr5f3tO
        KRC/VqR75HXHQtM67lzvBPUshTY5iac=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-0IvVAJAQONmmdzkthLSmcA-1; Fri, 27 Nov 2020 14:15:48 -0500
X-MC-Unique: 0IvVAJAQONmmdzkthLSmcA-1
Received: by mail-qt1-f199.google.com with SMTP id r29so3737403qtu.21
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d6G2nIxqhehmcqneDPM87NHHHaegmMSyQEpv2XH/rd0=;
        b=s5t+gKgH0hjmO0DxYqVzRIqw6px3pER5CEc1BMAWzeuqjLMAeTJ17Zsz0UU2xRYvHR
         nT/9lk42KZfWjDe2K7fQ0JHSxjJkHTwB7ZQ9Z8jQRHUfPgKhgS0esfy5oHmJbTPXu2p8
         aa9/nR375bkmXkhMALrqbq7D9ClDtmlVnzAbQH8Heo4PFqHFv8LeXcMUoYkBxAG5rJcz
         p3q1hEf8BjPPKdEhuJ6QPALEmvCvqOY6HnSKJLkROkycAYDyjDM+5ZKNgdoPui8GpnlK
         iyVNa2KLAWWNhCZZ1jusdJl2Kh8CYGxGLi84e3JFteuxoeX1Tz+6qlUj5Qali2TX1ZyD
         ZOSw==
X-Gm-Message-State: AOAM532gJIaZZLWbJoWh+t1BCfI91nsaespqk8pIJCt6f9THtyPNYU7L
        PkZ7nWCXY//CXJdU5bM9cLZ5WH8lhChuOwMA8mSu0CmvwxoWOsYrXZVUmZROc0IYZNQuv8yUAq4
        4KeKFVDrkVBTcpYjp+Gz/zLUf
X-Received: by 2002:a05:6214:190f:: with SMTP id er15mr7930541qvb.33.1606504548340;
        Fri, 27 Nov 2020 11:15:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLfzJKgPIayT6gRKsye8GTE3djuTXJDuAjxD/1iyv8tQ8iZ40gPZ9Bl4CSLya6Ta2xQATbGg==
X-Received: by 2002:a05:6214:190f:: with SMTP id er15mr7930523qvb.33.1606504548133;
        Fri, 27 Nov 2020 11:15:48 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p62sm7033652qkf.50.2020.11.27.11.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:15:47 -0800 (PST)
From:   trix@redhat.com
To:     dhowells@redhat.com, jarkko@kernel.org
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] keys: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 11:15:43 -0800
Message-Id: <20201127191543.2854306-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/key.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 0f2e24f13c2b..1b0837c975b9 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -360,7 +360,7 @@ static inline struct key *request_key(struct key_type *type,
  * completion of keys undergoing construction with a non-interruptible wait.
  */
 #define request_key_net(type, description, net, callout_info) \
-	request_key_tag(type, description, net->key_domain, callout_info);
+	request_key_tag(type, description, net->key_domain, callout_info)
 
 /**
  * request_key_net_rcu - Request a key for a net namespace under RCU conditions
@@ -372,7 +372,7 @@ static inline struct key *request_key(struct key_type *type,
  * network namespace are used.
  */
 #define request_key_net_rcu(type, description, net) \
-	request_key_rcu(type, description, net->key_domain);
+	request_key_rcu(type, description, net->key_domain)
 #endif /* CONFIG_NET */
 
 extern int wait_for_key_construction(struct key *key, bool intr);
-- 
2.18.4

