Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CF5239F27
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 07:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgHCFdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 01:33:52 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:39323 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbgHCFdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 01:33:52 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 0735XTuL015640;
        Mon, 3 Aug 2020 07:33:29 +0200
Date:   Mon, 3 Aug 2020 07:33:29 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: powerpc: build failures in Linus' tree
Message-ID: <20200803053329.GA15637@1wt.eu>
References: <20200802204842.36bca162@canb.auug.org.au>
 <20200802172019.GB26677@1wt.eu>
 <20200803034547.GA15501@1wt.eu>
 <20200803141017.55dd6cc7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803141017.55dd6cc7@canb.auug.org.au>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 02:10:17PM +1000, Stephen Rothwell wrote:
> Our mails have crossed.

Ah indeed :-)

> I just sent a more comprehensive patch.  I
> think your patch would require a lot of build testing and even then may
> fail for some CONFIG combination that we didn't test or added in the
> future (or someone just made up).

Your looks far more complete and very likely more future-proof, I
totally agree.

Thanks!
Willy
