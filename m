Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58421EB386
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 04:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgFBCxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 22:53:04 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:38010 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgFBCxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 22:53:04 -0400
Date:   Mon, 1 Jun 2020 22:53:02 -0400
From:   Rich Felker <dalias@libc.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-ID: <20200602025301.GZ1079@brightrain.aerifal.cx>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org>
 <20200529175335.GK1079@brightrain.aerifal.cx>
 <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
 <20200601181259.GV1079@brightrain.aerifal.cx>
 <20200602013332.GY1079@brightrain.aerifal.cx>
 <20200601194936.244303d858d2d0c47fc87821@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601194936.244303d858d2d0c47fc87821@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 07:49:36PM -0700, Andrew Morton wrote:
> On Mon, 1 Jun 2020 21:33:32 -0400 Rich Felker <dalias@libc.org> wrote:
> 
> > Hmm, it looks like Andrew Morton just pulled most of these into -mm,
> > apparently independently of me getting them in my for-next a few hours
> > ago, since his versions lack my signed-off-by. That's ok though, as
> > long as they go up. Some details since further action is needed on a
> > few:
> 
> It would be better if these were to go via the sh tree.  So please go
> ahead and merge them up - I'll drop my copies when they turn up in
> -next via the sh tree.

OK. That simplifies things a bit. Thanks.

Rich
