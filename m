Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3DF292EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbgJSTsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728196AbgJSTsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603136894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=bDsOLCPMFbR0cX2CHf90aiCRZhzzCHCD2XRNuPp/+Yk=;
        b=ardXh3r58iBQt1iqeXxYCkpIIPi5l8E/dvnPKwKlIvyg8yYXOGXmeGW69WFAFTIwZUGZ0i
        Z+aMcx7J2hrZftIhJb39mcgBDDcv2Fd51xtlE54Lp//8JT3iuQaTT9Y2xAjwSfDsx65V9f
        10f3Rps9xjRXjFPgxR8p5cWfQoYNLew=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-2bDhgV0VMhONK4gNHKcAXQ-1; Mon, 19 Oct 2020 15:48:12 -0400
X-MC-Unique: 2bDhgV0VMhONK4gNHKcAXQ-1
Received: by mail-qt1-f198.google.com with SMTP id d6so768306qtp.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bDsOLCPMFbR0cX2CHf90aiCRZhzzCHCD2XRNuPp/+Yk=;
        b=co5nwm/JKZZ8XPERCiJ/gQ2uc/2c+51c7DU9b/rP6BjZSzWyZa0evayiTONBymd7ow
         k10GJUkOyC6GH9mL7Kg4e2PPyAtzH3MycDz3ns5DURzXltQj+rJgjznPMI0etsAFV5o7
         0dgtoKZzug7goMJUWSNBYzt1HtfKjkqq9V1DVwp7I2fwfplYAANWAMkKj29Kh1NIFuyN
         eexx/oWFmi+LQMT/qz7qjsm2ZgDyTkY8aAay5qh/YZ0dQG0WcFq7d7P7Ieg/zIj0wsPN
         brj5Zlzm0Pc4FEnKtZVWAE9TBuBWY7KUWY8N8vIU6xNo1JolRmcCp//hm/FPCQmE4g9F
         4ubw==
X-Gm-Message-State: AOAM531Fmz2djVDkboYQ/ZCpeYyXGplKIGnG9mPAdveDuBOdMmaMC7g1
        f6O2OAOi6OLC5I+r+ijofm956Cy8F4yars8jI8P4FWnrKpbOCXCBtDeJ4c8G0/If/t0E54SODXa
        H5yZSMoeA0CoF5tSGIZjaDXvO
X-Received: by 2002:a05:620a:1265:: with SMTP id b5mr1202488qkl.27.1603136891918;
        Mon, 19 Oct 2020 12:48:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw81CUYvfLxISx3cCT0e2fYZOtr8WmXKqMokhkkzTusHzNRfZPMRYaV2QRXolMgWnlxdu+WoA==
X-Received: by 2002:a05:620a:1265:: with SMTP id b5mr1202347qkl.27.1603136890093;
        Mon, 19 Oct 2020 12:48:10 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a3sm374871qtp.63.2020.10.19.12.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:48:09 -0700 (PDT)
From:   trix@redhat.com
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] char: ipmi: remove unneeded break
Date:   Mon, 19 Oct 2020 12:48:05 -0700
Message-Id: <20201019194805.14996-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/char/ipmi/ipmi_devintf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
index f7b1c004a12b..3dd1d5abb298 100644
--- a/drivers/char/ipmi/ipmi_devintf.c
+++ b/drivers/char/ipmi/ipmi_devintf.c
@@ -490,7 +490,6 @@ static long ipmi_ioctl(struct file   *file,
 		}
 
 		return ipmi_set_my_address(priv->user, val.channel, val.value);
-		break;
 	}
 
 	case IPMICTL_GET_MY_CHANNEL_ADDRESS_CMD:
-- 
2.18.1

