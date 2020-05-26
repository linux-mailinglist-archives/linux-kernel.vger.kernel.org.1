Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63BA1B23A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 12:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgDUKPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 06:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgDUKPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 06:15:46 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B76232072D;
        Tue, 21 Apr 2020 10:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587464146;
        bh=/qHKDq3x1BKgXgyJGzsD5R8TaA5U9ZIfbNoCLSPaJkE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gT5a173moPBUTXYIvTDlmEjckUuRyohDpJunYr1Ff09RDOYN7u3MF4KLOv2lHNu2s
         8r5tRrjkrrs+67TtQ2uGXlTYXwh+WkVHWvQRxRGe0sYFviTY9yRdUGj79W2oL1Zo2z
         YR/1Lqc7Flr5ImJimhXIBOGJ/OTrRh/gNMtzpWqA=
Message-ID: <86562f7eca48dd13a6cbafa4c6465d3a731fab88.camel@kernel.org>
Subject: Re: [v3] ceph: if we are blacklisted, __do_request returns directly
From:   Jeff Layton <jlayton@kernel.org>
To:     Yanhu Cao <gmayyyha@gmail.com>
Cc:     Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 21 Apr 2020 06:15:44 -0400
In-Reply-To: <CAB9OAC1+E6Qs=hr0naT73MNQ5scKOck4vF2gzsCS=0fQMLvG8A@mail.gmail.com>
References: <20200417110723.12235-1-gmayyyha@gmail.com>
         <ad6ca41f601d4feb2c3bd2850aeab95c3187bf2d.camel@kernel.org>
         <CAB9OAC1+E6Qs=hr0naT73MNQ5scKOck4vF2gzsCS=0fQMLvG8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-21 at 10:13 +0800, Yanhu Cao wrote:
> On Mon, Apr 20, 2020 at 8:16 PM Jeff Layton <jlayton@kernel.org> wrote:
> > On Fri, 2020-04-17 at 19:07 +0800, Yanhu Cao wrote:
> > > If we mount cephfs by the recover_session option,
> > > __do_request can return directly until the client automatically reconnects.
> > > 
> > > Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> > > ---
> > >  fs/ceph/mds_client.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > index 486f91f9685b..16ac5e5f7f79 100644
> > > --- a/fs/ceph/mds_client.c
> > > +++ b/fs/ceph/mds_client.c
> > > @@ -2708,6 +2708,12 @@ static void __do_request(struct ceph_mds_client *mdsc,
> > > 
> > >       put_request_session(req);
> > > 
> > > +     if (mdsc->fsc->blacklisted &&
> > > +         ceph_test_mount_opt(mdsc->fsc, CLEANRECOVER)) {
> > > +             err = -EBLACKLISTED;
> > > +             goto finish;
> > > +     }
> > > +
> > 
> > Why check for CLEANRECOVER? If we're mounted with recover_session=no
> > wouldn't we want to do the same thing here?
> > 
> > Either way, it's still blacklisted. The only difference is that it won't
> > attempt to automatically recover the session that way.
> 
> I think mds will clear the blacklist. In addition to loading cephfs
> via recover_session=clean, I didn't find a location where
> fsc->blacklisted is set to false. If the client has been blacklisted,
> should it always be blacklisted (fsc->blacklisted=true)? Or is there
> another way to set fsc->blacklised to false?
> 

Basically, this patch is just changing it so that when the client is
blacklisted and the mount is done with recover_session=clean, we'll
shortcut the rest of the __do_request and just return -EBLACKLISTED.

My question is: why do we need to test for recover_session=clean here? 

If the client _knows_ that it is blacklisted, why would it want to
continue with __do_request in the recover_session=no case? Would it make
more sense to always return early in __do_request when the client is
blacklisted?


> > 
> > >       mds = __choose_mds(mdsc, req, &random);
> > >       if (mds < 0 ||
> > >           ceph_mdsmap_get_state(mdsc->mdsmap, mds) < CEPH_MDS_STATE_ACTIVE) {
> > --
> > Jeff Layton <jlayton@kernel.org>
> > 

-- 
Jeff Layton <jlayton@kernel.org>

