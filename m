Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F1126873D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgINIcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:32:21 -0400
Received: from nautica.notk.org ([91.121.71.147]:42460 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgINIcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:32:19 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 77BEFC009; Mon, 14 Sep 2020 10:32:15 +0200 (CEST)
Date:   Mon, 14 Sep 2020 10:32:00 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jianyong Wu <Jianyong.Wu@arm.com>
Cc:     "ericvh@gmail.com" <ericvh@gmail.com>,
        "lucho@ionkov.net" <lucho@ionkov.net>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Justin He <Justin.He@arm.com>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH RFC 4/4] 9p: fix race issue in fid contention.
Message-ID: <20200914083200.GA9259@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <HE1PR0802MB255594D67D97733CFDFE777EF4230@HE1PR0802MB2555.eurprd08.prod.outlook.com>
 <HE1PR0802MB25555E7AAFA66DA3FE025D0AF4230@HE1PR0802MB2555.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianyong Wu wrote on Mon, Sep 14, 2020:
> > Not having exceptions for that will also make the code around
> > fid_atomic_dec much simpler: just have clunk do an atomic dec and only do
> > the actual clunk if that hit zero, and we should be able to get rid of that
> > helper?
> 
> Sorry, I think always-one refcount  won't work at this point, as the
> fid will be clunked only by file context itself not the every consumer
> of every fid. We can't decrease the refcounter at just one static
> point.
> Am I wrong?

I don't understand the "We can't decrease the refcounter at just one
static point".
Basically everywhere you added a fid_atomic_dec() will just need to be
changed to clunk -- the basic rule of refcounting is that anywhere you
take a ref you need to put it back.

All these places take a fid to do some RPC already so it's not a problem
to add a clunk and do one more; especially since the "clunk" will just
be just a deref.
For consistency I'd advocate for the kref API as we use that for
requests already; it might be better to rename the clunk calls to
p9_fid_put or something but I think that's more churn than it's
worth....


Is there anywhere you think cannot do that?

> This enum value is not functionally necessary, but I think it can
> reduce the contention of fid, as there are really lots of scenarios
> that fid from inode is not necessary.

I really don't think it makes things slower if done correctly (e.g. no
waiting as currently done but the last deref does the actual clunk), and
would rather keep code simpler unless the difference is big (so would
need to do an actual benchmark of both if you're convinced it helps) --
sorry.

>> If possible put the patch first in the series so commits can be
>> tested independently.
> 
> Ah, this patch depends on the previous patches, how can I put it as
> the first of the series?

Basically build the logic in the first patch, then either apply the
other three as close as they currently are as possible and add the
missing refcalls in a new patch or incorporate the refcounting in them
as well.
It's fine if you keep it it last, that was just a greedy request on my
part to be able to test async clunk more easily ; forget about it.

-- 
Dominique
