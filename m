Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAAF2C47A5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 19:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbgKYS3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 13:29:43 -0500
Received: from verein.lst.de ([213.95.11.211]:60077 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730555AbgKYS3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:29:43 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6C9CA68B02; Wed, 25 Nov 2020 19:29:41 +0100 (CET)
Date:   Wed, 25 Nov 2020 19:29:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Colin King <colin.king@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma-mapping: Fix sizeof() mismatch on tsk allocation
Message-ID: <20201125182941.GB10377@lst.de>
References: <20201125140523.1880669-1-colin.king@canonical.com> <a6c5e5ed9a66485da301c1e91b56ccc7@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c5e5ed9a66485da301c1e91b56ccc7@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll fold this one in as well.
