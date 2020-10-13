Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E02A28C7C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 06:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbgJMERi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 00:17:38 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:49990 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgJMERh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 00:17:37 -0400
Received: by mail-il1-f199.google.com with SMTP id h13so8453776ils.16
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 21:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=iY3viFrVAJoQUr5fMIotbVA9HmEWTMceAT4MYIfos/0=;
        b=hCe5pgH9uMZRUYp7MxTejlYlwRiRououM/lPC/QYxERqi4tdkCju+xJQIE+fYrEI6G
         W6K0unjjIoTAWoI6jD6uecRz8MDtkCpyctPQRFwiiiplOSbcWkn+Hygmst+yX1iLOdjI
         7fhhX1lIbXSpnXM+y3H86GEG7u2dFshdXsEyorp4xEtCiCwkrOHF4biTYPIzoABS8p9J
         KREopgbgSe2DsKBWzEbOBEf4wtNa6EECLSuHwpzEqP5Thjsvy1oCMQHWoqUQai4nbjom
         GXIBYblJ4NGzpkuBD/BrFVo4XPycFv4EPkIJIdKmKqFWjdX9wGMDoNuKCIfl6Dr8t6j8
         SXkw==
X-Gm-Message-State: AOAM533GB15CmAK3BwIOVU/yWlzoBdXEFjXtTvmX3MXZxG2tiqzuYm+H
        b1JEJjo++86ueNuxictWOBq3aH5e4hps8H6k4ybvBMeh5cHE
X-Google-Smtp-Source: ABdhPJyCzM2h0NKSaYYOvw7lLCOo6QwSPg5iXf4KOPxWCdGDLYFetuC5+UeL4qytDVu/rB/vwPXPYdZVD3vdwgBhsmjd2kvMxIrW
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1508:: with SMTP id b8mr21585149jat.25.1602562655495;
 Mon, 12 Oct 2020 21:17:35 -0700 (PDT)
Date:   Mon, 12 Oct 2020 21:17:35 -0700
In-Reply-To: <2765fd98-7101-832e-2b34-72bd8c5ecf22@acm.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfc16205b185b15e@google.com>
Subject: Re: Re: WARNING in udf_truncate_extents
From:   syzbot <syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, bvanassche@acm.org, chaitanya.kulkarni@wdc.com,
        jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 10/12/20 6:20 AM, syzbot wrote:
>> dashboard link: https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ce0a8b900000
>> 
>> The issue was bisected to:
>> 
>> commit 2004bfdef945fe55196db6b9cdf321fbc75bb0de
>> Author: Bart Van Assche <bvanassche@acm.org>
>> Date:   Tue Mar 10 04:26:21 2020 +0000
>> 
>>     null_blk: Fix the null_add_dev() error path
>
> #syz wrong-bisect

unknown command "wrong-bisect"

