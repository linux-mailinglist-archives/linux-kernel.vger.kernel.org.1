Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766D42AA768
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 19:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgKGSZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 13:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgKGSZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 13:25:01 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A616C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 10:24:59 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 62so3559677pgg.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 10:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1lokD+YzDVwjuv0S1fnZ4jfJcWH5xG6o3ThkmNzSSQQ=;
        b=DB+DGtflH5xVPAkB8hFQUJSEmztJuWcM7rVOfIVMgEJ4GVsPTiAD1P3EW4wpJ25rZH
         IzGPl5yiNDufSGQ1TZXdo8maZnmDfasl0nDWC/rQScGdnWOXThQTJW+qTaq4sD7MCGx4
         Kw4I6GlvRrTkVbGvQDNKs6NeiRteDLUiGhsjd4Db22O3NMsUWOQ2KLlAJcEgFtmIqS/o
         HpmHQ2lF2lpwLby/nJPaOmN90Wqnp9t7VuJSpCCVeSR0FOW8j6cAVn8miWqphiHE9g2D
         LxWd39VI84RBjq+rea1CMS/CagADK2KHVnQ4zqfwpmXJmVWsPfUdX2QsCR8seEv8uiCU
         Nf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1lokD+YzDVwjuv0S1fnZ4jfJcWH5xG6o3ThkmNzSSQQ=;
        b=q+f0ZChVtKScRFlw3OQKNTKPgNqj4K+ak9mTEGaszRPEqF0fkLPkag71bJXB60Z5SW
         f418AXMiMRB67ZTGaQ3qfIRjLPNUzWLLE5W0t2aUe6Z8uZ6m7OhpYsUa1RlFWcg4wrvQ
         6qhmgFBH8YEXgs1cRcWZw7XwDo5JkV+3cHiolxNBegRXR6xwMCGToF38AqqJaXsr9hyH
         Toz3mElwzlvM/3v6MHt/TX4MTpyi8k+sztBne88xqtLCzcs+DUDQPLFtRaeTCUChadEF
         ILjhdnrAuQxL1YB/o3GLE6V2gCOY//OrGopxM8aAVOz0fqFqLFdAbgJB+jsPHkRyxfOP
         ufvg==
X-Gm-Message-State: AOAM532oMHCoX4ccaSd4A+AyhDnF/1/uJp9q+aGdN30WjTPkvWROyEJX
        8ODmwis9OEqlvU+1XJPqVf4=
X-Google-Smtp-Source: ABdhPJy1//f9Ngb6dO9Na8YgeoQYVDJ045nDAa22iIvTMsm0dNZpjLLTIfv+lEBKUbT8T28CCMdCJA==
X-Received: by 2002:a63:190e:: with SMTP id z14mr6427922pgl.272.1604773498722;
        Sat, 07 Nov 2020 10:24:58 -0800 (PST)
Received: from ubuntu (1-171-247-95.dynamic-ip.hinet.net. [1.171.247.95])
        by smtp.gmail.com with ESMTPSA id j25sm6208643pfa.199.2020.11.07.10.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 10:24:57 -0800 (PST)
Date:   Sun, 8 Nov 2020 02:24:47 +0800
From:   Yun Hsiang <hsiang023167@gmail.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, patrick.bellasi@matbug.net,
        kernel test robot <lkp@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v5 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201107182447.GA1056076@ubuntu>
References: <20201103023756.1012088-1-hsiang023167@gmail.com>
 <20201103134644.rafsqisz7fxopo5n@e107158-lin.cambridge.arm.com>
 <20201103134808.27xi27xodj6dvlt2@e107158-lin.cambridge.arm.com>
 <e4889208-ff6d-e087-6aeb-26ad98d426fc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4889208-ff6d-e087-6aeb-26ad98d426fc@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 10:45:09AM +0100, Dietmar Eggemann wrote:
