Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F832EC0E5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbhAFQOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:14:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:46258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbhAFQOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:14:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609949608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AOi5pYVGtWhmhkLhxN1VHSlGmbztJKzjsiPHFHewBmU=;
        b=aGj1bDy/JRpCkftBmuSI0gD7ypZdqUNoo4G9LvTymw2LI1WrDXgAZ9/bEyFDpnW6+GZw7B
        pwhAIRUOEbjz+RdURkBn09vdDGFeBeQQ1IwogZx6i/Zgl+uRnBj6arBNX2uX9aVxa5tc+x
        twevcxVsyXJk391Qp5lhfZRmBwTLamM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B9100B76C;
        Wed,  6 Jan 2021 16:13:28 +0000 (UTC)
Date:   Wed, 6 Jan 2021 17:13:27 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v2 1/6] mm: migrate: do not migrate HugeTLB page whose
 refcount is one
Message-ID: <20210106161327.GR13207@dhcp22.suse.cz>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106084739.63318-2-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-01-21 16:47:34, Muchun Song wrote:
> If the refcount is one when it is migrated, it means that the page
> was freed from under us. So we are done and do not need to migrate.

Is this common enough that it would warrant the explicit check for each
migration?
-- 
Michal Hocko
SUSE Labs
