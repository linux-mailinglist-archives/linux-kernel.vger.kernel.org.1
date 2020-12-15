Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C466D2DAC60
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgLOLtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:49:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbgLOLtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:49:00 -0500
Date:   Tue, 15 Dec 2020 12:49:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608032899;
        bh=mfR8Fo+LI1Xk1Ba3pEciYHd2QxEYQih8FiozefqP2vc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRuNp5cJ3jp2+WZ+pBPrBUZswmZYtBtaOkfJG5E9PF02Aukva1KsnJ5xndOVOHlTA
         U4ezQei8rbrbqp9nDZHt0B7h6aAzPo2ffZZBwi7L6xVgEiI15/KhzxiMNvLOT1RB0l
         EIMi+MK6ZHKmtIr2YV8p7NbuezczrnXA1/GEY7aI=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Staging/IIO driver changes for 5.11-rc1
Message-ID: <X9iiwr5Lf8l8TOpP@kroah.com>
References: <X9iNTajXvwiLa1bV@kroah.com>
 <20201215223752.42c377d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215223752.42c377d7@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 10:37:52PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Tue, 15 Dec 2020 11:17:49 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > All have been in linux-next for a while with no reported issues.
> 
> There is, however, a semantic conflict with a commit that is now in
> Linus' tree:
> 
> https://lore.kernel.org/lkml/20201207164601.2b9cefc8@canb.auug.org.au/

Ah, I missed that this hit Linus's tree already, I thought it was only
in linux-next.

As I can't fix it without doing the merge myself, either Linus can pull
this directly from lore using 'b4' or I can send it after he does the
merge.

Linus, your call.

thanks,

greg k-h
