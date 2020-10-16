Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91195290619
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407062AbgJPNPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:15:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:44826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404838AbgJPNPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:15:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602854132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bvAhj5rd9TdNJeHXm3trKOnA1tBOciYDggMWpj0b74s=;
        b=GnUJU6yoCfhaA7heEo3YN761vM6a4v/S6AoyAIUE1JTIq02xvo/izHii3S2UTgT0IyAGSj
        j2DdI+fdP0DEYOd7uNGqxuGV6FGDok/QyT2llMJ0mGTHRAoNJwi7Zw03VsE8o0WsrjGiRy
        1Uarp2X6M62vtyAO7wXG7DdBrs4uU4Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6FE7CAB0E;
        Fri, 16 Oct 2020 13:15:32 +0000 (UTC)
Date:   Fri, 16 Oct 2020 15:15:31 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     osalvador@suse.de
Cc:     Shijie Luo <luoshijie1@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linmiaohe@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] mm: fix potential pte_unmap_unlock pte error
Message-ID: <20201016131531.GK22589@dhcp22.suse.cz>
References: <20201015121534.50910-1-luoshijie1@huawei.com>
 <20201016123137.GH22589@dhcp22.suse.cz>
 <f99d9457ae88f3692e57cce86d0e22e8@suse.de>
 <20201016131112.GJ22589@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016131112.GJ22589@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-10-20 15:11:17, Michal Hocko wrote:
> On Fri 16-10-20 14:37:08, osalvador@suse.de wrote:
> > On 2020-10-16 14:31, Michal Hocko wrote:
> > > I do not like the fix though. The code is really confusing. Why should
> > > we check for flags in each iteration of the loop when it cannot change?
> > > Also why should we take the ptl lock in the first place when the look is
> > > broken out immediately?
> > 
> > About checking the flags:
> > 
> > https://lore.kernel.org/linux-mm/20190320081643.3c4m5tec5vx653sn@d104.suse.de/#t
> 
> This didn't really help. Maybe the code was different back then but
> right now the code doesn't make much sense TBH. The only reason to check
> inside the loop would be to have a completely unpopulated address range.
> Note about MPOL_MF_STRICT is not checked explicitly and I do not see how
> it makes any difference.

Ohh, I have missed queue_pages_required. Let me think some more.

-- 
Michal Hocko
SUSE Labs
