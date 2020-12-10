Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E342D6614
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 20:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393342AbgLJTMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 14:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393275AbgLJTLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 14:11:45 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE84EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 11:11:04 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id w18so3439619vsk.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 11:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PSuDOGmQG6f3wX+35DW8ozqca1MRVBAGEu0JKzO/rWo=;
        b=vlx65VSsqr1vs1yKD+xps0gOngTsHYXR3wg0PnZ9Cys3zdMWq5IcTAR/3dwyN0n4nP
         zu5JSzj4UzESNahyLzsbCN4lxESUAX7/4EIPuhAGTD50pJs7ojEW81Ik+90Q6EsN/V3k
         gZM2XxRmjtwyHCDOqT3FTDg7cBVIPL6V33fNnX79slISXK/NxlRrK2VeVyYPgA99uIG7
         MNTLB1jRRmvbsC8LCAVMjKKkZoEAYKMyUOYCte/tPD7gpsqHJRNsn5Obz5DvyL1+TbMp
         m5J6IJN/YWZGd8IVL8JZ4MkZXvo0S74HcfoqOJbU4k5rcAGjajh8bzsTNhjuLNpDutja
         oq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PSuDOGmQG6f3wX+35DW8ozqca1MRVBAGEu0JKzO/rWo=;
        b=ZNQc/NY3rfokc6HE1Ywv6Xy4lHPH2Sm86QHZ30TBxsnjAjv0lRCBPi5xTl47sKHl8e
         L5w7KFxiQbu9ebMIyONG3YWcn8/K2/VyZcii6rzQJOfShojb99XxNlsu6nCyWMXQFbmG
         yNk1dJ4UeowtlK+zzAncHOjA7imP7UMYbp+e7pA16CH2TwEd5AoXy5gThIBAKS0yVTOh
         MQXWcpC1Aor5GUToB/deZKh+0BrB05DQddv7SaQOHIGZ0b4c15Z5QhrFsWtdIQTWRkyr
         7O1UdIb2WqaG+RhT3uaICgjAzuA/v1XNa9Ds/dpW35tcyVnyqoXKSi1whUk/itBg0DLH
         qWHQ==
X-Gm-Message-State: AOAM532zQ6TffVdBHfPUo4wFBmYgqp+j8aodSkQXK9Fcg/GU7D2cn9jn
        5lH8QGfZVXwLzP+DeeFNqaGqYFy7jvcu4TJ0rgwNfg==
X-Google-Smtp-Source: ABdhPJxZ5mg/prWG1u/QfCa0H4LhRt17sbOIPuNXgLo3zysTo4TYUpTWCHmKRIn9XrfG1H1lP4AEbIMpbJpSFQeaYRY=
X-Received: by 2002:a67:b07:: with SMTP id 7mr9970482vsl.16.1607627463756;
 Thu, 10 Dec 2020 11:11:03 -0800 (PST)
MIME-Version: 1.0
References: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
 <20201210160521.3417426-2-gregkh@linuxfoundation.org> <20201210174236.GB107395@roeck-us.net>
In-Reply-To: <20201210174236.GB107395@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 10 Dec 2020 11:10:27 -0800
Message-ID: <CAPTae5+uHw7dHbhUze2WU_6mM8BPnF=rz6euZBZqv40=zyczhQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] USB: typec: tcpm: Prevent log overflow by removing
 old entries
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>,
        Will McVicker <willmcvicker@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

While I agree with what you are saying, since the logbuffer does not
have the intelligence to drop older entries where no issues were seen,
logbuffer gets full pretty quickly with good instances and there is no
space left to log the bad instance. Should wrapping this in a config
option be a better way to go about this  ? When the config optioin is
set, old entries will be dropped.
Please let me know, I can update the patch and resend.

Thanks,
Badhri



On Thu, Dec 10, 2020 at 9:53 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Dec 10, 2020 at 05:05:17PM +0100, Greg Kroah-Hartman wrote:
> > From: Badhri Jagan Sridharan <badhri@google.com>
> >
> > TCPM logs overflow once the logbuffer is full. Clear old entries and
> > allow logging the newer ones as the newer would be more relevant to the
> > issue being debugged.
> >
> > Also, do not reset the logbuffer tail as end users might take back to
> > back bugreports which would result in an empty buffer.
> >
>
> Historically, the reason for not doing this was that, once a problem occurs,
> the log would fill up quickly (typically with reconnect attempts), and the
> actual reason for the problem would be overwritten. Maybe that reasoning
> no longer applies; I just wanted to point out that there _was_ a reason for
> not clearing old log entries.
>
> Guenter
>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Cc: Kyle Tso <kyletso@google.com>
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 16 +++-------------
> >  1 file changed, 3 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index cedc6cf82d61..0ceeab50ed64 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -470,12 +470,6 @@ static bool tcpm_port_is_disconnected(struct tcpm_port *port)
> >
> >  #ifdef CONFIG_DEBUG_FS
> >
> > -static bool tcpm_log_full(struct tcpm_port *port)
> > -{
> > -     return port->logbuffer_tail ==
> > -             (port->logbuffer_head + 1) % LOG_BUFFER_ENTRIES;
> > -}
> > -
> >  __printf(2, 0)
> >  static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
> >  {
> > @@ -495,11 +489,6 @@ static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
> >
> >       vsnprintf(tmpbuffer, sizeof(tmpbuffer), fmt, args);
> >
> > -     if (tcpm_log_full(port)) {
> > -             port->logbuffer_head = max(port->logbuffer_head - 1, 0);
> > -             strcpy(tmpbuffer, "overflow");
> > -     }
> > -
> >       if (port->logbuffer_head < 0 ||
> >           port->logbuffer_head >= LOG_BUFFER_ENTRIES) {
> >               dev_warn(port->dev,
> > @@ -519,6 +508,9 @@ static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
> >                 (unsigned long)ts_nsec, rem_nsec / 1000,
> >                 tmpbuffer);
> >       port->logbuffer_head = (port->logbuffer_head + 1) % LOG_BUFFER_ENTRIES;
> > +     if (port->logbuffer_head == port->logbuffer_tail)
> > +             port->logbuffer_tail =
> > +                     (port->logbuffer_tail + 1) % LOG_BUFFER_ENTRIES;
> >
> >  abort:
> >       mutex_unlock(&port->logbuffer_lock);
> > @@ -622,8 +614,6 @@ static int tcpm_debug_show(struct seq_file *s, void *v)
> >               seq_printf(s, "%s\n", port->logbuffer[tail]);
> >               tail = (tail + 1) % LOG_BUFFER_ENTRIES;
> >       }
> > -     if (!seq_has_overflowed(s))
> > -             port->logbuffer_tail = tail;
> >       mutex_unlock(&port->logbuffer_lock);
> >
> >       return 0;
> > --
> > 2.29.2
> >
