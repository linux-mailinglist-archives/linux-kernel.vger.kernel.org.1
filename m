Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D762350D5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 08:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgHAGxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 02:53:11 -0400
Received: from verein.lst.de ([213.95.11.211]:33384 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgHAGxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 02:53:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C9ECF68BFE; Sat,  1 Aug 2020 08:53:08 +0200 (CEST)
Date:   Sat, 1 Aug 2020 08:53:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     josh@joshtriplett.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: inherit TAINT_PROPRIETARY_MODULE v2
Message-ID: <20200801065308.GA1930@lst.de>
References: <20200730061027.29472-1-hch@lst.de> <20200731201146.GA34345@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731201146.GA34345@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[note: private reply now to start a flame fest with the usual suspects]

On Fri, Jul 31, 2020 at 01:11:46PM -0700, josh@joshtriplett.org wrote:
> Christoph Hellwig wrote:
> > we've had a bug in our resolution of _GPL modules since day one, that
> > is a module can claim to be GPL licensed and use _GPL exports, while
> > it also depends on symbols from non-GPL modules.  This is used as a
> > circumvention of the _GPL exports by using a small shim module using
> > the _GPL exports and the other functionality.
> 
> This looks great. You might also consider doing the reverse: if a module
> imports any EXPORT_SYMBOL_GPL symbols, any symbols that module in turn
> exports shouldn't be importable by any module that doesn't explicitly
> claim to be GPL-compatible. Effectively, if a module imports any
> EXPORT_SYMBOL_GPL symbols, all of its exported symbols would then be
> treated as EXPORT_SYMBOL_GPL.
> 
> This would catch the case of attempting to "wrap" EXPORT_SYMBOL_GPL
> symbols in the other direction, by re-exporting the same or similar
> functions to another module. (This would help catch mistakes, not just
> intentional malice.)

I'd personally 100% agree with that, but I'd rather clear it with Linus
privately first.  This would basically make most of the usual
modular subsystems unavailable to proprietary modules as all of them
use _GPL driver core exports, and I suspect he'd cave into the screaming.
