Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9782C47A1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 19:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733069AbgKYS3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 13:29:33 -0500
Received: from verein.lst.de ([213.95.11.211]:60070 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730551AbgKYS3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:29:31 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D64BA68B02; Wed, 25 Nov 2020 19:29:28 +0100 (CET)
Date:   Wed, 25 Nov 2020 19:29:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Colin King <colin.king@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma-mapping: fix an uninitialized pointer read due to
 typo in argp assignment
Message-ID: <20201125182928.GA10377@lst.de>
References: <20201125135535.1880307-1-colin.king@canonical.com> <1b430a80dec14cb9aa612ff7e5dddac4@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b430a80dec14cb9aa612ff7e5dddac4@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ooops, that was my edit.  I'll make sure to fold the fix into the
original commit.
