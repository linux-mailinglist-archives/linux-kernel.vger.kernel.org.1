Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9282994A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788947AbgJZR6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:58:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39578 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781797AbgJZR6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:58:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id e15so6611277pfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9/6iMyuxRs29CcJNRGQlw3NkjK+ZAaS1DQKNOdZ49Y=;
        b=hKM+EPsFhBXudgBvBD6S/N+2rd4p0d87n+1PsscRuF8xG8aOokGqs1Scy01fSvCylK
         vFtVN5EVEStMT82Rv5AUwG7HaV95viWhftFrFm7Pjd8/H3nFJ1srA4+LYQdNcMX9ELOP
         NtwOz1qez9ijYPcyDSgSwsG9dlxvuQ8A6NppwAb4Hc0xYclisfujp8nptwltUtB4p+x9
         ldxOiwgJS3JsyKj2WHpa0s3C6i9/jmUy2HWSBwVM2xCGJrxi8K/Eoc1i236ds5H/G4wJ
         xmXaC6bIw+9iwiba92w30PmnOojGPKtaLVBaot3yRtneEjVV5ZvXiGLCxaRjXgLn4+6r
         SbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9/6iMyuxRs29CcJNRGQlw3NkjK+ZAaS1DQKNOdZ49Y=;
        b=P4xFMHTD2tqmkKgkDMWIG7HZOntP99YgQh9HG8CvkeLXtVqA00u51XEZTPqnP8mOHO
         cdzwaM1QebuAod0olXDQkb5GOInDnmI/1U4CRYqOgRDfN3uCtKjok+or2pXlj8y49ngj
         4e70q6vG/unfAexFrafSZiD8Z3tvA+fd/pvOq7EtUHorfKibS6z3Mfx4L+L6gVlSfbDj
         mZQd5vhxu8dast60EwhkoYns2Mx7gDdLXvL8l1CJxj4glcQxUf27XnrjRSGKQX2AqYYV
         Oc/EZKHxARCLasNQ+nsYBl63M3oOJjjowl/Wy/1dhNgY1lc41uKUGclaF7Ts7LH2f4UQ
         NVNw==
X-Gm-Message-State: AOAM532tM7colRzcPBlGusQOCZ9VnF7ZGhRaWY9o533gbjzSQcILDjII
        UY32eQkwwu4dpDTJmEBMOhqe
X-Google-Smtp-Source: ABdhPJw2lnv9eXuIfyKMaV0vZcd4W0AB+lLZP2R6KF9/aiT6U25wEoMJoTUI98wCUAp3d0KnHSTTnw==
X-Received: by 2002:a62:148a:0:b029:156:857e:853f with SMTP id 132-20020a62148a0000b0290156857e853fmr9112632pfu.25.1603735104771;
        Mon, 26 Oct 2020 10:58:24 -0700 (PDT)
Received: from localhost.localdomain ([116.68.74.56])
        by smtp.gmail.com with ESMTPSA id o65sm11583088pga.42.2020.10.26.10.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:58:24 -0700 (PDT)
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     johan@kernel.org
Cc:     ribalda@kernel.org, robh@kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, masahiroy@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kbuild@vger.kernel.org,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, vaishnav@beagleboard.org
Subject: [RFC PATCH 5/5] gnss: change of_property_read to device_property_read
Date:   Mon, 26 Oct 2020 23:27:18 +0530
Message-Id: <20201026175718.965773-6-vaishnav@beagleboard.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026175718.965773-1-vaishnav@beagleboard.org>
References: <20201026175718.965773-1-vaishnav@beagleboard.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change of_property_read_u32() for the current-speed property
to use the device_property_read_u32() this helps passing the
properties over a suitably populated struct property_entry.

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 drivers/gnss/serial.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
index def64b36d994..473faeea6aae 100644
--- a/drivers/gnss/serial.c
+++ b/drivers/gnss/serial.c
@@ -110,10 +110,9 @@ static int gnss_serial_set_power(struct gnss_serial *gserial,
 static int gnss_serial_parse_dt(struct serdev_device *serdev)
 {
 	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
-	struct device_node *node = serdev->dev.of_node;
 	u32 speed = 4800;
 
-	of_property_read_u32(node, "current-speed", &speed);
+	device_property_read_u32(&serdev->dev, "current-speed", &speed);
 
 	gserial->speed = speed;
 
-- 
2.25.1

