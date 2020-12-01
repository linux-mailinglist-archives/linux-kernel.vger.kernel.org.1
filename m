Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE382CADFC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388068AbgLAVDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:03:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgLAVDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:03:00 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D013F204FD;
        Tue,  1 Dec 2020 21:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606856540;
        bh=tv0qvp7to0qfEmCOChYQQOvDzhMCYnFg7qz3e7fOdT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhNyyCxvF53jfvtVVkEPIb7sTB4ys0hgtVFYv4gVM0CBA1gr4VjEkpcULK2p9lc34
         cRFa/tyjdaKG9ghzutUzoWmu0p6jwvlLOc9PPfg4kCaScEQ59f1vExhWBceGqivoe1
         IxM4ZA2Eiz8DO0IfMlkQCo9gQlHjnYJmmkDN1Fu8=
Date:   Tue, 1 Dec 2020 21:02:15 +0000
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     robin.murphy@arm.com, joro@8bytes.org, xiyou.wangcong@gmail.com,
        linuxarm@huawei.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, chenxiang66@hisilicon.com
Subject: Re: [RESEND PATCH v3 0/4] iommu/iova: Solve longterm IOVA issue
Message-ID: <20201201210215.GB28178@willie-the-truck>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
 <d87ceec4-b7a1-c600-3b78-6852f0320ce2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d87ceec4-b7a1-c600-3b78-6852f0320ce2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 03:35:02PM +0000, John Garry wrote:
> On 17/11/2020 10:25, John Garry wrote:
> Is there any chance that we can get these picked up for 5.11? We've seen
> this issue solved here for a long time.
> 
> Or, @Robin, let me know if not happy with this since v1.
> 
> BTW, patch #4 has been on the go for ~1 year now, and is a nice small
> optimisation from Cong, which I picked up and already had a RB tag.

I can pick the last patch up, but I'd really like some reviewed/tested-bys
on the others.

Will
