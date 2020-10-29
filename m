Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D64129EB58
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgJ2MKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJ2MKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:10:05 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2437DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:10:04 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w25so2819082edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 05:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VrXgy5M/zLPPW9d2sz/VFCmoXv1wXjIPmXoHN+0K+eg=;
        b=Y3rZK/MW3t96Izt5r6cbBUYTX+UOFK36O9Is92BtyEvHKfTSSgH26yX+xhW85UiU4b
         V9WV3ZT+k9j3uqCWtWhyzsTafGhDs3ZBDKgZ7zdQszekQD/rttrSBkysquOU+mc+rdN0
         4l0iejVDAp+3ntsKS4RHHktHgaXnqBWyOTTwl4AteHOn1GSrpNPIulW1w+Ms+Ch1aLbV
         ODHniizNMOHJsYlsEdqHEAGespOqDGIvtOB77YEivauz3HMiLVcgSf3RwgkhwdGYOsEL
         61J4ZUH7kUEGD0/rjFpsH581D1OxFAE1EPxMr8GJywcD/f8sbKTlrvujQ4m2ucYCFigj
         I0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VrXgy5M/zLPPW9d2sz/VFCmoXv1wXjIPmXoHN+0K+eg=;
        b=dOUK/gcxzBmlyZ97Ryem/SGNqfYKIyQ3DNY3JovKs4vuoC7ea6ols1+OOIl9c7H65m
         QXs0VJW1+Octokn4qasXOBTpBuo0QtwoKpV8yFajoNc68+M4c22Rue6flDheYiYovtZo
         H/jL2GFUKC5mjItCWZKDjT9oAuFJEmfBdtixiTwqdlQ7cOIFHN/uZxywx3P8YjDVk2jd
         9VnhKqjr1UKdJ9PsChdjaImXz147YsrBFJog8Y87yT3cjmxGVwE9GDS0zcXOmQ/jHCPV
         TRJ5t1D3WKr+k0xIPBeDyQ6BVsRvG/g6sJ8RT1m1LHs8BmECmtfLGKmLI988kbdrTJ7h
         mVug==
X-Gm-Message-State: AOAM530RzSnuLvpHJXrEdwLDYVRDiMkIyuvBoEYT3Nx7HtwWmgExpxrC
        9X1Y9ZDSGHJ0cmY8sHPbWBAgYZksQ60=
X-Google-Smtp-Source: ABdhPJys8Ma/4kwrJlexMWR50Px2y2uE1bFChAjxB3E8cnHpfMI3iQbRMCFqpoEdHH1b6HEekkI+sw==
X-Received: by 2002:a50:e087:: with SMTP id f7mr3545512edl.96.1603973402612;
        Thu, 29 Oct 2020 05:10:02 -0700 (PDT)
Received: from maphy.uni-hannover.de ([130.75.75.70])
        by smtp.gmail.com with ESMTPSA id nu20sm1354092ejb.109.2020.10.29.05.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 05:10:02 -0700 (PDT)
Date:   Thu, 29 Oct 2020 13:10:00 +0100
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v4 2/6] console_struct.h: Add members for mouse report
Message-ID: <7ab7a8b42e038d9ab243751dd03afbf825e14bdd.1603963593.git.tammo.block@gmail.com>
References: <cover.1603963593.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603963593.git.tammo.block@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need two values to store the status of mouse reporting, both need at
least two (vc_protocol_mouse) or three (vc_report_mouse) bits.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 include/linux/console_struct.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 153734816b49..d0aada27feb2 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -30,6 +30,12 @@ enum vc_intensity {
 	VCI_MASK = 0x3,
 };
 
+enum vc_pmouse {
+	VC_PMOUSE_X10,
+	VC_PMOUSE_SRG,
+	VC_PMOUSE_URXVT
+};
+
 /**
  * struct vc_state -- state of a VC
  * @x: cursor's x-position
@@ -132,6 +138,8 @@ struct vc_data {
 	struct pid 	*vt_pid;
 	int		vt_newvt;
 	wait_queue_head_t paste_wait;
+	unsigned char	vc_report_mouse;	/* Which events to report to userspace */
+	enum vc_pmouse	vc_protocol_mouse;	/* What protocol to use for report */
 	/* mode flags */
 	unsigned int	vc_disp_ctrl	: 1;	/* Display chars < 32? */
 	unsigned int	vc_toggle_meta	: 1;	/* Toggle high bit? */
@@ -144,7 +152,6 @@ struct vc_data {
 	unsigned int	vc_priv		: 3;
 	unsigned int	vc_need_wrap	: 1;
 	unsigned int	vc_can_do_color	: 1;
-	unsigned int	vc_report_mouse : 2;
 	unsigned char	vc_utf		: 1;	/* Unicode UTF-8 encoding */
 	unsigned char	vc_utf_count;
 		 int	vc_utf_char;
-- 
2.28.0

