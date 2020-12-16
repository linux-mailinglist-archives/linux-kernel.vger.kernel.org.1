Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800A52DB7C1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgLPAS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgLPASz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 19:18:55 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A0AC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:18:15 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id q137so22300269iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T5QmzgOoeP4SUmIL1zNOjJKDNzzGZxipYccNq8PFO7M=;
        b=Lus2wCU1FkRr0MgFcxgyLdvioHAqJljlRWXBQ7o74VbCh5I46Bh2UZglCG4azwiBcS
         dkdDUiJSZw4M0P/yFeWWSCB4StSboVNN6+AHlufUTuoyDT4uhcCegw1yjGkVaybsy8f/
         +A1z3JDCpw1Aho6CgcmIsR0WK/cBn44BEXlIJ51sUR74pzE4uD+AEl7D/LImkiWX2k1e
         Fc99Tv5A6w3PSVgLOn3XO81ylQ8STLHq5mADC6wDoPcj2xW5TbFov9Gq6formWjkR7ww
         Woxdl4oux9S1ppOvf9ZQupMWx16fCMS9RctPX3oHddxe0INtA8+7DtUbu8/uoX/Pwe7N
         ZXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T5QmzgOoeP4SUmIL1zNOjJKDNzzGZxipYccNq8PFO7M=;
        b=i1soK3Hp95OLRnbLBDKkou1AAAqSdcVUzRdJ3zfVVIb11OdM7ZnBRrT3PhkX8S/YQY
         lj1T53iFNMIH7JYpwqvbN5pJnbqdmZX/9TJ6m8evSVZDGt/ueBfdUFwU2Lhv9Y8uvOZa
         ePH/uHxvbVM0za+7X9F+7fWuPEBQ0hjOgBtabIRILhQ6sruZnDn27fy8Aah1MFvljeDX
         R++e27Jzpc1Oi5MLYdJEz3OywxNTsw+OFicLrRL5STbRw/b4mX1JPaFaj5znAyzTpfJZ
         vanRXMusr4+vsErZJ+UpyUTpQwR9RGY2CsHUNC7Wu7Y9/H29TtwVGT9kWgP9SCIb3vMB
         yPYg==
X-Gm-Message-State: AOAM5331Av0X4cKsDh0KdLMbc750SEw4zB8fOZRb00/LGl71z01VT5l/
        wV3bIFheeb2iGVevsN3ycDhA3A==
X-Google-Smtp-Source: ABdhPJzLDDvU0tcE98mIDOgQvXKlAJoZx3CXaPsT21ctYvqDkh/iEE3QszoIzvgFbJ/QyJYMP5UFkA==
X-Received: by 2002:a02:7152:: with SMTP id n18mr35743366jaf.127.1608077894475;
        Tue, 15 Dec 2020 16:18:14 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id m18sm11748979ioy.44.2020.12.15.16.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 16:18:13 -0800 (PST)
Date:   Tue, 15 Dec 2020 17:18:09 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] mm: enlarge the "int nr_pages" parameter of
 update_lru_size()
Message-ID: <X9lSQfI5SjRI/sz0@google.com>
References: <20201207220949.830352-1-yuzhao@google.com>
 <20201207220949.830352-12-yuzhao@google.com>
 <alpine.LSU.2.11.2012141317351.1925@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2012141317351.1925@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 01:50:16PM -0800, Hugh Dickins wrote:
> On Mon, 7 Dec 2020, Yu Zhao wrote:
> 
> > update_lru_sizes() defines an unsigned long argument and passes it as
> > nr_pages to update_lru_size(). Though this isn't causing any overflows
> > I'm aware of, it's a bad idea to go through the demotion given that we
> > have recently stumbled on a related type promotion problem fixed by
> > commit 2da9f6305f30 ("mm/vmscan: fix NR_ISOLATED_FILE corruption on 64-bit")
> > 
> > Note that the underlying counters are already in long. This is another
> > reason we shouldn't have the demotion.
> > 
> > This patch enlarges all relevant parameters on the path to the final
> > underlying counters:
> > 	update_lru_size(int -> long)
> > 		if memcg:
> > 			__mod_lruvec_state(int -> long)
> > 				if smp:
> > 					__mod_node_page_state(long)
> > 				else:
> > 					__mod_node_page_state(int -> long)
> > 			__mod_memcg_lruvec_state(int -> long)
> > 				__mod_memcg_state(int -> long)
> > 		else:
> > 			__mod_lruvec_state(int -> long)
> > 				if smp:
> > 					__mod_node_page_state(long)
> > 				else:
> > 					__mod_node_page_state(int -> long)
> > 
> > 		__mod_zone_page_state(long)
> > 
> > 		if memcg:
> > 			mem_cgroup_update_lru_size(int -> long)
> > 
> > Note that __mod_node_page_state() for the smp case and
> > __mod_zone_page_state() already use long. So this change also fixes
> > the inconsistency.
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> 
> NAK from me to this 11/11: I'm running happily with your 1-10 on top of
> mmotm (I'll review them n a few days, but currently more concerned with
> Rik's shmem huge gfp_mask), but had to leave this one out.
> 
> You think you are future-proofing with this, but it is present-breaking.
> 
> It looks plausible (though seems random: why these particular functions
> use long but others not? why __mod_memcg_state() long, mod_memcg_state()
> int?), and I was fooled; but fortunately was still testing with memcg
> moving, for Alex's patchset.

My apologies. The patch was fully tested on 4.15. Apparently I didn't
pay enough attention to what's changed in mem_cgroup_move_account() nor
had any test coverage on it when rebasing this patch.

> Soon got stuck waiting in balance_dirty_pages(), /proc/vmstat showing
> nr_anon_pages 2263142822377729
> nr_mapped 125095217474159
> nr_file_pages 225421358649526
> nr_dirty 8589934592
> nr_writeback 1202590842920
> nr_shmem 40501541678768
> nr_anon_transparent_hugepages 51539607554
> 
> That last (anon THPs) nothing to do with this patch, but illustrates
> what Muchun is fixing in his 1/7 "mm: memcontrol: fix NR_ANON_THPS
> accounting in charge moving".
> 
> The rest of them could be fixed by changing mem_cgroup_move_account()'s
> "unsigned int nr_pages" to "long nr_pages" in this patch, but I think
> it's safer just to drop the patch: the promotion of "unsigned int" to
> "long" does not work as you would like it to.
> 
> I see that mm/vmscan.c contains several "unsigned int" counts of pages,
> everything works fine at present so far as I know, and those appeared
> to work even with your patch; but I am not confident in my test coverage,
> and not confident in us being able to outlaw unsigned int page counts in
> future.

I'll just drop this one. Thanks.
