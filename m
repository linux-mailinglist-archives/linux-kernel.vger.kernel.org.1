Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9437A2D6C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390429AbgLKACc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 19:02:32 -0500
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:55590 "EHLO
        gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389478AbgLKACC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 19:02:02 -0500
Received: from cmgw12.unifiedlayer.com (unknown [10.9.0.12])
        by gproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id A93FC176F98
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:01:20 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id nVs5kpIQaeMJHnVs6kuesB; Thu, 10 Dec 2020 17:01:18 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=f4tm+t6M c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=_jlGtV7tAAAA:8
 a=1XWaLZrsAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=pDWBtCd9S4YHm_LgQy8A:9
 a=CjuIK1q_8ugA:10:nop_charset_2 a=nlm17XC03S6CtCLSeiRr:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6PZqv9kXxqkh21QOSUOt0pmwHWZLBZjcs5nnXqLVDO8=; b=thv0znhCXhvB4SUO2XbAnC6Yev
        0G/JbUknE6Y9K/UqQ0DZ6gj7mgyVeo50wqkpfZwelKQbDWt0eSNRUHbw7SW/5S9sqojSBpWGJhI9h
        euAae/DLcx/cA/hVjhCecOKyF0HsFiJFAtYiGty4hqEG4OUCkHQhcpAIx69IvQCmfp3sshsyBiPgC
        4NvFVt8TVHplZoL36KjgI7EC4TWJtcY6SALnQgM33jDypU8xKqBaUSaUeJ2bShjb6GRqUMqgdtGOK
        kSlVRp5kxb8iAlJnMlUFpu3+ZFrxz9DKCe3FHap6xcZt5tnnTyxXr3anVNOOKRkc6ZXmJL+6pz1XM
        TIVPpqxQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:34692 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1knVs5-004DDF-DO; Fri, 11 Dec 2020 00:01:17 +0000
Date:   Thu, 10 Dec 2020 16:01:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>,
        Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 1/5] USB: typec: tcpm: Prevent log overflow by removing
 old entries
Message-ID: <20201211000116.GF259082@roeck-us.net>
References: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
 <20201210160521.3417426-2-gregkh@linuxfoundation.org>
 <20201210174236.GB107395@roeck-us.net>
 <CAPTae5+uHw7dHbhUze2WU_6mM8BPnF=rz6euZBZqv40=zyczhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTae5+uHw7dHbhUze2WU_6mM8BPnF=rz6euZBZqv40=zyczhQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1knVs5-004DDF-DO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:34692
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 3
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:10:27AM -0800, Badhri Jagan Sridharan wrote:
> Hi Guenter,
> 
> While I agree with what you are saying, since the logbuffer does not
> have the intelligence to drop older entries where no issues were seen,
> logbuffer gets full pretty quickly with good instances and there is no
> space left to log the bad instance. Should wrapping this in a config

For my use case, it was typically sufficient to clear the log buffer
by reading it if needed. However, as I said, my original reason may no
longer apply. After all, the code is much more stable than it used to be,
and maybe the endless conection attempts after an initial error are no
longer seen. At this point I don't really have a strong opinion either way.

> option be a better way to go about this  ? When the config optioin is
> set, old entries will be dropped.

A config option (assuming you mean Kconfig) seems bad. Maybe we could
have a writeable debugfs file which defines the approach to use (not
sure if that would be acceptable, though).

Note that I also considered changing logging to tracing, but that has
the disadvantage that it needs to be explicitly activated and doesn't
provide any kind of history in the "normal" case. On a higher level,
it would be nice to have a logging option like the one implemented here
in the infrastucture. But that is really a completely different issue.

Thanks,
Guenter

> Please let me know, I can update the patch and resend.
> 
> Thanks,
> Badhri
> 
> 
> 
> On Thu, Dec 10, 2020 at 9:53 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Thu, Dec 10, 2020 at 05:05:17PM +0100, Greg Kroah-Hartman wrote:
> > > From: Badhri Jagan Sridharan <badhri@google.com>
> > >
> > > TCPM logs overflow once the logbuffer is full. Clear old entries and
> > > allow logging the newer ones as the newer would be more relevant to the
> > > issue being debugged.
> > >
> > > Also, do not reset the logbuffer tail as end users might take back to
> > > back bugreports which would result in an empty buffer.
> > >
> >
> > Historically, the reason for not doing this was that, once a problem occurs,
> > the log would fill up quickly (typically with reconnect attempts), and the
> > actual reason for the problem would be overwritten. Maybe that reasoning
> > no longer applies; I just wanted to point out that there _was_ a reason for
> > not clearing old log entries.
> >
> > Guenter
> >
> > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Cc: Kyle Tso <kyletso@google.com>
> > > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/usb/typec/tcpm/tcpm.c | 16 +++-------------
> > >  1 file changed, 3 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > > index cedc6cf82d61..0ceeab50ed64 100644
> > > --- a/drivers/usb/typec/tcpm/tcpm.c
> > > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > > @@ -470,12 +470,6 @@ static bool tcpm_port_is_disconnected(struct tcpm_port *port)
> > >
> > >  #ifdef CONFIG_DEBUG_FS
> > >
> > > -static bool tcpm_log_full(struct tcpm_port *port)
> > > -{
> > > -     return port->logbuffer_tail ==
> > > -             (port->logbuffer_head + 1) % LOG_BUFFER_ENTRIES;
> > > -}
> > > -
> > >  __printf(2, 0)
> > >  static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
> > >  {
> > > @@ -495,11 +489,6 @@ static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
> > >
> > >       vsnprintf(tmpbuffer, sizeof(tmpbuffer), fmt, args);
> > >
> > > -     if (tcpm_log_full(port)) {
> > > -             port->logbuffer_head = max(port->logbuffer_head - 1, 0);
> > > -             strcpy(tmpbuffer, "overflow");
> > > -     }
> > > -
> > >       if (port->logbuffer_head < 0 ||
> > >           port->logbuffer_head >= LOG_BUFFER_ENTRIES) {
> > >               dev_warn(port->dev,
> > > @@ -519,6 +508,9 @@ static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
> > >                 (unsigned long)ts_nsec, rem_nsec / 1000,
> > >                 tmpbuffer);
> > >       port->logbuffer_head = (port->logbuffer_head + 1) % LOG_BUFFER_ENTRIES;
> > > +     if (port->logbuffer_head == port->logbuffer_tail)
> > > +             port->logbuffer_tail =
> > > +                     (port->logbuffer_tail + 1) % LOG_BUFFER_ENTRIES;
> > >
> > >  abort:
> > >       mutex_unlock(&port->logbuffer_lock);
> > > @@ -622,8 +614,6 @@ static int tcpm_debug_show(struct seq_file *s, void *v)
> > >               seq_printf(s, "%s\n", port->logbuffer[tail]);
> > >               tail = (tail + 1) % LOG_BUFFER_ENTRIES;
> > >       }
> > > -     if (!seq_has_overflowed(s))
> > > -             port->logbuffer_tail = tail;
> > >       mutex_unlock(&port->logbuffer_lock);
> > >
> > >       return 0;
> > > --
> > > 2.29.2
> > >
