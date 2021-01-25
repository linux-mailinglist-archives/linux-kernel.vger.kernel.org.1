Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC89E302A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 19:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbhAYScK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 13:32:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:58478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbhAYSbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:31:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611599467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uqGPhwP3Lp8NPepOOe5fR+cd2R65FBDmRR/EArzQzA8=;
        b=ua3+I4lEcHFW3ioskhY8N98ODDCWluL0+MzmmP+epwSO6nGcXihX+PJVNhmyrVHO2Ns7XR
        PsfPk6klzDOztgREfEaDFQ9LJdnxIZSwzg74N8LwVaYcGOV1KZfTj7mUijLPk2YPRgD0Mi
        qyLaWMTT9MktCvWnX0Ksi8a4xVAF9Dk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1EB7DAE1F;
        Mon, 25 Jan 2021 18:31:07 +0000 (UTC)
Date:   Mon, 25 Jan 2021 19:31:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Adding missing mem_cgroup_uncharge() to
 __add_to_page_cache_locked()
Message-ID: <20210125183105.GW827@dhcp22.suse.cz>
References: <20210125042441.20030-1-longman@redhat.com>
 <20210125092815.GB827@dhcp22.suse.cz>
 <de87d009-985a-87d3-08fb-c688e23d60a9@redhat.com>
 <20210125160328.GP827@dhcp22.suse.cz>
 <20210125162506.GF308988@casper.infradead.org>
 <20210125164118.GS827@dhcp22.suse.cz>
 <20210125181436.GV827@dhcp22.suse.cz>
 <53eb7692-e559-a914-e103-adfe951d7a7c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53eb7692-e559-a914-e103-adfe951d7a7c@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25-01-21 13:23:58, Waiman Long wrote:
> On 1/25/21 1:14 PM, Michal Hocko wrote:
[...]
> > With the proposed simplification by Willy
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thank for the ack. However, I am a bit confused about what you mean by
> simplification. There is another linux-next patch that changes the condition
> for mem_cgroup_charge() to

This is obviously a fix and I believe should go in the next rc while
secretmem is a new feature which should wait at least to the next merge
window.

> -       if (!huge) {
> +       if (!huge && !page_is_secretmem(page)) {
>                 error = mem_cgroup_charge(page, current->mm, gfp);
> 
> That is the main reason why I introduced the boolean variable as I don't
> want to call the external page_is_secretmem() function twice.
> 
> Cheers,
> Longman
> 

-- 
Michal Hocko
SUSE Labs
