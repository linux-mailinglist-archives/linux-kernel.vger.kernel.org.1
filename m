Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 581511A27F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 19:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgDHR2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 13:28:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:37180 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730538AbgDHR2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:28:54 -0400
Received: (qmail 12314 invoked by uid 109); 8 Apr 2020 17:28:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Apr 2020 17:28:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9630 invoked by uid 111); 8 Apr 2020 17:39:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2020 13:39:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Apr 2020 13:28:53 -0400
From:   Jeff King <peff@peff.net>
To:     Joe Perches <joe@perches.com>
Cc:     Olaf Hering <olaf@aepfle.de>, linux-kernel@vger.kernel.org,
        git@vger.kernel.org
Subject: Re: get_maintainer.pl sends bogus addresses to git send-email
Message-ID: <20200408172853.GA1961925@coredump.intra.peff.net>
References: <20200407154046.GA15368@aepfle.de>
 <20200407170257.GA1844923@coredump.intra.peff.net>
 <2e6975d606846c834a387c07ee11cdce52356586.camel@perches.com>
 <20200407174449.GA1884106@coredump.intra.peff.net>
 <2afc201cea5fd59829ce818041b4290a0ec5bb8c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2afc201cea5fd59829ce818041b4290a0ec5bb8c.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 02:56:19PM -0700, Joe Perches wrote:

> > Syntactically they are rfc822 comments, and send-email _should_ be able
> > to handle them (and does in recent versions).
> 
> I'm not certain that comments are allowed _after_ a tld in an
> email address.  In any case, I guess it's a good thing I used
> parentheses for the get_maintainer rolestats block.

Oh, it's much more horrible than that. RFC822 contains this example:

  Muhammed.(I am  the greatest) Ali @(the)Vegas.WBA

which parses to:

  Muhammed.Ali@Vegas.WBA

Perl's Mail::Address does decipher that correctly.

> > > linux-kernel@vger.kernel.org (open list)
> > 
> > In this one, I think that the comment will be used as the name field,
> > since there isn't one.
> 
> I think that slightly unexpected as the name field is not required.

TBH, so do I. That's all done by Mail::Address's format() method. We
could probably convince it to be less magical, but perhaps it's best to
just leave it alone. Presumably that logic has some historical basis,
and as you note, it's a mistake to be passing these fields into
send-email in the first place.

-Peff
