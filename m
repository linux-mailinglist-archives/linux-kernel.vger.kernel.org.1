Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF4621D0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 09:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgGMHrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 03:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgGMHqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:46:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B79DC08C5DB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:46:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w3so12163494wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DmqYn8cL7eqDFwNGfmdwoQHTEQPwopRMh0yPN6WNGOc=;
        b=kMQi+LF463/qxHEfKGPGvCd2c6A2f6xdj3zZKG62HaLhW8tV06HUqvCtmNufbjrIdu
         +r8xls+i2UHhzWACB73k0OoRRj72ou0OQ7r1zeWimj+ntzHg+CFP9fmpyJghgJkXjJw2
         A05uGrWkzxgx82ApMTP8wqs03s9phPr++cD16/GYWchOzyqTxHwiRbqo1Ti/3YL4CJdL
         1oI53ro3+ZySyLW27dLpxBvokNzD2PUv9mcRHuC9gs1CzeL3E0ICDp/IkeEJ97/ZAv46
         hoZrC/IoAlccRJpK6OjveW//uzODgE0RYRvPXuTpnzfhNkdxuY/0noyO/8IWnS5hR8iF
         ZKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DmqYn8cL7eqDFwNGfmdwoQHTEQPwopRMh0yPN6WNGOc=;
        b=mAc9zDeIcmDPiiJM+pXJw+rkhLu0Yysy7Yz9zDscYNrwto8Tt3W9NrRY8/LZ0vKRsh
         8ZPGLnDVnWYRefCMdFIMMsZFjyhAH+iPnrkiKInTRTz5BuLaWYFC52Q/uouG30Wne/IM
         8tWeHERnTFDvbL9joXDrMyrcfkIhm4oqqQD9tOzoZPFUe38nE5t1IQFHfgU7EsVBU6X0
         E4SFviaRz8ISR8I16CuYJjn7LD0/Cu+VtxHryPNVqlpBn35RBurDgfQE+/8lAZJf6wmw
         Gnw+HCbLBtK6VYM+GFHuj0ZLIA3yEt9ONtGDSxj6fmCZezk4xvOAk/mLIgq3XowElu+A
         it0A==
X-Gm-Message-State: AOAM531i1uVTyvSTeFheBVnPdy4m0mhB3L5F/X6ZC3DdjusTrs54HYZu
        NYKPTTzoTD9oV8tRaz9lxndqkQ==
X-Google-Smtp-Source: ABdhPJxYPfD3jt/wvcLfJGWG+I9epedTnVYg39jHCJvCocIhbmxWOlTXNJ6eiKgn70cyJoojayZiGA==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr17773676wme.42.1594626414066;
        Mon, 13 Jul 2020 00:46:54 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id k11sm25142488wrd.23.2020.07.13.00.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 00:46:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 06/29] scsi: fcoe: fcoe_transport: Correct some kernel-doc issues
Date:   Mon, 13 Jul 2020 08:46:22 +0100
Message-Id: <20200713074645.126138-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713074645.126138-1-lee.jones@linaro.org>
References: <20200713074645.126138-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mainly due to misdocumentation or bitrotted descriptions.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/fcoe/fcoe_transport.c:396: warning: Function parameter or member 'skb' not described in 'fcoe_check_wait_queue'
 drivers/scsi/fcoe/fcoe_transport.c:447: warning: Function parameter or member 't' not described in 'fcoe_queue_timer'
 drivers/scsi/fcoe/fcoe_transport.c:447: warning: Excess function parameter 'lport' description in 'fcoe_queue_timer'
 drivers/scsi/fcoe/fcoe_transport.c:682: warning: Function parameter or member 'netdev' not described in 'fcoe_netdev_map_lookup'

Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/fcoe/fcoe_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe_transport.c b/drivers/scsi/fcoe/fcoe_transport.c
index a20ddc301c89e..6e187d0e71fd2 100644
--- a/drivers/scsi/fcoe/fcoe_transport.c
+++ b/drivers/scsi/fcoe/fcoe_transport.c
@@ -382,6 +382,7 @@ EXPORT_SYMBOL_GPL(fcoe_clean_pending_queue);
 /**
  * fcoe_check_wait_queue() - Attempt to clear the transmit backlog
  * @lport: The local port whose backlog is to be cleared
+ * @skb: The received FIP packet
  *
  * This empties the wait_queue, dequeues the head of the wait_queue queue
  * and calls fcoe_start_io() for each packet. If all skb have been
@@ -439,7 +440,7 @@ EXPORT_SYMBOL_GPL(fcoe_check_wait_queue);
 
 /**
  * fcoe_queue_timer() - The fcoe queue timer
- * @lport: The local port
+ * @t: Timer context use to obtain the FCoE port
  *
  * Calls fcoe_check_wait_queue on timeout
  */
@@ -672,6 +673,7 @@ static void fcoe_del_netdev_mapping(struct net_device *netdev)
 /**
  * fcoe_netdev_map_lookup - find the fcoe transport that matches the netdev on which
  * it was created
+ * @netdev: The net device that the FCoE interface is on
  *
  * Returns : ptr to the fcoe transport that supports this netdev or NULL
  * if not found.
-- 
2.25.1

