Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC8A2E1A30
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgLWIys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgLWIys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:54:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0331C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HKLhSP0AX849qe/seOGRQIG2LuIaRgQixYFEE7TpKGw=; b=jqhmPAN1ReUqMHRqF0T4Vd6e0q
        VLXL2XDuEDFIsDLVdCkvl8aHB4ZakK2ifrR9rSbsbiymIby144YrZWxZebkuAft7UINfIY5QYzQ+o
        KTTe7p24Nw6A6Ao+pIWfmi0la6gxevNOWLVlaakQYSDiADhO9f6eBtwFze32YhAP7Z+AgDdOELenT
        psPpmWbmS2BAZyRy6+xgPeF6YLiFSXVdpuXXj70ffdvnVg2TLAgObQF4QAd9+AytZ4ODQh2ozJaJ5
        9d6GyTTdodIYbOvpJSEyAO07wgmTaN9/lJkyZOify4TgG5d4/93uWynlZyP3qjhZwEWhBWeEdZUCv
        h1So9lkw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krzuD-00006T-Qs; Wed, 23 Dec 2020 08:54:01 +0000
Date:   Wed, 23 Dec 2020 08:54:01 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <hsiangkao@redhat.com>, guoweichao@oppo.com,
        linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: support direct IO for uncompressed file
Message-ID: <20201223085401.GA336@infradead.org>
References: <20201214140428.44944-1-huangjianan@oppo.com>
 <20201222142234.GB17056@infradead.org>
 <20201222193901.GA1892159@xiangao.remote.csb>
 <20201223074455.GA14729@infradead.org>
 <dc4452e9-83eb-90e7-f001-d39d0ecdd105@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc4452e9-83eb-90e7-f001-d39d0ecdd105@oppo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 04:48:20PM +0800, Huang Jianan wrote:
> Hi Christoph,
> 
> The reason we use dio is because we need to deploy the patch on some early
> kernel versions, and we don't pay much attention to the change of iomap.

No, that is never an excuse for upstream development.
