Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDEA2186AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 14:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgGHMC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 08:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgGHMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:02:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD70C08E6DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:02:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so48641986wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gv6x0VpkNH1KBubo4tbm9ETrzBqqoMdr5YdMKsMLhQk=;
        b=G220Ai4wYV+H9LPdaGJhcn08dRDAI9AZc/Sag2LiLOJpLSclfGTa1nEe8XtWtJQKQv
         Uzl3wfDFpi1fa9rWO/jY2L/m80DRo3XcKjxexcx/3WPL/NuvUbyiMWNIFBffi9ghjKTq
         JdOqkEjXw7xEJ3VkVQJGR1fwzHuXGIMfRDm8Bp/LG6Z55flahyb50r/hi/tT1Kh5Qr8F
         k6Z+Tnjc6b03u4VyL3sHc7jaaWOOM83IIPLihSYksQvwhhrYidTyn2eDM1xfyiATcsCz
         w8i2IMbw+BkePHEPgumwuveLujmIrM6NIQF4F2jOhVJbwGMaVuVwh4Wfq+tPeyEhNjRi
         Us4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gv6x0VpkNH1KBubo4tbm9ETrzBqqoMdr5YdMKsMLhQk=;
        b=LvzyV4C+EPLKIfQAD32HpwgXIZdna/4GAlQZlVfRD+VKJexO9xk7k/+CbXbEM1rQoD
         TVJ2MraOsLIUr79SmJ9RnO6pi0AYHOsK5kKODA+k1NI5Mk3MaXdfhvtXwSjUKQ8K2k9Z
         FDYO30a0JQpct4o+AD4yDsoY4uILAmWbZA4I8HUyjHwFFV7tNQhgobgRJlDzBIldelU7
         owQ92sBflJBr6O8Bvh6q9fy+T4lXWZS0ou69OubiBNCNL5XunppYiFbWcxVe2cYQfLO2
         O4HYGRlnzZE4hX8O3ImsnEp5PdQTyAKxD/5zB30IFMIJEvUxAcmMjRuk2GJps8cH2dQp
         wrwQ==
X-Gm-Message-State: AOAM530TqHL+8fkIgIV9ao0tA2sLhgaxnevkH7mdIPfBBgVQVb9aepeh
        zjXc4IxScnrEhyc14y1wkBAsBg==
X-Google-Smtp-Source: ABdhPJxBZ5+wTaIVpUTRzBASxtW3kmeSXLXBjvGGO/osSrQr7g/mocW02GIZju2wbYKAuDeAP8ePCA==
X-Received: by 2002:adf:f711:: with SMTP id r17mr59508450wrp.409.1594209772642;
        Wed, 08 Jul 2020 05:02:52 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id m62sm3964997wmm.42.2020.07.08.05.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:02:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.com>,
        "Daniel M. Eischen" <deischen@iworks.InterWorks.org>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 19/30] scsi: aic7xxx: aic7xxx_osm: Remove unused variable 'tinfo'
Date:   Wed,  8 Jul 2020 13:02:10 +0100
Message-Id: <20200708120221.3386672-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708120221.3386672-1-lee.jones@linaro.org>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like none of the artifact from  ahc_fetch_transinfo() are used anymore.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aic7xxx/aic7xxx_osm.c: In function ‘ahc_linux_target_alloc’:
 drivers/scsi/aic7xxx/aic7xxx_osm.c:567:30: warning: variable ‘tinfo’ set but not used [-Wunused-but-set-variable]
 567 | struct ahc_initiator_tinfo *tinfo;
 | ^~~~~

Cc: Hannes Reinecke <hare@suse.com>
Cc: "Daniel M. Eischen" <deischen@iworks.InterWorks.org>
Cc: Doug Ledford <dledford@redhat.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aic7xxx/aic7xxx_osm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index 2edfa0594f183..32bfe20d79cc1 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -564,8 +564,6 @@ ahc_linux_target_alloc(struct scsi_target *starget)
 	struct scsi_target **ahc_targp = ahc_linux_target_in_softc(starget);
 	unsigned short scsirate;
 	struct ahc_devinfo devinfo;
-	struct ahc_initiator_tinfo *tinfo;
-	struct ahc_tmode_tstate *tstate;
 	char channel = starget->channel + 'A';
 	unsigned int our_id = ahc->our_id;
 	unsigned int target_offset;
@@ -612,9 +610,6 @@ ahc_linux_target_alloc(struct scsi_target *starget)
 			spi_max_offset(starget) = 0;
 		spi_min_period(starget) = 
 			ahc_find_period(ahc, scsirate, maxsync);
-
-		tinfo = ahc_fetch_transinfo(ahc, channel, ahc->our_id,
-					    starget->id, &tstate);
 	}
 	ahc_compile_devinfo(&devinfo, our_id, starget->id,
 			    CAM_LUN_WILDCARD, channel,
-- 
2.25.1

