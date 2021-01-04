Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFD12E9B0B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 17:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbhADQ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 11:29:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:49188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbhADQ3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:29:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609777703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k9n13/goqNlk+9bl+AC/ByGqYptah5oyUc4xhXLrV54=;
        b=GtydKPYgDSK5kxaBJ2HNWM8SiDlN+2Ry1k3X3liC3qDACauXTXQyqdLooiMs+kqNjQuEqa
        8XAx91cy2LVKcYLQNthSPGm1yvldOheK2we9vXVZbQrzZsHipqp8Wd+YWqdPXYmnjRMtbK
        6Ht0brc85qUm3jyLtTaJpqBkRblTm7c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 72AFCADD6;
        Mon,  4 Jan 2021 16:28:23 +0000 (UTC)
Message-ID: <6a56df508f597d38746878e80e1f159a556d3152.camel@suse.com>
Subject: Re: KASAN: use-after-free Read in service_outstanding_interrupt
From:   Oliver Neukum <oneukum@suse.com>
To:     syzbot <syzbot+9e04e2df4a32fb661daf@syzkaller.appspotmail.com>,
        andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, ingrassia@epigenesys.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        syzkaller-bugs@googlegroups.com
Date:   Mon, 04 Jan 2021 17:28:21 +0100
In-Reply-To: <000000000000994d2a05b6b49959@google.com>
References: <000000000000994d2a05b6b49959@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 17.12.2020, 19:21 -0800 schrieb syzbot:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    5e60366d Merge tag 'fallthrough-fixes-clang-5.11-rc1' of g..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=12c5b623500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea7506b7139727
> dashboard link: https://syzkaller.appspot.com/bug?extid=9e04e2df4a32fb661daf
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175adf07500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1672680f500000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9e04e2df4a32fb661daf@syzkaller.appspotmail.com

#syz test: https://github.com/google/kasan.git  5e60366d

From f51e3c5a202f3abc805edd64b21a68d29dd9d60e Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Mon, 4 Jan 2021 17:26:33 +0100
Subject: [PATCH] cdc-wdm: poison URBs upon disconnect

We have a chicken and egg issue between interrupt and work.
This should break the cycle.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/usb/class/cdc-wdm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 02d0cfd23bb2..14eddda35280 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -324,9 +324,9 @@ static void wdm_int_callback(struct urb *urb)
 static void kill_urbs(struct wdm_device *desc)
 {
 	/* the order here is essential */
-	usb_kill_urb(desc->command);
-	usb_kill_urb(desc->validity);
-	usb_kill_urb(desc->response);
+	usb_poison_urb(desc->command);
+	usb_poison_urb(desc->validity);
+	usb_poison_urb(desc->response);
 }
 
 static void free_urbs(struct wdm_device *desc)
-- 
2.26.2


