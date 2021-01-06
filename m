Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705412EC0E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbhAFQNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:13:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:45740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbhAFQNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:13:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609949557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kKJzb3MOlxSvTvPOfZX83INGa5Pu51ElYOXk9ozMlRg=;
        b=MtZFWdUlsz4yMYA5uDGxEGeY+iUWLavAZM/D9x6JcWwOoou5yBW3TKZP5ncctO/ExLqR05
        9oEXeegkHPs8LyYhsI5JmnF1flIk+uw/8cf23P3x8hjGeFC9wcXx9LzGUWtVsD71KgMuWv
        2gpOUQvXFHFWuTOTGKkMuwFe60U7qls=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4E31AD75;
        Wed,  6 Jan 2021 16:12:36 +0000 (UTC)
Date:   Wed, 6 Jan 2021 17:12:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        hillf.zj@alibaba-inc.com, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, yongjun_wei@trendmicro.com.cn,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: migrate: do not migrate HugeTLB page whose
 refcount is one
Message-ID: <20210106161236.GQ13207@dhcp22.suse.cz>
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210106161135.GP13207@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106161135.GP13207@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-01-21 17:11:39, Michal Hocko wrote:
> On Mon 04-01-21 14:58:38, Muchun Song wrote:
> > If the refcount is one when it is migrated, it means that the page
> > was freed from under us. So we are done and do not need to migrate.
> 
> Is this common enough that it would warrant the explicit check for each
> migration?

Ups, just noticed that you have posted a newer version. I will follow up
there.

-- 
Michal Hocko
SUSE Labs
