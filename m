Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B768C2B1AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgKMMKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgKMMKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:10:20 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735FAC0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 04:10:19 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id ec16so4457781qvb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 04:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiehXoilaLcjVL9BlBQaNhTaAJDG9nqqIO0TWMbl7mA=;
        b=B07q5E3cb5/mB7Ld7CNt3Vbvde8zMncRaosaJDlZv6Vt864LjakgIYDon/9ubBonvg
         MO3dfCIP5RFXoUEuTnK7p8eV0NxSxk1WH1Oa0YEVRaifFQE/SkBLrhNubfN70NR24tVd
         D9m5jD86WUrSyzE6XiabBxQIrGVN34QmK0s6i0KeMXu+JwDjPh2iF2jRylV3bjBlmq17
         jge0XZ+wdtj6d0xSME6wxs+eY8E6end4ZX1KPOZSaD6XPoYcKtRYRbKQwwDNnOsKS4p4
         sGxcLt+g5Kc2UZNxyhcQYCU5nnMlVoyrUE4ilHTXS9cc+ImaVSEHK0wNnztoDxy4E/7H
         ihnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiehXoilaLcjVL9BlBQaNhTaAJDG9nqqIO0TWMbl7mA=;
        b=RIbWyjLGCvkrBFKnZZ5oxDzISxEr4iEunDeVRTSqvKOP5BQXrOsxpcdxRTMdMb/eAH
         +LhnTct8OdukNl54/Eg4ouOOj1YumerG2uTuFAe7rEkh5cRlVUor5FfpOInyUpj0a1oz
         f7khTvTGfQ711TDkI3bQG5hlwjcq2GRlSwhNLZA/8iqje8Sy+tEGHCDxWGUra1IErx7d
         K8bPlqLl2l9GiYG0wO6XwybUKqVv260XguvMLVayZ8AdaNmczL2L7H75LUA1tQAxjAco
         p5vHyqtjLuByR3UphpsGHKemFMq1vCCG98QLyaAyJKBCNXgFYMVNsyYjRxMN3nCW3B7H
         u5fA==
X-Gm-Message-State: AOAM532DuzbENmwxSaaEFfaJINNP53RcsuND3+6fj+AEGHELQU7IX9x9
        e/jlf+Iz9jCmfakUJA9s1Nv/4wf5F+qSPH+HmV6/JQ==
X-Google-Smtp-Source: ABdhPJz0bG9vUG7cborAESnk3G+Mfz2v/pDLuOMyNrvdaU6cKXA9OkAgDWAnWlxShWUS3ojvDZ7hgvRtw5w5WSbreCg=
X-Received: by 2002:a0c:e911:: with SMTP id a17mr2006226qvo.18.1605269418352;
 Fri, 13 Nov 2020 04:10:18 -0800 (PST)
MIME-Version: 1.0
References: <00000000000061316205b0e750fc@google.com> <0000000000004cb88b05b2e8d1b4@google.com>
 <CACVXFVNk9Os+2Bzht+eoeFZr=E-FCBZg2SSYx5AP_eu_-3zF3w@mail.gmail.com>
In-Reply-To: <CACVXFVNk9Os+2Bzht+eoeFZr=E-FCBZg2SSYx5AP_eu_-3zF3w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 13 Nov 2020 13:10:06 +0100
Message-ID: <CACT4Y+YrLRueFzXqNrWcy5ic-TsAJz393G+fg_4x1zfMo061oQ@mail.gmail.com>
Subject: Re: INFO: task can't die in nbd_ioctl
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     syzbot <syzbot+69a90a5e8f6b59086b2a@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nbd@other.debian.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 8:21 AM Ming Lei <tom.leiming@gmail.com> wrote:
>
> On Sat, Oct 31, 2020 at 4:01 AM syzbot
> <syzbot+69a90a5e8f6b59086b2a@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    4e78c578 Add linux-next specific files for 20201030
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=158c1798500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=83318758268dc331
> > dashboard link: https://syzkaller.appspot.com/bug?extid=69a90a5e8f6b59086b2a
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e051a8500000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bf75b8500000
>
> Not reproduce this issue by above C reproducer with the kernel config
> in hours running
> on linus tree.

Let's see how reproducible this is by syzbot:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git
4e78c578
