Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA62276281
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgIWUvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWUvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:51:31 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB79C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 13:51:31 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 5so458438pgf.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 13:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5mYY1/QZ9bbfssPpUK5rLFj8T1wdt6FSex8pFDqPFDg=;
        b=Tq3pXhsBwLTidCxt7eYgud1yh+5MqYuMhaI39IMz3JyERa9Wzc4BDZQpPH91Gjbv+Q
         /JB/JLSWgKcFhfoDMM124/uPD+DhDxUdQb9lHyizVgJlLtcHDq2SmlEVwm58lJnekeLR
         IkXxVlMIcAIqu33TqWQHXtY710l5q8/AZLB8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5mYY1/QZ9bbfssPpUK5rLFj8T1wdt6FSex8pFDqPFDg=;
        b=biBmYSaUoqllrJzGyTRwhMIq0WgkbmShuasn2vvhxCo91xfseiiINgeOqUiX0qbKsA
         29fhRVjG+XBQL2nNOTQqLV6wyP5z8Ptbq5fQBJRm2Uk1V8YRpxu95EhB1dJMaBZiC0F4
         PFyfAeTEdBSe5lirC4QB8g7U9g4mMoWEGW7pa1fxn2kS8XcCMrDsdZ5ti3vgar7hbE2F
         u3Cbxzgrz4VDkJxNkExbeOHdN0iJAxj5f/yW29XuciX92+enA3zaQ1aZnx5QhbCAUfvN
         x9fHUwJWi4NoZ2xmavrG57vPfU7cwURvMeNZhVKSnWvXirvR8OvvigvxHFWIdIxgLFCk
         bhQw==
X-Gm-Message-State: AOAM5319p8Rev3pL4ueitsHOIItt0dcyLrNZ4A4D3D74bnRIg2x3GvjE
        yozXQH2i+/gLDoNnATXCOGQGXg==
X-Google-Smtp-Source: ABdhPJxHH8RiAjKGsoRRpEBC64dx3TTxYmjdnMq58Xq+dmgez5buPEwmF5Yim6amKEbr1ubtA7nzhQ==
X-Received: by 2002:a62:7c43:0:b029:139:858b:8033 with SMTP id x64-20020a627c430000b0290139858b8033mr1517161pfc.3.1600894291018;
        Wed, 23 Sep 2020 13:51:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m188sm555413pfd.56.2020.09.23.13.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:51:30 -0700 (PDT)
Date:   Wed, 23 Sep 2020 13:51:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com, surenb@google.com,
        linux-kernel@vger.kernel.org, hridya@google.com, arve@android.com,
        Shuah Khan <skhan@linuxfoundation.org>, joel@joelfernandes.org,
        maco@android.com, christian@brauner.io
Subject: Re: [RFC PATCH 07/11] drivers/android/binder: convert stats,
 transaction_log to counter_atomic
Message-ID: <202009231350.8343298C23@keescook>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
 <4fe28fc5f315657e4af276b8a3c71d80a5eaa379.1600816121.git.skhan@linuxfoundation.org>
 <20200923051027.GA2578443@kroah.com>
 <202009231204.5531FBA23F@keescook>
 <20200923193134.GD199068@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923193134.GD199068@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 09:31:34PM +0200, Greg KH wrote:
> On Wed, Sep 23, 2020 at 12:04:58PM -0700, Kees Cook wrote:
> > On Wed, Sep 23, 2020 at 07:10:27AM +0200, Greg KH wrote:
> > > On Tue, Sep 22, 2020 at 07:43:36PM -0600, Shuah Khan wrote:
> > > >  struct binder_stats {
> > > > -	atomic_t br[_IOC_NR(BR_FAILED_REPLY) + 1];
> > > > -	atomic_t bc[_IOC_NR(BC_REPLY_SG) + 1];
> > > > -	atomic_t obj_created[BINDER_STAT_COUNT];
> > > > -	atomic_t obj_deleted[BINDER_STAT_COUNT];
> > > > +	struct counter_atomic br[_IOC_NR(BR_FAILED_REPLY) + 1];
> > > > +	struct counter_atomic bc[_IOC_NR(BC_REPLY_SG) + 1];
> > > > +	struct counter_atomic obj_created[BINDER_STAT_COUNT];
> > > > +	struct counter_atomic obj_deleted[BINDER_STAT_COUNT];
> > > 
> > > These are just debugging statistics, no reason they have to be atomic
> > > variables at all and they should be able to just be "struct counter"
> > > variables instead.
> > 
> > But there's no reason for them _not_ to be atomic. Please let's keep
> > this API as always safe. Why even provide a new foot-gun here?
> 
> These are debugging things, how can you shoot yourself in the foot with
> that???

Because suddenly you might be trying to use these values for debugging
only to dig and dig to discover that because they were non-atomic, some
parallel race cause a counter to get dropped, etc.

Since we can design this API robustly, let's take the opportunity to do
so.

-- 
Kees Cook
