Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61641EC610
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 02:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgFCAEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 20:04:47 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51486 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgFCAEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 20:04:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AA5FC8EE268;
        Tue,  2 Jun 2020 17:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1591142685;
        bh=ZiKQ/cfbDn9jWGCX3Ai/Ywhy9oUSWUU+Sx8hFK1S17w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TEUfUx2ZCDy9g/gjgK89K6I67X3Z+lnqDLnB0x2CXvoavcMKSq4/mi9BZeDEz5wxb
         NxZSPp30B+wjkKkl3OTVd3xR7HvenUjESNFOJwkp9+TFRGdxfLEbfp27EYQKh7iuNI
         W0J7ZAtIcaTrZAMAWnQBK7a76cjBsHgac8VNiw38=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iHPO3SLpc0WE; Tue,  2 Jun 2020 17:04:45 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E35A58EE0F8;
        Tue,  2 Jun 2020 17:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1591142685;
        bh=ZiKQ/cfbDn9jWGCX3Ai/Ywhy9oUSWUU+Sx8hFK1S17w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TEUfUx2ZCDy9g/gjgK89K6I67X3Z+lnqDLnB0x2CXvoavcMKSq4/mi9BZeDEz5wxb
         NxZSPp30B+wjkKkl3OTVd3xR7HvenUjESNFOJwkp9+TFRGdxfLEbfp27EYQKh7iuNI
         W0J7ZAtIcaTrZAMAWnQBK7a76cjBsHgac8VNiw38=
Message-ID: <1591142683.16819.44.camel@HansenPartnership.com>
Subject: Re: kobject_init_and_add is easy to misuse
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Wang Hai <wanghai38@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, khlebnikov@yandex-team.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 02 Jun 2020 17:04:43 -0700
In-Reply-To: <1591134670.16819.18.camel@HansenPartnership.com>
References: <20200602115033.1054-1-wanghai38@huawei.com>
         <20200602121035.GL19604@bombadil.infradead.org>
         <1591111514.4253.32.camel@HansenPartnership.com>
         <20200602173603.GB3579519@kroah.com>
         <1591127656.16819.7.camel@HansenPartnership.com>
         <20200602200756.GA3933938@kroah.com>
         <1591134670.16819.18.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-02 at 14:51 -0700, James Bottomley wrote:
> On Tue, 2020-06-02 at 22:07 +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 02, 2020 at 12:54:16PM -0700, James Bottomley wrote:
> 
> [...]
> > > I think the only way we can make the failure semantics consistent
> > > is to have the kobject_init() ones (so kfree on failure).  That
> > > means for the add part, the function would have to unwind
> > > everything it did from init on so kfree() is still an option.  If
> > > people agree, then I can produce the patch ... it's just the
> > > current drive to transform everyone who's doing kfree() into
> > > kobject_put() would become wrong ...
> > 
> > Everyone should be putting their kfree into the kobject release
> > anyway, right?
> 
> No, that's the problem ... for a static kobject you can't free it;
> and the release path may make assumption which aren't valid depending
> on the kobject state.
> 
> > Anyway, let's see your patch before I start to object further :)
> 
> My first thought was "what?  I got suckered into creating a patch",
> thanks ;-)  But now I look, all the error paths do unwind back to the
> initial state, so kfree() on error looks to be completely correct.

Actually, I spoke too soon.  I did another analysis of the syzkaller
flow in b8eb718348b8 ("net-sysfs: Fix reference count leak in
rx|netdev_queue_add_kobject") and it turns out there is a single piece
of state that's not correctly unwound: the kobj->name which, thanks to
additions after kobject_init_and_add() was created, is now allocated
via kmalloc if it's not a rodata string and is always and freed in
kobject_cleanup via kfree_const().  This problem can be fixed by
unwinding the name allocation at the end of kobject_init_and_add() ...
or it could be unwound in kobject_add_varg, which would also make
kobject_add() unwind correctly.

The unwind step is to kfree_const(kobj->name); kobj->name = NULL; so it
won't interfere if the kobject_put() is called instead of a simple
kfree.

Would you prefer the unwind in kobject_init_and_add() like the patch
below or in kobject_add_varg()?


James

---

diff --git a/lib/kobject.c b/lib/kobject.c
index 65fa7bf70c57..9991baf43d27 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -472,6 +472,10 @@ int kobject_init_and_add(struct kobject *kobj, struct kobj_type *ktype,
 	va_start(args, fmt);
 	retval = kobject_add_varg(kobj, parent, fmt, args);
 	va_end(args);
+	if (retval && kobj->name) {
+		kfree_const(kobj->name);
+		kobj->name = NULL;
+	}
 
 	return retval;
 }
