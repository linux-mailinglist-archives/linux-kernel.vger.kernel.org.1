Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E492ACF91
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgKJGVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:21:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:50496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJGVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:21:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8EE0BABCC;
        Tue, 10 Nov 2020 06:21:38 +0000 (UTC)
Date:   Tue, 10 Nov 2020 07:21:34 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v5 0/4] HWpoison: further fixes and cleanups
Message-ID: <20201110062134.GA3741@localhost.localdomain>
References: <20201013144447.6706-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013144447.6706-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 04:44:43PM +0200, Oscar Salvador wrote:
> This patchset includes some more fixes and a cleanup.
> 
> Patch#2 and patch#3 are both fixes for taking a HWpoison page off a buddy
> freelist, since having them there has proved to be bad (see [1] and
> pathch#2's commit log).
> Patch#3 does the same for hugetlb pages.
> 
> [1] https://lkml.org/lkml/2020/9/22/565

Hi Andrew, I think this slipped through the cracks.
(Probably because I did not CC you, my bad)

Could you please consider taking this series? It has been already acked
by Naoya.

Thanks


-- 
Oscar Salvador
SUSE L3
