Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DD22A0BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgJ3Q4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:56:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:32814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbgJ3Qz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:55:59 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A428C20791;
        Fri, 30 Oct 2020 16:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604076957;
        bh=c3kxm2crOyIhGs6VOfq3cufvcTi+w7SfUEUvU1r33rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z/dVtz0GT9NCTXiOc18KE1Mhboa1bxEbGpKvoXfSVKJsFwObuazYrrrC3xCvXH6CV
         Db40/4bQmyR9UKW2S2nHgfys9p/oFsDg1NL35ejqJB8Nd/cLoc1V5SeAhG0+34WkYx
         /vrsq8CmcHZTVbePOkTzfJ8cxf1QjQlEGLOvOADU=
Date:   Fri, 30 Oct 2020 09:55:56 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: move ioctl interface definitions to
 separated file
Message-ID: <20201030165556.GA1097@sol.localdomain>
References: <20201030072610.57155-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030072610.57155-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 03:26:10PM +0800, Chao Yu wrote:
> +
> +struct f2fs_gc_range {
> +	u32 sync;
> +	u64 start;
> +	u64 len;
> +};

Userspace headers need to use __u32, __u64, etc. instead of u32, u64, etc.

Did you try installing this header, and including it in a userspace program?

- Eric
