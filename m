Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30060286950
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 22:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgJGUn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 16:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgJGUnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:43:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A84C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 13:43:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y20so1607238pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VCinuZMYeBCtpffADMXEoQr/XmJXCICNr4Nv7UOf76M=;
        b=VYg7BxkAOA7UOThtoUdxgn0/LwS8d5AjWTcJkLrfeU+oFQwYVrrX3CgwBb/6m2epZw
         1aGGGTW4THwlIMybQqWiVj7FJPxFxozJrz5DEZLr3qUmAa5xTjdtDbhUvSlGykqS9e5W
         UellVQHxyc4E2QUtV4Q5wVtMTlLBzOe8uwgCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VCinuZMYeBCtpffADMXEoQr/XmJXCICNr4Nv7UOf76M=;
        b=orZgC+NcYE4SAKTHEBSsd7RljaBR5Rpz2sFTeGfsxTQmTcjLpAcw5GvWNmq+1m3rdb
         B6lcm6yE+yyrfU63aRg1/12MILHaOCvu3avWdMGDjI3Czi9L/78EbVeNIAelr+tc1rKi
         3sMhNx1I44NITgSEaO6Qsx3xz7fKHHVBtFfyMcGhHATDm/lS05djIA14X+0sY/uodjMS
         MLxA5jIoEhpqOrMisTRylH9IAwrBTYAwq/2JwTN/lbf7UrXUq1r9kD4IAlNc0ofqqfqu
         9LCob7dnHFYiFg2Axvo0AHJQKWTSwYLym37PbvkfqMZWFt6zhhgAafgLS6vqFSqEYXr3
         U+nQ==
X-Gm-Message-State: AOAM5324dQedbqARoCx5SwScS/JGtKDUoKI31trSMq1p9FjXNEJtXGaM
        cEFZU//KMbIQu+6K5DVIQc0g/g==
X-Google-Smtp-Source: ABdhPJz77pgiC3u/NYMorDhqb5UkPb36DsIPJa1K611/tOcC3aDIYI78WvU55G4TM/Jw0nxG83b7Uw==
X-Received: by 2002:a17:902:7c0d:b029:d3:de09:a3 with SMTP id x13-20020a1709027c0db02900d3de0900a3mr4365159pll.52.1602103404809;
        Wed, 07 Oct 2020 13:43:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 16sm3497975pjl.27.2020.10.07.13.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 13:43:23 -0700 (PDT)
Date:   Wed, 7 Oct 2020 13:43:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/11] drivers/base/devcoredump: convert devcd_count
 to counter_atomic32
Message-ID: <202010071334.8298F3FA7@keescook>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <462fd514dfe2afbb8faa1dea4cdb4b0e75d8e8da.1602011710.git.skhan@linuxfoundation.org>
 <202010071114.EE9A2A47C@keescook>
 <cb86761a-5531-cbb2-3987-0897771949b8@linuxfoundation.org>
 <f27149d6b9b781ccf9c2fa041082c134abccd925.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f27149d6b9b781ccf9c2fa041082c134abccd925.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 09:38:47PM +0200, Johannes Berg wrote:
> On Wed, 2020-10-07 at 13:33 -0600, Shuah Khan wrote:
> > On 10/7/20 12:15 PM, Kees Cook wrote:
> > > On Tue, Oct 06, 2020 at 02:44:35PM -0600, Shuah Khan wrote:
> > > > counter_atomic* is introduced to be used when a variable is used as
> > > > a simple counter and doesn't guard object lifetimes. This clearly
> > > > differentiates atomic_t usages that guard object lifetimes.
> > > > 
> > > > counter_atomic* variables will wrap around to 0 when it overflows and
> > > > should not be used to guard resource lifetimes, device usage and
> > > > open counts that control state changes, and pm states.
> > > > 
> > > > devcd_count is used to track dev_coredumpm device count and used in
> > > > device name string. It doesn't guard object lifetimes, device usage
> > > > counts, device open counts, and pm states. There is very little chance
> > > > of this counter overflowing. Convert it to use counter_atomic32.
> > > > 
> > > > This conversion doesn't change the overflow wrap around behavior.
> > > > 
> > > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > > 
> > > I actually wonder if this should use refcount_t just because it is
> > > designed to be an alway-unique value. It is hard to imagine ever causing
> > > this to overflow, but why not let it be protected?
> > > 
> > 
> > This is one of the cases where devcd_count doesn't guard lifetimes,
> > however if it ever overflows, refcount_t is a better choice.
> > 
> > If we decide refcount_t is a better choice, I can drop this patch
> > and send refcount_t conversion patch instead.
> > 
> > Greg! Any thoughts on refcount_t for this being a better choice?
> 
> I'm not Greg, but ... there's a 5 minute timeout. So in order to cause a
> clash you'd have to manage to overflow the counter within a 5 minute
> interval, otherwise you can actually reuse the numbers starting again
> from 0 without any ill effect.

That's not true as far as I can see: there's no reset in here. It's a
global heap variable with function-level visibility (note the "static"),
so it is only ever initialized once:

void dev_coredumpm(struct device *dev, struct module *owner,
                   void *data, size_t datalen, gfp_t gfp,
                   ssize_t (*read)(char *buffer, loff_t offset, size_t count,
                                   void *data, size_t datalen),
                   void (*free)(void *data))
{
        static atomic_t devcd_count = ATOMIC_INIT(0);
	...
        dev_set_name(&devcd->devcd_dev, "devcd%d",
                     atomic_inc_return(&devcd_count));
	...
}

https://godbolt.org/z/T6Wfcj

-- 
Kees Cook
