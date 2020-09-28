Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E954C27A8A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgI1Hbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgI1Hbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:31:31 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563CBC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:31:31 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 7so83910pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SN/Z1OKLST8clHo8zLGMXWmW2Rhd5mTXkIDbXO4m+xw=;
        b=RB4FNLYXOt1zYeWhgSIpWxa6hr5V1gngd6TOV8SY59DaowmdqE7mulg3nv4WJS1uFl
         gqG2n8GYPx0khDUCp8veYbrlpcdSHxPs1uzWO2SdfaNpS05iJcF2dxECp1evLOYlY1Ew
         pWG3cV833/9kPpv95pG117ilzo5MBD115qnaYZdkkK6x9JK4lv6+fxBjc3+8+fmmaXnj
         T35fdYEFYBtbMR3xJk+RPnwKWC70xEBYA8O5yA+2Y2YRn9g8ygDORzRBFHd4+raTmaXx
         rRHAra0xXzJu00zWMmwDTqhTq+4EOfjBodhrOi+7g2Fo21RLlLilPEQ3cyzCtrE5x1oU
         jCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SN/Z1OKLST8clHo8zLGMXWmW2Rhd5mTXkIDbXO4m+xw=;
        b=HrYCn/yQVVJR3KfecIO4o4zR70NTTybvr0h3dRBLv1ekwK/IdteHWlsQ9L1MFrmON6
         0fC8W1JghELtHmiRAYc7JWts8NswCkD2kTl0dabzTbyVX6CFiGzjQfPC9FyeXvcvQPsh
         GDkHB1TY1Opus1qTjhg0AQA45jPMtIEAqXS4VTFY7tIYEnjE56RUuZPN4d/NNY/CHPgI
         Lv2nFViuhlE5ciOYrVRjN3ODjlatZ3YC+GxhHRHR/3lhlaP0dOxy1dvY1nHbQ3qSEwxS
         HM2wU0m4jB5OuKKy4mt+P2ghLaaJC5VqShRRuCRzeqMchyE7vwR1RoM0fhtw+FCUOMD2
         h0sg==
X-Gm-Message-State: AOAM531YQZbCyNxu7U1bFcEvSumJ4+msa6N0okMXgjqYAg5qZiguHAWl
        zhB48NXEKPSDcpgNgNX5VDg+PhIv0tnZc4wOBjL4mg==
X-Google-Smtp-Source: ABdhPJy1otaDActJ6s1m+1IF7tomXdsJ2jKgsNqvLoKJt7rL2BnRgzzOFHP+NnJK2ZdcqYZeigg0RsoMwOAe0x0pRUw=
X-Received: by 2002:aa7:941a:0:b029:142:2501:35d1 with SMTP id
 x26-20020aa7941a0000b0290142250135d1mr329020pfo.49.1601278290803; Mon, 28 Sep
 2020 00:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200828031928.43584-1-songmuchun@bytedance.com>
 <CAMZfGtWtAYNexRq1xf=5At1+YJ+_TtN=F6bVnm9EPuqRnMuroA@mail.gmail.com>
 <8c288fd4-2ef7-ca47-1f3b-e4167944b235@linux.com> <CAMZfGtXsXWtHh_G0TWm=DxG_5xT6kN_BbfqNgoQvTRu89FJihA@mail.gmail.com>
 <2f347fde-6f8d-270b-3886-0d106fcc5a46@linux.com> <CAMZfGtVhrgvWqCG140e7S5wn00ocS5L_t=KFNpbsfXhc293rSg@mail.gmail.com>
 <eab0e129-b4dd-a683-349b-972c56f8d840@linux.com>
In-Reply-To: <eab0e129-b4dd-a683-349b-972c56f8d840@linux.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 28 Sep 2020 15:30:54 +0800
Message-ID: <CAMZfGtVbuA_mt1CQ4QGWO_fz1f_SCTvQj9gW-P44f_jo_B7OaQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] stackleak: Fix a race between stack
 erasing sysctl handlers
