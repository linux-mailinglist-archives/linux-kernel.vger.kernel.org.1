Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5602813E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387911AbgJBNRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:17:09 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:42337 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733260AbgJBNRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:17:09 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 092DFt0G003851;
        Fri, 2 Oct 2020 15:15:55 +0200
Date:   Fri, 2 Oct 2020 15:15:55 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Torsten Duwe <duwe@lst.de>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-crypto@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Andy Lavr <andy.lavr@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [DISCUSSION PATCH 00/41] random: possible ways towards NIST
 SP800-90B compliance
Message-ID: <20201002131555.GD3783@1wt.eu>
References: <20200921075857.4424-1-nstange@suse.de>
 <20201002123836.GA14807@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002123836.GA14807@lst.de>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 02:38:36PM +0200, Torsten Duwe wrote:
> Almost two weeks passed and these are the "relevant" replies:
> 
> Jason personally does not like FIPS, and is afraid of
> "subpar crypto". Albeit this patch set strictly isn't about
> crypto at all; the crypto subsystem is in the unlucky position
> to just depend on a good entropy source.
> 
> Greg claims that Linux (kernel) isn't about choice, which is clearly
> wrong.

I think there's a small misunderstanding here, my understanding is
that for quite a while, the possibilities offered by the various
random subsystems or their proposed derivative used to range from
"you have to choose between a fast system that may be vulnerable
to some attacks, a system that might not be vulnerable to certain
attacks but might not always boot, or a slow system not vulnerable
to certain attacks". Greg's point seems to be that if we add an
option, it means it's yet another tradeoff between these possibilities
and that someone will still not be happy at the end of the chain. If
the proposed solution covers everything at once (performance,
reliability, unpredictability), then there probably is no more reason
for keeping alternate solutions at all, hence there's no need to give
the user the choice between multiple options when only one is known
to always be valid. At least that's how I see it and it makes sense
to me.

> And this is all ???

Possibly a lot of people got used to seeing the numerous versions
and are less attentive to new series, it's possible that your message
will wake everyone up.

Regards,
Willy
