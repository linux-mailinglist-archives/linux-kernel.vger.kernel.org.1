Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8202F2D9300
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 06:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403865AbgLNFxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 00:53:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgLNFxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 00:53:42 -0500
Date:   Mon, 14 Dec 2020 06:52:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607925182;
        bh=SoiheqCI9PIiKWpVjyXjG6Sn5NCVQc3Mxb3Mboyp9XI=;
        h=From:To:Subject:References:In-Reply-To:From;
        b=I9RkWVsDnRHa6i1jZQQ6+NM0Hu/LXJbdeEYnxBmtdkqhLofqsVy5AWdLXD4fiZ9Ge
         QbWdfxYF1F4BI3Si17BOv2rEIEPLwWUXoeHHmTTLAR/ZQ2htpEecCk1VR9RF5fZhfS
         +gHFBisOTIS7XPmMJ0sGBGel1/LE4+ZiTh8y71i8=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: Linux 5.10
Message-ID: <X9b9ujh5T6U5+aBY@kroah.com>
References: <CAHk-=whCKhxNyKn1Arut8xUDKTwp3fWcCj_jbL5dbzkUmo45gQ@mail.gmail.com>
 <20201214053147.GA24093@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214053147.GA24093@codemonkey.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 12:31:47AM -0500, Dave Jones wrote:
> On Sun, Dec 13, 2020 at 03:03:29PM -0800, Linus Torvalds wrote:
>  > Ok, here it is - 5.10 is tagged and pushed out.
>  > 
>  > I pretty much always wish that the last week was even calmer than it
>  > was, and that's true here too. There's a fair amount of fixes in here,
>  > including a few last-minute reverts for things that didn't get fixed,
>  > but nothing makes me go "we need another week".
> 
> ...
> 
>  > Mike Snitzer (1):
>  >       md: change mddev 'chunk_sectors' from int to unsigned
> 
> Seems to be broken.  This breaks mounting my raid6 partition:
> 
> [   87.290698] attempt to access beyond end of device
>                md0: rw=4096, want=13996467328, limit=6261202944
> [   87.293371] attempt to access beyond end of device
>                md0: rw=4096, want=13998564480, limit=6261202944
> [   87.296045] BTRFS warning (device md0): couldn't read tree root
> [   87.300056] BTRFS error (device md0): open_ctree failed
> 
> Reverting it goes back to the -rc7 behaviour where it mounts fine.

If the developer/maintainer(s) agree, I can revert this and push out a
5.10.1, just let me know.

thanks,

greg k-h
