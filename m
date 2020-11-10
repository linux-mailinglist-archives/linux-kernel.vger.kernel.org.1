Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1D82ACE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 05:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbgKJEUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 23:20:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:48582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730520AbgKJEUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 23:20:01 -0500
Received: from google.com (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FB392068D;
        Tue, 10 Nov 2020 04:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604982000;
        bh=mtMkcnOFN4RlUUzRYrCLlt+g/UA6psyljz03o2ED1Wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1iHe+xZRrOfaeHxMTsyj7ALvSlQ+g1dAW1n+znRHzgrx6oY6IDpOepQtrbFD/7WDq
         dWa8dVV7NBTB7dd1uEvab2Kd+S5aq2PBmnhX1FdpopYa38kKl9VZuD5OvjWbklIkFZ
         LM9PUSrbXTbEHV2/tlTQgD1WptoYW/GgF1eq0aO4=
Date:   Mon, 9 Nov 2020 20:19:58 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Light Hsieh <Light.Hsieh@mediatek.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid race condition for shinker count
Message-ID: <20201110041958.GA1598246@google.com>
References: <20201109170012.2129411-1-jaegeuk@kernel.org>
 <f195a4f0-34af-1594-f443-be8ba3058707@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f195a4f0-34af-1594-f443-be8ba3058707@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10, Chao Yu wrote:
> On 2020/11/10 1:00, Jaegeuk Kim wrote:
> > Light reported sometimes shinker gets nat_cnt < dirty_nat_cnt resulting in
> 
> I didn't get the problem clearly, did you mean __count_nat_entries() will
> give the wrong shrink count due to race condition? should there be a lock
> while reading these two variables?
> 
> > wrong do_shinker work. Basically the two counts should not happen like that.
> > 
> > So, I suspect this race condtion where:
> > - f2fs_try_to_free_nats            __flush_nat_entry_set
> >   nat_cnt=2, dirty_nat_cnt=2
> >                                     __clear_nat_cache_dirty
> >                                      spin_lock(nat_list_lock)
> >                                      list_move()
> >                                      spin_unlock(nat_list_lock)
> >   spin_lock(nat_list_lock)
> >   list_del()
> >   spin_unlock(nat_list_lock)
> >   nat_cnt=1, dirty_nat_cnt=2
> >                                     nat_cnt=1, dirty_nat_cnt=1
> 
> nm_i->nat_cnt and nm_i->dirty_nat_cnt were protected by
> nm_i->nat_tree_lock, I didn't see why expanding nat_list_lock range
> will help... since there are still places nat_list_lock() didn't
> cover these two reference counts.

Yeah, I missed nat_tree_lock, and indeed it should cover this. So, the problem
is Light reported subtle case of nat_cnt < dirty_nat_cnt in shrink_count.
We may need to use nat_tree_lock in shrink_count?

> 
> Thanks,
> 
> > 
> > Reported-by: Light Hsieh <Light.Hsieh@mediatek.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/node.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 42394de6c7eb..e8ec65e40f06 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -269,11 +269,10 @@ static void __clear_nat_cache_dirty(struct f2fs_nm_info *nm_i,
> >   {
> >   	spin_lock(&nm_i->nat_list_lock);
> >   	list_move_tail(&ne->list, &nm_i->nat_entries);
> > -	spin_unlock(&nm_i->nat_list_lock);
> > -
> >   	set_nat_flag(ne, IS_DIRTY, false);
> >   	set->entry_cnt--;
> >   	nm_i->dirty_nat_cnt--;
> > +	spin_unlock(&nm_i->nat_list_lock);
> >   }
> >   static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
> > 
