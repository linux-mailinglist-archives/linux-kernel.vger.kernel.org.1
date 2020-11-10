Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5281C2ADFF9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbgKJToG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:44:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgKJToF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:44:05 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A0A820825;
        Tue, 10 Nov 2020 19:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605037445;
        bh=seNybUnu/z66DWRDuPPyP69NxwKQVHVpyPN9eY37It0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwK0m1ZDOh/aPdTFbY070MiBo5SLzbYd7MQgBz8ixdmUB7b+s36x4PTxPMZD0iU1S
         nNPoHgdqo8I50QP6lVW0P1OtiJWF5OTsXB86jXPPEVLEVVAkG8FVPUNETH2WZmHl6t
         O4vOkUwtMbKDwOeA2muP/zuVeDjJpkuPol1Bbu1g=
Date:   Tue, 10 Nov 2020 11:44:03 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v5 2/2] f2fs: fix compat F2FS_IOC_{MOVE,
 GARBAGE_COLLECT}_RANGE
Message-ID: <X6rtgy5Xl7OtrSWE@sol.localdomain>
References: <20201110012437.26482-1-yuchao0@huawei.com>
 <20201110012437.26482-2-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110012437.26482-2-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 09:24:37AM +0800, Chao Yu wrote:
> Eric reported a ioctl bug in below link:
> 
> https://lore.kernel.org/linux-f2fs-devel/20201103032234.GB2875@sol.localdomain/
> 
> That said, on some 32-bit architectures, u64 has only 32-bit alignment,
> notably i386 and x86_32, so that size of struct f2fs_gc_range compiled
> in x86_32 is 20 bytes, however the size in x86_64 is 24 bytes, binary
> compiled in x86_32 can not call F2FS_IOC_GARBAGE_COLLECT_RANGE successfully
> due to mismatched value of ioctl command in between binary and f2fs
> module, similarly, F2FS_IOC_MOVE_RANGE will fail too.
> 
> In this patch we introduce two ioctls for compatibility of above special
> 32-bit binary:
> - F2FS_IOC32_GARBAGE_COLLECT_RANGE
> - F2FS_IOC32_MOVE_RANGE
> 
> Reported-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Reviewed-by: Eric Biggers <ebiggers@google.com>
