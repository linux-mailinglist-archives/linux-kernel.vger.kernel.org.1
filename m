Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70B82F0618
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 09:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbhAJI4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 03:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbhAJI4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 03:56:10 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EABC061786;
        Sun, 10 Jan 2021 00:55:30 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 4so7916740plk.5;
        Sun, 10 Jan 2021 00:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZrSthnCc1UUGIq+E/XFB3h6NgrMnNDpSkII5rQhvgJQ=;
        b=UdqSEhk47OnUVZDYM4LQfMPpdtgd4hJ7ctmjWlS/406I2eTWSJmS5dL1/6aupO82wG
         aswnfV0iJsL72bc++iVRtnkemKK4IAZ93DOTBo3DHAilIHIRTueOVapTaP7WOcl+2m5r
         EE4VnLbFj/+d1DOIfkHTXvql2L20ssRKSQ54YgNXg6izA9GDz7QuWyWEBrYE/aIr8w8F
         gyYDhglsogwdCDNugeCOGHyT+1tvsjxrg8UBsfNYaSEE8ZtI1VPUcwvYdku/qKTreQ3l
         cmY//UNZzOn9L6mSUs46FajPFn/u5nXu4JUfElLvuOiQVO/0Q4zyJgVbikkOtH43kQJ5
         tSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZrSthnCc1UUGIq+E/XFB3h6NgrMnNDpSkII5rQhvgJQ=;
        b=KQTIxCP5Z1JjmTtkf/owBFHyV4VBPG/6SawXvfxjZs0NqWar7oDshG2Pv+iQ6zYRZO
         Dl+1DnU00Q8ijQ+wF2No3QGo+FsmI22yyMr7ciwWHV3nn0R7VEYbIcMsL82vzes92pD1
         rQpoR4i1Q8KLNpk6enQcJ2GPJ9q6s2GcsJC+zzXqAruCexpyuDdXUZcjxAoHLi+Wer5L
         sMvlKVmFOJQmrUw13lzOf1aP5OidnbwDGqiVU3q53FYxBUWs7k2zIlvxn3myhp7M2ZsR
         4OpxoEsCOEiERtdBb7nWc/W4Xt+18x6edtNuIgBoBD0hft8iizia9iPL95WtYa/T8fUD
         Qp/Q==
X-Gm-Message-State: AOAM53086lzus1XLtv0B10h93sHwhGZ7Oqj2P6lc7+zkIruwYh9eVHKp
        bb47PofJ/FVrKHI/85QhPoY=
X-Google-Smtp-Source: ABdhPJz3qeU7il83k4f2IkOCDPfiGzMOiY9pS95z2YaWP6aqzPIkqkg3RkXAh4jXFQEiQYK1Hg36jQ==
X-Received: by 2002:a17:903:230f:b029:dc:9b7f:bd0e with SMTP id d15-20020a170903230fb02900dc9b7fbd0emr11518573plh.47.1610268930032;
        Sun, 10 Jan 2021 00:55:30 -0800 (PST)
Received: from android.asia-east2-a.c.savvy-summit-295307.internal (53.207.96.34.bc.googleusercontent.com. [34.96.207.53])
        by smtp.googlemail.com with ESMTPSA id u3sm12346904pjf.52.2021.01.10.00.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 00:55:29 -0800 (PST)
From:   Bui Quang Minh <minhquangbui99@gmail.com>
To:     syzbot+57281c762a3922e14dfe@syzkaller.appspotmail.com
Cc:     a.darwish@linutronix.de, bigeasy@linutronix.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        minhquangbui99@gmail.com
Subject: [PATCH] can: mcba_usb: Fix memory leak when cancelling urb
Date:   Sun, 10 Jan 2021 08:54:36 +0000
Message-Id: <20210110085436.3616-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210110085436.3616-1-minhquangbui99@gmail.com>
References: <000000000000f599c005b6f59913@google.com>
 <20210110085436.3616-1-minhquangbui99@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mcba_usb_read_bulk_callback(), when we don't resubmit the urb, we
need to deallocate the transfer buffer that is allocated in
mcba_usb_start().

Reported-by: syzbot+57281c762a3922e14dfe@syzkaller.appspotmail.com
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/can/usb/mcba_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index df54eb7d4b36..7375c384cbd2 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -584,6 +584,8 @@ static void mcba_usb_read_bulk_callback(struct urb *urb)
 	case -EPIPE:
 	case -EPROTO:
 	case -ESHUTDOWN:
+		usb_free_coherent(urb->dev, urb->transfer_buffer_length,
+					urb->transfer_buffer, urb->transfer_dma);
 		return;
 
 	default:
-- 
2.17.1

