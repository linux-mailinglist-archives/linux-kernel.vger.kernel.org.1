Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F882765FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 03:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIXBpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 21:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIXBpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 21:45:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00D8C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 18:45:39 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d19so784121pld.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 18:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cW0nV77srDNY6xtWIN0V3XsJcs6UdJ5qZDcpMrle79A=;
        b=Mi69YO6zEBWhiRjHcG1SvaB6qxt9D4qr+8d/RnY96dhgO/+Ew8u/kf9gAxgalcTYg5
         pKtc8twzODrnLK3hyeX1OGPZkKeLRFQ9Fe0VdCO5V7myR31YuIXrJ857s4gcBbgERvUc
         MD5JHinxE2eAXhD8xy4C1HksJaNpGP03olgr+T6a2JUySqp4cjfVIigrMIyVRHOYxg0R
         TpEFLCZ3kdJY/APGml0FXQNdcdOeQY+xdAUW4J+wDAPHOk2JmVsm7/gmR1m1GLfVj4uF
         tcBpsREFYYKvP1xDHO4vNDgwYaTTpG9ww6beLmJIGq+yIQwL6CiQiMsx92GkpphxhPaZ
         749A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cW0nV77srDNY6xtWIN0V3XsJcs6UdJ5qZDcpMrle79A=;
        b=QCPPRkmnKSXxY9MyEZ8sM7LwLecymRC5wwv43pLkesBSAPji9ZfRJfC3Ov6TKfCVb0
         u5YJXaIMyR3L7TzsD2w2JL6wmL5F/r/FM9TwFo+b+z06XZhFi4q7hlNcl0Agwa+VniUJ
         CL+i+NYCCgpddI6JIFtUayYzD7Hw62HYNZ4NNZ1aaay+ddyRHj032jaYnTEiaKqlk2K3
         z+RD2CfclZUW0z/MH7sln0M6tpKCzBWUoSJF64bMmlTHBAISfScaxF3d/wB7P3smHzHt
         6JEnuBwGmHYyr+VdnQd44N02WRjKIAA/yxSDSiBDvKIUA/Jg7XYT/qQZra6YD6aPa0VW
         sHHQ==
X-Gm-Message-State: AOAM53013rT9iS0EOrXbfSQEzxR1p4AMq0YCtBQMlV14ZuthsVQCcw8L
        J3Wed2iqJGSQwJu7Ovfir6I=
X-Google-Smtp-Source: ABdhPJw1Gsp85ApQOunDC2BU8rmMpjsutYkR5yovNv6dcloiK1sol3ZLyBMs7KyM/lztSpW2HhlHcg==
X-Received: by 2002:a17:90a:d90c:: with SMTP id c12mr1836667pjv.94.1600911939176;
        Wed, 23 Sep 2020 18:45:39 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id a15sm818218pfi.119.2020.09.23.18.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 18:45:38 -0700 (PDT)
Date:   Thu, 24 Sep 2020 10:45:36 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Changki Kim <changki.kim@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Store all three timestamps
Message-ID: <20200924014536.GC577@jagdpanzerIV.localdomain>
References: <20200923135617.27149-1-pmladek@suse.com>
 <20200923135617.27149-2-pmladek@suse.com>
 <87pn6cdtwa.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn6cdtwa.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/24 00:18), John Ogness wrote:
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 1560649cbd35..0ed8901916f4 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -520,10 +522,10 @@ static int log_store(u32 caller_id, int facility, int level,
> >  	r.info->facility = facility;
> >  	r.info->level = level & 7;
> >  	r.info->flags = flags & 0x1f;
> > -	if (ts_nsec > 0)
> > -		r.info->ts_nsec = ts_nsec;
> > +	if (ts)
> > +		r.info->ts = *ts;
> >  	else
> > -		r.info->ts_nsec = local_clock();
> > +		ktime_get_fast_timestamps(&r.info->ts);
> 
> I am wondering if we still want to keep the local_clock() as well (and
> as the default). ftrace also uses it by default, which means traces and
> printk logs could be coordinated by default until now.

Good point.

> If we wanted to keep the local clock, should the local clock be a part
> of struct ktime_timestamps? Or should struct printk_info maintain that
> separately (either as @ts_nsec or @ts_local or whatever).

I like the idea of having a dedicated printk_timestamps structure
with the timestamps.

	-ss
