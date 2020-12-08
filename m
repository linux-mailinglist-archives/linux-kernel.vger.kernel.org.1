Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E844C2D2695
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgLHIup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:50:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728192AbgLHIup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607417357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FVKEmPz+hR1MOnlGTe8fbrRzGCLUHNQb/QoMNYY2V2c=;
        b=AF0v/M4JXU1iboDsruANS1je4EAUQ3P1hlBzPdwXdl8FaOBU8SMSptFWIin7FSTiSQ8406
        EoZLXC6OKzDZtkQBUHu76k740LmbrS3G0n98PfWL8z9AaD+pUuCkRnMiznhNYbYJcQzJHe
        ynR9nqiCLN5aMsvl69ybm33YxicuHrs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-LVj0QVR8OEaIg7tf8OKuVw-1; Tue, 08 Dec 2020 03:49:16 -0500
X-MC-Unique: LVj0QVR8OEaIg7tf8OKuVw-1
Received: by mail-pl1-f197.google.com with SMTP id e11so6521087pld.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 00:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FVKEmPz+hR1MOnlGTe8fbrRzGCLUHNQb/QoMNYY2V2c=;
        b=Yf82gieWcvs/4ki6wYDg5PcDKRsX7CtazVKBT93mFDtf+gITWaMtbF4WQ6WBG6rcKM
         N8hmHLc/QszsLNku1oY/fPxxXhV+tXh0SE3qB463MBH7SLM1uwjzwh4epYak5dwXUTTO
         x/Ky472aEMKIMTZ+aZKDUU6sbNcdMRfott04Xcu44x4glktEgOtGLDFqe6v6FIpWFYeb
         wCJDWoLHo48taX3U6eZfLp3zqIwZKKZSV0i//KSLnYgcpiBOi8GUAwwPdB3nNJgtvr8N
         iHpMIVTO2q2BJPg5E0zmFUVYM+huu4fdEM4QFPrK761vWrHrrmad4EWgRiq9e0XYhvbq
         CEww==
X-Gm-Message-State: AOAM53363jtgGfEBkK/LVe59EdYWd+9cpWdpLwjuFA8/D92F/GzC53hK
        YP2vHGTn6pGH9sisgYy7BJjzhA/Xmuk2T21FxDGx/E53QzeSfl7YOHruBkvw0AVduqwhyDiZh30
        9kAyLKBSFPDPxP5Wo8OU7QreW
X-Received: by 2002:a17:90b:14d3:: with SMTP id jz19mr3328900pjb.196.1607417355192;
        Tue, 08 Dec 2020 00:49:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVVwLl/tb5ygU0mRdNtU1CDi3sGfGi/JjDj/VNYM/43xNAydkYfbdc6OZgWcOAuFtBetv1xg==
X-Received: by 2002:a17:90b:14d3:: with SMTP id jz19mr3328880pjb.196.1607417354921;
        Tue, 08 Dec 2020 00:49:14 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b8sm14983646pgk.7.2020.12.08.00.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 00:49:14 -0800 (PST)
Date:   Tue, 8 Dec 2020 16:49:04 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2 1/3] erofs: get rid of magical Z_EROFS_MAPPING_STAGING
Message-ID: <20201208084904.GA3060163@xiangao.remote.csb>
References: <20201207012346.2713857-1-hsiangkao@redhat.com>
 <0fc43d3f-9c79-c7a1-6e41-b5b6932fe571@huawei.com>
 <20201208082319.GB3006985@xiangao.remote.csb>
 <7da6fe17-1257-67e7-379c-99a0ebbe6ba4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7da6fe17-1257-67e7-379c-99a0ebbe6ba4@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 04:44:12PM +0800, Chao Yu wrote:
> Hi Xiang,

...

