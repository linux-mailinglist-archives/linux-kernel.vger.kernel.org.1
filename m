Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE59F2CE179
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgLCWPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgLCWPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:15:53 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38924C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:15:13 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 7FBBCC009; Thu,  3 Dec 2020 23:15:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1607033711; bh=9RnW75V2ft6CYV2AWxcLJJxN6B3UJUIpbVBcN0U+JaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFVh/CZnaz9Ib5kGBsHdWXhDebaWor4yi8e7e+LvZdveeekJMS+aTgtILS52HamNf
         iXHcwcyzmG6whJcJoECWtn+8y2EiweJigxrzBT0GRHxU7K4eC4NBaL5bs9m6FYrIhh
         NWTn1mTOL42mKL0awS7Q0hMDPNZRkpKZgjMorBfoe+caJwHQ456leuec83W0ghRGaw
         vYLhYkE9JOvNT4tFOiWzbIa2BeAGsbJwPctWOnPpe9VM1tz3uFV5mnRYxpB2gPFe/s
         W4qnNSSTQilGnvY03q1xCewTFmBvuJW1aDAPPWMbYZAELAKQsWXQem+lWUV7D0I3Kn
         dxZlFEbLyloxw==
Date:   Thu, 3 Dec 2020 23:14:56 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] 9p update for 5.10-rc7 (restore splice ops)
Message-ID: <20201203221456.GA20620@nautica>
References: <20201203103315.GA3298@nautica>
 <CAHk-=wigRSokT5YLRGH5Jyun1CwgYHR_1RMcoHjUyz7NJ8wG_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wigRSokT5YLRGH5Jyun1CwgYHR_1RMcoHjUyz7NJ8wG_g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote on Thu, Dec 03, 2020:
> Pulled.

Thanks!

> > (Thanks for letting me know my mails got flagged as spam last time, I've
> > taken the time to setup dkim/dmarc which brings its share of problems
> > with some mailing lists but hopefully will help here)
> 
> It looks good here, but I would suggest you edit your DKIM configuration a bit.
> 
> In particular, you have "List-ID" in your set of header files that
> DKIM hashes, and that means that any mailing list that then adds that
> header will destroy your DKIM hash.

Hmm, good catch, but that one was on me just now -- I just resent the
mail as I got it through the v9fs list to reuse recipients instead of
the one I had sent before so I did send a bogus list-id, which happened
to get signed.
... looking at list archives it looks like majordomo took that to be a
spam and didn't forward the mail at all, that's a discrete way to sneak
a direct mail without any Cc!
I was about to add it to ignored headers for signing but I'll just have
to be careful about that now. Or figure how to make mutt drop it first.


The problems I had with dkim are all lists that add footers so really
not much to do about header filtering (normally lists would change the
from when they do that or change subject, but for some reason the two
I'm thinking of don't, one of the two even strips dkim headers so even
the body length flag (l=) isn't helping)
I haven't had problems with kernel lists which don't mess with key
headers, good job admins.


Anyway, it's a bit off topic -- good to know new mail didn't go to spam
at least :)
-- 
Dominique
