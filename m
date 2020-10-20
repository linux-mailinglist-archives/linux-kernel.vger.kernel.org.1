Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E9E281AB4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbgJBSQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:16:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37605 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbgJBSQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:16:09 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 092IEIPI018984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Oct 2020 14:14:19 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9E71642003C; Fri,  2 Oct 2020 14:14:18 -0400 (EDT)
Date:   Fri, 2 Oct 2020 14:14:18 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Van Leeuwen, Pascal" <pvanleeuwen@rambus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Torsten Duwe <duwe@lst.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
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
Message-ID: <20201002181418.GV23474@mit.edu>
References: <20200921075857.4424-1-nstange@suse.de>
 <20201002123836.GA14807@lst.de>
 <CY4PR0401MB365298FA8C0C53EAF2D66705C3310@CY4PR0401MB3652.namprd04.prod.outlook.com>
 <20201002140428.GC3475053@kroah.com>
 <CY4PR0401MB365240353B6AB3B2045C9F89C3310@CY4PR0401MB3652.namprd04.prod.outlook.com>
 <20201002151300.GC5212@kroah.com>
 <CY4PR0401MB3652EA0FFA3CD9679172B02CC3310@CY4PR0401MB3652.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR0401MB3652EA0FFA3CD9679172B02CC3310@CY4PR0401MB3652.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 03:39:35PM +0000, Van Leeuwen, Pascal wrote:
> > Then your company can not contribute in Linux kernel development, as
> > this is obviously not allowed by such a footer.
> >
> Interesting, this has never been raised as a problem until today ...
> Going back through my mail archive, it looks like they started automatically adding that some
> 3 months ago. Not that they informed anyone about that, it just silently happened.

So use a private e-mail address (e.g., at fastmail.fm if you don't
want to run your mail server) and then tunnel out SMTP requests using
ssh.  It's not hard.  :-)

I've worked a multiple $BIG_COMPANY's, and I've been doing this for
decades.  It's also helpful when I need to send e-mails from
conference networks from my laptop....

						- Ted
