Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350071E0DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 13:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390464AbgEYLxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 07:53:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:45254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390302AbgEYLxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:53:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6F4AEABD1;
        Mon, 25 May 2020 11:53:15 +0000 (UTC)
Date:   Mon, 25 May 2020 13:53:10 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu/vt-d: fix a GCC warning
Message-ID: <20200525115310.GG5075@suse.de>
References: <20200521215030.16938-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521215030.16938-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 05:50:30PM -0400, Qian Cai wrote:
> The commit 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
> introduced a GCC warning,
> 
> drivers/iommu/intel-iommu.c:5330:1: warning: 'static' is not at beginning of
> declaration [-Wold-style-declaration]
>  const static int
>  ^~~~~
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/iommu/intel-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
