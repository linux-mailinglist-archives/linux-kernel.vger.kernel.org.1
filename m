Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9AE276DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgIXJwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIXJwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:52:10 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1E0C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:52:10 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 99A4DC009; Thu, 24 Sep 2020 11:52:08 +0200 (CEST)
Date:   Thu, 24 Sep 2020 11:51:53 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jianyong Wu <Jianyong.Wu@arm.com>
Cc:     "ericvh@gmail.com" <ericvh@gmail.com>,
        "lucho@ionkov.net" <lucho@ionkov.net>,
        "qemu_oss@crudebyte.com" <qemu_oss@crudebyte.com>,
        "groug@kaod.org" <groug@kaod.org>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Justin He <Justin.He@arm.com>
Subject: Re: [PATCH RFC v2 4/4] 9p: fix race issue in fid contention.
Message-ID: <20200924095153.GA10446@nautica>
References: <20200923141146.90046-1-jianyong.wu@arm.com>
 <20200923141146.90046-5-jianyong.wu@arm.com>
 <20200923144953.GA1685@nautica>
 <HE1PR0802MB25556D1AAF1336F4EE3CA8DBF4390@HE1PR0802MB2555.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HE1PR0802MB25556D1AAF1336F4EE3CA8DBF4390@HE1PR0802MB2555.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianyong Wu wrote on Thu, Sep 24, 2020:
> > Jianyong Wu wrote on Wed, Sep 23, 2020:
> > > open-unlink-f*syscall test:
> > > I have tested for f*syscall include: ftruncate fstat fchown fchmod faccessat.
> >
> > Given the other thread, what did you test this with?
>
> Er, I just use Greg's qemu of https://github.com/gkurz/qemu.git:
> 9p-attr-fixes. I should have referenced it in commit message.

Ok. That branch is fairly old (based on pre-2.7.0 code), so will
need some work as well.
It doesn't look like anyone has time to refresh the patches from what I
just have read so it might fall on you as well...

(I see Greg just made the same point, took a bit too long to write this
mail ;))

> > Since qemu doesn't work apparently do you have a in-house server at arm I
> > could test?
> > (I'll try with ganesha otherwise, it keeps files open so it should work I think...)
>
> Yeah, I test this on my arm server. But as these codes are arch-free, we can test it in whatever a machine.
> (also the server in arm can't be accessed by outer space, so sorry)
> But I think that this test are far from serious and complete.

Yes I meant arm-specific code, not infrastructure. This is fine I'll do
more tests here.
 
> > > +atomic_set(&fid->count, 1);
> >
> > I kind of like the refcount API becauese it has some extra overflow checks;
> > but it requires a bit more work around clunk (instead of bailing out early if
> > counter hits 0, you need to have it call a separate function in case it does)
> >
> > That's mostly esthetics though I'm not going to fuss over that.
>
> Sorry, I'm not sure what's the context of this line, does this line lie in "__add_fid”. I'm not sure about
> why it do harm to clunk?

It's not about clunk, it's about atomic_set/inc/dec
vs. refcount_set/inc/dec -- because refcount has overflow checks.

I've just noticed refcount_dec_and_test that could be used as a drop-in
replacement, so it would be good ot update.

> 
> > > @@ -74,6 +77,7 @@ static struct p9_fid *v9fs_fid_find_inode(struct
> > > inode *inode, kuid_t uid)  void v9fs_open_fid_add(struct inode *inode,
> > > struct p9_fid *fid)  {
> > >  spin_lock(&inode->i_lock);
> > > +atomic_set(&fid->count, 1);
> >
> > Hm, that should be done at fid creation time in net/9p/client.c p9_fid_create ;
> > no ?
> > (you do it there already, I don't see what reseting count here brings except
> > confusion)
> 
> I put this counter set op before the fids are added to hlist. So I can
> make sure the counter value is 1 before fids are used. It's redundant
> code. I can remove it in both "__add_fid" and "v9fs_open_fid_add", but

I'm not sure what you're trying to do.
There are two ways to handle inserting to a list as far as refcounting
goes:
 - consider you add a new reference that will be removed when the fid is
removed from the list ; in that case you should increment the counter
and clunk the fid as usual whne you're done using it in whatever calls
__add_fid and v9fs_open_fid_add
 - or consider it an ownership transfer; then don't increment refcount,
but you must also never use the fid ever again after in the same thread
(because another thread could free the list and clunk) ; so if you still
need to use the fid after adding to the list the first option is better.

I'm not sure a fid could be added to both list in some usage patterns
but if that is the case reseting the count to 1 is most definitely an
error, as both would want to be able to decrement once.

> we must take care of it that no clunk is called between fids are
> created and added to hlist. Both are good for me.

note for this point that if the fid is not in any list it cannot be
accessed by another thread and thus cannot be raced on clunk.



> > > diff --git a/fs/9p/fid.h b/fs/9p/fid.h index
> > > dfa11df02818..1fed96546728 100644
> > > --- a/fs/9p/fid.h
> > > +++ b/fs/9p/fid.h
> > > @@ -22,6 +22,14 @@ static inline struct p9_fid *clone_fid(struct
> > > p9_fid *fid)  }  static inline struct p9_fid *v9fs_fid_clone(struct
> > > dentry *dentry)  {
> > > -return clone_fid(v9fs_fid_lookup(dentry));
> > > +struct p9_fid *fid, *nfid;
> > > +
> > > +fid = v9fs_fid_lookup(dentry);
> > > +if (!fid || IS_ERR(fid))
> > > +return fid;
> > > +
> > > +nfid = p9_client_walk(fid, 0, NULL, 1);
> >
> > I think you clone_fid() here is slightly easier to understand; everyone doesn't
> > know that a walk with no component is a clone.
> > The compiler will optimize that IS_ERR(fid) is checked twice, it's fine.
> >
> Er, I rewrite it because I must acquire the intermedia fid from
> v9fs_fid_lookup and clunk it.

I agree we need to expand clone_fid(lookup()) patterns, this is good.
I'm just saying clone_fid() is easier to understand than
p9_client_walk() with no component.

(so this is a one-for-one replacement)


> > Overall looks good to me.
> > I'd need to spend some time checking the actual counting part & hammering
> > the fs a bit then confirming no fid got forgotten (there's a pr_info at umount
> > time) but I'm happy with this ; thanks!
>
> Yeah, it's a tedious job to do that. Also we need to find a reliable test suit. Then we can check
> this patch both from code and test.

I use a subset of xfstests plus some hand-crafted tests most of which
can be found in https://github.com/phdeniel/sigmund (I no longer use it
though)

I'm sure some xfstests also do open-unlink-whatever tests, just need to
find which :P

-- 
Dominique
