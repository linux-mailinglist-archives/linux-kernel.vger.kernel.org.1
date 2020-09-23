Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB0B2760BD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 21:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgIWTFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 15:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWTFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 15:05:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E19C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 12:05:00 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so264718pgm.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 12:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZBh9RbhVGnIffy2QajMsqYEPj2mzX15NIxK1aL/PEzs=;
        b=dZm1Taf0xU5E1KKhHeWYit7oaFr4eJcqj10AuEn+LtbbruyDxpW0rcttxuS8gRNi51
         /0r+tHM8E6rLduWK78WDMOvcEHMnb8BpAMGLbwJ84BPQNdwivtQwgvWerW0GKYHiUkhW
         UYcxUPqGFHhbPTjPLgIMZChsMlUzSZtor1/Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZBh9RbhVGnIffy2QajMsqYEPj2mzX15NIxK1aL/PEzs=;
        b=pa72ri9NlZf7x5KhrcnRfffXMv60yXLJKkiTCDPleliItg4yp2wu3cFpNoNtPZyqRf
         i1/5EGrX/wYu+cCiqPDFRiN9FQoKhK39A/Z3j5CQ+2GIMSlIQ+heAGuhoNmzz7Ic+shA
         ZNIAy+hRPfV619FDgjK4RNY1eOF2UWXtFUNDRmQHyNJvhh/M+gGbYRPLu2EbbzCtEXB9
         VykGAjKIBZKgsf+ioiamcwtIn0lflRe6VXCVyhzwpIMHNrUsGrPzrjJ+hDOkl9S8by/7
         cUQIR5N+dUaiPjxRYP1Ngx2KJ/v2kjnwJlvI8Ze83eCf6AxXNZou3677ySqNskIhEV7R
         6yGw==
X-Gm-Message-State: AOAM532Z4hyJhTtlQfBex/YKxNOO3ynm3zc0Q7rsxsPCcH6fWbLt+2du
        LgMAWLb8RuhIWfmmEez6Add3gA==
X-Google-Smtp-Source: ABdhPJzCphTKya6JaoxMvPf5mc+XKN0x8N+d6XBlum1PjcHuOW+tGmg8m9D/6ew9feSKQLtSLPfuIA==
X-Received: by 2002:a63:230f:: with SMTP id j15mr951550pgj.363.1600887900506;
        Wed, 23 Sep 2020 12:05:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t10sm574075pgp.15.2020.09.23.12.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 12:04:59 -0700 (PDT)
Date:   Wed, 23 Sep 2020 12:04:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        christian@brauner.io, hridya@google.com, surenb@google.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/11] drivers/android/binder: convert stats,
 transaction_log to counter_atomic
Message-ID: <202009231204.5531FBA23F@keescook>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
 <4fe28fc5f315657e4af276b8a3c71d80a5eaa379.1600816121.git.skhan@linuxfoundation.org>
 <20200923051027.GA2578443@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923051027.GA2578443@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 07:10:27AM +0200, Greg KH wrote:
> On Tue, Sep 22, 2020 at 07:43:36PM -0600, Shuah Khan wrote:
> > counter_atomic is introduced to be used when a variable is used as
> > a simple counter and doesn't guard object lifetimes. This clearly
> > differentiates atomic_t usages that guard object lifetimes.
> > 
> > counter_atomic variables will wrap around to 0 when it overflows and
> > should not be used to guard resource lifetimes, device usage and
> > open counts that control state changes, and pm states.
> > 
> > stats tracks per-process binder statistics. Unsure if there is a chance
> > of this overflowing, other than stats getting reset to 0. Convert it to
> > use counter_atomic.
> > 
> > binder_transaction_log:cur is used to keep track of the current log entry
> > location. Overflow is handled in the code. Since it is used as a
> > counter, convert it to use counter_atomic.
> > 
> > This conversion doesn't change the oveflow wrap around behavior.
> > 
> > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > ---
> >  drivers/android/binder.c          | 41 ++++++++++++++++---------------
> >  drivers/android/binder_internal.h |  3 ++-
> >  2 files changed, 23 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index f936530a19b0..11a0407c46df 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -66,6 +66,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/task_work.h>
> >  #include <linux/sizes.h>
> > +#include <linux/counters.h>
> >  
> >  #include <uapi/linux/android/binder.h>
> >  #include <uapi/linux/android/binderfs.h>
> > @@ -172,22 +173,22 @@ enum binder_stat_types {
> >  };
> >  
> >  struct binder_stats {
> > -	atomic_t br[_IOC_NR(BR_FAILED_REPLY) + 1];
> > -	atomic_t bc[_IOC_NR(BC_REPLY_SG) + 1];
> > -	atomic_t obj_created[BINDER_STAT_COUNT];
> > -	atomic_t obj_deleted[BINDER_STAT_COUNT];
> > +	struct counter_atomic br[_IOC_NR(BR_FAILED_REPLY) + 1];
> > +	struct counter_atomic bc[_IOC_NR(BC_REPLY_SG) + 1];
> > +	struct counter_atomic obj_created[BINDER_STAT_COUNT];
> > +	struct counter_atomic obj_deleted[BINDER_STAT_COUNT];
> 
> These are just debugging statistics, no reason they have to be atomic
> variables at all and they should be able to just be "struct counter"
> variables instead.

But there's no reason for them _not_ to be atomic. Please let's keep
this API as always safe. Why even provide a new foot-gun here?

-- 
Kees Cook
