Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019A92B6A76
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgKQQkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:40:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgKQQkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:40:24 -0500
Received: from google.com (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE6CA21D7E;
        Tue, 17 Nov 2020 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605631224;
        bh=dVxDFAXp6FT9+XWoqU4EDdf3Oe33FE/vSylhfLqTJVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AplUYdKVw+5q2guEA+7SSOzhDI0mbCO+QtVbEflBbv070cX030TV4iVc6rUOziYdB
         27J3C+KSf4VJoMOGT0Nk5yUbx4D4xdvGG/KAwfqz3OZScMP4MBGXPAllELo+2XtJhJ
         kMzl/pywyeWOgjdAhxxyB8m69EHSLWVV/GlQjQRo=
Date:   Tue, 17 Nov 2020 08:40:21 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Light Hsieh <Light.Hsieh@mediatek.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid race condition for shinker
 count
Message-ID: <20201117164021.GA1636127@google.com>
References: <20201109170012.2129411-1-jaegeuk@kernel.org>
 <20201112053414.GB3826485@google.com>
 <20201112054051.GA4092972@google.com>
 <4aae85c2-1829-06c0-8fd1-4148100dc0b9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aae85c2-1829-06c0-8fd1-4148100dc0b9@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12, Chao Yu wrote:
> On 2020/11/12 13:40, Jaegeuk Kim wrote:
> > Light reported sometimes shinker gets nat_cnt < dirty_nat_cnt resulting in
> > wrong do_shinker work. Let's avoid to get stale data by using nat_tree_lock.
> > 
> > Reported-by: Light Hsieh <Light.Hsieh@mediatek.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> > v3:
> >   - fix to use NM_I(sbi)
> > 
> >   fs/f2fs/shrinker.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
> > index d66de5999a26..555712ba06d8 100644
> > --- a/fs/f2fs/shrinker.c
> > +++ b/fs/f2fs/shrinker.c
> > @@ -18,7 +18,11 @@ static unsigned int shrinker_run_no;
> >   static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
> >   {
> > -	long count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
> > +	long count;
> > +
> > +	down_read(&NM_I(sbi)->nat_tree_lock);
> > +	count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
> > +	up_read(&NM_I(sbi)->nat_tree_lock);
> >   	return count > 0 ? count : 0;
> 
> Minor thing,
> 
> Just return count is enough? since count should never be smaller than 0.

Yeah, but let me keep this just in case.

> 
> Anyway,
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> Thanks,
> 
> >   }
> > 
