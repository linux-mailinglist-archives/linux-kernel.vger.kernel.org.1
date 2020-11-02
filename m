Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5CF2A2DFC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgKBPTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgKBPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:19:33 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75B3C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 07:19:31 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id p7so15303820ioo.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 07:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=49FGBKLX9bjRkUIwwFYH04GGaHdzd9ual/GUV3gPQsU=;
        b=Z9YjdCoMGxgXi8OKp7mMzKofIUTxG3aaghQ4KuqjZoIQ60iQ+0AYAk4pbEYrkhQcas
         bXSwZ/8q078axG1lyreFsisJspjsS8TaRGqNXNQzwEyl2zQ0hcXbeC4QQnY2CU4Jn4SF
         MGC76YUNUkvOpZG75zKiBAZK+WsXAlkA8TBxVoDjDHVqpX2iqoZX7JcTODvb0zWJcOfP
         0LIWCB0MuKEE/QXc9CEMOFBc/cHAywmV5m5N3iYb0UR2TyM5uCt12h13ufNOHTaJ3IAw
         iGYTFgGQBsQDt08aCfCpvOjMZ2QdexJOMXveQliBvzaI7dQKYNGn7CM663YM2Py0oVRc
         IZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=49FGBKLX9bjRkUIwwFYH04GGaHdzd9ual/GUV3gPQsU=;
        b=CwOzHRFhfXWrXowUEEaVhqw+sp5I3lpTzDPWE1ArAWgmqXgehuGJm62Dq0ge5Nz3hS
         poL/Y3cKwTjhJE/k4c6qdh9nQLJIzR2S/174Pqhb4uWFK961xTDs7N88G+tNIYRZAFhj
         V9MEwDz2DKZ5uKE9rimdJnRsQeKfgebUjVhiwV2xJR3x5ROyc6Q9hEOY6nKyzUC4lK7B
         ql+G9TW2Ub5nPX1rdQdz40Rkr75ohD1uecLPAluYapc7MYZp+543W1+1fuyLP2DwACdY
         /TtrZDtdgKBJsBxglM13ymvklVyd2UQjfgKh2Ire/UhlU70n5PTiFfZahbNwqUozQDZE
         7FQQ==
X-Gm-Message-State: AOAM531Wn6DHl1QNnQMH6qCapI8geIl1ej1oZ2LHcDiQF4z1iXp35527
        cVRkIwa7ZLGN7LB6dWL3El3i3A==
X-Google-Smtp-Source: ABdhPJxpku+l31t6D5PSG3BnC/0CVXqaptAeWUb/56zYbW0Bbd3pGxC590t1qtuOaZ58Q1B35gotfw==
X-Received: by 2002:a6b:6806:: with SMTP id d6mr10963958ioc.54.1604330371135;
        Mon, 02 Nov 2020 07:19:31 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t16sm10775048ilh.76.2020.11.02.07.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 07:19:30 -0800 (PST)
Subject: Re: KASAN: null-ptr-deref Write in kthread_use_mm
To:     syzbot <syzbot+b57abf7ee60829090495@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org
References: <00000000000008604f05b31e6867@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <298f1180-ab14-d08e-dcd2-3e4bbbc1e90a@kernel.dk>
Date:   Mon, 2 Nov 2020 08:19:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000008604f05b31e6867@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/20 4:54 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4e78c578 Add linux-next specific files for 20201030
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=148969d4500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=83318758268dc331
> dashboard link: https://syzkaller.appspot.com/bug?extid=b57abf7ee60829090495
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e1346c500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1388fbca500000
> 
> The issue was bisected to:
> 
> commit 4d004099a668c41522242aa146a38cc4eb59cb1e
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Fri Oct 2 09:04:21 2020 +0000
> 
>     lockdep: Fix lockdep recursion

That bisection definitely isn't correct. But I'll take a look at the issue.

-- 
Jens Axboe

