Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB75C2F351C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392132AbhALQLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:11:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391713AbhALQLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:11:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C17C32087D;
        Tue, 12 Jan 2021 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610467843;
        bh=pHC5Rp2JwAmBkODskotGkfwkAJtGSBIb5ZrGFGrxlNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lNS3Ua/OFw8+Gog4zKG130cPD0li8/cMKV0SQ1U8tWXlhjojpj8tVSS/YLRSTizCt
         lw0pgfoRDINX1ZDF8vuI5AMdrFN3FTL+uoib7Ok+Eg6FcJmYZUGHqCJreOaZut9bEO
         pS25yonu47fB2eTkifMhSW1DlmxjyyZlt/9kzG1w=
Date:   Tue, 12 Jan 2021 17:11:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Phillip Susi <phill@thesusis.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
Message-ID: <X/3KR80YekApObf8@kroah.com>
References: <20200916205434.GA10389@duo.ucw.cz>
 <87czyf5jjp.fsf@vps.thesusis.net>
 <CAHk-=wjsjC1h7fskwYaaRLykN1ms6ZtxGvucQgmL-zZTfxPdBA@mail.gmail.com>
 <87bldujj1r.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bldujj1r.fsf@vps.thesusis.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:00:09AM -0500, Phillip Susi wrote:
> 
> Linus Torvalds writes:
> 
> > It really was buggy, with security implications. And we have no maintainers.
> 
> Could you be more specific?  I can't try to fix it if I don't understand
> what is wrong with it.  Are there any bug reports or anything I could
> look at?

Along with what Daniel has already pointed out, just look at all of the
old syzbot reports for the code in this area.  Try fixing one of those
reports in an older kernel to give yourself an idea of the issues
involved.

Best of luck!

greg k-h
