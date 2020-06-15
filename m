Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CCD1F9EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 19:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgFOR6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 13:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgFOR6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:58:01 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70F16206F1;
        Mon, 15 Jun 2020 17:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592243881;
        bh=sNn6POHHZDQ9IACdImpskz4O92eeG7vzTpa1ghfyuIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vBF2Zxx90O2zggkzdqrAvirH4V7LShHUF+GDy3ptW5L7oxSbyT8KVN/EdksTccAvq
         uehEHRNxZHyTfjZ9B8RFvonWNW/QM+E0eGz2XLZ8mOvann9+NoXAHxcX/HlQLvQocE
         7gstnuq2N80VfOQLZgPpIUx6uS69D+ihemIeoGcI=
Date:   Mon, 15 Jun 2020 10:58:00 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>, Chao Yu <yuchao0@huawei.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] f2fs: use kfree() instead of kvfree() to free
 superblock data
Message-ID: <20200615175800.GA117170@google.com>
References: <20200605181533.73113-1-efremov@linux.com>
 <20200609221446.24537-1-efremov@linux.com>
 <20200609222546.GA24766@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609222546.GA24766@sol.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09, Eric Biggers wrote:
> On Wed, Jun 10, 2020 at 01:14:46AM +0300, Denis Efremov wrote:
> > Use kfree() instead of kvfree() to free super in read_raw_super_block()
> > because the memory is allocated with kzalloc() in the function.
> > Use kfree() instead of kvfree() to free sbi, raw_super in
> > f2fs_fill_super() and f2fs_put_super() because the memory is allocated
> > with kzalloc().
> > 
> > Fixes: 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed")
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> 
> I don't think "Fixes" is appropriate here.

Agreed. I queued this Cl without it. :)
Thanks,

> 
> kvfree() still works on kmalloc'ed memory; it's just not preferred.
> 
> So this is more a cleanup than a fix.
> 
> - Eric
