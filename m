Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73C1292E83
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbgJSTch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731067AbgJSTcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603135955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=fz8ym4oVc1gCQn9wZPkVIpRLpAccmzB83wmPoGnAnN8=;
        b=PHCDxXa6I6lFyg6CmmE2WgOdju4w72/3MHBbUfZLHSNSgOreDVhRqHsM7w0099bXLDP+71
        ZpwfgDv8Rv6PhX4HSiSJs5jEeRKOEbyftf6V2uprdJF2/6usDKztIK4rnJwbAA7DJCHGyz
        zOmuknuYe6OT+925mHcCM/sVgwz1/hQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-hr6ScYcdOKCOYCeAeoY0NA-1; Mon, 19 Oct 2020 15:32:33 -0400
X-MC-Unique: hr6ScYcdOKCOYCeAeoY0NA-1
Received: by mail-qk1-f197.google.com with SMTP id b7so459028qkh.20
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fz8ym4oVc1gCQn9wZPkVIpRLpAccmzB83wmPoGnAnN8=;
        b=TknwOLFHVv1zDDUhRpSqF3mT0mVNNiEp7pFDVOEbm1LWZq606j7OnUowKfpDS7dyHe
         jaD6PuG+7uWOo3VGz/zv0sDh8vQ/JTQEkvqVGjSpvIMQoUnmD68SCc2j0639OtxQUUdE
         meXH+eCVxXyhd8+nzur9qxqANr4EMdJ4yuI4RO3J0WYht5ATZdU6EWRfuIRAQ9rHHrNu
         mj9+5XIAMKt8+ATt5CmYtW3hiZ1tZUGwAL0xZKyyj++JVR3LlvkVs1xgK98EJbxbYsAl
         GaeIkMaAHQtJna9Pv1qXU/62NB0GU+WrE8vKjgy5JzA6xhABqerR6e9UKkDKkOAgFrF7
         47Dw==
X-Gm-Message-State: AOAM5311gz2QyLED3CWizGiRKQun5pEwRbSEkt2OmQcf+suLLKaTfczb
        Xsy78hwWMovDnGEL8sBpKrb17+FCPCPSwqEMTpqb/dA0s3PCYc2jcbAaIhk03bW782RCk+Rxtga
        GB0KTJEx8F7jorCEEj6OzvUaP
X-Received: by 2002:a37:a81:: with SMTP id 123mr1126134qkk.487.1603135953015;
        Mon, 19 Oct 2020 12:32:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjGKFVGD5PW0deM0q0Np4e7HM1MOF3o5e1OcEKDr5d7giAMlnDl+MCUlT/s9+zXspoOECLhA==
X-Received: by 2002:a37:a81:: with SMTP id 123mr1126109qkk.487.1603135952765;
        Mon, 19 Oct 2020 12:32:32 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id n38sm355058qtb.91.2020.10.19.12.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:32:32 -0700 (PDT)
From:   trix@redhat.com
To:     siglesias@igalia.com, jens.taprogge@taprogge.org,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] ipack: iopctal: remove unneeded break
Date:   Mon, 19 Oct 2020 12:32:27 -0700
Message-Id: <20201019193227.12738-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/ipack/devices/ipoctal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ipack/devices/ipoctal.c b/drivers/ipack/devices/ipoctal.c
index d480a514c983..3940714e4397 100644
--- a/drivers/ipack/devices/ipoctal.c
+++ b/drivers/ipack/devices/ipoctal.c
@@ -544,7 +544,6 @@ static void ipoctal_set_termios(struct tty_struct *tty,
 		break;
 	default:
 		return;
-		break;
 	}
 
 	baud = tty_get_baud_rate(tty);
-- 
2.18.1

