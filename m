Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A232A4352
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgKCKle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:41:34 -0500
Received: from nautica.notk.org ([91.121.71.147]:58869 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgKCKld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:41:33 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id AAD5AC01B; Tue,  3 Nov 2020 11:41:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1604400091; bh=gXMvbyFmzw+WHPPo8kBZIq+goTbj33ryWfuToPLkWdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=4lHjFmbkIYxyZHYzzqh54nfYbvRUTMjB1H525D1XITLm35130K97AYSlDxkEQ60u/
         ZmxcFuPCw6t7kt81p+QdqgdVm2ElsPz2QFGEYRuaTJbGAlLXYKXQ+ISnnS3NS0yDqa
         RZeic6/fT6ADxMoL3lpQm1iiZdyFAQYkaEG+R90a3m3U4o9+0Y3w0FZr7Y9jV7jva8
         KCmOuh78VaBzbRNksKc2rCvvnS7qdqN4P6ZUgQ9oK1Rkzp/vwN6886Tf9CXxiVH+yN
         C+jP8K9i+yF5mia9ZteStcoCks0uXVNjG+rhLHNIr8VPBOn1FQSjzNEmO87BOTxNhk
         NTC/eActIX4Ig==
Date:   Tue, 3 Nov 2020 11:41:16 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jianyong Wu <jianyong.wu@arm.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net, qemu_oss@crudebyte.com,
        groug@kaod.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, justin.he@arm.com
Subject: Re: [PATCH RFC v2 4/4] 9p: fix race issue in fid contention.
Message-ID: <20201103104116.GA19587@nautica>
References: <20200923141146.90046-1-jianyong.wu@arm.com>
 <20200923141146.90046-5-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200923141146.90046-5-jianyong.wu@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianyong,

Jianyong Wu wrote on Wed, Sep 23, 2020:
> Eric's and Greg's patch offer a mechanism to fix open-unlink-f*syscall
> bug in 9p. But there is race issue in fid comtention.
> As Greg's patch stores all of fids from opened files into according inode,
> so all the lookup fid ops can retrieve fid from inode preferentially. But
> there is no mechanism to handle the fid comtention issue. For example,
> there are two threads get the same fid in the same time and one of them
> clunk the fid before the other thread ready to discard the fid. In this
> scenario, it will lead to some fatal problems, even kernel core dump.
> 
> I introduce a mechanism to fix this race issue. A counter field introduced
> into p9_fid struct to store the reference counter to the fid. When a fid
> is allocated from the inode or dentry, the counter will increase, and
> will decrease at the end of its occupation. It is guaranteed that the
> fid won't be clunked before the reference counter go down to 0, then
> we can avoid the clunked fid to be used.
> 
> tests:
> race issue test from the old test case:
> for file in {01..50}; do touch f.${file}; done
> seq 1 1000 | xargs -n 1 -P 50 -I{} cat f.* > /dev/null
> 
> open-unlink-f*syscall test:
> I have tested for f*syscall include: ftruncate fstat fchown fchmod faccessat.
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>

Ok so I've finally taken some time to test -- sorry for the delay.
I didn't bother with qemu but the use-after-close f* calls work with
nfs-ganesha and it doesn't introduce any obvious regression with the
current qemu either, so this is good for me.

Greg, Christian - from what I understood (in private, hopefully I'm
allowed to repeat!), he won't be able to contribute to qemu because of
company policies and I'm unlikely to take the time either right now.
I don't think it's a problem to continue as is though, we can land linux
kernel support (it's still useful for non-qemu servers) and if someone
is interested later on they'll just need to finish that bit.


I'm not seeing any obvious problem now so I'll take these patches in
-next within the next few days, with this extra patch on top that
basically applies the requests I had:
 - removing the extra atomic_set in fs/9p/fid.c
 - convert from atomic to refcount API (overflow checks)
 - rename a no-composant walk to clone_fid()

I'll just run some more instrumented tests first to check we're not
leaking anything but so far I haven't found any problem.

If you noticed anything else please speak up.
Thanks for taking the time to finish this! :)
---
 fs/9p/fid.c             | 10 ++++------
 fs/9p/fid.h             |  2 +-
 include/net/9p/client.h |  2 +-
 net/9p/client.c         |  4 ++--
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 89643dabcdae..50118ec72a92 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -28,7 +28,6 @@
 
 static inline void __add_fid(struct dentry *dentry, struct p9_fid *fid)
 {
-	atomic_set(&fid->count, 1);
 	hlist_add_head(&fid->dlist, (struct hlist_head *)&dentry->d_fsdata);
 }
 
@@ -62,7 +61,7 @@ static struct p9_fid *v9fs_fid_find_inode(struct inode *inode, kuid_t uid)
 		}
 	}
 	if (ret && !IS_ERR(ret))
-		atomic_inc(&ret->count);
+		refcount_inc(&ret->count);
 	spin_unlock(&inode->i_lock);
 	return ret;
 }
@@ -77,7 +76,6 @@ static struct p9_fid *v9fs_fid_find_inode(struct inode *inode, kuid_t uid)
 void v9fs_open_fid_add(struct inode *inode, struct p9_fid *fid)
 {
 	spin_lock(&inode->i_lock);
-	atomic_set(&fid->count, 1);
 	hlist_add_head(&fid->ilist, (struct hlist_head *)&inode->i_private);
 	spin_unlock(&inode->i_lock);
 }
@@ -110,7 +108,7 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 		hlist_for_each_entry(fid, h, dlist) {
 			if (any || uid_eq(fid->uid, uid)) {
 				ret = fid;
-				atomic_inc(&ret->count);
+				refcount_inc(&ret->count);
 				break;
 			}
 		}
@@ -201,7 +199,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 	}
 	/* If we are root ourself just return that */
 	if (dentry->d_sb->s_root == dentry) {
-		atomic_inc(&fid->count);
+		refcount_inc(&fid->count);
 		return fid;
 	}
 	/*
@@ -250,7 +248,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 			fid = ERR_PTR(-ENOENT);
 		} else {
 			__add_fid(dentry, fid);
-			atomic_inc(&fid->count);
+			refcount_inc(&fid->count);
 			spin_unlock(&dentry->d_lock);
 		}
 	}
diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 1fed96546728..f7f33509e169 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -28,7 +28,7 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
 	if (!fid || IS_ERR(fid))
 		return fid;
 
-	nfid = p9_client_walk(fid, 0, NULL, 1);
+	nfid = clone_fid(fid);
 	p9_client_clunk(fid);
 	return nfid;
 }
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 58ed9bd306bd..e1c308d8d288 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -149,7 +149,7 @@ enum fid_source {
 struct p9_fid {
 	struct p9_client *clnt;
 	u32 fid;
-	atomic_t count;
+	refcount_t count;
 	int mode;
 	struct p9_qid qid;
 	u32 iounit;
diff --git a/net/9p/client.c b/net/9p/client.c
index a6c8a915e0d8..ba4910138c5b 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -901,7 +901,7 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
 	fid->clnt = clnt;
 	fid->rdir = NULL;
 	fid->fid = 0;
-	atomic_set(&fid->count, 1);
+	refcount_set(&fid->count, 1);
 
 	idr_preload(GFP_KERNEL);
 	spin_lock_irq(&clnt->lock);
@@ -1466,7 +1466,7 @@ int p9_client_clunk(struct p9_fid *fid)
 		dump_stack();
 		return 0;
 	}
-	if (!atomic_dec_and_test(&fid->count))
+	if (!refcount_dec_and_test(&fid->count))
 		return 0;
 
 again:

