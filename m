Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 883591A1BE0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 08:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDHGYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 02:24:18 -0400
Received: from verein.lst.de ([213.95.11.211]:40729 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDHGYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 02:24:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 192AF68C4E; Wed,  8 Apr 2020 08:24:16 +0200 (CEST)
Date:   Wed, 8 Apr 2020 08:24:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Philippe Liard <pliard@google.com>
Cc:     Christoph Hellwig <hch@lst.de>, phillip@squashfs.org.uk,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v3] squashfs: Migrate from ll_rw_block usage to BIO
Message-ID: <20200408062415.GA25951@lst.de>
References: <20191106074238.186023-1-pliard@google.com> <20191106083423.GA10679@lst.de> <20191106083711.GB10679@lst.de> <CAEThQxe2sNuCHoQfa30FVmtYkQ_zJsecdW2wmVmwafvne1RXSg@mail.gmail.com> <CAEThQxeC2qyUr+3EO7o+2p5tziXQ621SqaaxmF3jzheCKjpEkA@mail.gmail.com> <20200402153506.GA13332@lst.de> <CAEThQxfKWGo1TZ7SZ-N6kizbkujWwu3yKXUGDrsVrGjtopVqkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEThQxfKWGo1TZ7SZ-N6kizbkujWwu3yKXUGDrsVrGjtopVqkA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 10:37:15AM +0900, Philippe Liard wrote:
> This is lower priority for us now but I agree that it would be good to land it.
> This is my first patch being approved so I'm not familiar with the next steps.
> Can you land it yourself or is there something more that I should do?

Normally Phillip should pick it up as the squashfs maintainer, but he
has been last active about a year and a half ago.

Andrew, is this something you could pick up through the linux-mm tree?

> 
> 
> On Fri, Apr 3, 2020 at 12:35 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Fri, Nov 15, 2019 at 10:20:33AM +0900, Philippe Liard wrote:
> > > On Wed, Nov 6, 2019 at 6:28 PM Philippe Liard <pliard@google.com> wrote:
> > > >
> > > > On Wed, Nov 6, 2019 at 5:37 PM Christoph Hellwig <hch@lst.de> wrote:
> > > > >
> > > > > Sorry for the empty reply.
> > > > >
> > > > > This was meant to say that the patch looks good to me:
> > > > >
> > > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > >
> > > > Thanks!
> > >
> > > FYI I'm unfortunately no longer observing the 40% impact announced in the
> > > commit description after many optimizations landed in the Chrome OS VM
> > > infrastructure.
> > >
> > > Hopefully moving to BIO is still desirable though. Thank you in any case for
> > > your help/guidance and all the time you spent reviewing this.
> >
> > Do you still plan to submit the patch?  I think it is a major cleanup
> > of the codebase, so I'd like to see it land.
---end quoted text---
