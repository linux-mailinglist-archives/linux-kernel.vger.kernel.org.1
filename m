Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E929E2D299C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 12:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgLHLN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 06:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgLHLN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 06:13:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080B4C061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 03:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k/YWMVCp8Xvx3iJ8GfgpbtQhrzfSCoGjWFcSc3nBKTw=; b=q/8ZULrvyCLiDe1nwkRE9hnW+2
        n8njRcSwHSp1sMYWUaAzH6oKAPVpyzWV1shY2OieTVPGKyYAJLYa0QvsPXUPqoTX3K7W82wuKzcU7
        casDcHJdE7hjdPaF3MMsVyXWt5t99jHMsaAfgBxyFz1jfunwQcVtrKjM8IkWIhbePbBaauncIQfRP
        Ck8CzSlj9ZVu+c7cI86Yz6ANnsIOA/rdvTBJP23FeDr0Cfnr2CkYgDr0tONhhpns7DZ4mHXTHpFDj
        kyRKcCjVDmsXHYDxfmS2Jh8EM9SLRE8gWtHN6GTIedKod1001ojr3MWkJ80ZfQ8nVmlRgeI9mAJuN
        XuvUSEwg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmavg-0007Mn-E1; Tue, 08 Dec 2020 11:13:12 +0000
Date:   Tue, 8 Dec 2020 11:13:12 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Remove dead termiox code
Message-ID: <20201208111312.GA27425@infradead.org>
References: <20201203020331.2394754-1-jannh@google.com>
 <5cca5126-60ba-d123-0f7d-47fdbac4c4db@kernel.org>
 <X8nwnXQKOYWBWBZ+@kroah.com>
 <93834a92-b342-aaee-c400-2883d5df0cdc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93834a92-b342-aaee-c400-2883d5df0cdc@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 09:20:39AM +0100, Jiri Slaby wrote:
> > > > Delete this dead code; but leave the definition of struct termiox in the
> > > > UAPI headers intact.
> > > 
> > > I am thinking -- can/should we mark the structure as deprecated so that
> > > userspace stops using it eventually?
> > 
> > If it doesn't do anything, how can userspace even use it today?  :)
> 
> Well, right. I am in favor to remove it, BUT: what if someone tries that
> ioctl and bails out if EINVAL is returned. I mean: if they define a local
> var of that struct type and pass it to the ioctl, we would break the build
> by removing the struct completely. Even if the code didn't do anything
> useful, it still could be built. So is this very potential breakage OK?

Um, we do guarantee a stable ABI.  We have never guaranteed that all old
crappy code will continue to compile, although we avoid gratious
breakage.  And assuming there ever was code using termiox (which I'm not
sure about to start with) it will surely have some form of feature
check, and I think we are better off with that feature check not
detecting the presence as that would be completely pointless.

Or in short: by keeping the uapi definition we do userspace software a
disfavor.
