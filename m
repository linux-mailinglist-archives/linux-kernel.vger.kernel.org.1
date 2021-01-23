Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCB030189E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 22:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbhAWVto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 16:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbhAWVtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 16:49:41 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3042CC0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 13:49:01 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id 6so12679001ejz.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 13:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v/sWbS8R88OmqB0d4LX195kx65OR1XndiT5q/NMqDNU=;
        b=RNEL9CL7093KMxayaYtEhKDkWCQOpI+a2Agb/a31s5f/fYaZcdh1mPScrRoAvPAcfh
         lPXd1yUTaXUwwWvHOwJyY5Lq7gWaZ3fFmq+QiJz+rKJ3aRuf0oSpd3g7Arqyg9Cd8VfJ
         +7Ul6xC+1Qj5AhaLN/z3or4lmj3JR1lvZSNV9XP3CvJQcTlhkPBuCQWK8gVpx3e0SEmu
         LDU9xVZAgcYnWsz2piG5iWeaRRmy5CLbZjp+3u1bV8bgFBHEK4OmbCFCca4iAG9a0dea
         KtTiB1CpWHHESv/i/SK8w6bt1IKR0n3e84FK7NiR4ozfqVacb6fFeFpMxglYFj5TYJKG
         zFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=v/sWbS8R88OmqB0d4LX195kx65OR1XndiT5q/NMqDNU=;
        b=roeughmmjI8Vjsd3izSBlz5ko2vfsleZMPf50Gsr84nKPB1FqnfkZpTN5Ahg5e4aAi
         /zKoBa+pOx3Z69UCksaqc/cvSsGScO6Zp6qRz+rdR7eSpVAtu+ZT9gaAEk2NlDbsGwTo
         NoLtsx9XUOej0Z5T41UkIh1ONsAENlu2m/qVgRcwlZfdu97DVx0rPV3lMBIpgaLTTb+x
         d3Kf4vdfs4LvEWPRkeSl7epHB/S8TmXkjnKYxcTLyMnsFdmOBCsHT2D5Mw7ccmpLH0RL
         ZHF11PCU2yF3jPOMEOP6B1kLz+40rk5B7hq4B4LwrzT6MWCk3vMT30Du8owihBstVlZS
         QulQ==
X-Gm-Message-State: AOAM533ePzVP69B0zknCpuxuE/0AylShvum7YypLFjI+7KBLzwZqt03G
        l3SVbkqKJYqoxzc7x5pfWV/0axtMiCy3aw==
X-Google-Smtp-Source: ABdhPJweH+SQxxCgIN3eS58dVrFfaXWEIKYQB2bgNwoWGSE0/QHRJwKbI071VVuyTJUrxB05MdMoYA==
X-Received: by 2002:a17:906:dfce:: with SMTP id jt14mr244779ejc.435.1611438539816;
        Sat, 23 Jan 2021 13:48:59 -0800 (PST)
Received: from stitch.. ([2a01:4262:1ab:c:d5f7:30cf:b95b:92d7])
        by smtp.gmail.com with ESMTPSA id o4sm1480345edw.78.2021.01.23.13.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 13:48:59 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-kernel@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] vt: keyboard, use new API for keyboard_tasklet
Date:   Sat, 23 Jan 2021 22:47:39 +0100
Message-Id: <20210123214739.2042-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the keyboard_tasklet to use the new API in
commit 12cc923f1ccc ("tasklet: Introduce new initialization API")

The new API changes the argument passed to the callback function, but
fortunately the argument isn't used so it is straight forward to use
DECLARE_TASKLET_DISABLED() rather than DECLARE_TASKLET_DISABLED_OLD().

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/tty/vt/keyboard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 52922d21a49f..6c85f024bec4 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1233,7 +1233,7 @@ void vt_kbd_con_stop(int console)
  * handle the scenario when keyboard handler is not registered yet
  * but we already getting updates from the VT to update led state.
  */
-static void kbd_bh(unsigned long dummy)
+static void kbd_bh(struct tasklet_struct *unused)
 {
 	unsigned int leds;
 	unsigned long flags;
@@ -1249,7 +1249,7 @@ static void kbd_bh(unsigned long dummy)
 	}
 }
 
-DECLARE_TASKLET_DISABLED_OLD(keyboard_tasklet, kbd_bh);
+DECLARE_TASKLET_DISABLED(keyboard_tasklet, kbd_bh);
 
 #if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_ALPHA) ||\
     defined(CONFIG_MIPS) || defined(CONFIG_PPC) || defined(CONFIG_SPARC) ||\
-- 
2.30.0

