Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A190F2B02EA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgKLKkw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Nov 2020 05:40:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:44342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728061AbgKLKkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:40:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 875D9AC77;
        Thu, 12 Nov 2020 10:40:44 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 594192cf;
        Thu, 12 Nov 2020 10:40:56 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [RFC PATCH] ceph: fix cross quota realms renames with new
 truncated files
References: <20201111153915.23426-1-lhenriques@suse.de>
        <0609b9014d4032e4fc4a8c8b74c935bf0cf4524a.camel@kernel.org>
        <87361feojx.fsf@suse.de>
        <925dda9b15044c8a19ac2017d4b135209e1f6184.camel@kernel.org>
Date:   Thu, 12 Nov 2020 10:40:56 +0000
In-Reply-To: <925dda9b15044c8a19ac2017d4b135209e1f6184.camel@kernel.org> (Jeff
        Layton's message of "Wed, 11 Nov 2020 18:51:36 -0500")
Message-ID: <87v9eadfif.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> On Wed, 2020-11-11 at 18:28 +0000, Luis Henriques wrote:
>> Jeff Layton <jlayton@kernel.org> writes:
>> 
>> > On Wed, 2020-11-11 at 15:39 +0000, Luis Henriques wrote:
>> > > When doing a rename across quota realms, there's a corner case that isn't
>> > > handled correctly.  Here's a testcase:
>> > > 
>> > >   mkdir files limit
>> > >   truncate files/file -s 10G
>> > >   setfattr limit -n ceph.quota.max_bytes -v 1000000
>> > >   mv files limit/
>> > > 
>> > > The above will succeed because ftruncate(2) won't result in an immediate
>> > > notification of the MDSs with the new file size, and thus the quota realms
>> > > stats won't be updated.
>> > > 
>> > > This patch forces a sync with the MDS every time there's an ATTR_SIZE that
>> > > sets a new i_size, even if we have Fx caps.
>> > > 
>> > > Cc: stable@vger.kernel.org
>> > > Fixes: dffdcd71458e ("ceph: allow rename operation under different quota realms")
>> > > URL: https://tracker.ceph.com/issues/36593
>> > > Signed-off-by: Luis Henriques <lhenriques@suse.de>
>> > > ---
>> > >  fs/ceph/inode.c | 11 ++---------
>> > >  1 file changed, 2 insertions(+), 9 deletions(-)
>> > > 
>> > > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
>> > > index 526faf4778ce..30e3f240ac96 100644
>> > > --- a/fs/ceph/inode.c
>> > > +++ b/fs/ceph/inode.c
>> > > @@ -2136,15 +2136,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
>> > >  	if (ia_valid & ATTR_SIZE) {
>> > >  		dout("setattr %p size %lld -> %lld\n", inode,
>> > >  		     inode->i_size, attr->ia_size);
>> > > -		if ((issued & CEPH_CAP_FILE_EXCL) &&
>> > > -		    attr->ia_size > inode->i_size) {
>> > > -			i_size_write(inode, attr->ia_size);
>> > > -			inode->i_blocks = calc_inode_blocks(attr->ia_size);
>> > > -			ci->i_reported_size = attr->ia_size;
>> > > -			dirtied |= CEPH_CAP_FILE_EXCL;
>> > > -			ia_valid |= ATTR_MTIME;
>> > > -		} else if ((issued & CEPH_CAP_FILE_SHARED) == 0 ||
>> > > -			   attr->ia_size != inode->i_size) {
>> > > +		if ((issued & (CEPH_CAP_FILE_EXCL|CEPH_CAP_FILE_SHARED)) ||
>> > > +		    (attr->ia_size != inode->i_size)) {
>> > >  			req->r_args.setattr.size = cpu_to_le64(attr->ia_size);
>> > >  			req->r_args.setattr.old_size =
>> > >  				cpu_to_le64(inode->i_size);
>> > 
>> > Hmm...this makes truncates more expensive when we have caps. I'd rather
>> > not do that if we can help it.
>> 
>> Yeah, as I mentioned in the tracker, there's indeed a performance impact
>> with this fix.  That's what made me add the RFC in the subject ;-)
>> 
>> > What about instead having the client mimic a fsync when there is a
>> > rename across quota realms? If we can't tell that reliably then we could
>> > also just do an effective fsync ahead of any cross-directory rename?
>> 
>> Ok, thanks for the suggestion.  That may actually work, although it will
>> make the rename more expensive of course.  I'll test that tomorrow and
>> eventually follow-up with a patch.
>> 
>
> Patrick pointed out to me on IRC that since you're moving the parent
> directory of the truncated file, flushing the caps on the directory
> won't really help. You'd need to walk the entire subtree and try to
> flush every dirty inode, or basically do a syncfs() prior to renaming
> the directory across quotarealms.
>
> I think we probably will need to revert the change to allow cross-
> quotarealm renames of directories and make those return EXDEV again.
> Anything else sounds like it's probably going to be too expensive.

Hmm... that sounds a bit drastic and it would make the kernel client
behave differently from the fuse client -- from what I could understand
the fuse client does the sync ATTR_SIZE and thus doesn't have this issue.

Obviously, I agree with you that the performance penalty is too high for
such a common operation.  But maybe renames across quotarealms aren't that
common and paying the penalty of doing a full ceph_flush_dirty_caps() is
acceptable for such cases?

Cheers,
-- 
Luis
