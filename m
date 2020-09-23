Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E7E276110
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 21:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIWTbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 15:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgIWTbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 15:31:17 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DE1F21D92;
        Wed, 23 Sep 2020 19:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600889477;
        bh=HofJQBUkXGFQOYGL4lr+EYwXyw/QmcufSV5KnSHysj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=we/4z+2+4D7WJJ5vgWaOXyOo3grlqL8EUDVNwV9feDwpMAF6WPssdE72scvWNi9Tv
         u3+DY4/hqATDmcOaw9ULuNmKLkBNVyd0rGeJNIi0j+TG0ga+pED6RmXVPwuaJaLssC
         rlQRy2ruZ7D3xO3mHb78XTCqPxPaLBzBuV9/oT3Y=
Date:   Wed, 23 Sep 2020 21:31:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com, surenb@google.com,
        linux-kernel@vger.kernel.org, hridya@google.com, arve@android.com,
        Shuah Khan <skhan@linuxfoundation.org>, joel@joelfernandes.org,
        maco@android.com, christian@brauner.io
Subject: Re: [RFC PATCH 07/11] drivers/android/binder: convert stats,
 transaction_log to counter_atomic
Message-ID: <20200923193134.GD199068@kroah.com>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
 <4fe28fc5f315657e4af276b8a3c71d80a5eaa379.1600816121.git.skhan@linuxfoundation.org>
 <20200923051027.GA2578443@kroah.com>
 <202009231204.5531FBA23F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009231204.5531FBA23F@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 12:04:58PM -0700, Kees Cook wrote:
> On Wed, Sep 23, 2020 at 07:10:27AM +0200, Greg KH wrote:
> > On Tue, Sep 22, 2020 at 07:43:36PM -0600, Shuah Khan wrote:
> > > counter_atomic is introduced to be used when a variable is used as
> > > a simple counter and doesn't guard object lifetimes. This clearly
> > > differentiates atomic_t usages that guard object lifetimes.
> > > 
> > > counter_atomic variables will wrap around to 0 when it overflows and
> > > should not be used to guard resource lifetimes, device usage and
> > > open counts that control state changes, and pm states.
> > > 
> > > stats tracks per-process binder statistics. Unsure if there is a chance
> > > of this overflowing, other than stats getting reset to 0. Convert it to
> > > use counter_atomic.
> > > 
> > > binder_transaction_log:cur is used to keep track of the current log entry
> > > location. Overflow is handled in the code. Since it is used as a
> > > counter, convert it to use counter_atomic.
> > > 
> > > This conversion doesn't change the oveflow wrap around behavior.
> > > 
> > > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > > ---
> > >  drivers/android/binder.c          | 41 ++++++++++++++++---------------
> > >  drivers/android/binder_internal.h |  3 ++-
> > >  2 files changed, 23 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index f936530a19b0..11a0407c46df 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -66,6 +66,7 @@
> > >  #include <linux/syscalls.h>
> > >  #include <linux/task_work.h>
> > >  #include <linux/sizes.h>
> > > +#include <linux/counters.h>
> > >  
> > >  #include <uapi/linux/android/binder.h>
> > >  #include <uapi/linux/android/binderfs.h>
> > > @@ -172,22 +173,22 @@ enum binder_stat_types {
> > >  };
> > >  
> > >  struct binder_stats {
> > > -	atomic_t br[_IOC_NR(BR_FAILED_REPLY) + 1];
> > > -	atomic_t bc[_IOC_NR(BC_REPLY_SG) + 1];
> > > -	atomic_t obj_created[BINDER_STAT_COUNT];
> > > -	atomic_t obj_deleted[BINDER_STAT_COUNT];
> > > +	struct counter_atomic br[_IOC_NR(BR_FAILED_REPLY) + 1];
> > > +	struct counter_atomic bc[_IOC_NR(BC_REPLY_SG) + 1];
> > > +	struct counter_atomic obj_created[BINDER_STAT_COUNT];
> > > +	struct counter_atomic obj_deleted[BINDER_STAT_COUNT];
> > 
> > These are just debugging statistics, no reason they have to be atomic
> > variables at all and they should be able to just be "struct counter"
> > variables instead.
> 
> But there's no reason for them _not_ to be atomic. Please let's keep
> this API as always safe. Why even provide a new foot-gun here?

These are debugging things, how can you shoot yourself in the foot with
that???

thanks,

greg k-h
