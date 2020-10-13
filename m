Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F3F28C7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 06:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgJMERj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 00:17:39 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:47390 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731509AbgJMERi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 00:17:38 -0400
Received: by mail-il1-f199.google.com with SMTP id z14so14123479ilb.14
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 21:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=tPorGxDLGi0uMfoNwIUX6DL2hdrLXA4EUqp8rMDAIYk=;
        b=Nusu6EwMgI+MnamUFqwMIHece0xQhIKXb6IX+DmwPBSNe9GhBROiIZjrXLDjnCQbfK
         qcPTBHDs+3uVBEmTw+pETFw/OzVgkjDeGxk+SGpuDA25ihlEC0PaKSneyOfFxxG9VfLq
         poPU3URCn1yaT8Y8bzhfUeQjCtj+Zc04zf59zsfVx1gPxFlcOoysEPBNAoMIdslNVMHQ
         GNCLP+qmcWxFAUIMqFLL1n+QjffVrqGo12ADS3VcKzZrlvJ50b/T+DmGulEklUcwFO+u
         UUK/XOwzgGBG+DVBxfYFyt2bpLryWrUdRkGIribCNU0650/+OXukXTcIA100KaIVPiWH
         f0qQ==
X-Gm-Message-State: AOAM530vsf2RnxE9CXZ9SmA3iDQ09AX2/K1mXqRlDQrsR73KsuVPnHpf
        wus54HXicHr38gkFBl/xkSam49aMVuPQv1Pd/eii9m2JRYGb
X-Google-Smtp-Source: ABdhPJz/hl4LURaVBryWRE7SqMAukW3wi3HGkzO8bTuq1hF/lE+88Iubb816rQtF9Qq245AUl74XWUiVtVVhImIkwtsdof7uMNh2
MIME-Version: 1.0
X-Received: by 2002:a92:aa81:: with SMTP id p1mr1687291ill.230.1602562657570;
 Mon, 12 Oct 2020 21:17:37 -0700 (PDT)
Date:   Mon, 12 Oct 2020 21:17:37 -0700
In-Reply-To: <2765fd98-7101-832e-2b34-72bd8c5ecf22@acm.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef578405b185b112@google.com>
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

>
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/2765fd98-7101-832e-2b34-72bd8c5ecf22%40acm.org.
