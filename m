Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D789B28759D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgJHOFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:05:46 -0400
Received: from verein.lst.de ([213.95.11.211]:40641 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbgJHOFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:05:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 71C9067373; Thu,  8 Oct 2020 16:05:42 +0200 (CEST)
Date:   Thu, 8 Oct 2020 16:05:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Christoph Hellwig <hch@lst.de>, Joel Becker <jlbec@evilplan.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 02/12] samples: configfs: order includes alphabetically
Message-ID: <20201008140542.GA10275@lst.de>
References: <20200924124526.17365-1-brgl@bgdev.pl> <20200924124526.17365-3-brgl@bgdev.pl> <20201007134323.GA764@lst.de> <CAMRc=Mf8BDyoy+V-S_JQjAZ9+Lt=+5pEYH2ugSL0pbQ5E5Dfrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mf8BDyoy+V-S_JQjAZ9+Lt=+5pEYH2ugSL0pbQ5E5Dfrw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 03:23:11PM +0200, Bartosz Golaszewski wrote:
> On Wed, Oct 7, 2020 at 3:43 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, Sep 24, 2020 at 02:45:16PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > The preferred coding style is to order all includes alphabetically for
> > > improved readability. There's no need for the configfs header to come
> > > last.
> >
> > Is it?  People seem to have all kinds of weird opinions, but I don't
> > think any ordering really makes sense.  What does make sense it dropping
> > the pointless empty line, so I've folded that into the next patch.
> 
> This is not just a baseless opinion, keeping headers sorted clearly
> has an advantage: you more easily avoid duplicating includes, you see
> right away if a header is already included or not. Many maintainers
> will require ordering in new patches.

Various maintainers required all kind of crap.  I've not seen one
I deal with require alphabetic ordering, but I've seen the equally
insane reverse christmas tree.

> It's your call but it's better code with not much effort.

No, it is not in any quantifyable way better.  It is different and you
might prefer that, but in the end change it is just churn.
