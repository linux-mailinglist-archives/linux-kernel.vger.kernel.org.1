Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596EC27B4AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgI1SmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:42:12 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:57256 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI1SmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:42:11 -0400
Received: by mail-io1-f71.google.com with SMTP id d21so1254718iow.23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 11:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=USTitjBt7BhgpNWZwLXk38Ti/vZU2Kr0xZT/wNOO+pU=;
        b=LAk9+mcHLoAGoV795EBSTwvYnJAaQZluZ5zc1utfOuOF5MYBiW3XYuqhpIuxJiPzdA
         gyCgEHFroiaaqSf2VwJj7q3GqDubdki3+z4k0b7vLRpHBzO9ZRen2awyCFJOuz/bXUv+
         08eU1MYxvbPGREf52OfhHCn05b+uxVstpa02939rX3MK//h9JZstxprGClDnI8jxUK+h
         09pMKeQJ/p4GbbPipAqDYp4xo43HGH8JhEX0EHKW9t8uANSlSMQcXwle3Yjzc4xvx/jm
         vNZqApa7svk4zMtukvYIJPlSJSaGY5zSt9rtCIj7FngCBqfYsnhI3M9OFQuKz0NLw3si
         hEZQ==
X-Gm-Message-State: AOAM531KEz82ema1mKbGBEkwB4uBWBGfcP4nmUvb7f690zDWukx0RgMo
        M5HMu5agJH/Yb6ZuP/6Q0wGL0Izwkc/8A7Jx7NaF18ZZVVhS
X-Google-Smtp-Source: ABdhPJy+jPyOc19HWBq/6EBaZVHRqolvxOK1YlgdhD/ZPfoMxbwmw1fYgbCWxrcCJUEULrfUE4QjhVhXDmX54Bs+w5gJIXnEGp3l
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:e0a:: with SMTP id a10mr2461640ilk.113.1601318530184;
 Mon, 28 Sep 2020 11:42:10 -0700 (PDT)
Date:   Mon, 28 Sep 2020 11:42:10 -0700
In-Reply-To: <835b294f-2d2b-082b-04dd-819e12095698@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029fbe305b06406d0@google.com>
Subject: Re: general protection fault in io_poll_double_wake (2)
From:   syzbot <syzbot+81b3883093f772addf6d@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+81b3883093f772addf6d@syzkaller.appspotmail.com

Tested on:

commit:         fad8e0de io_uring: fix potential ABBA deadlock in ->show_f..
git tree:       git://git.kernel.dk/linux-block io_uring-5.9
kernel config:  https://syzkaller.appspot.com/x/.config?x=2daac53dfbd493d7
dashboard link: https://syzkaller.appspot.com/bug?extid=81b3883093f772addf6d
compiler:       gcc (GCC) 10.1.0-syz 20200507

Note: testing is done by a robot and is best-effort only.
