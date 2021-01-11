Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D062F1FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404081AbhAKTtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404055AbhAKTtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:49:07 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CCAC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:48:26 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id n142so647400qkn.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kLtaf1eBxTtR2D3tfYv6Mi1M5oh/dRDSoNs9Uf00ARo=;
        b=ZZucLJbbWopawPRNLX9jXnzkVKB0sybo+SM+6ScKfFOdf8KMVP/8lqER/VmwEmEF/f
         0EgNvtds3h91RPK659ij/nU4VYZZWQivVNFkPuHf/rlBri90Aq8teMihvGmZEUYuSmuD
         qSdFx1hb3xo4qMByuGM2N8JD7dnfUQRtDe03Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=kLtaf1eBxTtR2D3tfYv6Mi1M5oh/dRDSoNs9Uf00ARo=;
        b=oGrXu0T2Wz9VMeGjxf9gidxzTarNpWlXOskYb7SM1eK/HrMDQToVGNaauKcGJjqu7J
         ELBDHeNIjLQtHx4qSPvWDbpTnlRKXyk1hY1yYTJRvn400Vjzsh/pfh1+CS6CTZYsuFJk
         tSlYFj9zfhYCKY4a/XpuU0iJSZWYcZW8qnWypXjZAWZb2DzsQ3sfX256iZSbQOE2bc88
         NhnXoUAyiPP7lOMC8US5DkYYTC5r7We9qI9jvfJOquZm2SLjMfHyoa/D6pesRklg8pWo
         /XmQThBkWH0lPR1is5/NBrD7f/fQc8hdlieOqCg93kdsa46k7V7+5WSnofCNXmJyRRKk
         z2hw==
X-Gm-Message-State: AOAM530Eu2sJDY55NrobKOUFIGEJlXqvHhlhOZWyMUIBgkHWdnhduJbr
        cTz4w7FjsDl5hK9uzdsia/zZRA==
X-Google-Smtp-Source: ABdhPJzb7xMroLdY2UyKsaSXZ8ji8kcTWDIU9bnksF6ExL9bmBVa+EgYtgyyTGM/rlm7TGPqB3Pr5w==
X-Received: by 2002:a37:4bc1:: with SMTP id y184mr984925qka.278.1610394505120;
        Mon, 11 Jan 2021 11:48:25 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id l20sm341808qtu.25.2021.01.11.11.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:48:24 -0800 (PST)
Date:   Mon, 11 Jan 2021 14:48:22 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 (RFC)] docs: discourage users from using
 bugzilla.kernel.org
Message-ID: <20210111194822.4kvl2tx24anyu23k@chatter.i7.local>
Mail-Followup-To: Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210110121033.130504-1-linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210110121033.130504-1-linux@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 01:10:33PM +0100, Thorsten Leemhuis wrote:
> The front page doesn't make this aspect obvious and not even point to
> Documentation/admin-guide/reporting-bugs.rst to help those that want to
> properly report a bug. Only the FAQ mentions it, albeit only indirectly:
> 'The subsystem maintainers in kernel tracker are volunteers to help
> track bugs in an area they are interested in. Sometimes they are the
> same person as on kernel.org sometimes they are not. There are still
> some categories with no maintainers so more volunteers are needed.'

My general comment on this is that bug triage sucks and nobody really wants to
do it for any extended period of time. :) There were times in the past when
this or that person did step up and kept an eye on all incoming new bugs,
properly routing them to the proper product/component, but they quickly burned
out or found a less thankless occupation. Understandably.

> It looks like those volunteers were never found; the outdated list of
> components and products (see 'the bad' above) also shows that the
> volunteers seem to not really take care of things.

I want to encourage you and the rest of the developers to complain about this
to the TAB. It is entirely in their power to come to the Linux Foundation with
the suggestion that perhaps bug triage should be a paid position. It's not a
given that such a position would then be created and funded, but this for sure
won't happen if these complaints don't reach People In Charge Of Funds at the
LF.

(FYI, this person shouldn't be me -- every time I've come to the Foundation, I
was asked that the proper way to go about it is through the TAB.)

TBH, bug triage sounds like a great kernel developer semi-retirement gig. :)

> In the end that's the reasons why quite a few (a lot?) reports never get
> a reply from someone. During a randomly selected 2 week window at the
> end of November 2020(¹) there were 60 public bugs and a bit more than
> half of them by the end of the year never got a single comment by anyone
> except maybe the reporter.

Well, that said, a lot of stuff sent to the _proper_ mailing lists also never
receives a response -- either because it didn't catch appropriate eyeballs or
because those eyeballs didn't have time to spend on the required
back-and-forth to identify the source of the problem. I don't think we should
be using this metric as indication that bugzilla doesn't work.

> But there is one aspect that should be noted here: The situation can't
> be blamed on the kernel.org admins. They are doing a good job at keeping
> the bugzilla.kernel.org up and the bugzilla codebase up2date. But as
> admins it's not their job to maintain the list of products and
> components.

Aw, thanks. :) It's indeed hard enough just keeping all the spam off it.
Unfortunately, there are no perfect solutions for it, but usually all spam is
junked and hidden from public view within an hour or two of being posted.
Sadly, this usually happens after spammy notifications have already gone out.

> Apart from this change there is one more change planned to improve the
> situation with bugzilla.kernel.org: discuss with the admins how to make
> it more obvious to users when to use the bug tracker, and when to avoid
> it; the text that does this will obviously link to
> Documentation/admin-guide/reporting-issues.rst, which is one of the
> reasons why it's designed to be understandable for newcomers.

I'm not sure there's any single solution that will solve the problem. If we
properly organize products/components, many people will just get lost in them
and create all bug reports in "other" (or "helpdesk", as is the case lately).

The sanest approach would be to have a simple web gateway to bug reporting:

- which distribution are you using?
- if they choose a distribution, show them where to report bugs for that
  distribution, because most bugs should start there, really
- on that page, also give a link:
  "I'm a distribution maintainer and I want to report this bug upstream"
- if they click that link, let them fill out a freeform bug report that will
  create a new bug entry on bugzilla.kernel.org in "Other/Other"
- creating a bug there will email the designated person in charge of initial
  bug triage
- that designated person or persons will then assign proper product/component,
  or simply forward the bug report to the proper maintainer if they are able
  to ascertain that

This is far from perfect and still hinges on finding a person willing to do
bug triage. However, it should hopefully improve the workflow without making
it too complicated.

-K
