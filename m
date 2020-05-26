Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C911AE7D7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 23:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgDQVyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 17:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728202AbgDQVyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:54:00 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8D6C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:54:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x1so2656744ejd.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bl0pa+hbUKTXV3E8yhfZmk+igw1QNCwVFqR4CtMCNtE=;
        b=p5mlizDnCc6Smzeerr+47ThU1VtYAcCdc4Har7cwXXeRHLpqG3rirDQ6+LlBZuOJyP
         GwrQFNk1vQ45HD348VApKz5GTRL/X1psqK6RBdD+GENF4rQwP1sfQhilmuZnkp5we2SI
         uo7TM92Ktmx51GV7huHA5vroZ1thy738vLX7EuDAAzrscTktsDwkpbPxyOsKezlytqCo
         HbpGfkw61ya15BWPT/BqPfhwOsgl8uxV37GX3xqEc1WC6us4jCtorA9ncOIaVtJhWFp3
         RFvDCE65Rc86FZoBebdAF7RMOlbuZETqOEgpSOZXfrHqUU57olayACExlZQVFjwaRYLl
         gM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bl0pa+hbUKTXV3E8yhfZmk+igw1QNCwVFqR4CtMCNtE=;
        b=XY0V+XNEqpbdk4DuA0lGIhUaA9ch1n5YHgQf/QTM/7keXrL/rCinHj7808RxF9nNmQ
         FRuw0SnJHRjFbicelxvMXrHDA6EJ7/5lLSEfUXG5HQnmqw848Vl8K3gUIbPJ3iTKOc37
         mY0X2CQwMdWof+5wm5g4qxtlrrjEeuIcryTrT8G7e3pGE/QjJGaT5/JmJ1xTKv0a9CDA
         VBsXfRnI5w8FPWHQ1MlkQEqcIwtn9+2/iuhaafKDHPJVFXXn/GSwQU8olURMeg6zxa1L
         cPkXuPJGh+Bm1zFmuAbz+TKrmoaFbUocNbgbzUOvGTfIIs/woeJEac/HXK/vFTwyEKpG
         9Ydw==
X-Gm-Message-State: AGi0PuZ6MaBfq3wtAe054br3KXdG4Ibts0UK8YJUbZZIIxX7VT7JX7vO
        cMDBj5n2daGCwlvGEpXXpMQvwHnW1kHQwTFSliDS
X-Google-Smtp-Source: APiQypJpQfpzdeKOHwySCCbd4znVvnFmq7fAjX0Z1U3JXdJ9nI+FXYWtWqv07L9QpEU8Uqv70QvY3IRGTcQJQ/A0KtY=
X-Received: by 2002:a17:906:4cd2:: with SMTP id q18mr5203442ejt.70.1587160438885;
 Fri, 17 Apr 2020 14:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584480281.git.rgb@redhat.com> <13ef49b2f111723106d71c1bdeedae09d9b300d8.1584480281.git.rgb@redhat.com>
 <20200318131128.axyddgotzck7cit2@madcap2.tricolour.ca> <CAHC9VhTdLZop0eT11H4uSXRj5M=kBet=GkA8taDwGN_BVMyhrQ@mail.gmail.com>
 <20200318213327.ow22q6nnjn3ijq6v@madcap2.tricolour.ca>
In-Reply-To: <20200318213327.ow22q6nnjn3ijq6v@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Apr 2020 17:53:47 -0400
Message-ID: <CAHC9VhSbbjFbF0A_-saquZ8B85XaF7SWD2e1QcWsXhFSQrUAbQ@mail.gmail.com>
Subject: Re: [PATCH ghak25 v3 3/3] audit: add subj creds to NETFILTER_CFG
 record to cover async unregister
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, twoerner@redhat.com,
        Eric Paris <eparis@parisplace.org>, fw@strlen.de,
        ebiederm@xmission.com, tgraf@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 5:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-03-18 17:22, Paul Moore wrote:
> > On Wed, Mar 18, 2020 at 9:12 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2020-03-17 17:30, Richard Guy Briggs wrote:
> > > > Some table unregister actions seem to be initiated by the kernel to
> > > > garbage collect unused tables that are not initiated by any userspace
> > > > actions.  It was found to be necessary to add the subject credentials to
> > > > cover this case to reveal the source of these actions.  A sample record:
> > > >
> > > >   type=NETFILTER_CFG msg=audit(2020-03-11 21:25:21.491:269) : table=nat family=bridge entries=0 op=unregister pid=153 uid=root auid=unset tty=(none) ses=unset subj=system_u:system_r:kernel_t:s0 comm=kworker/u4:2 exe=(null)
> > >
> > > Given the precedent set by bpf unload, I'd really rather drop this patch
> > > that adds subject credentials.
> > >
> > > Similarly with ghak25's subject credentials, but they were already
> > > present and that would change an existing record format, so it isn't
> > > quite as justifiable in that case.
> >
> > Your comments have me confused - do you want this patch (v3 3/3)
> > considered for merging or no?
>
> I would like it considered for merging if you think it will be required
> to provide enough information about the event that happenned.  In the
> bpf unload case, there is a program number to provide a link to a
> previous load action.  In this case, we won't know for sure what caused
> the table to be unloaded if the number of entries was empty.  I'm still
> trying to decide if it matters.  For the sake of caution I think it
> should be included.  I don't like it, but I think it needs to be
> included.

I'm in the middle of building patches 1/3 and 2/3, assuming all goes
well I'll merge them into audit/next (expect mail soon), however I'm
going back and forth on this patch.  Like you I kinda don't like it,
and with both of us not in love with this patch I have to ask if there
is certification requirement for this?  I know about the generic
subj/obj requirements, but in the case where there is no associated
task/syscall/etc. information it isn't like the extra fields supplied
in this patch are going to have much information in that regard; it's
really the *absence* of that information which is telling.  Which
brings me to wonder if simply the lack of any associated records in
this event is enough?  Before when we weren't associating records into
a single event it would have been a problem, but the way things
currently are, if there are no other records (and you have configured
that) then I think you have everything you need to know.

Thoughts?

-- 
paul moore
www.paul-moore.com