To:     alex.popov@linux.com
Cc:     Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        miguel.ojeda.sandonis@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 2:32 PM Alexander Popov <alex.popov@linux.com> wrote:
>
> On 22.09.2020 08:59, Muchun Song wrote:
> > On Mon, Sep 14, 2020 at 9:56 PM Alexander Popov <alex.popov@linux.com> wrote:
> >>
> >> On 07.09.2020 16:53, Muchun Song wrote:
> >>> On Mon, Sep 7, 2020 at 7:24 PM Alexander Popov <alex.popov@linux.com> wrote:
> >>>>
> >>>> On 07.09.2020 05:54, Muchun Song wrote:
> >>>>> Hi all,
> >>>>>
> >>>>> Any comments or suggestions? Thanks.
> >>>>>
> >>>>> On Fri, Aug 28, 2020 at 11:19 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >>>>>>
> >>>>>> There is a race between the assignment of `table->data` and write value
> >>>>>> to the pointer of `table->data` in the __do_proc_doulongvec_minmax() on
> >>>>>> the other thread.
> >>>>>>
> >>>>>>     CPU0:                                 CPU1:
> >>>>>>                                           proc_sys_write
> >>>>>>     stack_erasing_sysctl                    proc_sys_call_handler
> >>>>>>       table->data = &state;                   stack_erasing_sysctl
> >>>>>>                                                 table->data = &state;
> >>>>>>       proc_doulongvec_minmax
> >>>>>>         do_proc_doulongvec_minmax             sysctl_head_finish
> >>>>>>           __do_proc_doulongvec_minmax           unuse_table
> >>>>>>             i = table->data;
> >>>>>>             *i = val;  // corrupt CPU1's stack
> >>>>
> >>>> Hello everyone!
> >>>>
> >>>> As I remember, I implemented stack_erasing_sysctl() very similar to other sysctl
> >>>> handlers. Is that issue relevant for other handlers as well?
> >>>
> >>> Yeah, it's very similar. But the difference is that others use a
> >>> global variable as the
> >>> `table->data`, but here we use a local variable as the `table->data`.
> >>> The local variable
> >>> is allocated from the stack. So other thread could corrupt the stack
> >>> like the diagram
> >>> above.
> >>
> >> Hi Muchun,
> >>
> >> I don't think that the proposed copying of struct ctl_table to local variable is
> >> a good fix of that issue. There might be other bugs caused by concurrent
> >> execution of stack_erasing_sysctl().
> >
> > Hi Alexander,
> >
> > Yeah, we can fix this issue on a higher level in kernel/sysctl.c. But
> > we will rework some kernel/sysctl.c base code. Because the commit:
> >
> >     964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")
> >
> > is introduced from linux-4.20. So we should backport this fix patch to the other
> > stable tree. Be the safe side, we can apply this patch to only fix the
> > stack_erasing_sysctl. In this case, the impact of backport is minimal.
> >
> > In the feature, we can fix the issue(another patch) like this on a higher
> > level in kernel/sysctl.c and only apply it in the later kernel version. Is
> > this OK?
>
> Muchun, I would recommend:
>   1) fixing the reason of the issue in kernel/sysctl.c
> or
>   2) use some locking in stack_erasing_sysctl() to fix the issue locally.

Yeah, this is work.

>
> Honestly, I don't like this "dup_table" approach in the patch below. It doesn't
> remove the data race.

Alexander, I don't understand where the race is? I think that the duplicate is
enough. But If you prefer using the lock to protect the data. I also
can do that.

>
> Thank you!
> Alexander
>
> >> I would recommend using some locking instead.
> >>
> >> But you say there are other similar issues. Should it be fixed on higher level
> >> in kernel/sysctl.c?
> >>
> >> [Adding more knowing people to CC]
> >>
> >> Thanks!
> >>
> >>>> Muchun, could you elaborate how CPU1's stack is corrupted and how you detected
> >>>> that? Thanks!
> >>>
> >>> Why did I find this problem? Because I solve another problem which is
> >>> very similar to
> >>> this issue. You can reference the following fix patch. Thanks.
> >>>
> >>>   https://lkml.org/lkml/2020/8/22/105
> >>>>
> >>>>>> Fix this by duplicating the `table`, and only update the duplicate of
> >>>>>> it.
> >>>>>>
> >>>>>> Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")
> >>>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>>>>> ---
> >>>>>> changelogs in v2:
> >>>>>>  1. Add more details about how the race happened to the commit message.
> >>>>>>
> >>>>>>  kernel/stackleak.c | 11 ++++++++---
> >>>>>>  1 file changed, 8 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> >>>>>> index a8fc9ae1d03d..fd95b87478ff 100644
> >>>>>> --- a/kernel/stackleak.c
> >>>>>> +++ b/kernel/stackleak.c
> >>>>>> @@ -25,10 +25,15 @@ int stack_erasing_sysctl(struct ctl_table *table, int write,
> >>>>>>         int ret = 0;
> >>>>>>         int state = !static_branch_unlikely(&stack_erasing_bypass);
> >>>>>>         int prev_state = state;
> >>>>>> +       struct ctl_table dup_table = *table;
> >>>>>>
> >>>>>> -       table->data = &state;
> >>>>>> -       table->maxlen = sizeof(int);
> >>>>>> -       ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> >>>>>> +       /*
> >>>>>> +        * In order to avoid races with __do_proc_doulongvec_minmax(), we
> >>>>>> +        * can duplicate the @table and alter the duplicate of it.
> >>>>>> +        */
> >>>>>> +       dup_table.data = &state;
> >>>>>> +       dup_table.maxlen = sizeof(int);
> >>>>>> +       ret = proc_dointvec_minmax(&dup_table, write, buffer, lenp, ppos);
> >>>>>>         state = !!state;
> >>>>>>         if (ret || !write || state == prev_state)
> >>>>>>                 return ret;
> >>>>>> --
> >>>>>> 2.11.0
> >
> >
> >
>


-- 
Yours,
Muchun
