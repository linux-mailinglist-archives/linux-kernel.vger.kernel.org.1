Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C6628CBF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgJMKsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726901AbgJMKsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602586100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WyKGp1pBWxGQmg+kNRzmODkOPN7pCzfPHnO9FYGbroQ=;
        b=DLIBXGtMLqwi8HK2AhM2bAO3RsUXI2i3Wrwu+cs/FWPcWu6+sUbBwF/zjO2PXiuCYtMAlc
        +vyT5ypkq8khKUnsE+Q7joTVvLQu2TqpiPUfLKbhEbVw4KEsO0UmzMBQQWKHL0I/7++Kl+
        W9v0F6xVPZlLcxFIOCrfDMeJ1mzlZ0c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-NmPhJ1ecOOuCVEKeBQGHKA-1; Tue, 13 Oct 2020 06:48:15 -0400
X-MC-Unique: NmPhJ1ecOOuCVEKeBQGHKA-1
Received: by mail-wr1-f70.google.com with SMTP id u15so10729926wrn.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 03:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WyKGp1pBWxGQmg+kNRzmODkOPN7pCzfPHnO9FYGbroQ=;
        b=SyKy55Q6/I7/W9Oc+yYVCbSf+IOu+8cEaQE80gBZIBpgH7KJUBDVxbaq2b/R9MvrQL
         Po8g9uKJ4Gnb4+6xFF3Zmw+quuYflDuW0nqMPPisHZMGOaUvZAVYHpMVmMc1LKSjnonX
         1490wwO0N+emStr6cEwuPkR3tag4aa0S9a8qFGFCfsdE1T0umpOb5gRxFt4gqJ0Oo3HP
         L4ActqN4gScKAwR74Axz/SLDLR3QKGQ8BbTcgt9+eqfIFimxRA+HHKxjPmtqJgRXOgWV
         uaYQkCG8HU9TKte3ml1EkO1F5zouVk4Y1Hz9fsgbMrhlgyMRikxmLQrV14tF/c3hwY/3
         /pLg==
X-Gm-Message-State: AOAM533Cggc+kO4iO4L04NXNCJOJRQyk1M2pnpAFBZtkhdppAF4pZ8/C
        oQdEqkwqzmJaaXBmaEz/hchIf2//V7JR9FNZm/auZJLs0J1O82FbWQ2RHbqsmbAaw0fjkpwTi5L
        7dozI+6fT2M5SeA9zHsrGbHiO
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr34311269wrq.209.1602586094297;
        Tue, 13 Oct 2020 03:48:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx95H6+L6KXCpDSgOTiCbIeuY3NKerTVReuC9fhtPnUvJAsHZayUo6pnbHsjS2jajTdqgf6wg==
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr34311245wrq.209.1602586094075;
        Tue, 13 Oct 2020 03:48:14 -0700 (PDT)
Received: from localhost.localdomain ([151.29.23.182])
        by smtp.gmail.com with ESMTPSA id 4sm29600509wrn.48.2020.10.13.03.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 03:48:13 -0700 (PDT)
Date:   Tue, 13 Oct 2020 12:48:11 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        chris.redpath@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/features: Fix !CONFIG_JUMP_LABEL case
Message-ID: <20201013104811.GE89256@localhost.localdomain>
References: <20201013053114.160628-1-juri.lelli@redhat.com>
 <878scail9o.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878scail9o.derkling@matbug.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/20 10:26, Patrick Bellasi wrote:
> 
> On Tue, Oct 13, 2020 at 07:31:14 +0200, Juri Lelli <juri.lelli@redhat.com> wrote...
> 
> > Commit 765cc3a4b224e ("sched/core: Optimize sched_feat() for
> > !CONFIG_SCHED_DEBUG builds") made sched features static for
> > !CONFIG_SCHED_DEBUG configurations, but overlooked the CONFIG_
> > SCHED_DEBUG enabled and !CONFIG_JUMP_LABEL cases. For the latter echoing
> > changes to /sys/kernel/debug/sched_features has the nasty effect of
> > effectively changing what sched_features reports, but without actually
> > changing the scheduler behaviour (since different translation units get
> > different sysctl_sched_features).
> 
> Hops, yes, I think I missed to properly check that config :/
> Good spot!
> 
> > Fix CONFIG_SCHED_DEBUG and !CONFIG_JUMP_LABEL configurations by properly
> > restructuring ifdefs.
> >
> > Fixes: 765cc3a4b224e ("sched/core: Optimize sched_feat() for !CONFIG_SCHED_DEBUG builds")
> > Co-developed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> 
> (did you get some wrong formatting for the changelog above?)

Hummm, what you mean?

I intended to follow

https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L566

