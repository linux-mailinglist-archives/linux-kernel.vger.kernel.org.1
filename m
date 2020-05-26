Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871061D79BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 15:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgERNX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 09:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgERNX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:23:58 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009F0C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 06:23:56 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id l20so9757274ilj.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q4s3spBg1MuQWtvDoLbMK2ZyIIe+vIiqKz2qRus6bcE=;
        b=FkOxga9Dic5nQJwkNzsVST9nRMKVvuIQXGyC+Qu8JLihUgSmqGzBG45VF1NIECnq22
         gcbg77nIvuONrKk7DRL079v/BUjPCIL2esjGqBbvBWjmIuJE3EMBjUcD0EkaGMOUHRCh
         /aw9qffWm37ZXBFYLj96l1AZZ7hADAEe6VOnpIVrDvXSQBZyY+efl9yaiNtSC1WDH7du
         AVVVmwzNG1bwXaDGbyMl7kvIiuE1Qq2JrJcEQ3JpsY2xp+BXpmF9tV+VPbdurWjG4Fb0
         XyhjlVRPpYnA53BHqfdvsBTS+S7uF8irc3dfK6BkNU/0qsyQSp/FJXHf2+qV+ssMSz4F
         48qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q4s3spBg1MuQWtvDoLbMK2ZyIIe+vIiqKz2qRus6bcE=;
        b=YppDIWtLd0gIbC2Tb6oP7+kqT374z9ECDiXPiEJD2diji8RabMzooHt4WCYZ3VI2lk
         UD0qC6B3LO7PenjsRhreh/T5Q0kjwRkW9J5OJ4DjRKpPlbh2miCd2aYawaaV7Zcjrqbl
         VhYKGap+33sZbpWncDR1EmIRFn+xAxkOpbNq94O6ecaPUiHt0QseY1r9N1fJYMSRIvf6
         fP+l8WJsNBbxB53knCn62Iaf/Z0Ac5ECcXU91np2Iiq7Df3SDg2Le6ISSVBDsm9pCVLi
         Y7IG7bABBNTKeoBs0utAMzFTScjg9rXK0pAKPYTl5EwNeuksJgqQcyodiKBRy4ZPiBtD
         KTsQ==
X-Gm-Message-State: AOAM531uF5zxEsiHhwnA3sDefRdtnodQuulQp9ryYdaQb0dGYh73sifM
        2QTM0w4fkFKC+e4xj18ckpJNXg==
X-Google-Smtp-Source: ABdhPJwRtGlPfxeHoGNDCJ45N+N0IqzWHJg3O0a3If8fksTe0+6NFI/ylWgN0YggwyyP5Jg8qwPYQg==
X-Received: by 2002:a05:6e02:13e3:: with SMTP id w3mr14739119ilj.62.1589808236285;
        Mon, 18 May 2020 06:23:56 -0700 (PDT)
Received: from cisco ([2601:282:b02:8120:6155:7c8c:3dc0:c56e])
        by smtp.gmail.com with ESMTPSA id j2sm3910456ioo.8.2020.05.18.06.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:23:55 -0700 (PDT)
Date:   Mon, 18 May 2020 07:23:55 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Message-ID: <20200518132355.GB2405879@cisco>
References: <202005162344.74A02C2D@keescook>
 <20200517104701.bbn2d2rqaplwchdw@wittgenstein>
 <20200517112156.cphs2h33hx2wfcs4@yavin.dot.cyphar.com>
 <20200517142316.GA1996744@cisco>
 <20200517143311.fmxaf3pnopuaezl4@wittgenstein>
 <20200517144603.GD1996744@cisco>
 <20200517150215.GE1996744@cisco>
 <202005171428.68F30AA0@keescook>
 <20200518083224.GA16270@ircssh-2.c.rugged-nimbus-611.internal>
 <20200518124500.5cb7rtjitbiiw3mq@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518124500.5cb7rtjitbiiw3mq@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 02:45:00PM +0200, Christian Brauner wrote:
> On Mon, May 18, 2020 at 08:32:25AM +0000, Sargun Dhillon wrote:
> > On Sun, May 17, 2020 at 02:30:57PM -0700, Kees Cook wrote:
> > > On Sun, May 17, 2020 at 09:02:15AM -0600, Tycho Andersen wrote:
> > > 
> > > I'm going read this thread more carefully tomorrow, but I just wanted to
> > > mention that I'd *like* to extend seccomp_data for doing deep argument
> > > inspection of the new syscalls. I think it's the least bad of many
> > > designs, and I'll write that up in more detail. (I would *really* like
> > > to avoid extending seccomp's BPF language, and instead allow probing
> > > into the struct copied from userspace, etc.)
> > > 
> > > Anyway, it's very related to this, so, yeah, probably we need a v2 of the
> > > notif API, but I'll try to get all the ideas here collected in one place.
> > I scratched together a proposal of what I think would make a not-terrible
> > V2 API. I'm sure there's bugs in this code, but I think it's workable --
> > or at least a place to start. The biggest thing I think we should consider
> > is unrolling seccomp_data if we don't intend to add new BPF-accessible
> > fields.
> > 
> > If also uses read(2), so we get to take advantage of read(2)'s ability
> > to pass a size along with the read, as opposed to doing ioctl tricks.
> > It also makes programming from against it slightly simpler. I can imagine
> > that the send API could be similar, in that it could support write, and
> > thus making it 100% usable from Go (and the like) without requiring
> > a separate OS-thread be spun up to interact with the listener.
> 
> I don't have strong feelings about using read() and write() here but I
> think that Jann had reservations and that's why we didn't do it in the
> first version. But his reservations were specifically tied to fd passing
> which we never implemented:
> http://lkml.iu.edu/hypermail/linux/kernel/1806.2/05995.html
> 
> But still, worth considering.

There was a thread about this same time for some other API (I can't
find it now, but I can dig if you want) that suggests that "read() is
for data" and we shouldn't use it for control in APIs.

Tycho
