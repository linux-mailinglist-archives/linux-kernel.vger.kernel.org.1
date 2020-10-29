Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937AF29E7B0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgJ2Jqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:46:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:34018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgJ2Jqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:46:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603964794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pbFAaKUl5VVAmcWFZZmKE80nI9sV5y+La5sGN9xUtVc=;
        b=sutn2z9kOlCvRIu2OixH9GRLYAO/8JtPPlOFqzJOadGqkabIkypNJSZ7go4xoap700td9B
        LWmESx/EUyokxucQf+KERqd3D+iLWenqRG1uz+PDdwMkkP+if/6xgwPRTBUj/ueKDlWrPy
        /MCwgMwMV6sTYJooNFz8DXib0KpuYfM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BC367ACA1;
        Thu, 29 Oct 2020 09:46:34 +0000 (UTC)
Date:   Thu, 29 Oct 2020 10:46:33 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: Fix a race during split THP
Message-ID: <20201029094633.GE17500@dhcp22.suse.cz>
References: <20201009073647.1531083-1-ying.huang@intel.com>
 <20201027102519.GR20500@dhcp22.suse.cz>
 <20201028154346.d8144f8ad7040e6b17592c58@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028154346.d8144f8ad7040e6b17592c58@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-10-20 15:43:46, Andrew Morton wrote:
> On Tue, 27 Oct 2020 11:25:19 +0100 Michal Hocko <mhocko@suse.com> wrote:
> 
> > I have noticed this fix and I do not see it in the mmotm tree.
> > Is there anything blocking this patch or it simply fall through cracks?
> 
> It's merged into mainline.  Perhaps the grammatical fixlet in
> the title tricked you...
> 
> commit c4f9c701f9b44299e6adbc58d1a4bb2c40383494
> Author:     Huang Ying <ying.huang@intel.com>
> AuthorDate: Thu Oct 15 20:06:07 2020 -0700
> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> CommitDate: Fri Oct 16 11:11:15 2020 -0700
> 
>     mm: fix a race during THP splitting

Thanks! I was pretty sure I've checked for the acutal code but myabe I
was just looking incorrectly. Thanks for the clarification!
-- 
Michal Hocko
SUSE Labs
