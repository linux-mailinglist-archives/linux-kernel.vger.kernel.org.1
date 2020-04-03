Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A99019D7E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 15:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403880AbgDCNns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 09:43:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40142 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390915AbgDCNnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:43:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id a81so7731937wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mjzjw6acIOcM+AePCmOJ/RJwLcwwLr94rISpIdIa8zw=;
        b=J9Im480znNJhXkZnzvuOS7V+yE/zCuJ14U7YI6QPp8WhFMRFk7nMFP/3eVVYIrFZ3y
         0fGp6BTZY2YTSDIjejAYyVVRGyAUhwmV4cgGmIVHpviz6zaihArFXCMFGqzHN5Wn3QFX
         PUernwfnSbqBXC688JhsS7+twR0rnCnrkRv8vwH4NN56ElniVdCac0dhTPEYYqYVeNAM
         OglTuLoIsQAYUHl7alyyaxRZ++AdhTmcrSphUrUA+l/2GLUnBnAgvwr9Qe8rOBDvanzv
         ykPh0mNuzNu8cz+FHccxI29LMmpKVvDouLAtIImNrqesZVEboKExvHpoerL2ngejrZJc
         RVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mjzjw6acIOcM+AePCmOJ/RJwLcwwLr94rISpIdIa8zw=;
        b=J3AItczObCJelJcrzl4noJNmOpOgnwJjTc7q2rS8CPiB5C7Dacu0WyQWz6aHl5l3lt
         qIT92q6LOdV2XDdy7/xy//PT4XsdxT5ElkCV1Iv60DdhTT2N3jxqRsw8vogvm3Tt3DRC
         G2jqtLnxlhqSWtAIb5Oh9a6pAnZ+8a1QUL/CgZZQswguWENGKPquRESFSYfycf+arJMz
         FOwoC+jToHnFFKSCwfSoNRUbprxKJZaZVU9FEZmFVTGGBvGkJT9FoDitjITWw7jpdL8d
         2GYunmQeHIMW4rJKOQpByzr4xCMZEvgTFt/UniSNLblR5Y2gKFyvKkBPJM3eUhQe+dBQ
         jAWQ==
X-Gm-Message-State: AGi0PubqIMWT32/gGsqOgwAAzS65Dv2E2ekoB6Q1MuHl7JBEXHGafJek
        XOatROaq1YrIpDHIvB+JaHhLSXsMQvw=
X-Google-Smtp-Source: APiQypIYiUVdFHr4ANkQs2Cpe5K050oe8MXxx624rtGsCXVMWisqQn2MZHg33zNjjdrDESzFefmz+w==
X-Received: by 2002:a1c:2d10:: with SMTP id t16mr6066101wmt.155.1585921420433;
        Fri, 03 Apr 2020 06:43:40 -0700 (PDT)
Received: from debian.lan (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id f12sm12081232wrm.94.2020.04.03.06.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 06:43:39 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 06/11] parport_mfc3: Convert DPRINTK to pr_debug
Date:   Fri,  3 Apr 2020 14:43:20 +0100
Message-Id: <20200403134325.11523-6-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403134325.11523-1-sudipm.mukherjee@gmail.com>
References: <20200403134325.11523-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>

Use a more common logging style.

Signed-off-by: Joe Perches <joe@perches.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_mfc3.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/parport/parport_mfc3.c b/drivers/parport/parport_mfc3.c
index 3190ef0f3c81..d6bbe8446301 100644
--- a/drivers/parport/parport_mfc3.c
+++ b/drivers/parport/parport_mfc3.c
@@ -70,11 +70,6 @@
 #define MAX_MFC 5
 
 #undef DEBUG
-#ifdef DEBUG
-#define DPRINTK printk
-#else
-static inline int DPRINTK(void *nothing, ...) {return 0;}
-#endif
 
 static struct parport *this_port[MAX_MFC] = {NULL, };
 static volatile int dummy; /* for trigger readds */
@@ -84,7 +79,7 @@ static struct parport_operations pp_mfc3_ops;
 
 static void mfc3_write_data(struct parport *p, unsigned char data)
 {
-DPRINTK(KERN_DEBUG "write_data %c\n",data);
+	pr_debug("write_data %c\n", data);
 
 	dummy = pia(p)->pprb; /* clears irq bit */
 	/* Triggers also /STROBE.*/
@@ -128,13 +123,13 @@ static unsigned char control_mfc3_to_pc(unsigned char control)
 
 static void mfc3_write_control(struct parport *p, unsigned char control)
 {
-DPRINTK(KERN_DEBUG "write_control %02x\n",control);
+	pr_debug("write_control %02x\n", control);
 	pia(p)->ppra = (pia(p)->ppra & 0x1f) | control_pc_to_mfc3(control);
 }
 	
 static unsigned char mfc3_read_control( struct parport *p)
 {
-DPRINTK(KERN_DEBUG "read_control \n");
+	pr_debug("read_control\n");
 	return control_mfc3_to_pc(pia(p)->ppra & 0xe0);
 }
 
@@ -142,7 +137,7 @@ static unsigned char mfc3_frob_control( struct parport *p, unsigned char mask, u
 {
 	unsigned char old;
 
-DPRINTK(KERN_DEBUG "frob_control mask %02x, value %02x\n",mask,val);
+	pr_debug("frob_control mask %02x, value %02x\n", mask, val);
 	old = mfc3_read_control(p);
 	mfc3_write_control(p, (old & ~mask) ^ val);
 	return old;
@@ -171,7 +166,7 @@ static unsigned char mfc3_read_status(struct parport *p)
 	unsigned char status;
 
 	status = status_mfc3_to_pc(pia(p)->ppra & 0x1f);
-DPRINTK(KERN_DEBUG "read_status %02x\n", status);
+	pr_debug("read_status %02x\n", status);
 	return status;
 }
 
@@ -202,7 +197,7 @@ static void mfc3_disable_irq(struct parport *p)
 
 static void mfc3_data_forward(struct parport *p)
 {
-	DPRINTK(KERN_DEBUG "forward\n");
+	pr_debug("forward\n");
 	pia(p)->crb &= ~PIA_DDR; /* make data direction register visible */
 	pia(p)->pddrb = 255; /* all pins output */
 	pia(p)->crb |= PIA_DDR; /* make data register visible - default */
@@ -210,7 +205,7 @@ static void mfc3_data_forward(struct parport *p)
 
 static void mfc3_data_reverse(struct parport *p)
 {
-	DPRINTK(KERN_DEBUG "reverse\n");
+	pr_debug("reverse\n");
 	pia(p)->crb &= ~PIA_DDR; /* make data direction register visible */
 	pia(p)->pddrb = 0; /* all pins input */
 	pia(p)->crb |= PIA_DDR; /* make data register visible - default */
-- 
2.11.0

