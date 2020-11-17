Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FD32B6620
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbgKQOBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:01:34 -0500
Received: from verein.lst.de ([213.95.11.211]:59557 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733003AbgKQOBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:01:25 -0500
Received: by verein.lst.de (Postfix, from userid 2005)
        id CF5AD6736F; Tue, 17 Nov 2020 15:01:18 +0100 (CET)
Date:   Tue, 17 Nov 2020 15:01:18 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>,
        Willy Tarreau <w@1wt.eu>, linux-crypto@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        And y Lavr <andy.lavr@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>, ardb@kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Tesarik <ptesarik@suse.cz>, simo@redhat.com
Subject: Re: [PATCH v36 00/13] /dev/random - a new approach
Message-ID: <20201117140118.GA31400@lst.de>
References: <20200921075857.4424-1-nstange@suse.de> <2961243.vtBmWVcJkq@tauon.chronox.de> <20201016172619.GA18410@lst.de> <3073852.aeNJFYEL58@positron.chronox.de> <20201028185117.74300988@blackhole.lan> <20201028180728.GA2831268@kroah.com> <20201102154435.71cab8c0@blackhole>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102154435.71cab8c0@blackhole>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 02:44:35PM +0100, Torsten Duwe wrote:
> 
> Ted, if you don't have the time any more to take care of /dev/random,
> it's not a shame to hand over maintainership, especially given your
> long history of Linux contributions.
> 
> Please do seriously consider to hand it over to someone new. This would
> be a good opportunity.

I can see you are quite busy working on ext4, and there is a number of
patches for drivers/char/random.c awaiting review. Wouldn't it be good
to pass it on to someone more enthusiastic?

At least some sort of reply would be appreciated.
Or are you already pondering the request ;-) ?

	Torsten

