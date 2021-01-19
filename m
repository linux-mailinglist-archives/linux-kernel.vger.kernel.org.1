Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3B02FC163
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbhASUmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:42:42 -0500
Received: from verein.lst.de ([213.95.11.211]:53456 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390587AbhASUjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:39:14 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6849E68BEB; Tue, 19 Jan 2021 21:38:27 +0100 (CET)
Date:   Tue, 19 Jan 2021 21:38:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: Splicing to/from a tty
Message-ID: <20210119203826.GA31171@lst.de>
References: <20210118081615.GA1397@lst.de> <CAHk-=wgoWjqMoEZ9A7N+MF+urrw2Vyk+PP_FW4BQLAeY9PWARQ@mail.gmail.com> <CAHk-=wg1n2B2dJAzohVdFN4OQCFnnpE7Zbm2gRa8hfGXrReFQg@mail.gmail.com> <CAHk-=wga4M_VLcfkBL0mK-1_mJHYKDzPA48jEOCBgME=nE4O6Q@mail.gmail.com> <CAHk-=whsaDmEch8KR3Qr-KkcxoOhTX5RaEJ529cB2c97fu+=Ag@mail.gmail.com> <CAHk-=wg-1gntaB4xTAsQhvxumOeB_36sFdpVCWgZGLnCUQGUvw@mail.gmail.com> <CAHk-=wjgufiORSuAb270XpGn45jexRjP9SCmcc7AAAZsVrAaPw@mail.gmail.com> <CAHk-=whW7t=3B=iCwYkJ3W-FH08wZNCFO7EJ5qQSqD9Z_tBxrQ@mail.gmail.com> <YAbIVgGt1Qz8ItMh@kroah.com> <CAHk-=wiDX9K0aj6mQsQM54yyJTg2fkzME82aSswB2woFGmW81Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiDX9K0aj6mQsQM54yyJTg2fkzME82aSswB2woFGmW81Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 12:24:22PM -0800, Linus Torvalds wrote:
> But that sysfs binary file case really isn't interesting, and just
> more of a "Christoph broke it, I think he should just fix it".
> Christoph?

I'll give it a spin tomorrow.  Should be simple enough.
