Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00671B8990
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 23:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgDYVVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 17:21:05 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:47818 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgDYVVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 17:21:05 -0400
Received: by mail-il1-f199.google.com with SMTP id a15so15201118ild.14
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 14:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=U51TFQW3hSk1SpLr90uyghSU1xkzsMwJ91s9V6q7YJY=;
        b=OTXxuc/xjFpRWJm1rIIV6E8JFSS8XWh+I1nhBeDy/9wZLZIKWk8kzfer9FwGT10H7B
         4XcqWMUiMvh+7ec0y8nWroqnh+PGR1qEHMcR1ZYLcnKTAXzWLsrvAmMEYTpby4AaiRjN
         untQ4jfAqUtZxMfLg+G+QrUPQmsVTlQ1Jyb9X5AvgHZvNcIOQtmTyMtCBABR/5bFZPBh
         xjJGu0y5cY7tFXOwAN/YS+4rN/KazVqMgWp8MC79IZ2X0+xFQbGfuN5x9Vfr+uxXfJ8q
         OmJaEEplC91TBGFSM6gPtS9CXA/VC8r4bD0CyuDAPC9opeUkbRnv5n8njmX99r8FO9ja
         Liag==
X-Gm-Message-State: AGi0PuYi0rFTxSYMx8Sv3T0i20etLDvu+KFHAfxEg3vJInKPaPABP5nO
        0APpVv5q1QxZJO6L8jjMACxXjx8r2uFyHs94/dWwf9jml4xQ
X-Google-Smtp-Source: APiQypIAC1HTqMzZFACNNG6zbHQfbF1JUnrZ1yOTvHELhgt6yJFFqu8n47pdVYtm9RJj1pbcB06dq/tG2SZ0KG31gT5LEJ/M8JW+
MIME-Version: 1.0
X-Received: by 2002:a92:5a5c:: with SMTP id o89mr14934397ilb.47.1587849664493;
 Sat, 25 Apr 2020 14:21:04 -0700 (PDT)
Date:   Sat, 25 Apr 2020 14:21:04 -0700
In-Reply-To: <Pine.LNX.4.44L0.2004251621590.4125-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000357dce05a4240f67@google.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (3)
From:   syzbot <syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com

Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=db339689b2101f6f6071
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12437828100000

Note: testing is done by a robot and is best-effort only.
