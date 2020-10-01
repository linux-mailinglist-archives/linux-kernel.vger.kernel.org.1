Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E5527F992
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgJAGkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:40:13 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:38945 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgJAGkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:40:07 -0400
Received: by mail-io1-f72.google.com with SMTP id y16so2924962ioy.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 23:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8ZPUiK5xIdDCc0xK61WpBqqfUj8VzeTeMVAnJhuRkZ8=;
        b=oeBjWEQgkzYOdlsMsPxwduUkWM+5T70B0vx2qRWBLVjGYzFYf0XMG+2fJqxeicTYYo
         LwXQMiRlcY3WYYc7BCjvqf4rCVPovJ23ZWc5GdM6KaUypKKfi7cNOzxnhubyZZaaGT9j
         TyqDTCoRAJbcqg1hFhimwVoe1i54Rpuqb36E8HTsXeIFM2gMXFyueCI+InuJ/tdtTKEj
         Kg0Uxf5jQvPEqTeSRxqXy2tHIO8kHSp/trPwD9HGC+QPO1cB/QGBtrrN7EAUOH23IwZW
         Zzxgr0mh6FBSE9eJvAMDSH3ekSzk/ZKNHHnmq3ryxs4trPvea2nqLZIUL9r+acgotohD
         vABA==
X-Gm-Message-State: AOAM533BAPrEwsSsD4xw3uc2tImUSgxfSCqJhWPDGnHFGNJ2MN3/xhkT
        JiJGdSeJNc+jH5OWVUHlIa/gzmoqw0Yjs9Lo2FUIrozwrIDf
X-Google-Smtp-Source: ABdhPJyCUXV1Atqih0XfjzbZqhinetrnbdIcc4dxtZCg5vcKg4pgutDDshPeQdie+3XeA2qiuKejW73TyENaFORzM7nYtxliq4Ng
MIME-Version: 1.0
X-Received: by 2002:a6b:d60b:: with SMTP id w11mr1882148ioa.198.1601534405596;
 Wed, 30 Sep 2020 23:40:05 -0700 (PDT)
Date:   Wed, 30 Sep 2020 23:40:05 -0700
In-Reply-To: <CAM_iQpW+_5wLteCoVc6Wn+z9WOp6FwVUpsy456hM+up0daxedw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000575e3405b09649ff@google.com>
Subject: Re: INFO: task hung in tcf_action_init_1
From:   syzbot <syzbot+82752bc5331601cf4899@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+82752bc5331601cf4899@syzkaller.appspotmail.com

Tested on:

commit:         d5b70379 request_module()
git tree:       https://github.com/congwang/linux.git net
kernel config:  https://syzkaller.appspot.com/x/.config?x=240e2ebab67245c7
dashboard link: https://syzkaller.appspot.com/bug?extid=82752bc5331601cf4899
compiler:       gcc (GCC) 10.1.0-syz 20200507

Note: testing is done by a robot and is best-effort only.
