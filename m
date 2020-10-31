Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5392A1824
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 15:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgJaO2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 10:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgJaO2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 10:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604154490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=KDQ2Q1WrfPeBaMWL4WQgVqLf/RWk9Z5JfCqkrJoKAU8=;
        b=ONWKyBlmVZiMX4t61tJekVYNmtN0MahPbv6Y+DYFom/Jfq+kjv1DqZxeegdWOX55RhpYfb
        1j/guE0D7MzLLkz15mcvn8FEYNKtSIRcKI/DiobnSza5LaODhUCQFZLF5rrs3KhtdiJgMT
        yXCQUqT8iUxPNfmKs5UCi324fVWaNEs=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-q3Jv0kfJMFCy58xk__Oa7A-1; Sat, 31 Oct 2020 10:28:07 -0400
X-MC-Unique: q3Jv0kfJMFCy58xk__Oa7A-1
Received: by mail-ot1-f72.google.com with SMTP id x12so3838949otq.11
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 07:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KDQ2Q1WrfPeBaMWL4WQgVqLf/RWk9Z5JfCqkrJoKAU8=;
        b=EdC55/ivL4akyvrFAQkLezmK0VzwIZYyFknwNbBrjc5xl9uzEVxe3KT12XXeOx/FBu
         H3hfFqvWgP4ryKdS0iMqM758k/kYPyzL2x8J4VPrGtELGb0Xm8ojFANJWkP9mxdy+gvL
         ZmrHfebc6EjsaSmXBweHAxXOErVklYdvOq8VZTDt2mIKs6aiE0H69rV6ek5yeDnWBgZC
         24IPu8AEmckQbri87iDGU/J0RtDPm44uoF35QTIlrvyomkeOWBlHFtP8TxRrz69dQ/BK
         8S14pjbwPPHLDN8YzYxNcRu8JMksZzHbDcQiBSLrkA7XMZmbY1tDvsrq5W2FKIs8cbSP
         nDZQ==
X-Gm-Message-State: AOAM531hv0s3hyl2wTYVjZDAIsvvfTLSIUpGHUKCMYDiS8I2HCg1FAby
        t19EOdEkQd9X24uOaS6QPoUnesFgmWVDP2oajsOnmgMQaqxQzc7Ykv4T6pZkz0veLr5/uLMuikP
        rt8GcS7JQkQGTsswUQhqyFvu1
X-Received: by 2002:a4a:d848:: with SMTP id g8mr5776408oov.35.1604154486780;
        Sat, 31 Oct 2020 07:28:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL4YNo6zuxvjwLQHq+MTN5D27aIClSv1bhC8z+upoQKQkJ4Vdxt3pW0jvKVDrp7pvrCaxYTg==
X-Received: by 2002:a4a:d848:: with SMTP id g8mr5776397oov.35.1604154486629;
        Sat, 31 Oct 2020 07:28:06 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x14sm2063997ooo.43.2020.10.31.07.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 07:28:06 -0700 (PDT)
From:   trix@redhat.com
To:     oakad@yahoo.com, maximlevitsky@gmail.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] memstick: tifm: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 07:27:56 -0700
Message-Id: <20201031142756.2140029-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/memstick/host/tifm_ms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
index 786e46798da2..57145374f6ac 100644
--- a/drivers/memstick/host/tifm_ms.c
+++ b/drivers/memstick/host/tifm_ms.c
@@ -528,7 +528,7 @@ static int tifm_ms_set_param(struct memstick_host *msh,
 		} else
 			return -EINVAL;
 		break;
-	};
+	}
 
 	return 0;
 }
-- 
2.18.1

