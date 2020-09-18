Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FD327059A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgIRTdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:33:05 -0400
Received: from lobo.ruivo.org ([173.14.175.98]:40946 "EHLO lobo.ruivo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgIRTdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:33:04 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 15:33:03 EDT
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id B329C5315F; Fri, 18 Sep 2020 15:27:40 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tate.lan.ruivo
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.5 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 2410E52EBB;
        Fri, 18 Sep 2020 15:27:24 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id 1D7401A52B6; Fri, 18 Sep 2020 15:27:24 -0400 (EDT)
Date:   Fri, 18 Sep 2020 15:27:24 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        mhocko@kernel.org, tony.luck@intel.com, cai@lca.pw,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 3/7] mm,hwpoison: Try to narrow window race for free
 pages
Message-ID: <20200918192724.GD18315@cathedrallabs.org>
References: <20200917081049.27428-1-osalvador@suse.de>
 <20200917081049.27428-4-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917081049.27428-4-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 10:10:45AM +0200, Oscar Salvador wrote:
> Aristeu Rozanski reported that a customer test case started
> to report -EBUSY after the hwpoison report patchset.
> 
> There is a race window between spotting a free page and taking it off
> its buddy freelist, so it might be that by the time we try to take it off,
> the page has been already allocated.
> 
> This patch tries to handle such race window by trying to handle the new
> type of page again if the page was allocated under us.
> 
> After this patch, Aristeu said the test cases work properly.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reported-by: Aristeu Rozanski <aris@ruivo.org>

Tested-by: Aristeu Rozanski <aris@ruivo.org>

-- 
Aristeu

