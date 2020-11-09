Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF47E2AC366
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgKISMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729807AbgKISMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:12:06 -0500
Received: from gmail.com (unknown [104.132.1.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BDC320644;
        Mon,  9 Nov 2020 18:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604945526;
        bh=tsjnf5mmTj0EScyRB7zrXWKWdSc7EtXrjBjYMukdyA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wk08W6kNcA29qf+RsYjb2LrGwZhhwDSeAhmCxNJn4RCzUGW5OUYPn655TQLeJMlVe
         ZndxtRZ8w2JIvhUauqKK0mf7xb4MpXDIYPENdxJcNOVmX1OfStAU92kXQ3F0UA+zDA
         0wFNS0tflmZ2otx2JfzzijCE/b9ciaSYQmuy5HsA=
Date:   Mon, 9 Nov 2020 10:12:04 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: fix compat F2FS_IOC_{MOVE,
 GARBAGE_COLLECT}_RANGE
Message-ID: <20201109181204.GA1232946@gmail.com>
References: <20201106065331.76236-1-yuchao0@huawei.com>
 <20201106180324.GA78548@sol.localdomain>
 <a7e78b61-021a-444d-eb36-68ce7aae133e@kernel.org>
 <20201107171635.GA841@sol.localdomain>
 <63efaa5c-bc19-4b16-653d-840bc6a6d9d1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63efaa5c-bc19-4b16-653d-840bc6a6d9d1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 10:29:25AM +0800, Chao Yu wrote:
> > Oh I see, the cp-related checks are at the beginning of f2fs_ioctl() too.
> > 
> > In that case a much better approach would be to add __f2fs_ioctl() which is
> > called by f2fs_ioctl() and f2fs_compat_ioctl(), and have f2fs_ioctl() and
> > f2fs_compat_ioctl() do the cp-related checks but not __f2fs_ioctl().
> 
> Will this cleanup make sense to you?

I think it would be better to do it the way I suggested.

- Eric
