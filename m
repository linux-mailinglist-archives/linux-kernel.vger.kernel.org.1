Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664BF25D436
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 11:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgIDJFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 05:05:24 -0400
Received: from 8bytes.org ([81.169.241.247]:40838 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgIDJFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:05:22 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 96D08433; Fri,  4 Sep 2020 11:05:20 +0200 (CEST)
Date:   Fri, 4 Sep 2020 11:05:19 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3] iommu/tegra-smmu: Add missing locks around
 mapping operations
Message-ID: <20200904090519.GF6714@8bytes.org>
References: <20200814162252.31965-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814162252.31965-1-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 07:22:52PM +0300, Dmitry Osipenko wrote:
> The mapping operations of the Tegra SMMU driver are subjected to a race
> condition issues because SMMU Address Space isn't allocated and freed
> atomically, while it should be. This patch makes the mapping operations
> atomic, it fixes an accidentally released Host1x Address Space problem
> which happens while running multiple graphics tests in parallel on
> Tegra30, i.e. by having multiple threads racing with each other in the
> Host1x's submission and completion code paths, performing IOVA mappings
> and unmappings in parallel.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Thierry, does this change look good to you?

