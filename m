Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADBD1AE069
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgDQPDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 11:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgDQPDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:03:51 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E17820857;
        Fri, 17 Apr 2020 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587135830;
        bh=CR+V2g4RH1TCJK3+XSyZGECwl1xXbqgOfYq+cx3FodQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=m6Kd8/+97V/XdoSGVbAoZQwSvKyAlHkafA/dqrHzjp7ZedNq0kwcFoOxtScWFH7vL
         Rq4fsQ1TU2niTL9oYJqsUrsMlpHUNoCMW1SSr5g0MwWtJs+E0aMJAx81e7LJ2lRuLk
         2bZnZGdgC5qXQHiGNJXHe4+6L2C90I7qolArWZFs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 70D1E3523234; Fri, 17 Apr 2020 08:03:50 -0700 (PDT)
Date:   Fri, 17 Apr 2020 08:03:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] kcsan: Use GFP_ATOMIC under spin lock
Message-ID: <20200417150350.GI17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200417025837.49780-1-weiyongjun1@huawei.com>
 <CANpmjNMzwqFaaA-zQh0Nv4SUdoJUFO_yTmTjfbMFqyxBea1U+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMzwqFaaA-zQh0Nv4SUdoJUFO_yTmTjfbMFqyxBea1U+Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 11:23:05AM +0200, Marco Elver wrote:
> On Fri, 17 Apr 2020 at 04:56, Wei Yongjun <weiyongjun1@huawei.com> wrote:
> >
> > A spin lock is taken here so we should use GFP_ATOMIC.
> >
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Good catch, thank you!
> 
> Reviewed-by: Marco Elver <elver@google.com>

Queued and pushed, thank you both!

							Thanx, Paul

> > ---
> >  kernel/kcsan/debugfs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
> > index 1a08664a7fab..023e49c58d55 100644
> > --- a/kernel/kcsan/debugfs.c
> > +++ b/kernel/kcsan/debugfs.c
> > @@ -230,7 +230,7 @@ static ssize_t insert_report_filterlist(const char *func)
> >                 /* initial allocation */
> >                 report_filterlist.addrs =
> >                         kmalloc_array(report_filterlist.size,
> > -                                     sizeof(unsigned long), GFP_KERNEL);
> > +                                     sizeof(unsigned long), GFP_ATOMIC);
> >                 if (report_filterlist.addrs == NULL) {
> >                         ret = -ENOMEM;
> >                         goto out;
> > @@ -240,7 +240,7 @@ static ssize_t insert_report_filterlist(const char *func)
> >                 size_t new_size = report_filterlist.size * 2;
> >                 unsigned long *new_addrs =
> >                         krealloc(report_filterlist.addrs,
> > -                                new_size * sizeof(unsigned long), GFP_KERNEL);
> > +                                new_size * sizeof(unsigned long), GFP_ATOMIC);
> >
> >                 if (new_addrs == NULL) {
> >                         /* leave filterlist itself untouched */
> >
> >
> >
> >
> >
