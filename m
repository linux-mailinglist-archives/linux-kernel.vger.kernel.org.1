Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705D12D5C12
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389476AbgLJNjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:39:05 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:36985 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730845AbgLJNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:38:44 -0500
Received: by mail-il1-f199.google.com with SMTP id g10so3167707ile.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 05:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=kgFGcmgPC8j3KRHWZ4y5Gyk/Fnf8f4ATjgdtBg1RD1A=;
        b=LAPWpdT+BJ///iqgsXGjC2crLuetwImZ5YyU6AVgDPox/7+Gfv0bd3oKP5DFQ1gA+7
         2P6TxbTDTjiN3733UCj/I3dElM515iV3yiSXlwf5l4I+1/j1dt6WBE0ek2tlQCpXho0z
         xeQZaVBGgqu7XlzHkvY3EGNmaNjTPKhYElYgr/hto2mtMX4Fil1XqK5zGziVOBkWV7ob
         YyjhTaEMEBfmX2ED05GBlE25UowNh7BRB9Tqb9l7T+Rzlz52EsjXBkZaEmO9tHFZyHe0
         rQqEPyeuoxCoUhNx3E31S5rqOnH+LauNIq/eFvH2hsM9iuF+kRkSOQ0F/UTvgXaYhWoV
         mpLw==
X-Gm-Message-State: AOAM532hQVFLE8VD2ChwH/TbqGCxtzN4CuOpY7nZzp48Mby8oirhrpVS
        z2P3yy38ujeLuOlUIwl1ALx+9UmiHYnRdYtaaEj3Ok4ZIJSt
X-Google-Smtp-Source: ABdhPJzKakhL76WLvBKzOxJhMiSEhpIghvxAoWZtBw/Qc29GbG//xqYBqwgWc4mVrw77xaQMi6jiEciSsZGZBgCigzE046DPqG0C
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1653:: with SMTP id y19mr8510977iow.90.1607607483982;
 Thu, 10 Dec 2020 05:38:03 -0800 (PST)
Date:   Thu, 10 Dec 2020 05:38:03 -0800
In-Reply-To: <X9GiwQsABTa/zC/t@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000056a2905b61c496c@google.com>
Subject: Re: WARNING in cm109_input_ev/usb_submit_urb
From:   syzbot <syzbot+150f793ac5bc18eee150@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, eli.billauer@gmail.com,
        gregkh@linuxfoundation.org, gustavoars@kernel.org,
        ingrassia@epigenesys.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        vulab@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+150f793ac5bc18eee150@syzkaller.appspotmail.com

Tested on:

commit:         f6d088b4 Input: cm109 - do not stomp on control URB
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=af17f186e004b5ef
dashboard link: https://syzkaller.appspot.com/bug?extid=150f793ac5bc18eee150
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)

Note: testing is done by a robot and is best-effort only.
