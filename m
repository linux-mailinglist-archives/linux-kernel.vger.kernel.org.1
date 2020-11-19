Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE2A2B8D95
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgKSIhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgKSIhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:37:08 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B380C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:37:08 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id l10so5356079lji.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+a6SBHOIGDEXoUce4L2waaYCg/VrsfsbxsAVjJObJs=;
        b=i7+TxqaMRgKxz7TG5cv8ZTGsAbtZydVKfDJxoELRlLmYRrbI2Y/oBl9ogL+zhdUjFb
         9yy0MmENgbDJmdvePwPaK/lx4FWv3uPc2ZsF6oEAK4+6rZaKhmtHyYG9PBBXKlJvKsU0
         XYQxT7qwFfwhUV9VPRdXjY9QCf61OrVaWeZ4eroaL5ZP8yWA1lZCCriVnI2dgGRpt9Tq
         0aDudarCu2umDCS1lXfiHO6NXYSVBIHFcDcu4X/81LNxzVNdBefOguxWlwz5ec57rVrQ
         n9pfAE5w68jI/8GJT3B+BtE9/ye/mV+iZOs2aTO6jJeoAUskQq6lcNLGr+rcsAZuHPy5
         QwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+a6SBHOIGDEXoUce4L2waaYCg/VrsfsbxsAVjJObJs=;
        b=U4CeSduY2kNurSDHPfQldZFOfTDlfq1ncSz5Y94FeVZqATUbNRsJX6EnNqZA/ZwbXD
         nVLnNTyRjCDdhZ31C9usuzaEOxt/O4RHJO0nM98GFSG4A2QArYtu1GLtPN5/1TXyPwBB
         ObOY8822C+7RFUBP8KKRJ4Y2mSdbgWrBghqRmg7nceHB20Yz1HCXDfWmzfMEcQ9shBq+
         xdFAfntoOw5YrLzgB5CO8GjVtPhfsWeRPxdNAzqTbQ8iUG9FxAbHUdByICEwE1NwNYwl
         n0ATy4QKc5Pv8BMMM3jzH9NMlfYF0MlO6L/jkIdbExuAEKLK3WjBGy8u4tmCKiugnc7d
         7f2g==
X-Gm-Message-State: AOAM530H9ydTCVAoJ22fc8Jum8/imXiWVq5Z5OkOynUg9smYkIQh/CnN
        4A/XkOrrMit6iTmT3W4tllHNb9lMDGX8BnF1agjVEA==
X-Google-Smtp-Source: ABdhPJyh3AOhoLZVXBPx2c33/4l51LAm2SjHPARaDKjrDDgbfplrndx8N1XvlKiBRDDzlTxHeRp5AV8lUa9+W76H6mQ=
X-Received: by 2002:a2e:b8d4:: with SMTP id s20mr5742322ljp.226.1605775026714;
 Thu, 19 Nov 2020 00:37:06 -0800 (PST)
MIME-Version: 1.0
References: <17fc60a3-cc50-7cff-eb46-904c2f0c416e@canonical.com>
 <20201118235015.GB6015@geo.homenetwork> <20201119003319.GA6805@geo.homenetwork>
In-Reply-To: <20201119003319.GA6805@geo.homenetwork>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 19 Nov 2020 09:36:55 +0100
Message-ID: <CAKfTPtBYm8UtBBnbc7qddA2_OAa3vwH=KoHNgvsQJ9zO2KocYQ@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: fix unthrottle_cfs_rq for leaf_cfs_rq list
To:     Tao Zhou <t1zhou@163.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        SeongJae Park <sjpark@amazon.com>
Cc:     Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tao Zhou <zohooouoto@zoho.com.cn>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Tao Zhou <ouwen210@hotmail.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Gavin Guo <gavin.guo@canonical.com>, halves@canonical.com,
        nivedita.singhvi@canonical.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "# v4 . 16+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 at 01:36, Tao Zhou <t1zhou@163.com> wrote:
>
> On Thu, Nov 19, 2020 at 07:50:15AM +0800, Tao Zhou wrote:
> > On Wed, Nov 18, 2020 at 07:56:38PM -0300, Guilherme G. Piccoli wrote:
> > > Hi Vincent (and all CCed), I'm sorry to ping about such "old" patch, but
> > > we experienced a similar condition to what this patch addresses; it's an
> > > older kernel (4.15.x) but when suggesting the users to move to an
> > > updated 5.4.x kernel, we noticed that this patch is not there, although
> > > similar ones are (like [0] and [1]).
> > >
> > > So, I'd like to ask if there's any particular reason to not backport
> > > this fix to stable kernels, specially the longterm 5.4. The main reason
> > > behind the question is that the code is very complex for non-experienced
> > > scheduler developers, and I'm afraid in suggesting such backport to 5.4
> > > and introduce complex-to-debug issues.
> > >
> > > Let me know your thoughts Vincent (and all CCed), thanks in advance.
> > > Cheers,
> > >
> > >
> > > Guilherme
> > >
> > >
> > > P.S. For those that deleted this thread from the email client, here's a
> > > link:
> > > https://lore.kernel.org/lkml/20200513135528.4742-1-vincent.guittot@linaro.org/
> > >
> > >
> > > [0]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fe61468b2cb
> > >
> > > [1]
> > > https://lore.kernel.org/lkml/20200506141821.GA9773@lorien.usersys.redhat.com/
> > > <- great thread BTW!
> >
> > 'sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list" failed to apply to
> > 5.4-stable tree'
> >
> > You could check above. But I do not have the link about this. Can't search it
> > on LKML web: https://lore.kernel.org/lkml/
> >
> > BTW: 'ouwen210@hotmail.com' and 'zohooouoto@zoho.com.cn' all is myself.
> >
> > Sorry for the confusing..
> >
> > Thanks.
>
> Sorry again. I forget something. It is in the stable.
>
> Here it is:
>
>   https://lore.kernel.org/stable/159041776924279@kroah.com/

I think it has never been applied to stable.
As you mentioned, the backport has been sent :
https://lore.kernel.org/stable/20200525172709.GB7427@vingu-book/

I received another emailed in September and pointed out to the
backport : https://www.spinics.net/lists/stable/msg410445.html


>
