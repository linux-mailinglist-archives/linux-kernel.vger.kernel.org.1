Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A295D2F6844
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbhANRun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:50:43 -0500
Received: from colin.muc.de ([193.149.48.1]:55445 "HELO mail.muc.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
        id S1726636AbhANRum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:50:42 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2021 12:50:41 EST
Received: (qmail 59988 invoked by uid 3782); 14 Jan 2021 17:43:20 -0000
Received: from acm.muc.de (p4fe15b0e.dip0.t-ipconnect.de [79.225.91.14]) by
        colin.muc.de (tmda-ofmipd) with ESMTP;
        Thu, 14 Jan 2021 18:43:19 +0100
Received: (qmail 15554 invoked by uid 1000); 14 Jan 2021 17:43:19 -0000
Date:   Thu, 14 Jan 2021 17:43:19 +0000
To:     linux-kernel@vger.kernel.org
Subject: Re: fbcon: remove soft scrollback code
Message-ID: <YACCtwJgufxLJI4e@ACM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjsjC1h7fskwYaaRLykN1ms6ZtxGvucQgmL-zZTfxPdBA@mail.gmail.com>
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
From:   Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, lkml.

This is my first post to the list.

From: Linus Torvalds <>
Date: Fri, 8 Jan 2021 15:11:34 -0800
Subject:Re: fbcon: remove soft scrollback code (missing Doc. patch)
	
>On Fri, Jan 8, 2021 at 11:13 AM Phillip Susi
><phill@thesusis.net> wrote:

>> > Could we pause this madness? Scrollback is still useful.  I needed it
>> > today... it was too small, so command results I was looking for
>> > already scrolled away, but... life will be really painful with 0
>> > scrollback.

>> > You'll need it, too... as soon as you get oops and will want to see
>> > errors just prior to that oops.

>> > If it means I get to maintain it... I'm not happy about it but that's
>> > better than no scrollback.

>> Amen!  What self respecting admin installs a gui on servers?  What do
>> we have to do to get this back in?  What was so buggy with this code
>> that it needed to be removed?  Why was it such a burden to just leave
>> it be?

I am an Emacs maintainer, and do all my text work on the Linux console.
My distribution is Gentoo.

Whilst it may be an exaggeration to say Linux will become unusable to me
without this scrolling facility, it's not much of one.  For the moment, I
can get by by not upgrading my kernel, but that's not a long term
solution.

>It really was buggy, with security implications. And we have no
>maintainers.

The first I heard of these problems was yesterday, when somebody posted a
heads-up in the Gentoo users' list.

I'm disappointed not to have heard of this around the time the decision
was taken.  Perhaps the problems, and request for a maintainer, could
have been more widely circulated.  I would have offered to stand up then,
just as I am offering to stand up now.

I have as yet no experience in kernel hacking, though I did look closely
at the console code a few years back, with a view to enhancing it to
handle more than 256 glyphs and 16 colours.  It struck me as code badly
needing some love.

>So the scroll-back code can't come back until we have a maintainer and a
>cleaner and simpler implementation.

I offer my services, just as others have done.

>And no, maintaining it really doesn't mean "just get it back to the old
>broken state".

Is there a coherent description of the problems (including the security
problems) anywhere?

>So far I haven't actually seen any patches, which means that it's not
>coming back.

But with a few pertinent patches, it might come back, perhaps?

[ .... ]

	                     Linus

-- 
Alan Mackenzie (Nuremberg, Germany).
