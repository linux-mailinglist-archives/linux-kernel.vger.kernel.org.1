Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38558284F31
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 17:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgJFPoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 11:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgJFPoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 11:44:46 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A738C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 08:44:46 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y14so8182618pgf.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 08:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvPeygSRI48grLUqNULD5W+f3mhPyObVQKrAhFQNIS8=;
        b=vx+TAEpaWL989xTX2O3znU6AUP/8syf/G6qWeeQ9jW8jvLsF3Pa1BQJ+xVLpQx4iiM
         NDDOjNh/uEC48cIOE2dLgKZzSwdKoEFeX7Dt7nYu+fQSB62N3F+B/WTc4B7pkUNndi9v
         42KZvZYnrlLjmsaDZ7C9l9oE8/FTolU4RkTnKrtaEHcn3Yxts+MDm8zXw0VrafHcfhQ7
         20y3kr1QwJ6g3KWOFhVxQMnrBilp/8YuhnfenoIdE3yiyjPLqDoy+mA6tZKcC3/sEJjm
         kYLbUYscXFdJrULjlE4wTAEPOLnhHvsoQwB/GEVGqq3+r5+/RJhgggVgvreXOgwbCK5L
         Y32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvPeygSRI48grLUqNULD5W+f3mhPyObVQKrAhFQNIS8=;
        b=UJ+hkwRjR8xV45HJvh6f5YvYGP9KlrwFeMMTl3mdGrVXW+1bSMwYZ9mMLEE633kCZw
         lKnQau2LJnIC7TNJVpglaz6bevfTBzy7CXMA10HAPhL+pzQA4/uEf8WQDceQQc5sAeBs
         f81NwT5qiT1BvCnON8EZPlspcApf9t53Tuf1HkQ5PfPUjLoJkrMBw67CTgIFbyotvY6o
         7cMBluSWbP88mJ5FVxWGW5SE/wMS9bHTmtLLJ7W3blMSHYBUHzzRub6Yr55b5T9kZPSC
         rz6KQpCWfUIET1WcZK0tnSc1q8gRH539/dvWjnePfUq1cNWlPf6XJoMFNaQ9sBt95Ore
         jYfw==
X-Gm-Message-State: AOAM533h7Ndz5d9bGqMuPejkKcKIp2Qx5gj5PQ0yAY0Ya19RjIQ16zzb
        XfYMuX/pFRZQGlUQif+GVMI32YE/tPJtXwSYXt3ieQ==
X-Google-Smtp-Source: ABdhPJxu8epATsAnVzNpcf9DQmiAD+l96Xpgn7WIfZOTDnvcg+MTv+IsH7tnMqOinZpjj62OnUSaG8BlODYz9bVMiJs=
X-Received: by 2002:a62:78d5:0:b029:154:ebc0:c92c with SMTP id
 t204-20020a6278d50000b0290154ebc0c92cmr1268030pfc.24.1601999084773; Tue, 06
 Oct 2020 08:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+wb4k-LGTjK9F5YbJNviF_+yU+wE_=Vpo9Rn7KFN8vG6Q@mail.gmail.com>
 <20201005151857.GA2309511@kroah.com> <CAAeHK+zes2Y00+EJ6SVtOHj8YCADw5WSXUEFHWCRgxi=H42+4w@mail.gmail.com>
 <20201005152540.GG376584@rowland.harvard.edu> <65b4ff62-f9c8-b9cf-50bb-c9b08cce7230@linuxfoundation.org>
 <20201006012333.GA399825@rowland.harvard.edu>
In-Reply-To: <20201006012333.GA399825@rowland.harvard.edu>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 6 Oct 2020 17:44:33 +0200
Message-ID: <CAAeHK+w3hUbNO5PBcoZX2cJsmRPZ8bq+8j8-Xs7nZLFyKbdd+A@mail.gmail.com>
Subject: Re: Is usb_hcd_giveback_urb() allowed in task context?
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 3:23 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, Oct 05, 2020 at 05:38:22PM -0600, Shuah Khan wrote:
> > On 10/5/20 9:25 AM, Alan Stern wrote:
> > > On Mon, Oct 05, 2020 at 05:21:30PM +0200, Andrey Konovalov wrote:
> > > No, no -- it won't work right if it's called in process context.  Not
> > > only do the spinlock calls leave the interrupt flag unchanged, also the
> > > driver callback routines may expect to be invoked with interrupts
> > > disabled.  (We have tried to fix this, but I'm not at all certain that
> > > all the cases have been updated.)
> > >
> >
> > In the case of vhci case, usb_hcd_giveback_urb() is called from vhci's
> > urb_enqueue, when it determines it doesn't need to xmit the urb and can give
> > it back. This path runs in task context.
> >
> > Do you have any recommendation on how this case can be handled?
>
> Just call local_irq_disable() before usb_hcd_giveback_urb(), and
> local_irq_enable() afterward.

OK, so overall it's possible to call usb_hcd_giveback_urb() in task
context, but only with irqs disabled.

This means we do need a fix for kcov as well, thank you!
