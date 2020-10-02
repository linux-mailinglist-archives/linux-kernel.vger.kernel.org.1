Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E745281E8C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 00:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgJBWmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 18:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJBWmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 18:42:31 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A46C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 15:42:31 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x16so1786676pgj.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 15:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0BLzxT6WUemFKsAn6h5mf72t5nn+rCxo/YdzeOflxtE=;
        b=TuBV/giGUm+Ke8jfXjpm9lJjEbFsrpix4WyKmL0+eHKrqzOskKGGtuihzKU3x4JOmt
         NXMg9edy5h/Oq2qynIragg/6MIZaneWaPVWdBcM5mOFpD7C9tRSVi5enS1tHN3LiRrA+
         pPrwUE1J2Mr2Q7W974fVe847pG9rlbsA27Db+FK57UjFjaJlFS7FjRgk7hxzbYTo6kzR
         XQfpTuA9UP3TfkdgyiZkudWT8ZYFMFRr/A+7FszxuVC1zv1ROu35xX9dB+B2Ea9hM420
         lOVWeQFyqx+iKOmYJ6l9Efa9Hp3cDaApkq+EjcgXHLO6syteI0+EOwrRRnj/YL2y+oqC
         vHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0BLzxT6WUemFKsAn6h5mf72t5nn+rCxo/YdzeOflxtE=;
        b=AZ/KdLy+nhTTfuCjgjbQRQaiVZeErUObkIwkLqvuramCp9J8qVd+G2h+v13aUSGThb
         pG6zTSazIwPntW3MNzI/9JkKV/5raSiA/9/ZQ9WrjqPAbAsPbIUn2y1XQ2ORuV68bCtK
         jmgWfyXUlb+FlrFQhN0lvVlL4oMC3aowcN3V+YyGlDdHHl9cs5aK2E8uKMCpBJ8SchBB
         XU1m+mEsmNyv13KEHCHapAI/kAzMZMldegqBLCKMQYxRDo37TC0F09iTZb76wN9eUfs2
         f+0yncTRnQ/FG3IkQ5LBZk7JzYxhMvjf7qQWh7w7ePd/jjNOckDbSTf6FR+v6bIj96+I
         ipbg==
X-Gm-Message-State: AOAM531csm9MSQCKaeMumBg7fpehY+qGGua2h8Es/eyx/kYj2WGsqwL3
        cvmiY8r6xGoEsX8ZLlTOeEn+4OkrbtgzDQ==
X-Google-Smtp-Source: ABdhPJyu173B+p5Jv1HEkzYuP6VUoCXpC5gB1pWvCRxau9ZNay2HWhBjT/VxkC04+6uuo4g3CvTf2A==
X-Received: by 2002:a63:5f89:: with SMTP id t131mr4197704pgb.436.1601678550759;
        Fri, 02 Oct 2020 15:42:30 -0700 (PDT)
Received: from hermes.local (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id a14sm2579968pju.30.2020.10.02.15.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 15:42:30 -0700 (PDT)
Date:   Fri, 2 Oct 2020 15:42:22 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Jarod Wilson <jarod@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Davis <tadavis@lbl.gov>, Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 6/6] bonding: make Kconfig toggle to disable
 legacy interfaces
Message-ID: <20201002154222.3adfe408@hermes.local>
In-Reply-To: <CAKfmpSc3-j2GtQtdskEb8BQvB6q_zJPcZc2GhG8t+M3yFxS4MQ@mail.gmail.com>
References: <20201002174001.3012643-1-jarod@redhat.com>
        <20201002174001.3012643-7-jarod@redhat.com>
        <20201002121317.474c95f0@hermes.local>
        <CAKfmpSc3-j2GtQtdskEb8BQvB6q_zJPcZc2GhG8t+M3yFxS4MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Oct 2020 16:23:46 -0400
Jarod Wilson <jarod@redhat.com> wrote:

> On Fri, Oct 2, 2020 at 3:13 PM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Fri,  2 Oct 2020 13:40:01 -0400
> > Jarod Wilson <jarod@redhat.com> wrote:
> >  
> > > By default, enable retaining all user-facing API that includes the use of
> > > master and slave, but add a Kconfig knob that allows those that wish to
> > > remove it entirely do so in one shot.
> > >
> > > Cc: Jay Vosburgh <j.vosburgh@gmail.com>
> > > Cc: Veaceslav Falico <vfalico@gmail.com>
> > > Cc: Andy Gospodarek <andy@greyhouse.net>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > Cc: Thomas Davis <tadavis@lbl.gov>
> > > Cc: netdev@vger.kernel.org
> > > Signed-off-by: Jarod Wilson <jarod@redhat.com>
> > > ---
> > >  drivers/net/Kconfig                   | 12 ++++++++++++
> > >  drivers/net/bonding/bond_main.c       |  4 ++--
> > >  drivers/net/bonding/bond_options.c    |  4 ++--
> > >  drivers/net/bonding/bond_procfs.c     |  8 ++++++++
> > >  drivers/net/bonding/bond_sysfs.c      | 14 ++++++++++----
> > >  drivers/net/bonding/bond_sysfs_port.c |  6 ++++--
> > >  6 files changed, 38 insertions(+), 10 deletions(-)
> > >  
> >
> > This is problematic. You are printing both old and new values.
> > Also every distribution will have to enable it.
> >
> > This looks like too much of change to users.  
> 
> I'd had a bit of feedback that people would rather see both, and be
> able to toggle off the old ones, rather than only having one or the
> other, depending on the toggle, so I thought I'd give this a try. I
> kind of liked the one or the other route, but I see the problems with
> that too.
> 
> For simplicity, I'm kind of liking the idea of just not updating the
> proc and sysfs interfaces, have a toggle entirely disable them, and
> work on enhancing userspace to only use netlink, but ... it's going to
> be a while before any such work makes its way to any already shipping
> distros. I don't have a satisfying answer here.
> 

I like the idea of having bonding proc and sysf apis optional.
