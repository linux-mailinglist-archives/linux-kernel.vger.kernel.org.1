Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE93D1B87AD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 18:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgDYQXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 12:23:00 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:46346 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgDYQXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 12:23:00 -0400
Date:   Sat, 25 Apr 2020 12:22:59 -0400
From:   Rich Felker <dalias@libc.org>
To:     Rob Landley <rob@landley.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-sh@vger.kernel.org
Subject: Re: [PATCHv3 31/50] sh: Add loglvl to printk_address()
Message-ID: <20200425162259.GK11469@brightrain.aerifal.cx>
References: <20200418201944.482088-1-dima@arista.com>
 <20200418201944.482088-32-dima@arista.com>
 <20200420155237.1b6532c0d0c6940fccd1b762@linux-foundation.org>
 <92cf0382-bdb4-6966-5a77-2ade50fdc451@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92cf0382-bdb4-6966-5a77-2ade50fdc451@landley.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 11:06:41AM -0500, Rob Landley wrote:
> On 4/20/20 5:52 PM, Andrew Morton wrote:
> > I guess it doesn't matter much, as sh seems to be rather dead.
> 
> The j-core guys are using it.

Yes. There are also Debian/SH folks using classic SH4.

Rich
