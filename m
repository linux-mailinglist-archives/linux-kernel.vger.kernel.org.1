Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9C92EF804
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbhAHTVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:21:23 -0500
Received: from vps.thesusis.net ([34.202.238.73]:44312 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727919AbhAHTVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:21:22 -0500
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Jan 2021 14:21:22 EST
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id C42A02739C;
        Fri,  8 Jan 2021 14:13:14 -0500 (EST)
Received: from vps.thesusis.net ([127.0.0.1])
        by localhost (vps.thesusis.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dagrAE_vPef1; Fri,  8 Jan 2021 14:13:14 -0500 (EST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 85FF72739B; Fri,  8 Jan 2021 14:13:14 -0500 (EST)
User-agent: mu4e 1.5.7; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc\@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
In-Reply-To: <20200916205434.GA10389@duo.ucw.cz>
Date:   Fri, 08 Jan 2021 14:01:31 -0500
Message-ID: <87czyf5jjp.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Could we pause this madness? Scrollback is still useful. I needed it
> today... it was too small, so command results I was looking for
> already scrolled away, but... life will be really painful with 0
> scrollback.

> You'll need it, too... as soon as you get oops and will want to see
> errors just prior to that oops.

> If it means I get to maintain it... I'm not happy about it but that's
> better than no scrollback.

Amen!  What self respecting admin installs a gui on servers?  What do we
have to do to get this back in?  What was so buggy with this code that
it needed to be removed?  Why was it such a burden to just leave it be?

Now excuse me while I go dust off the old ext2 defrag utility and enjoy
watching disk blocks move around the ncurses interface.