> On 03/11/2020 14:48, Qais Yousef wrote:
> > Oops, +Juri for real this time.
> > 
> > On 11/03/20 13:46, Qais Yousef wrote:
> >> Hi Yun
> >>
> >> +Juri (A question for you below)
> >>
> >> On 11/03/20 10:37, Yun Hsiang wrote:
> 
> [...]
> 
> >>>  include/uapi/linux/sched.h |  7 +++--
> >>>  kernel/sched/core.c        | 59 ++++++++++++++++++++++++++++----------
> >>>  2 files changed, 49 insertions(+), 17 deletions(-)
> >>>
> >>> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> >>> index 3bac0a8ceab2..6c823ddb1a1e 100644
> >>> --- a/include/uapi/linux/sched.h
> >>> +++ b/include/uapi/linux/sched.h
> >>> @@ -132,17 +132,20 @@ struct clone_args {
> >>>  #define SCHED_FLAG_KEEP_PARAMS		0x10
> >>>  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
> >>>  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
> >>> +#define SCHED_FLAG_UTIL_CLAMP_RESET	0x80
> >>
> >> The new flag needs documentation about how it should be used. It has a none
> >> obvious policy that we can't expect users to just get it.
> 
> See (1) further below.
> 
> >>>  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
> >>>  				 SCHED_FLAG_KEEP_PARAMS)
> >>>  
> >>>  #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
> >>> -				 SCHED_FLAG_UTIL_CLAMP_MAX)
> >>> +				 SCHED_FLAG_UTIL_CLAMP_MAX | \
> >>> +				 SCHED_FLAG_UTIL_CLAMP_RESET)
> >>
> >> Either do this..
> >>
> >>>  
> >>>  #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
> >>>  			 SCHED_FLAG_RECLAIM		| \
> >>>  			 SCHED_FLAG_DL_OVERRUN		| \
> >>>  			 SCHED_FLAG_KEEP_ALL		| \
> >>> -			 SCHED_FLAG_UTIL_CLAMP)
> >>> +			 SCHED_FLAG_UTIL_CLAMP		| \
> >>> +			 SCHED_FLAG_UTIL_CLAMP_RESET)
> >>
> >> Or this.
> >>
> >> I checked glibc and it seems they don't use the sched.h from linux and more
> >> surprisingly they don't seem to have a wrapper for sched_setattr(). bionic libc
> >> from Android does take sched.h from linux, but didn't find any user. So we
> >> might be okay with modifying these here.
> 
> Schould be package linux-libc-dev. Debian 10 (buster-backports)
> 5.8.10-1~bpo10+1 contains the uclamp bits as well.
> 
> /usr/include/linux/sched/types.h
> /usr/include/linux/sched.h
> 
> /usr/include/linux/sched.h contains SCHED_FLAG_UTIL_CLAMP and
> SCHED_FLAG_ALL.
> 
> But there is no glibc wrapper for sched_[sg]etattr so syscall wrapping
> is still needed.
> 
> >> I still would like us to document better what we expect from these defines.
> >> Are they for internal kernel use or really for user space? If the former we
> >> should take them out of here. If the latter, then adding the RESET is dangerous
> >> as it'll cause an observable change in behavior; that is if an application was
> >> using SCHED_FLAG_ALL or SCHED_FLAG_UTIL_CLAMP to update the UTIL_MIN/MAX of
> >> a task, existing binaries will find out now that instead of modifying the value
> >> they're actually resetting them.
> 
> I doubt that any application uses SCHED_FLAG_ALL so far since it already
> mixes e.g. DL and UCLAMP stuff. AFAIK the only tools supporting uclamp
> so far is rt-app and uclampset, which both use their own files for DL
> and uclamp definition.
> 

I think SCHED_FLAG_ALL is for internal kernel use. So is it better to
make it within an #ifdef __KERNEL__ #endif block as Patrick said?

> [..]
> 
> >> Add the policy part of the commit message as a documentation to this function
> >> please.
> >>
> >> ie:
> >>
> >> 	/*
> >> 	 * The policy is
> >> 	 * _CLAMP_RESET                           => reset both min and max
> >> 	 * _CLAMP_RESET | _CLAMP_MIN              => reset min value
> >> 	 * _CLAMP_RESET | _CLAMP_MAX              => reset max value
> >> 	 * _CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max
> >> 	 */
> >>
> 
> (1) Related to documentation, wouldn't it be better to document in
> include/uapi/linux/sched.h, i.e. where the flags are defined, so it gets
> exported via linux-libc-dev?
> Like it's done for struct sched_attr members in
> include/uapi/linux/sched/types.h.
> 

Ok, I'll put the comment for_CLAMP_MIN/_CLAMP_MAX/CLAMP_RESET in
include/uapi/linux/sched.h.

> [...]
> 
> >>> -	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
> >>> +	if (likely(!(attr->sched_flags && SCHED_FLAG_UTIL_CLAMP)) ||
> >>> +		attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET)
> >>>  		return;
> 
> Another multi line statement so the 'return' could go with braces.
> 
> >>>  
> >>> -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> >>> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> >>>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
> >>> -			      attr->sched_util_min, true);
> >>> -	}
> >>> +				attr->sched_util_min, true);
> >>>  
> >>> -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> >>> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
> >>>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
> >>> -			      attr->sched_util_max, true);
> >>> -	}
> >>> +				attr->sched_util_max, true);
> >>
> >> These two hunks seem unrelated too. Multi line statement should still have
> >> braces AFAIK. Why change it?

Sorry for the wrong coding style, I'll fix it. And I'll split the
modifications to different patches if I want to do some cleanup.

> +1
> 
> [...]
