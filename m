Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5902E21D83B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 16:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgGMOUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 10:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbgGMOUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:20:17 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 492382065F;
        Mon, 13 Jul 2020 14:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594650016;
        bh=y5iGcCPTboLQWmJbEy5llbXI9H+mvjX5azNHLwbxqKk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nTYR+5E0tPk25AtEeevEjKyTnh6/I2eRzztIZnkq4L+XaU8YckGryb3/UHMRVD/mQ
         m4uWz5EWUmukOpWAFYHcW4AxdIdxBZZpkK9Kw+YUOse6j/yzSxdPayqJSYDWwJ4Pdu
         dPmMsT6ZI2buB5NxX4L/IdEW2rpLXXRFoS6AJaf8=
Date:   Mon, 13 Jul 2020 23:20:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        anil.s.keshavamurthy@intel.com, corbet@lwn.net,
        davem@davemloft.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: kprobes
Message-Id: <20200713232011.da584d6f7147b54ba083556f@kernel.org>
In-Reply-To: <1594388442.4mjtjyic5z.naveen@linux.ibm.com>
References: <20200707194959.52487-1-grandmaster@al2klimov.de>
        <20200708184201.611d929ae6017c87ea98b114@kernel.org>
        <1594388442.4mjtjyic5z.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naveen and Alexander,

On Fri, 10 Jul 2020 19:14:47 +0530
"Naveen N. Rao" <naveen.n.rao@linux.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > On Tue,  7 Jul 2020 21:49:59 +0200
> > "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
> > 
> >> Rationale:
> >> Reduces attack surface on kernel devs opening the links for MITM
> >> as HTTPS traffic is much harder to manipulate.
> >> 
> >> Deterministic algorithm:
> >> For each file:
> >>   If not .svg:
> >>     For each line:
> >>       If doesn't contain `\bxmlns\b`:
> >>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> >>           If both the HTTP and HTTPS versions
> >>           return 200 OK and serve the same content:
> >>             Replace HTTP with HTTPS.
> > 
> > OK, but it seems that some of them are disappeared :(
> > 
> >  http://www-106.ibm.com/developerworks/library/l-kprobes.html?ca=dgr-lnxw42Kprobe
> > 
> >  -> https://www.ibm.com/developerworks/library/l-kprobes/index.html
> 
> That looks right.
> 
> > 
> >  http://www.redhat.com/magazine/005mar05/features/kprobes/
> > 
> >  -> I can not find that.
> 
> Ditto, we should drop that.
> 
> > 
> >>  - http://www-users.cs.umn.edu/~boutcher/kprobes/
> >>  - http://www.linuxsymposium.org/2006/linuxsymposium_procv2.pdf (pages 101-115)
> > 
> > Both are not found.
> 
> It looks like the first link is gone, but there seems to be a copy in 
> the web archive:
> https://web.archive.org/web/20061106154519/http://www-users.cs.umn.edu/~boutcher/kprobes/
> 
> I suppose we can drop that link.
> 
> > 
> > (OT, it seems http://www.linuxsymposium.org/ has been left from historical
> >  Linux Symposium, we must remove it asap)
> 
> Indeed, I think that link pointed to the Kprobes paper:
> https://www.kernel.org/doc/ols/2006/ols2006v2-pages-109-124.pdf

Ah, there is.
Thank you for the confirmation.
Alexander, can you update other urls instead of just replacing the http with https?

> 
> 
> - Naveen
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
