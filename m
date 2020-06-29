Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E048A20D752
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 22:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbgF2T2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 15:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732730AbgF2T1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:27:42 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB88C02F001
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:42:21 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 80so15431916qko.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tE+uNMOmvXKlM9MDwwvgwFQMudiDJ08BXLKwViIBRLY=;
        b=LS90ccyCxqDOxTxwPHvo89xHzOig0kIiAq98F9lLvIs20b9BxtBaGOrz/M44C5MqgF
         TZOU/4JkmtukoMvCXd5uoTSIBnQ8boOMor6YWLZirgi4IOoo4l9/gg1GYMgxAJXrm3FB
         98XzhtA/KJC8gVVe772zfCF/ZwKVixT3Ri31lUu5twbHr3tFX3y72r68Tdf/MAFdUluy
         36GaY8xThFhUZVFHF+m8dfSVi6EauZa3IvDWeUKlCtjzMw8MQvmchel3JoA0ztSu79dd
         pqBfw3+zayqgi+lkLY483iZ1F9JB1XHUQqYOfRsBOhs0/kvgel6cVPwiZ7lEe+lWgr2L
         67eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tE+uNMOmvXKlM9MDwwvgwFQMudiDJ08BXLKwViIBRLY=;
        b=T12aAotE0U6o3cxDtWct43E066VxfPqFLezjUzvUw90Lkkp8H77NR4KATMcKvsME1L
         3aXOxQK1mxhjR5Lo76Nm5G5Qr5XFqSWcj/BB9u1nArrgeuqA4jPAz5MCoc77ayN1Wf6B
         ZPurrRIAnUhgpChEZxnfV+qhF59KyohyAveQQ+6Tc3p/lGN3DQkvQWPkdERJWbabn2Pz
         0ir3847bXSuu5SnaAW+TCz0CA+Ui3Vvreb8OqKKXUQQr8Ftih3mUfrcYSB6fB9r6pLLj
         +0kBedcym0+yrfmwT+xw2Ni12H3fPNeluBPSMlymmC+p+SiN4txY6xn8P+dpLE/q2nsT
         9qPw==
X-Gm-Message-State: AOAM532QxJOwMzoQ2MxnkTcGUmacfH74TwfqJ/XNtLRDbJR+NbPJ0w0S
        JCXisP2teKGYkqyh4myj9e6zog23s0R5O/r7Mrk9HA==
X-Google-Smtp-Source: ABdhPJxFnEE8YM5H4v2UGyxhHpGF+cgvplp7W5loGFKkU6AuQB7Fsvqsvm/XwmyMqUVAVtHc+Gu/JMZu4R/ZJ0vOZcg=
X-Received: by 2002:a37:4f0e:: with SMTP id d14mr15780018qkb.8.1593441739957;
 Mon, 29 Jun 2020 07:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000107b4605a7bdce7d@google.com> <20200614085321.8740-1-hdanton@sina.com>
 <20200627130205.16900-1-hdanton@sina.com> <20200627222527.GC25301@ziepe.ca>
In-Reply-To: <20200627222527.GC25301@ziepe.ca>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 29 Jun 2020 16:42:08 +0200
Message-ID: <CACT4Y+ab1q7fON3rkj+FHODPQXDGyP5c0tJt7gbrpmsAAYRb1g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in addr_handler (2)
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+a929647172775e335941@syzkaller.appspotmail.com>,
        chuck.lever@oracle.com, Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        parav@mellanox.com, Markus Elfring <Markus.Elfring@web.de>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 12:25 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sat, Jun 27, 2020 at 09:02:05PM +0800, Hillf Danton wrote:
> > > So, to hit this syzkaller one of these must have happened:
> > >  1) rdma_addr_cancel() didn't work and the process_one_work() is still
> > >     runnable/running
> >
> > What syzbot reported indicates that the kworker did survive not only
> > canceling work but the handler_mutex, despite it's a sync cancel that
> > waits for the work to complete.
>
> The syzbot report doesn't confirm that the cancel work was actaully
> called.
>
> The most likely situation is that it was skipped because of the state
> mangling the patch fixes..
>
> > >  2) The state changed away from RDMA_CM_ADDR_QUERY without doing
> > >     rdma_addr_cancel()
> >
> > The cancel does cover the query state in the reported case, and have
> > difficult time working out what's in the patch below preventing the
> > work from going across the line the sync cancel draws. That's the
> > question we can revisit once there is a reproducer available.
>
> rdma-cm never seems to get reproducers from syzkaller

+syzkaller mailing list

Hi Jason,

Wonder if there is some systematic issue. Let me double check.
