Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E30D292EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbgJSTpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731325AbgJSTp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603136712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Hb08AltmgsRmhtwJsTFuAg4pMIkcbc9NuPKooD4kYfc=;
        b=Iun/M7bKQASeOYR49mcF1PGqyLTEbLN7E3xO5siYY0wEP8EBqA20HuX4AyFgHiwCbeEowu
        dqYE/1dtyyt13+o7VlKPv8OUsxcNqbyjedOphSDrC3cg0djllU3Cxe4rGILMTnYTXTaRWJ
        UrnZwC5xwzbcSIbrNkOCakJ8DGT59rI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-aqFKYCjIO8KDlpiB4qbHDQ-1; Mon, 19 Oct 2020 15:45:10 -0400
X-MC-Unique: aqFKYCjIO8KDlpiB4qbHDQ-1
Received: by mail-qk1-f197.google.com with SMTP id x5so528170qkn.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hb08AltmgsRmhtwJsTFuAg4pMIkcbc9NuPKooD4kYfc=;
        b=iCdh+ZnQSVNkGBQ0gCIVNUe+epktpT8S3OlDWm3oohrE2ryPueZgdOKGmYf9w4tJJr
         XjlXezjp6SmzZOHy2zqaLddGZ2QLTAqdEVR5rJpyVF7EkWD6HUh3PcqvMB1JvMTf5Azy
         JCbP4IixEaeyBQdcAY68fjoiRR1bNZdHt4sj1gjGfTrcRYaMC3iZXncikrSYUQSqRDx2
         nNekyK3uHJbW4aGxdd5VIRql6tVGUFR8NQTahtTSaRm5sY2x5pPqlUOsqBpGFx0y+95l
         evLEoUcfbfHepVZxJqceU31mof87ZzsfaeRTrdZuvRPVnIY6TUx0a+vpU+D15m0mkieW
         stHg==
X-Gm-Message-State: AOAM5301yCeCNO7I3xsyJ1Eizhz3BRzmJ31a6lfnIgZoVOa+J5GUS7f4
        hNj7gYpkuqfRZTrsIS0e6ar26d/0xsDcqqU6WlS3snMqiLSaj3OKtDrQmDH7mvnohisJmRuEGsH
        U+Vl1C4gTV05EOed5+AkEM7bF
X-Received: by 2002:a37:9282:: with SMTP id u124mr1206425qkd.463.1603136708862;
        Mon, 19 Oct 2020 12:45:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx58oVjzz/M7zy9xycRk1BT9+VEbkeqK7y8Ysr5VeNHk7h4hHRhEmzOgvJQP4p8ZuY5af35Yw==
X-Received: by 2002:a37:9282:: with SMTP id u124mr1206386qkd.463.1603136708442;
        Mon, 19 Oct 2020 12:45:08 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d142sm435877qke.125.2020.10.19.12.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:45:07 -0700 (PDT)
From:   trix@redhat.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] char: mwave: remove unneeded break
Date:   Mon, 19 Oct 2020 12:45:03 -0700
Message-Id: <20201019194503.14426-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/char/mwave/mwavedd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/mwave/mwavedd.c b/drivers/char/mwave/mwavedd.c
index e43c876a9223..11272d605ecd 100644
--- a/drivers/char/mwave/mwavedd.c
+++ b/drivers/char/mwave/mwavedd.c
@@ -403,7 +403,6 @@ static long mwave_ioctl(struct file *file, unsigned int iocmd,
 	
 		default:
 			return -ENOTTY;
-			break;
 	} /* switch */
 
 	PRINTK_2(TRACE_MWAVE, "mwavedd::mwave_ioctl, exit retval %x\n", retval);
-- 
2.18.1

