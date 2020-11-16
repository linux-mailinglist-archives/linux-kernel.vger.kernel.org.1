Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223C82B4AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbgKPQSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:18:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41391 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731846AbgKPQSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:18:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id v20so20764901ljk.8;
        Mon, 16 Nov 2020 08:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OBa64MrO5qJGaFqCdbWYuhJzFaIotz7u6BGu6W4Bwjs=;
        b=UlAJmEvduPpbMv0y5Ct8xT3/AI2aRwa5hm2Ew8qlMK9Amhc3KLCLHvwuumptjzBwyT
         rrCxC6UNXbJ/H09oneewRzjXitIdo+iCHTD9ZII4gR6PhcwpWOffNnhpBaalXpc/z1kX
         K1y/gWKPn18O9myt2qa3+bvKzSwUt2oy9d+Pqa2Hvk+3fTMVlG4JFRT6+THLGzuY5Y/O
         046eWywMcce38Q6VzLP63kpYloAae2SDK+qmCENaX/8qfdlqKTTtcaVpruSk6jdxPUHZ
         qBp23XQCmroeJHQMtvmbloPSOH9KoJjUW0trd0aICEEkbzynYFZIdZzpl4/+Ak7dm6sm
         jFyQ==
X-Gm-Message-State: AOAM533X59WJrBuNG7p5nBDXD6MPBE4QC14p4VVINq0ekx0YDsRjQnvA
        KsE84jLfUCGe5D7PrrW2tQlSLEP1uSP4Tg==
X-Google-Smtp-Source: ABdhPJzUG6Z8+0bVzTxILjLzzcmmCVURnn2V9mR1iiyMbw6QunTMlM4BNXhQAo5cISnWdVexWMNpAg==
X-Received: by 2002:a05:651c:510:: with SMTP id o16mr71902ljp.198.1605543523160;
        Mon, 16 Nov 2020 08:18:43 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v7sm2753073lfd.235.2020.11.16.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:18:41 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kehDI-0007fu-0R; Mon, 16 Nov 2020 17:18:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Sheng Long Wang <shenglong.wang.ext@siemens.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/6] USB: serial: cp210x: drop flow-control debugging
Date:   Mon, 16 Nov 2020 17:18:24 +0100
Message-Id: <20201116161826.29417-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201116161826.29417-1-johan@kernel.org>
References: <20201116161826.29417-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop some unnecessary flow-control debugging.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index bb9c3d7ccaee..04d2b15ceded 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1165,8 +1165,6 @@ static void cp210x_set_termios(struct tty_struct *tty,
 				sizeof(flow_ctl));
 		ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
 		flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
-		dev_dbg(dev, "%s - read ulControlHandshake=0x%08x, ulFlowReplace=0x%08x\n",
-				__func__, ctl_hs, flow_repl);
 
 		ctl_hs &= ~CP210X_SERIAL_DSR_HANDSHAKE;
 		ctl_hs &= ~CP210X_SERIAL_DCD_HANDSHAKE;
@@ -1179,17 +1177,15 @@ static void cp210x_set_termios(struct tty_struct *tty,
 			flow_repl &= ~CP210X_SERIAL_RTS_MASK;
 			flow_repl |= CP210X_SERIAL_RTS_SHIFT(
 					CP210X_SERIAL_RTS_FLOW_CTL);
-			dev_dbg(dev, "%s - flow control = CRTSCTS\n", __func__);
 		} else {
 			ctl_hs &= ~CP210X_SERIAL_CTS_HANDSHAKE;
 
 			flow_repl &= ~CP210X_SERIAL_RTS_MASK;
 			flow_repl |= CP210X_SERIAL_RTS_SHIFT(
 					CP210X_SERIAL_RTS_ACTIVE);
-			dev_dbg(dev, "%s - flow control = NONE\n", __func__);
 		}
 
-		dev_dbg(dev, "%s - write ulControlHandshake=0x%08x, ulFlowReplace=0x%08x\n",
+		dev_dbg(dev, "%s - ulControlHandshake=0x%08x, ulFlowReplace=0x%08x\n",
 				__func__, ctl_hs, flow_repl);
 		flow_ctl.ulControlHandshake = cpu_to_le32(ctl_hs);
 		flow_ctl.ulFlowReplace = cpu_to_le32(flow_repl);
-- 
2.26.2

