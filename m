Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954982CFDA8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgLESm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgLERic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 12:38:32 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EA5C02B8EB;
        Sat,  5 Dec 2020 06:20:40 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id z12so4786839pjn.1;
        Sat, 05 Dec 2020 06:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G5dXYBI3g7auZSezxpk+BRTnxqfmxMyhqdtsgpef5c4=;
        b=p8I8tCM8aOZu6RxbIZ6LEAdi3p49iSzEG6MMTvVpgltjjb1HSN7nMEAxu/ZvRzL/MJ
         CRUpWX5BKeRn6CwsSagJPVhKozFogWa0SUS5A79tBscFKjsVbBMTcRjAFGl7ZsR4otwl
         OyAAuCdk2ery1O8Tmbd5V1n8StWfb/U8TwYptJBW4x8FkXv33lZNtLI5zUNQ76CpUe5M
         eL9PuLQn3/xuYbxeWv7DBSBXR3AgRCk9P0egGW6bpuM2667TxQhGLwrCgzDJrMK3uZjW
         NedGGbr2Dz+CfA5QHpnjUwDmgFPv4c7tJKDH3YPMAFrJG/0gX0rHSMF1g6qv+veXyShy
         mhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G5dXYBI3g7auZSezxpk+BRTnxqfmxMyhqdtsgpef5c4=;
        b=DpEXk0pJhch6DYrYIscm1jM8rs7GRaeuOD5C+hbakHZkavtJT3jB9hlC+mBEVrJsJI
         del3TxAP7VeuhHXnWlq5c4iu5Kl/pCv/AZjvMxVJX7aHgHIdGDJ600P+I85k/5HX83YS
         aAEUxuj+7TIaM7hLa1v1tqLkc66FLuCcO/Lqtr9jYp4Nj5J+Bmg4rjGF18kxK9TheC4+
         HxeTqMkToL7Aa+JEV1XjDQW/euDJwjRWn6EFPq/Uo1ApdUYOO12sgA8rU5QOWWvIsxZq
         GiRr97WXua+3M755OsnUQRqQ0opqxppqPddvbTKJbQ/Sep85+fQMLJEnr7ey2uy4ZMRy
         6rzQ==
X-Gm-Message-State: AOAM531Y5tX5ruzMFVfstuZaCanmo5ETX6GZsswQCabWgCaPbbr0J00I
        hsCSRvvke/ojhil2udIB1627lYzwSN/kaUN/
X-Google-Smtp-Source: ABdhPJzeVe5b/aKguBd/vIEIGI5t44OXNx6RGVHtAvoilMDBKU8fnnCubhhdoH8rEXzRHgvfZYTyMw==
X-Received: by 2002:a17:902:82c7:b029:da:cb88:38f8 with SMTP id u7-20020a17090282c7b02900dacb8838f8mr8546537plz.49.1607178040325;
        Sat, 05 Dec 2020 06:20:40 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f0c9:3f6:a1c3:a34c:b902])
        by smtp.gmail.com with ESMTPSA id m4sm9400202pfd.203.2020.12.05.06.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 06:20:39 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH 4/8] tty: serial: jsm: Fixed file by added more spacing in line 613
Date:   Sat,  5 Dec 2020 19:50:11 +0530
Message-Id: <d7e4de468a3fd17bf181b2c296f46b6226ee4fd4.1607177807.git.rclemsmith@gmail.com>
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
index 2bc5f32e59f4..45e212be64c4 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -610,7 +610,7 @@ void jsm_input(struct jsm_channel *ch)
 				if (*(ch->ch_equeue + tail + i) & UART_LSR_BI)
 					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i),  TTY_BREAK);
 				else if (*(ch->ch_equeue + tail + i) & UART_LSR_PE)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_PARITY);
+					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i), TTY_PARITY);
 				else if (*(ch->ch_equeue +tail +i) & UART_LSR_FE)
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_FRAME);
 				else
-- 
2.27.0

