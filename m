Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDE02C4F61
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 08:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbgKZHYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 02:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388494AbgKZHYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:24:08 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2BCC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 23:24:07 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id u21so831750iol.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 23:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lY9WcgjRAuSB1sVe9pZbMqYNGAqE5NKeMBySD6KNPgU=;
        b=JYF1Mmahz+3wxs+0JH7ie0ol7o/QwIWB5CtProBINGMk6+GxuRiUnhWdAWsdikHSjN
         EqbXDga1k7V7YwhliWSUdlzsY2AmIWsGeuaaLKxI5mtxgAY2T6+0zx7QGm+G86+K+gD0
         ZGlVSEIsvXiJ58R6J3w3mrpEJABMSWyj/icc198AbtvDzbBCo5V2bDuYKfFuU6ANQGcQ
         VdxVMsBDrxDNf68eLssoAbj6ma4SKGqw76oYm9YIvtKiAnOTDZqe3p4PclWdn2Zo8Kr9
         Oguhq5Gb87mRKWMMwhF5kMVlRFpOSIgGdAVJ4UM4WzboJ3cWBwKktupE+MaqXQco4YBY
         L9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lY9WcgjRAuSB1sVe9pZbMqYNGAqE5NKeMBySD6KNPgU=;
        b=ZHZUUSLDSnbwuNm8U00zEp5vADBluMUqV89ZS7f9qd9mLQloF+Qe6qjtc9bszwL5pW
         IU4in+pAyumhlar34tdUiUpDQu+sANvB50d1bV1qqTXZSvdPzvcSqrRoEWBC8bvxKb4+
         eu0BXVA6ieMjL/PP8cu/9wYcCtYb7zGdj/9FA5egOjinC4I2PPXH9oeyu3p7n1/5yztj
         j0hlnD4GUeIAw8ijoEL6NJUb30P5Fl+rtEJjloae+cM31H9QyxHWHgsmwhTKgMvl/fhX
         Ji1+ZlgqNnq/9kCFpm9ZoAjrPuf5fL24w2XwjnoKYFrCBS8zoVIORm0/swln1GZoKyf+
         Sa8g==
X-Gm-Message-State: AOAM533l/43/m1md5CEzFjCeAhR5ksoggj3AT7vjzZWVci+yfHHyVN4m
        Olrybw3TzXifli/WNXf4k0yQWw==
X-Google-Smtp-Source: ABdhPJzgcfvi/KBVN0+6c0Cgk2ld8KZLlmLpg5BCZ+fm4AdqaMf3bq0Ma8e86OLnbIVWm/BOgFQ2AQ==
X-Received: by 2002:a02:3716:: with SMTP id r22mr2065414jar.104.1606375447069;
        Wed, 25 Nov 2020 23:24:07 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id i77sm284789ioa.54.2020.11.25.23.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 23:24:06 -0800 (PST)
Date:   Thu, 26 Nov 2020 00:24:02 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] mm/swap.c: reduce lock contention in lru_cache_add
Message-ID: <20201126072402.GA1047005@google.com>
References: <1605860847-47445-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201126045234.GA1014081@google.com>
 <ed19e3f7-33cb-20ae-537e-a7ada2036895@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed19e3f7-33cb-20ae-537e-a7ada2036895@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 02:39:03PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/11/26 下午12:52, Yu Zhao 写道:
> >>   */
> >>  void __pagevec_lru_add(struct pagevec *pvec)
> >>  {
> >> -	int i;
> >> -	struct lruvec *lruvec = NULL;
> >> +	int i, nr_lruvec;
> >>  	unsigned long flags = 0;
> >> +	struct page *page;
> >> +	struct lruvecs lruvecs;
> >>  
> >> -	for (i = 0; i < pagevec_count(pvec); i++) {
> >> -		struct page *page = pvec->pages[i];
> >> +	nr_lruvec = sort_page_lruvec(&lruvecs, pvec);
> > Simply looping pvec multiple times (15 at most) for different lruvecs
> > would be better because 1) it requires no extra data structures and
> > therefore has better cache locality (theoretically faster) 2) it only
> > loops once when !CONFIG_MEMCG and !CONFIG_NUMA and therefore has no
> > impact on Android and Chrome OS.
> > 
> 
> With multiple memcgs, it do help a lot, I had gotten 30% grain on readtwice
> case. but yes, w/o MEMCG and NUMA, it's good to keep old behavior. So 
> would you like has a proposal for this?

Oh, no, I'm not against your idea. I was saying it doesn't seem
necessary to sort -- a nested loop would just do the job given
pagevec is small.

diff --git a/mm/swap.c b/mm/swap.c
index cb3794e13b48..1d238edc2907 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -996,15 +996,26 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
  */
 void __pagevec_lru_add(struct pagevec *pvec)
 {
-	int i;
+	int i, j;
 	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
 
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
 
+		if (!page)
+			continue;
+
 		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
-		__pagevec_lru_add_fn(page, lruvec);
+
+		for (j = i; j < pagevec_count(pvec); j++) {
+			if (page_to_nid(pvec->pages[j]) != page_to_nid(page) ||
+			    page_memcg(pvec->pages[j]) != page_memcg(page))
+				continue;
+
+			__pagevec_lru_add_fn(pvec->pages[j], lruvec);
+			pvec->pages[j] = NULL;
+		}
 	}
 	if (lruvec)
 		unlock_page_lruvec_irqrestore(lruvec, flags);
