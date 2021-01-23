Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2E6301689
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 17:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbhAWQBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 11:01:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbhAWQBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 11:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611417613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A9lrkRkDFl2822VxzUCycvBhkreTTq48B/9OTJ+zgls=;
        b=NXdwXVaBa3VnI4bDb0B87x5JBB4ZW7cERL2pXZySt+OSk85FSvNw7NCsMZTlRJ1WXpACRC
        q+2R4znjk8kKgdMhBO+Znbexp+EK9K07aiOuYFoC28ZEuC3dVfko9viOWDEgjJ/AS3V0S0
        u7gO+yolioVFfcAfQ/LwwAh95B5uCtQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-Wy0yjB3jNW6X98EPS5XqxQ-1; Sat, 23 Jan 2021 11:00:11 -0500
X-MC-Unique: Wy0yjB3jNW6X98EPS5XqxQ-1
Received: by mail-qk1-f198.google.com with SMTP id f27so6496187qkh.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 08:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9lrkRkDFl2822VxzUCycvBhkreTTq48B/9OTJ+zgls=;
        b=gGl1cQ1Z0L85gVKRSvJULWLEuaOad4LYgNEpkK2rLfYqkOmZbfNqJx6lt8PvaGToX4
         PpQkkqsiFRwnEJBj4gaEDw35tjjZ/vZGTJ/tpctdESgk1DIIjmxLa79eKXinNIbXnop7
         fHdfuWx21xdBG/QtuYBqH6WMZZLv3VZpTQ1pdrin2qOltzkN2e9443BWkP8MQSuzHAF4
         vLqXIz9kJig3CoxuHX+Fux1OhatJUdPinYUYHS3NTC4MGiWWWWHoMa1euq+WSrJ3hj1R
         tqjTJuAQf9infnsoCRcq0I7M7Y0Z0rUeWU9O6ZtYJigqNqZpePiJxRKN1PpOiUT1kAcz
         0aHg==
X-Gm-Message-State: AOAM531idl9bYkb14Wuwm6ff8zQw3djNlbyAigpOHM08g+ICZdjaj8TS
        6vIpIdLCx9f4Dou+ujRyZ+eWv7SS8TP/beW/fdhYbUpVAJSwOj932KBUAUeBzQ7vBp43McDD6iH
        Fr2+InPUU6yHfeE5D31nRjTav
X-Received: by 2002:a37:8942:: with SMTP id l63mr6356888qkd.94.1611417610555;
        Sat, 23 Jan 2021 08:00:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4F5VqVpL2DF5NH4zhNSpbcvmUh/4a9Qm27AdeAZmARbokFvrLQlkp7Tr4xRBZNkPMO1Hk8A==
X-Received: by 2002:a37:8942:: with SMTP id l63mr6356870qkd.94.1611417610342;
        Sat, 23 Jan 2021 08:00:10 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i65sm8725800qkf.105.2021.01.23.08.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 08:00:09 -0800 (PST)
From:   trix@redhat.com
To:     robinmholt@gmail.com, steve.wahl@hpe.com, mike.travis@hpe.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] sgi-xp: remove h from printk format specifier
Date:   Sat, 23 Jan 2021 08:00:03 -0800
Message-Id: <20210123160003.1777766-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This change fixes the checkpatch warning described in this commit
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
  unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/misc/sgi-xp/xpnet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/sgi-xp/xpnet.c b/drivers/misc/sgi-xp/xpnet.c
index 23837d0d6f4a..2508f83bdc3f 100644
--- a/drivers/misc/sgi-xp/xpnet.c
+++ b/drivers/misc/sgi-xp/xpnet.c
@@ -208,7 +208,7 @@ xpnet_receive(short partid, int channel, struct xpnet_message *msg)
 	} else {
 		dst = (void *)((u64)skb->data & ~(L1_CACHE_BYTES - 1));
 		dev_dbg(xpnet, "transferring buffer to the skb->data area;\n\t"
-			"xp_remote_memcpy(0x%p, 0x%p, %hu)\n", dst,
+			"xp_remote_memcpy(0x%p, 0x%p, %u)\n", dst,
 					  (void *)msg->buf_pa, msg->size);
 
 		ret = xp_remote_memcpy(xp_pa(dst), msg->buf_pa, msg->size);
@@ -218,7 +218,7 @@ xpnet_receive(short partid, int channel, struct xpnet_message *msg)
 			 * !!! appears in_use and we can't just call
 			 * !!! dev_kfree_skb.
 			 */
-			dev_err(xpnet, "xp_remote_memcpy(0x%p, 0x%p, 0x%hx) "
+			dev_err(xpnet, "xp_remote_memcpy(0x%p, 0x%p, 0x%x) "
 				"returned error=0x%x\n", dst,
 				(void *)msg->buf_pa, msg->size, ret);
 
-- 
2.27.0

