Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E44289EEE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 09:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgJJHYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 03:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbgJJHTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 03:19:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FC9C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 00:19:31 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m15so5604936pls.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 00:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rWjsdcnDRvSWxQe1zdQAtaJfkEii+J+JtFDPk7y9Adc=;
        b=GJwKBkIoy5h5bdFlf2DZeCzDGI1EGG/a7hHOjsIulGKHAX/5scIqf8UU/trSZuLPUp
         mPg8R6jXo98mLCQxjC6iEcayNa0zwDlIaCTPIFrOSnO13Z/OlrdwDWbAlWbAx+EXP2g3
         0Do+QHzggeANiQt0Gqk7FRUUceW/KHTLb/Lrjr1SDr4Nt2mQm86E8EVb5tl7k2ZCQSF0
         tnyIxtlrNGNBWWmy0N0JmxbF0aDUB2w4Ix79FYb5aZYrnXgGIg5o3cEobElNqO6eW+UN
         lv+TXHKXO+grh6px7RQOynhgfTarznulMsP3rFvoPELTghaFbUdZIgHNehMMOeYUkRRG
         H2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rWjsdcnDRvSWxQe1zdQAtaJfkEii+J+JtFDPk7y9Adc=;
        b=qjjZA/pDXBCanMpDhof0ktRMDi6Y0WgEDCwtU5wXduAlcFSrXxc2D1CFxcFpYuUVRC
         z1XviUPE3hiLj1J5JuLCowrbhpVGuzcksg6w2hIHhRHqHn9o2tbqzizcbPOozQKFJWmU
         IqSxlq6LlPJVW1KzwUAtiuq5yvk+EWcb8taEwY8+ssnzIaYQY8MKUTphIwUOXKj01ZrT
         gJBJuomFxDNf5E8s3slMcqz068Xfvu0RdXrib14eWXlC26eSJ3yI02YiTRyqugVlawlX
         KsOSDGyqYc8zE+tZ3zpOwkFCo5+wFwEMyCPBVtz5aj6UexBRbf8OuN5+OtbwZJv1tZxK
         vKiQ==
X-Gm-Message-State: AOAM530436XOF8GwO/wrd7CwqNVi54f0YncZJgPnqRNmyFD1cuDposRf
        70SQoF66hHmY0qNwnKMUCU8=
X-Google-Smtp-Source: ABdhPJyIlfkHrH0ea6xOFXtDXjREGUjvMvi2CV9cnBIkDYbk4cQjom+qjvm11o0v1qfrjUwbKoJXFQ==
X-Received: by 2002:a17:902:b592:b029:d3:8dc4:391e with SMTP id a18-20020a170902b592b02900d38dc4391emr15889080pls.76.1602314370951;
        Sat, 10 Oct 2020 00:19:30 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id s67sm13180604pfb.35.2020.10.10.00.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 00:19:30 -0700 (PDT)
Date:   Sat, 10 Oct 2020 00:19:14 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH v2 2/4] time: make getboottime64 aware of time namespace
Message-ID: <20201010071914.GA135401@gmail.com>
References: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
 <20201008053944.32718-3-michael.weiss@aisec.fraunhofer.de>
 <20201009132815.5afulu5poh5ti57m@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201009132815.5afulu5poh5ti57m@wittgenstein>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 03:28:15PM +0200, Christian Brauner wrote:
> On Thu, Oct 08, 2020 at 07:39:42AM +0200, Michael Weiß wrote:
> > getboottime64() provides the time stamp of system boot. In case of
> > time namespaces, the offset to the boot time stamp was not applied
> > earlier. However, getboottime64 is used e.g., in /proc/stat to print
> > the system boot time to userspace. In container runtimes which utilize
> > time namespaces to virtualize boottime of a container, this leaks
> > information about the host system boot time.
> > 
> > Therefore, we make getboottime64() to respect the time namespace offset
> > for boottime by subtracting the boottime offset.
> > 
> > Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> > ---
> >  kernel/time/timekeeping.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index 4c47f388a83f..67530cdb389e 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/clocksource.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/time.h>
> > +#include <linux/time_namespace.h>
> >  #include <linux/tick.h>
> >  #include <linux/stop_machine.h>
> >  #include <linux/pvclock_gtod.h>
> > @@ -2154,6 +2155,8 @@ void getboottime64(struct timespec64 *ts)
> >  {
> >  	struct timekeeper *tk = &tk_core.timekeeper;
> >  	ktime_t t = ktime_sub(tk->offs_real, tk->offs_boot);
> > +	/* shift boot time stamp according to the timens offset */
> > +	t = timens_ktime_to_host(CLOCK_BOOTTIME, t);
> 
> Note that getbootime64() is mostly used in net/sunrpc and I don't know
> if this change has any security implications for them.

I would prefer to not patch kernel internal functions if they are used
not only to expose time to the userspace.

I think when kernel developers sees the getboottime64 function, they
will expect that it returns the real time of kernel boot. They will
not expect that it is aware of time namespaces and a returned time will
depend on a task in which context it will be called.

IMHO, as a minimum, we need to update the documentation for this function or
even adjust a function name.

And I think we need to consider an option to not change getbootime64 and
apply a timens offset right in the show_stat(fs/proc/stat.c) function.

Thanks,
Andrei