> > 
> > I discussed this case in the original thread,
> > https://lore.kernel.org/r/20200519100612.GA3687@hsiangkao-HP-ZHAN-66-Pro-G1
> > 
> > The previous conclusion is that for EROFS case (see Matthew's reply) this
> > pair won't have too much usage. since EROFS pattern saves extra page
> > reference count (- and +) by cases.
> 
> Alright, I see.

Yeah, yet in order for further confusion (or questions from others), let me
update to use this pair as much as possible in the next version :( (If someone
breaks in the future, I may need to remind him in time though...)

> 

...

> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks for the review!

Thanks,
Gao Xiang

> 
> Thanks,
> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > 
> > > Thanks,
> > > 
> > > >    		}
> > > > @@ -648,12 +649,12 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> > > >    retry:
> > > >    	err = z_erofs_attach_page(clt, page, page_type);
> > > > -	/* should allocate an additional staging page for pagevec */
> > > > +	/* should allocate an additional short-lived page for pagevec */
> > > >    	if (err == -EAGAIN) {
> > > >    		struct page *const newpage =
> > > >    				alloc_page(GFP_NOFS | __GFP_NOFAIL);
> > > > -		newpage->mapping = Z_EROFS_MAPPING_STAGING;
> > > > +		set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
> > > >    		err = z_erofs_attach_page(clt, newpage,
> > > >    					  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
> > > >    		if (!err)
> > > > @@ -710,6 +711,11 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
> > > >    		queue_work(z_erofs_workqueue, &io->u.work);
> > > >    }
> > > > +static bool z_erofs_page_is_invalidated(struct page *page)
> > > > +{
> > > > +	return !page->mapping && !z_erofs_is_shortlived_page(page);
> > > > +}
> > > > +
> > > >    static void z_erofs_decompressqueue_endio(struct bio *bio)
> > > >    {
> > > >    	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
> > > > @@ -722,7 +728,7 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
> > > >    		struct page *page = bvec->bv_page;
> > > >    		DBG_BUGON(PageUptodate(page));
> > > > -		DBG_BUGON(!page->mapping);
> > > > +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> > > >    		if (err)
> > > >    			SetPageError(page);
> > > > @@ -795,9 +801,9 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> > > >    		/* all pages in pagevec ought to be valid */
> > > >    		DBG_BUGON(!page);
> > > > -		DBG_BUGON(!page->mapping);
> > > > +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> > > > -		if (z_erofs_put_stagingpage(pagepool, page))
> > > > +		if (z_erofs_put_shortlivedpage(pagepool, page))
> > > >    			continue;
> > > >    		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
> > > > @@ -831,9 +837,9 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> > > >    		/* all compressed pages ought to be valid */
> > > >    		DBG_BUGON(!page);
> > > > -		DBG_BUGON(!page->mapping);
> > > > +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> > > > -		if (!z_erofs_page_is_staging(page)) {
> > > > +		if (!z_erofs_is_shortlived_page(page)) {
> > > >    			if (erofs_page_is_managed(sbi, page)) {
> > > >    				if (!PageUptodate(page))
> > > >    					err = -EIO;
> > > > @@ -858,7 +864,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> > > >    			overlapped = true;
> > > >    		}
> > > > -		/* PG_error needs checking for inplaced and staging pages */
> > > > +		/* PG_error needs checking for all non-managed pages */
> > > >    		if (PageError(page)) {
> > > >    			DBG_BUGON(PageUptodate(page));
> > > >    			err = -EIO;
> > > > @@ -897,8 +903,8 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> > > >    		if (erofs_page_is_managed(sbi, page))
> > > >    			continue;
> > > > -		/* recycle all individual staging pages */
> > > > -		(void)z_erofs_put_stagingpage(pagepool, page);
> > > > +		/* recycle all individual short-lived pages */
> > > > +		(void)z_erofs_put_shortlivedpage(pagepool, page);
> > > >    		WRITE_ONCE(compressed_pages[i], NULL);
> > > >    	}
> > > > @@ -908,10 +914,10 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> > > >    		if (!page)
> > > >    			continue;
> > > > -		DBG_BUGON(!page->mapping);
> > > > +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> > > > -		/* recycle all individual staging pages */
> > > > -		if (z_erofs_put_stagingpage(pagepool, page))
> > > > +		/* recycle all individual short-lived pages */
> > > > +		if (z_erofs_put_shortlivedpage(pagepool, page))
> > > >    			continue;
> > > >    		if (err < 0)
> > > > @@ -1011,13 +1017,17 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
> > > >    	mapping = READ_ONCE(page->mapping);
> > > >    	/*
> > > > -	 * unmanaged (file) pages are all locked solidly,
> > > > +	 * file-backed online pages in plcuster are all locked steady,
> > > >    	 * therefore it is impossible for `mapping' to be NULL.
> > > >    	 */
> > > >    	if (mapping && mapping != mc)
> > > >    		/* ought to be unmanaged pages */
> > > >    		goto out;
> > > > +	/* directly return for shortlived page as well */
> > > > +	if (z_erofs_is_shortlived_page(page))
> > > > +		goto out;
> > > > +
> > > >    	lock_page(page);
> > > >    	/* only true if page reclaim goes wrong, should never happen */
> > > > @@ -1062,8 +1072,8 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
> > > >    out_allocpage:
> > > >    	page = erofs_allocpage(pagepool, gfp | __GFP_NOFAIL);
> > > >    	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
> > > > -		/* non-LRU / non-movable temporary page is needed */
> > > > -		page->mapping = Z_EROFS_MAPPING_STAGING;
> > > > +		/* turn into temporary page if fails */
> > > > +		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
> > > >    		tocache = false;
> > > >    	}
> > > > diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
> > > > index 68c9b29fc0ca..b503b353d4ab 100644
> > > > --- a/fs/erofs/zdata.h
> > > > +++ b/fs/erofs/zdata.h
> > > > @@ -173,6 +173,7 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
> > > >    	v = atomic_dec_return(u.o);
> > > >    	if (!(v & Z_EROFS_ONLINEPAGE_COUNT_MASK)) {
> > > > +		set_page_private(page, 0);
> > > >    		ClearPagePrivate(page);
> > > >    		if (!PageError(page))
> > > >    			SetPageUptodate(page);
> > > > 
> > > 
> > 
> > .
> > 
> 

