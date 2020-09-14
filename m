Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34679268845
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgINJ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:28:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:34174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgINJ2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:28:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A8BBAF22;
        Mon, 14 Sep 2020 09:28:22 +0000 (UTC)
Date:   Mon, 14 Sep 2020 11:28:04 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     akpm@linux-foundation.org, christian@brauner.io,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] mm/madvise.c: Remove the unused variable in function
 madvise_inject_error
Message-ID: <20200914092800.GA15920@linux>
References: <1600075336-43414-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600075336-43414-1-git-send-email-liuqi115@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 05:22:16PM +0800, Qi Liu wrote:
> Variable zone is unused in function madvise_inject_error, let's remove it.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>

Andrew already fixed that up in my patch.

Thanks anyway

-- 
Oscar Salvador
SUSE L3
