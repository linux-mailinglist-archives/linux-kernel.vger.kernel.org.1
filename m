Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91482D3D48
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgLIIYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:24:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgLIIX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:23:57 -0500
Date:   Wed, 9 Dec 2020 00:23:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607502197;
        bh=MBbmbOIjq5eM4nxV5TZKAlCSXESrnTnoVEWXH8GhZc4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=c9q0T/V/EkEnXdZIOLiT53zAR8FSqy8mgWYHNVpK0nSKUrIBJAAckTYFIaR2cwDGx
         DvTxgm3/wEw/BJAU0kMYDvSLxtK+Zzul0KmGJBTMDaEo6UK7Ryb781wdauQ/YTW9DX
         9/BQ4Hs7WS0slTBveTPaFbOCq+UxbBOtR4QIoCUapTNBlPrGE7LwXWeqNJkvLLIKh5
         QMZxD3jd+HdwYqaBWLpaBD/4KK2/YaRtQC6KdAUMhgOt6wzZ+iX4F6rY7sI8Ry2G7h
         Y7WG/GwBmHQfgtEc+prFF1L9alCYAY7P/LQehfEQCrv8amomwe7nNLb8pRYVrSA1Zs
         DSKKnV1lmfitg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: compress: support chksum
Message-ID: <X9CJc7xas7OqTZv2@google.com>
References: <20201208031437.56627-1-yuchao0@huawei.com>
 <22ac4df6-53ec-fb7c-c4dd-26435352a701@huawei.com>
 <X9A7Jn+cHRRcAmIi@google.com>
 <37d89d34-add1-5254-380b-233ef7a460d4@huawei.com>
 <X9BKX9PUMFkts9bI@google.com>
 <5398c880-d4d3-81b9-f3c9-765ba1470e96@huawei.com>
 <0d4a20ec-f6e4-ff24-8733-94cc3762195d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d4a20ec-f6e4-ff24-8733-94cc3762195d@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09, Chao Yu wrote:
> On 2020/12/9 12:28, Chao Yu wrote:
> > On 2020/12/9 11:54, Jaegeuk Kim wrote:
> > > Ah, could you please write another patch to adjust the new changes?
> > 
> > No problem, will drop "f2fs: compress:support chksum" based on your dev branch, and
> > apply all compress related patches on top of dev branch.
> 
> Jaegeuk, could you please
> - drop "f2fs: compress:support chksum",

What I mean is keeping the old version in dev branch as is, since it gives
another conflicts when dropping it. That can add another bug at this point.
Can I get a separate patch to fix any issues in that original patch?

> - manually fix conflict when applying "f2fs: add compress_mode mount option"
> - and then apply last my resent patches.
> 
> Thanks,
