Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28A6217FCA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 08:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgGHGsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 02:48:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35181 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgGHGsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:48:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so1752620wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 23:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mx5YFMaHMelX0DtCGXWP469pCIpp8WzwmqgqUlByBHU=;
        b=ixQ4OY231wE/OQAk63hB2aTipApicoaFsp+FafPJg3hz9TXt/Ayo02QeyD61ajqS5h
         kBbayupgi/TYyu9bfVl9FIM+PKdA5S8jC7cidOfKcIYGtIRcooh5hiv/mm7TBUNWC8uS
         MA2yQ1QQHkPHVWFGVTyXMF2kGBwDsLdAC9hGA6YkCdZN9Vab/uq3444LOgsK3xv7DMMF
         Cf3ofrQKgkGd+Hl9xID70mCVq3mKm3FIFybqfLxGRoUBVVVc1EmJJ3gRuL+ruX0BO4bz
         PxdbG2vqXAbwXTJhrxFscoVZWX0oLyeOBHz+t0YXGGn/O5AhLygS7nUrb6F9sIbgwjIM
         S7ig==
X-Gm-Message-State: AOAM533i0gLJnlNzEzS6fU08+7+h3SbM8nYaQ5sD+m3esQk5FKRo8lx+
        4UOQQJkL9JGSSSQpIG50MVc=
X-Google-Smtp-Source: ABdhPJzmh2SOej9nVcwgDxP8syQsxOL3KR2YXmfpJVC2muvh0HrHdelu669erL+dRSAV0WM979gbRg==
X-Received: by 2002:a1c:9c8c:: with SMTP id f134mr7522048wme.142.1594190882655;
        Tue, 07 Jul 2020 23:48:02 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id d201sm4120042wmd.34.2020.07.07.23.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 23:48:01 -0700 (PDT)
Date:   Wed, 8 Jul 2020 08:48:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v4 04/11] mm/hugetlb: make hugetlb migration callback CMA
 aware
Message-ID: <20200708064800.GB7271@dhcp22.suse.cz>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-5-git-send-email-iamjoonsoo.kim@lge.com>
 <20200707113116.GH5913@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707113116.GH5913@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-07-20 13:31:19, Michal Hocko wrote:
> Btw. you are keeping his acks even
> after considerable changes to patches which I am not really sure he is
> ok with.

I am sorry but I have missed the last email from Mike in v3.
-- 
Michal Hocko
SUSE Labs
