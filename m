Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4E12C9672
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 05:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgLAEYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 23:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgLAEYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 23:24:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD5CC061A04
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 20:22:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h9so882030ybj.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 20:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nruMNWNcZEmjcKrORKjvDrxT0A/8sh/ZqXFGa7woZ+A=;
        b=UMXU8w2cUY0sT47QLX4rKblaiuaWMGkD5mdqrs1sB8lQ9OFaFFcvwaFABiRHvZdAJ0
         Djo2X+h1dd516KdL29sTzsTfOeqAdr4O1+jABIUCaMcjEPHIODUD78xxnLUhVBgrjiZw
         RW1hYeMREXpX30FB3DP/5vRwPfIhrY4dxpJbBMgZVUvOXKp6InKgdetHbN6aHavldJae
         K4ADF154w6iKSeRhegIAhyxeDlJKvwwX9AWv2GjHFltK28GBDpoAC0ExgkylgQXs7FCW
         n+TqD7WGWISpuQe6S3u9Paky/LpjM/CaTLp3wJquZX26syVf/is2cr/6p5nho+epKUpS
         Nh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nruMNWNcZEmjcKrORKjvDrxT0A/8sh/ZqXFGa7woZ+A=;
        b=PBv+8+azkh4vu3sTTt2hyLeiJDWW0tX8lZGZr2ckvmADjG0JgFfdbR0RasAQfgWCIx
         ywKCTqsqwxWZc/jq/gYZOJZatcEq2FXc5yANHMojtIoUKeeVitMTf0l6GcsH086EvOVc
         gPOTvwrnttPTqJeAIA4TB14GtkMPqfwpUcotOuoM/x0bzAbgathoongyGvTSCVpdow2W
         mFTWGgapcGwLVRGKTTKneuXBDJCoBsz8Rn88Onum3jyJDdYjSCphX33+EVWTTv0YPxZt
         UCx1FZgr+Hx23f85G2D19S1RnDX2TmTS+DapKwR7JHS4CMyGkidUEE1Fv/iYz2GHYv8d
         5mnA==
X-Gm-Message-State: AOAM530kojJOGKuA3g8FImQbQ/9mE//7s6v4zzhjlOTBxqkwDM7MCrTs
        aYaL3qbdgR4oHpZmOXMkNDms+HwMOJ8=
X-Google-Smtp-Source: ABdhPJxg3vHAoPRrWpoNVu9EQE38PNG4trmiTCausd4xox8b0mN9zlPwUuVwTFrHlfajZKjQXgtZ7hepIQI=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:830e:: with SMTP id s14mr925680ybk.213.1606796568112;
 Mon, 30 Nov 2020 20:22:48 -0800 (PST)
Date:   Mon, 30 Nov 2020 20:22:37 -0800
In-Reply-To: <20201201042237.414235-1-badhri@google.com>
Message-Id: <20201201042237.414235-4-badhri@google.com>
Mime-Version: 1.0
References: <20201201042237.414235-1-badhri@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v1 4/4] usb: typec: wcove: Update wcove_pd_transmit to include
 negoitated rev
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pd_transmit callback now passes down negotiated_rev to set retry
count accordingly if needed.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/wcove.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
index 9b745f432c91..79ae63950050 100644
--- a/drivers/usb/typec/tcpm/wcove.c
+++ b/drivers/usb/typec/tcpm/wcove.c
@@ -356,7 +356,8 @@ static int wcove_set_pd_rx(struct tcpc_dev *tcpc, bool on)
 
 static int wcove_pd_transmit(struct tcpc_dev *tcpc,
 			     enum tcpm_transmit_type type,
-			     const struct pd_message *msg)
+			     const struct pd_message *msg,
+			     unsigned int negotiated_rev)
 {
 	struct wcove_typec *wcove = tcpc_to_wcove(tcpc);
 	unsigned int info = 0;
-- 
2.29.2.454.gaff20da3a2-goog

