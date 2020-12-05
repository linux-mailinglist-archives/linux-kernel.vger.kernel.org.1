Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4412CFC8E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgLES1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbgLESYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:24:10 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952B2C02B8E9;
        Sat,  5 Dec 2020 06:20:36 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id g18so5397354pgk.1;
        Sat, 05 Dec 2020 06:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=USRYxmIwe1OBMFlL/HbvBbDUCeEy8NAhjeDKt9W2z7o=;
        b=nkWRftyQhuiAqVs2nPas1OT593651giRcYWV07TVehALHjP944nuwaEl/agreJ1diL
         gZ933lzHDIucxW8CE7UEqQUN63zYY5cS6/uBQ/i2R5ljt+vwQpgF2j4rcxidx5d1+DQN
         AdwcKrhmgCrqnNgXcb+mYrqHgm6o5UfAYZlcSgxsE2jF75RuMLYuw7fXkipB+ZWH29SL
         i3T3fsd6EhD1LLn+o22KUYLZ5FAr4U3JlUrY/0QFxlljAYxD9dopEqnBkZU+YTuG/9Ce
         0j2zhDBs6WNjUroZd6+xtxbDQ6B1fm28x3coi2e+S2Dskm4K5drVMSUHu7mQlD/F2bxM
         iFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=USRYxmIwe1OBMFlL/HbvBbDUCeEy8NAhjeDKt9W2z7o=;
        b=lOQPIZrQs/tKkFwgkbIau8o4DoSPBg+z6QODoUBE156/cFKdwDFo2ZZqLaE2Ihdhvv
         FLalAJ8hR6xZFgYLYHFSOftM6DZBrRAHWV73lhBciEEdr3mL4fAD9Ve++rlhGO0Ag2Nl
         qA562/vdVhwtrxc3tJgnUqvV1HQ1Pstqzxm8UD/lZzaj/Rp0Hpwoaf09lQoxdEcufhtI
         JKoaY/7uqibUz18y3TB6ASOwHdNjaBu/NDau3ZTKMO3A2dPMGOB8nD0c9PQ6jJr0BdeN
         b6H4Q6mUUC+60btP9eqwJcHNuvmjMAo84HtdH5VeRzaG3F/lLyPRi8Jv459gX+D7dKYk
         wM4w==
X-Gm-Message-State: AOAM532aIug0DgZadbfwGauv5CEYfAXZDVjjdheHVXo4Sv3eqGiRqib3
        459Xajjkpu9r1ar91ULlvoY=
X-Google-Smtp-Source: ABdhPJw/pDkBwT0rE6iUsexS+dFRWrJNKJ/2CzQYeq18/mz/sd/Hta+HvSmP+RFUhFKt5OoAuj1ULA==
X-Received: by 2002:a63:f457:: with SMTP id p23mr11704209pgk.241.1607178036087;
        Sat, 05 Dec 2020 06:20:36 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f0c9:3f6:a1c3:a34c:b902])
        by smtp.gmail.com with ESMTPSA id m4sm9400202pfd.203.2020.12.05.06.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 06:20:35 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH 2/8] tty: serial: jsm: Fixed file by added more spacing in line 611
Date:   Sat,  5 Dec 2020 19:50:09 +0530
Message-Id: <0ae98016f12770ad8b2b6296152d8d09ade7d031.1607177807.git.rclemsmith@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1607177807.git.rclemsmith@gmail.com>
References: <cover.1607177807.git.rclemsmith@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Fixed a coding style issue

    Signed-off-by: Clement Smith <rclemsmith@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 512b77195e9f..202d6ba93313 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -608,7 +608,7 @@ void jsm_input(struct jsm_channel *ch)
 				 * format it likes.
 				 */
 				if (*(ch->ch_equeue + tail + i) & UART_LSR_BI)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i),  TTY_BREAK);
+					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i),  TTY_BREAK);
 				else if (*(ch->ch_equeue +tail +i) & UART_LSR_PE)
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_PARITY);
 				else if (*(ch->ch_equeue +tail +i) & UART_LSR_FE)
-- 
2.27.0

