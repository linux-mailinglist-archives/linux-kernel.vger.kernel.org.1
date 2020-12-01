Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1992CA76E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgLAPvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgLAPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:51:19 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05326C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 07:50:33 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id 7so5133963ejm.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 07:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34cD4Gjg3coO97LH8YA2wLfJ1VfGCovwKd0p8wcVflc=;
        b=QKtGZrn6MtPnl1/WrEYBw1w4bW6069kROhD6OtFKZgXxbt2ewDtmk1kMg0brLI/31w
         RKxD+egikrcRD1Hja6dvqEGrYuwJ9dvkYIbxGhxm7EGLJ8yzKLjL+Z2qH4KPh4m3MpDj
         5J+Cz43a/IgpMfQlwSkpq48Cnf38paywmfmBR7BOlX9T+P07i47pEIQV3KSPVzVqCj/m
         kJGmHyrT0aZGUwd160++dq41ZX8vnt1Po005BgN5oRTkBsYbeZq2NQu1+35u6/cnm/1y
         XzEzqsQdO4pOVWCwQU9REycS8UzlzxHf1ZBQ+yHQT+v96NX7bpZCfqZS3tWTbhWPu0Wv
         9xMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=34cD4Gjg3coO97LH8YA2wLfJ1VfGCovwKd0p8wcVflc=;
        b=MbBuiczY7SuMvhRjUpmR8o0wC31zKdDasmHnel5kZ0sbEAmPODLAkRI6Sihman1vGy
         xDEAGj+aO/UBaG4DY4JR5RRKtYzSMS1coXNj7VOr4oljCxAlC+KcVlRmI5X2dgDiePPe
         PF87MoibXSero10q/7mSx1ZNHSR+ExPeMbqpzfLRTvZveiG/i20upI2JOoZAlYv5aU/+
         uVtnt8nLlo8hTlPWQXX79fzHf59kpLhWL8VkH/0u+49wCzJqa3QCV97sg0/EPfjEspp9
         VAjFtry72YM2HcllqbENdGqg+G370zcu0aeXP4lC4Vp8MM88P/1sWU3lwP5eg8YOflKd
         P20Q==
X-Gm-Message-State: AOAM533Z+U5cezvAKFNpMQgu6TBNJvoFoVLlf8rLhybwH0iyXTY1d8fF
        Wqayw+CGvWFTkY6HlLa0hoS6YAWtuc1PWeEd
X-Google-Smtp-Source: ABdhPJy0uEFCohG6VzxXtV9+Ryt/aWbB7oC1XWggaKzikhrL7Pbcfye+GiG4XNoJi+yJBNYjBsfHag==
X-Received: by 2002:a17:906:7cc6:: with SMTP id h6mr3592792ejp.161.1606837831515;
        Tue, 01 Dec 2020 07:50:31 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id w3sm108497edt.84.2020.12.01.07.50.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Dec 2020 07:50:31 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] firmware: xilinx: Remove additional newline
Date:   Tue,  1 Dec 2020 16:50:24 +0100
Message-Id: <d927f3f2c97910958dd77a22828cd0bf8d89c9de.1606837822.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606837822.git.michal.simek@xilinx.com>
References: <cover.1606837822.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This additional newline is useless and also reported by checkpatch
--strict.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 include/linux/firmware/xlnx-zynqmp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index f84244ea633b..0db9005782d6 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -316,7 +316,6 @@ struct zynqmp_pm_query_data {
 	u32 arg3;
 };
 
-
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 			u32 arg2, u32 arg3, u32 *ret_payload);
 
-- 
2.29.2

