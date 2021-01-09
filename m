Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E92F038E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 21:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbhAIUmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 15:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbhAIUmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 15:42:16 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35EEC061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 12:41:35 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 19so11562123qkm.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 12:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IbTb08PprChNngXBvjc4h9VFFvQ6U97TSuYGrcxSOcI=;
        b=bWazo+dTLxeC80/zlvH37orGMH+CtZ4B/NUUeAGTpJmKcZBa0nR05jrhVPZBnMECuS
         2l823exJFjkrBKOQIhVWGCN7M62Jks8DpsjIwsNRkZa+NBwU/kEZBFd32k2cWOu5OCTL
         CbK3CnRPWlznS3TU/z5iAobRbZDmWxihcbBGTRKZep/Ku6PGETz2boGxFC+McnuUxuNn
         kU6XoAlFahqxZ/Khb1nM4BR8WPZOpDUikiu0Bp8GIQ4CwPEzUdJvYvXx1raxx/s3EFjB
         GQwWNeUhUkb8FqOnLRKf/cYl44QtSkrHQeoGqc51Q7juV6PhK9MnTHTxHee5MK87DIm1
         6bSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IbTb08PprChNngXBvjc4h9VFFvQ6U97TSuYGrcxSOcI=;
        b=nlLl5r6DQMSfDfPMDx+ryLgpGD3qxP3wi+CHNZyra7keO1cfjlpEqso5e+KfJI/DMm
         9P39Kb1dhD7Qy/HmyK6JMEcxJQuEF2YFXcv5XR2MddU5NOnOzwHRNDjbav5xXuQUwtgY
         Q5OcVcq2raJ745IwoTIFxSYpuc2LR9qcAWfQ+dn6Cz6PkFSpqVdTLELaHp8fs4aSvK8f
         5/+fWc0PfTLzrX2UWVEKwTU7QtVUvMIBng1Yv/+GDKQBA8GM8HSYjhguwIadJbmjKF+R
         7CZHOiKJaxW/V60PNRPEbfevgZTLnfYgtcAoQeW8p4jp4Bk7CUnWBRGNpOg95/dZ1iGM
         rSWg==
X-Gm-Message-State: AOAM530Zo00r0QHxm9Ft+Xw7M3tvaNMzqbK0gGeEGOfSts3bjHr0GXFn
        zeq66EhxzP3JbnTePlh1VrebuZEPOorEYyThaqfeO/B2WxskzA==
X-Google-Smtp-Source: ABdhPJzMsAiJlxmWDyvRJzb6XoDgIHJfypnMhWP4C3um5OWCFLa6oTNdA7FIdxEYC0G1OcogOR+uk+bCtV5PqS3783o=
X-Received: by 2002:a37:e10c:: with SMTP id c12mr10296358qkm.265.1610224894806;
 Sat, 09 Jan 2021 12:41:34 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001bc23b05b2b6fd8a@google.com>
In-Reply-To: <0000000000001bc23b05b2b6fd8a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 9 Jan 2021 21:41:23 +0100
Message-ID: <CACT4Y+b0-Rw+_aNtGnbwKj7FFM2yKDAsPFO3XP5DnirCRCbbNg@mail.gmail.com>
Subject: Re: upstream build error (11)
To:     syzbot <syzbot+5b0d0de84d6c65b8dd2b@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 9:31 AM syzbot
<syzbot+5b0d0de84d6c65b8dd2b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    4d09c1d9 Merge tag 'devicetree-fixes-for-5.10-1' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1615899c500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a5c844e56cc50cdb
> dashboard link: https://syzkaller.appspot.com/bug?extid=5b0d0de84d6c65b8dd2b
> compiler:       gcc (GCC) 10.1.0-syz 20200507
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5b0d0de84d6c65b8dd2b@syzkaller.appspotmail.com
>
> mm/process_vm_access.c:277:5: error: implicit declaration of function 'in_compat_syscall'; did you mean 'in_ia32_syscall'? [-Werror=implicit-function-declaration]

Other build failures are piling behind this.

#syz fix: mm/process_vm_access: Add missing #include <linux/compat.h>
