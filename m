Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF30B2A2A31
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgKBL5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbgKBL5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:50 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A36AC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:48 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id k18so9221974wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8wKhzR7FJBQMiEnfCciYkFk4n5t6vlssgzVpAdB5/k=;
        b=gD0I20h4Dh2LeDbWfzWGGtdxwqgd7gofYUfN/hGTorCtUOd2482JpLjfAq3leG6ewk
         YhWqffE2X2PhyZSatZs+UHeBxsQWh083R5vwBipGnKXGxDozlTkJLCm4WR72wdewLctX
         ClA2YYLGl5YJqVXZ0xlMvPiJy+BqSKxyE32VMl9jh8cE43FSrb9bI/AI6WRsn+ttLNf2
         abdTlfkdTPU27Y/MxO9hxaEA1xZwESybit4SV0OFct+4o/mNPtTESVBzHcMtypJQXNDQ
         one/T5FTKT92IK79DhPxReWzotPIXP2koHLkw6/iTJ1mrxs5J2uNqVKG8MmqbPuAMJIs
         X4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8wKhzR7FJBQMiEnfCciYkFk4n5t6vlssgzVpAdB5/k=;
        b=aYyL5MA7Zzw+D7//P2bS0PAfCHwLlqspnX+TaOJBl8Q+nXW76PPOfjasvfx8rRh0qg
         4XrJpEQA54TfXHVON0Iq0sspjJCbCeqheOf0s1c0MS0P4y1JpwCFYclCEAslxwOGnUPL
         IXI9NIbS+v6gQ+Z/bQZz5PdzAh5RZ01IVZtf0++wdcOGJKSzC9LUZAwo+kSnZdVABwbx
         BWR4f/pZ86xtANtpR9bMZwDDi1n7P+245W8ocRaJxc1yagXzR1621rDbQajDfY6x/JPI
         GODj76ypXq0cJMIoV//rygoimJK8FF2DAAVx6gr6pfSxs3WmPg7ARErhf9kXZJiXMzsS
         g8cA==
X-Gm-Message-State: AOAM530EdnrHWLJo97cHB5hISqYSZqchB1ogs7LXf1OhDnVp/xZnkkvx
        lF8HzvYo1Ta03g3pQmYrHeigDw==
X-Google-Smtp-Source: ABdhPJzacNY2O5SOVhv0XF4HPrvGfxMEMrNlUjiANIfHVoECLV0SXfWDA49EKUZXR/xTz5no0+JYcA==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr17437257wmb.54.1604318267318;
        Mon, 02 Nov 2020 03:57:47 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Bradley Grove <linuxdrivers@attotech.com>
Subject: [PATCH 13/19] scsi: esas2r: esas2r_int: Add brackets around potentially empty if()s
Date:   Mon,  2 Nov 2020 11:57:22 +0000
Message-Id: <20201102115728.1077697-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115728.1077697-1-lee.jones@linaro.org>
References: <20201102115728.1077697-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/esas2r/esas2r_int.c: In function ‘esas2r_doorbell_interrupt’:
 drivers/scsi/esas2r/esas2r_int.c:692:22: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
 drivers/scsi/esas2r/esas2r_int.c: In function ‘esas2r_send_reset_ae’:
 drivers/scsi/esas2r/esas2r_int.c:868:44: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]

Cc: Bradley Grove <linuxdrivers@attotech.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/esas2r/esas2r_int.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/esas2r/esas2r_int.c b/drivers/scsi/esas2r/esas2r_int.c
index f16d6bcf9bb6d..5281d93563275 100644
--- a/drivers/scsi/esas2r/esas2r_int.c
+++ b/drivers/scsi/esas2r/esas2r_int.c
@@ -688,8 +688,9 @@ static void esas2r_doorbell_interrupt(struct esas2r_adapter *a, u32 doorbell)
 		esas2r_local_reset_adapter(a);
 	}
 
-	if (!(doorbell & DRBL_FORCE_INT))
+	if (!(doorbell & DRBL_FORCE_INT)) {
 		esas2r_trace_exit();
+	}
 }
 
 void esas2r_force_interrupt(struct esas2r_adapter *a)
@@ -862,10 +863,11 @@ void esas2r_send_reset_ae(struct esas2r_adapter *a, bool pwr_mgt)
 	ae.byflags = 0;
 	ae.bylength = (u8)sizeof(struct atto_vda_ae_hdr);
 
-	if (pwr_mgt)
+	if (pwr_mgt) {
 		esas2r_hdebug("*** sending power management AE ***");
-	else
+	} else {
 		esas2r_hdebug("*** sending reset AE ***");
+	}
 
 	esas2r_queue_fw_event(a, fw_event_vda_ae, &ae,
 			      sizeof(union atto_vda_ae));
-- 
2.25.1

