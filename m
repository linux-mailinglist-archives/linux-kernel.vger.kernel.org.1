Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5866529051B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 14:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407569AbgJPMhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 08:37:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:37288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407562AbgJPMhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:37:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 679EAAC1F;
        Fri, 16 Oct 2020 12:37:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 16 Oct 2020 14:37:08 +0200
From:   osalvador@suse.de
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shijie Luo <luoshijie1@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linmiaohe@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] mm: fix potential pte_unmap_unlock pte error
In-Reply-To: <20201016123137.GH22589@dhcp22.suse.cz>
References: <20201015121534.50910-1-luoshijie1@huawei.com>
 <20201016123137.GH22589@dhcp22.suse.cz>
User-Agent: Roundcube Webmail
Message-ID: <f99d9457ae88f3692e57cce86d0e22e8@suse.de>
X-Sender: osalvador@suse.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-16 14:31, Michal Hocko wrote:
> I do not like the fix though. The code is really confusing. Why should
> we check for flags in each iteration of the loop when it cannot change?
> Also why should we take the ptl lock in the first place when the look 
> is
> broken out immediately?

About checking the flags:

https://lore.kernel.org/linux-mm/20190320081643.3c4m5tec5vx653sn@d104.suse.de/#t

