Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE0E27A074
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 12:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgI0KUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 06:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgI0KUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 06:20:44 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC662080C;
        Sun, 27 Sep 2020 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601202043;
        bh=JpuMIPKR6z2Qp+qMtG0eKFh4UB6e9j0DOGHJl87DCY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KC1MaG1D2BMcEm2aJgnteSV7W5UjkGE9yH+1zjuyU+P3Xszy38v54XcWv+ncvfmVP
         OnwHBoGB4nc7DsBOPRiegrfQWOHEfbC/ZuyLhnMmpEmIDuw3UZr+u0MtXHumGQGW1i
         I6CAuRFjd+exhXvxczd6Uce1gGTNowMZVkPo5l7M=
Date:   Sun, 27 Sep 2020 12:20:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] bus: mhi: core: debugfs: Use correct format
 specifiers for addresses
Message-ID: <20200927102053.GA87038@kroah.com>
References: <20200927033652.11789-1-manivannan.sadhasivam@linaro.org>
 <20200927033652.11789-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200927033652.11789-2-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 09:06:48AM +0530, Manivannan Sadhasivam wrote:
> For exposing the addresses of read/write pointers and doorbell register,
> let's use the correct format specifiers. This fixes the following issues
> generated using W=1 build in ARM32 and reported by Kbuild bot:
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/bus/mhi/core/debugfs.c:75:7: warning: format specifies type 'unsigned long long' but the argument has type 'dma_addr_t' (aka 'unsigned int') [-Wformat]
>                               mhi_event->db_cfg.db_val);
>                               ^~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/bus/mhi/core/debugfs.c:123:7: warning: format specifies type 'unsigned long long' but the argument has type 'dma_addr_t' (aka 'unsigned int') [-Wformat]
>                               mhi_chan->db_cfg.db_val);
>                               ^~~~~~~~~~~~~~~~~~~~~~~
>    2 warnings generated.
> 
> drivers/bus/mhi/core/debugfs.c: In function ‘mhi_debugfs_events_show’:
> drivers/bus/mhi/core/debugfs.c:74:51: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>    seq_printf(m, " local rp: 0x%llx db: 0x%pad\n", (u64)ring->rp,
>                                                    ^
> drivers/bus/mhi/core/debugfs.c: In function ‘mhi_debugfs_channels_show’:
> drivers/bus/mhi/core/debugfs.c:122:7: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>        (u64)ring->rp, (u64)ring->wp,
>        ^
> drivers/bus/mhi/core/debugfs.c:122:22: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>        (u64)ring->rp, (u64)ring->wp,
>                       ^
> drivers/bus/mhi/core/debugfs.c:121:62: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘dma_addr_t {aka unsigned int}’ [-Wformat=]
>    seq_printf(m, " local rp: 0x%llx local wp: 0x%llx db: 0x%llx\n",
>                                                            ~~~^
>                                                            %x
> drivers/bus/mhi/core/debugfs.c:123:7:
>        mhi_chan->db_cfg.db_val);
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/bus/mhi/core/debugfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

This file is not in any of the branches of any of my trees.

What was it made against?

confused,

greg k-h
