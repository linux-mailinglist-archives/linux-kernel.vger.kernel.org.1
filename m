Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA66E2186D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 14:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgGHMCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 08:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgGHMCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:02:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD3EC08E6DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:02:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so20691164wrp.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zj88WzcC8Hp115aJ2vlTY+pxEWRybRaihV1rme1nf/Q=;
        b=J5+Dp0HeyJVdvuXj8D7pcksR0L060RA13hVnHzmEuUSfmb+fExnpI95v2doAH5bgpM
         AerHZM65Y5A43lh6M1KxDXUEp7uKPcGChM5mNKuVi3J2s/d1jP9qF2+s6bEzGns8Gpbd
         Jmgw64cyc8ozeKeyLOd/7/FBN6QkujrHYgO05n3G7zRfFHGttwVLyAcKDQ529LKnV+3x
         BhFTJvTjrVfGMyRGZIzRGNg3ZHzByWbBxAmtupuVxhxMyhn+R5C6bbj7VYoBDPNzAJ9P
         TxkzDB4rciwtDU4q+WjZF/2KbEI/vScIQhTbz7KWw5oVcW1vCF4ORMZ6LQZA1UHiwD23
         atzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zj88WzcC8Hp115aJ2vlTY+pxEWRybRaihV1rme1nf/Q=;
        b=Y316JAUFhVNUvqwrjKZWP/x3IJs43Hz1L6ECFkeu9mhysJpwSX0zT72vumupvQNfve
         hx+P5vnZ24OKjNPLJ7IGnDaNgtL9PAwfUeqXdyboGuougVnO5VDR7r9JFwtcnShdjKcc
         yNeyzYcMwlHBtaLHoSshtYuocCO2lEuwxhQbnAdwPUE2XCasacf7gaygmNplyNQogMfC
         Z/i7AYzLzQ/y4pJt2LtwIaT11nabKGmTBYK0qYxblAwT/pH9G0voXqKRLOI8tEsbgXjB
         VnUZiFcwMoZu3dnv++fFwUuoXLUAHkkKELUh7qMTdIbCTKcSUEbJSdBJUnGpnRTF4bpy
         62kA==
X-Gm-Message-State: AOAM531kQrVGqBW8eq3PVgpRH6OBnTnkxQkINmluWgk95OtHw+KsE7fH
        PjGJlc431mvlWvscV76waPrxLA==
X-Google-Smtp-Source: ABdhPJzFvogyw5VWz9I19SIiKvctbL6YjQ+TmzjgqYE/dMgQrN6HrKQRPWUWFjUPI3aluSHxpvZBkA==
X-Received: by 2002:adf:82e1:: with SMTP id 88mr37661923wrc.376.1594209750242;
        Wed, 08 Jul 2020 05:02:30 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id m62sm3964997wmm.42.2020.07.08.05.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:02:29 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/30] scsi: fcoe: fcoe: Fix various kernel-doc infringements
Date:   Wed,  8 Jul 2020 13:01:55 +0100
Message-Id: <20200708120221.3386672-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708120221.3386672-1-lee.jones@linaro.org>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of headers make no attempt to document their associated function
parameters.  Others looks as if they are suffering with a little bitrot.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/fcoe/fcoe.c:654: warning: Function parameter or member 'lport' not described in 'fcoe_netdev_features_change'
 drivers/scsi/fcoe/fcoe.c:654: warning: Function parameter or member 'netdev' not described in 'fcoe_netdev_features_change'
 drivers/scsi/fcoe/fcoe.c:2039: warning: Function parameter or member 'ctlr_dev' not described in 'fcoe_ctlr_mode'
 drivers/scsi/fcoe/fcoe.c:2039: warning: Excess function parameter 'cdev' description in 'fcoe_ctlr_mode'
 drivers/scsi/fcoe/fcoe.c:2144: warning: Function parameter or member 'fcoe' not described in 'fcoe_dcb_create'
 drivers/scsi/fcoe/fcoe.c:2144: warning: Excess function parameter 'netdev' description in 'fcoe_dcb_create'
 drivers/scsi/fcoe/fcoe.c:2144: warning: Excess function parameter 'port' description in 'fcoe_dcb_create'
 drivers/scsi/fcoe/fcoe.c:2627: warning: Function parameter or member 'lport' not described in 'fcoe_elsct_send'
 drivers/scsi/fcoe/fcoe.c:2627: warning: Function parameter or member 'did' not described in 'fcoe_elsct_send'
 drivers/scsi/fcoe/fcoe.c:2627: warning: Function parameter or member 'fp' not described in 'fcoe_elsct_send'
 drivers/scsi/fcoe/fcoe.c:2627: warning: Function parameter or member 'op' not described in 'fcoe_elsct_send'
 drivers/scsi/fcoe/fcoe.c:2627: warning: Function parameter or member 'resp' not described in 'fcoe_elsct_send'
 drivers/scsi/fcoe/fcoe.c:2627: warning: Function parameter or member 'arg' not described in 'fcoe_elsct_send'
 drivers/scsi/fcoe/fcoe.c:2627: warning: Function parameter or member 'timeout' not described in 'fcoe_elsct_send'

Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/fcoe/fcoe.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index cb41d166e0c0f..0f9274960dc6b 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -645,7 +645,7 @@ static int fcoe_lport_config(struct fc_lport *lport)
 	return 0;
 }
 
-/**
+/*
  * fcoe_netdev_features_change - Updates the lport's offload flags based
  * on the LLD netdev's FCoE feature flags
  */
@@ -2029,7 +2029,7 @@ static int fcoe_ctlr_enabled(struct fcoe_ctlr_device *cdev)
 
 /**
  * fcoe_ctlr_mode() - Switch FIP mode
- * @cdev: The FCoE Controller that is being modified
+ * @ctlr_dev: The FCoE Controller that is being modified
  *
  * When the FIP mode has been changed we need to update
  * the multicast addresses to ensure we get the correct
@@ -2136,9 +2136,7 @@ static bool fcoe_match(struct net_device *netdev)
 
 /**
  * fcoe_dcb_create() - Initialize DCB attributes and hooks
- * @netdev: The net_device object of the L2 link that should be queried
- * @port: The fcoe_port to bind FCoE APP priority with
- * @
+ * @fcoe:   The new FCoE interface
  */
 static void fcoe_dcb_create(struct fcoe_interface *fcoe)
 {
@@ -2609,7 +2607,7 @@ static void fcoe_logo_resp(struct fc_seq *seq, struct fc_frame *fp, void *arg)
 	fc_lport_logo_resp(seq, fp, lport);
 }
 
-/**
+/*
  * fcoe_elsct_send - FCoE specific ELS handler
  *
  * This does special case handling of FIP encapsualted ELS exchanges for FCoE,
-- 
2.25.1

