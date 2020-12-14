Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D1E2D92DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 06:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbgLNFlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 00:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbgLNFlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 00:41:00 -0500
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Dec 2020 21:40:19 PST
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2183C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 21:40:19 -0800 (PST)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1kogao-00024t-C0; Mon, 14 Dec 2020 00:40:18 -0500
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id F0BE756016E; Mon, 14 Dec 2020 00:40:17 -0500 (EST)
Date:   Mon, 14 Dec 2020 00:40:17 -0500
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: Linux 5.10
Message-ID: <20201214054017.GA20381@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <CAHk-=whCKhxNyKn1Arut8xUDKTwp3fWcCj_jbL5dbzkUmo45gQ@mail.gmail.com>
 <20201214053147.GA24093@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214053147.GA24093@codemonkey.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
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

Another data point from the md setup in dmesg..

good:

[    4.614957] md/raid:md0: device sdd1 operational as raid disk 3
[    4.614960] md/raid:md0: device sda1 operational as raid disk 0
[    4.614962] md/raid:md0: device sdc1 operational as raid disk 2
[    4.614963] md/raid:md0: device sdf1 operational as raid disk 4
[    4.614964] md/raid:md0: device sdg1 operational as raid disk 1
[    4.615156] md/raid:md0: raid level 5 active with 5 out of 5 devices, algorithm 2
[    4.645563] md0: detected capacity change from 0 to 12001828929536


bad:

[    5.315036] md/raid:md0: device sda1 operational as raid disk 0
[    5.316220] md/raid:md0: device sdd1 operational as raid disk 3
[    5.317389] md/raid:md0: device sdc1 operational as raid disk 2
[    5.318613] md/raid:md0: device sdf1 operational as raid disk 4
[    5.319748] md/raid:md0: device sdg1 operational as raid disk 1
[    5.321155] md/raid:md0: raid level 5 active with 5 out of 5 devices, algorithm 2
[    5.370257] md0: detected capacity change from 0 to 3205735907328

