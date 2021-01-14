Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69B42F6AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbhANTS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbhANTS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:18:58 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D78C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:18:18 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 186so9377686qkj.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=C4cTRyNK/dC7x750o61uCU/kZvdErxEIbD//IbSoOqo=;
        b=IVs5API2ULJAzAHUSiRisWWxGFJGCovscCYfVU18XbamY7/WEof8Gym2BlSktJDXBo
         AoCoxz2E3yLrkkdsNWUFxDbxQqY4B+CwmC4cfYwn409aRYG7qB1b5Y6WhgV7StJCej62
         vfcM/W63g0sDQPGmSKZJ8JsXuiaegR5ZWDedA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=C4cTRyNK/dC7x750o61uCU/kZvdErxEIbD//IbSoOqo=;
        b=UncMkJ/i2kZl6e/xYQjV2B5YN3gqMkCNwZ04LrTHL9EUZ4S1xZd/xcU6fyWRYR3IwO
         AgaUJNUYxu/GO3x9GmIjX61JrHEgbRZp2Erp/votkxtJ0cOf/udyQbtez6C/ZDTx+3Zi
         FkG06WbryMi0hFZWC2UFXDCQd+97o+fZTPqDLbW2kCAzQ0IHxirWUYBqOayqTqs48Fva
         RnRolTkN3Le/raxHO6c+m4gCZIi4QXKF3JeV27WX2CH/OoeAQ6wfzws1nkfzbntNZUi7
         F9va9J67PChjgQSIIILqIMkw4q7U9hg2XFjJvuGVAYcToXICpTRoP2JrsehnSlRre0SH
         U6HA==
X-Gm-Message-State: AOAM530nVNdu2sIc//1dsghFg4AgCxW5B0H2p1scOYJLG9OsOFNc0P6h
        wecgPpkE1w6gGY8t1Q+X1dQrzvl6jVe2h8IM
X-Google-Smtp-Source: ABdhPJzmWOLSsFawh/iOlWprvRJZzLbN1iFPlFN/u1i8PPWL6QuikgUEMHCOEwWCGA62v07RPcSLwA==
X-Received: by 2002:a37:e504:: with SMTP id e4mr8561054qkg.191.1610651897173;
        Thu, 14 Jan 2021 11:18:17 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id m190sm3530840qkb.42.2021.01.14.11.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:18:16 -0800 (PST)
Date:   Thu, 14 Jan 2021 14:18:14 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 (RFC)] docs: discourage users from using
 bugzilla.kernel.org
Message-ID: <20210114191814.g3se2svqxtod25xi@chatter.i7.local>
Mail-Followup-To: Jani Nikula <jani.nikula@linux.intel.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210110121033.130504-1-linux@leemhuis.info>
 <20210111194822.4kvl2tx24anyu23k@chatter.i7.local>
 <fba45829-cac3-9f53-c753-0b08d813aa83@leemhuis.info>
 <877doht7bd.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877doht7bd.fsf@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 01:17:10PM +0200, Jani Nikula wrote:
> >> Well, that said, a lot of stuff sent to the _proper_ mailing lists also never
> >> receives a response
> >
> > Good point.
> 
> There's a school of thought that this is actually a feature. If there's
> no attention, the reports on the list will just fade away and be
> forgotten. Whereas in bugzilla, someone needs to actively resolve even
> the ignored and forgotten bugs. (Or it needs to be automated.)

FWIW, it's easy for me to script this, if there is consensus that a bug that
hasn't seen any activity for longer than N months should be auto-closed with
some apologetic comment like:

    This bug has aged out and will be auto-closed. Sorry that it didn't work out.

    If this issue is still present in recent kernel releases, you may need to
    reach out directly to subsystem maintainers in order to get their attention
    regarding this problem.

    Please do not re-open this bug without the above step, as it will simply
    get auto-closed again in the future.

> Attending to a bug database of thousands of open bugs takes a huge
> amount of effort, and if the bugs aren't being fixed, a lot of that
> effort is just wasted. If a bug doesn't get fixed now (or soon-ish),
> what are the chances it'll get fixed months or years down the line?

Well, it's *possible* that someone comes across that bug during their research
and adds enough additional information to get it fixed. However, this is
extremely unlikely and it's better to just open a new bug anyway.

> Just musing, has anyone else seen a shift in bug reports from "I'm part
> of the community, and I want to help improve this stuff" towards "I'm a
> customer and I demand support"? I don't think the kernel community can
> really cater to the latter very well, and would be better directed at
> distro bug trackers.

I haven't seen any specific change like that. One good thing about bugzilla is
that people who do file bugs have already overcome significant barriers to
sign up and navigate the quaint, decades-old bugzilla interface -- so their
bug reports tend to be generally well-written.

-K
