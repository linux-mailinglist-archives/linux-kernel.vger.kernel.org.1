Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D432D9DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbgLNRaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440378AbgLNRaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:30:39 -0500
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFA0C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:29:59 -0800 (PST)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1korfY-0004o6-Dt; Mon, 14 Dec 2020 12:29:56 -0500
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 08F3C56016E; Mon, 14 Dec 2020 12:29:56 -0500 (EST)
Date:   Mon, 14 Dec 2020 12:29:55 -0500
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: Linux 5.10
Message-ID: <20201214172955.GA9066@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
References: <CAHk-=whCKhxNyKn1Arut8xUDKTwp3fWcCj_jbL5dbzkUmo45gQ@mail.gmail.com>
 <20201214053147.GA24093@codemonkey.org.uk>
 <X9b9ujh5T6U5+aBY@kroah.com>
 <20201214160247.GA2090@redhat.com>
 <20201214162631.GA2290@redhat.com>
 <6522caad-bfe8-2554-2ba9-dff5856233d1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6522caad-bfe8-2554-2ba9-dff5856233d1@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 10:21:59AM -0700, Jens Axboe wrote:
 
 > >>>> [   87.290698] attempt to access beyond end of device
 > >>>>                md0: rw=4096, want=13996467328, limit=6261202944
 > >>>> [   87.293371] attempt to access beyond end of device
 > >>>>                md0: rw=4096, want=13998564480, limit=6261202944
 > >>>> [   87.296045] BTRFS warning (device md0): couldn't read tree root
 > >>>> [   87.300056] BTRFS error (device md0): open_ctree failed
 > >>>>
 > >>>> Reverting it goes back to the -rc7 behaviour where it mounts fine.
 > >>>
 > >>> If the developer/maintainer(s) agree, I can revert this and push out a
 > >>> 5.10.1, just let me know.
 > >>
 > >> Yes, these should be reverted from 5.10 via 5.10.1:
 > >>
 > >> e0910c8e4f87 dm raid: fix discard limits for raid1 and raid10
 > >> f075cfb1dc59 md: change mddev 'chunk_sectors' from int to unsigned
 > > 
 > > Sorry, f075cfb1dc59 was my local commit id, the corresponding upstream
 > > commit as staged by Jens is:
 > > 
 > > 6ffeb1c3f82 md: change mddev 'chunk_sectors' from int to unsigned
 > > 
 > > So please revert:
 > > 6ffeb1c3f822 md: change mddev 'chunk_sectors' from int to unsigned
 > > and then revert:
 > > e0910c8e4f87 dm raid: fix discard limits for raid1 and raid10
 > 
 > Working with Song on understanding the failure case here. raid6 was
 > tested prior to this being shipped. We'll be back with more soon...

FYI, mixup in my original mail, it was raid5  (I forgot I converted it from
raid6->raid5 a few months back).  But I wouldn't be surprised if they
were both equally affected given what that header touched.

	Dave

