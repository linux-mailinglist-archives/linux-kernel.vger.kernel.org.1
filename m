Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFACF2C8A04
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgK3Q4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:56:13 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45579 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728148AbgK3Q4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:56:13 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AUGrdfr005363
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 11:53:40 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6172A420136; Mon, 30 Nov 2020 11:53:39 -0500 (EST)
Date:   Mon, 30 Nov 2020 11:53:39 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     duwe@lst.de, Linus Torvalds <torvalds@linux-foundation.org>,
        Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Willy Tarreau <w@1wt.eu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
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
        Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Petr Tesarik <ptesarik@suse.cz>, simo@redhat.com
Subject: Re: drivers/char/random.c needs a (new) maintainer
Message-ID: <20201130165339.GE5364@mit.edu>
References: <20201130151231.GA24862@lst.de>
 <CAHmME9p4vFGWh7+CKF4f3dw5r+ru5PVG0-vP77JowX8sPhin1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9p4vFGWh7+CKF4f3dw5r+ru5PVG0-vP77JowX8sPhin1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 04:15:23PM +0100, Jason A. Donenfeld wrote:
> I am willing to maintain random.c and have intentions to have a
> formally verified RNG. I've mentioned this to Ted before.
> 
> But I think Ted's reluctance to not accept the recent patches sent to
> this list is mostly justified, and I have no desire to see us rush
> into replacing random.c with something suboptimal or FIPSy.

Being a maintainer is not about *accepting* patches, it's about
*reviewing* them.  I do plan to make time to catch up on reviewing
patches this cycle.  One thing that would help me is if folks
(especially Jason, if you would) could start with a detailed review of
Nicolai's patches.  His incremental approach is I believe the best one
from a review perspective, and certainly his cleanup patches are ones
which I would expect are no-brainers.

						- Ted
