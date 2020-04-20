Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD2F1B0266
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 09:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgDTHMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 03:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTHMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:12:17 -0400
Received: from localhost (unknown [171.61.106.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8E16206E9;
        Mon, 20 Apr 2020 07:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587366736;
        bh=xmp2pU3RNE4pr1Ih5vZDQepEAmdemu2mXawUuujDOY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DZ0NmxhVZhMWlJBq51+bYc9KbAiIhoWZud5Xop9HpuJLReMuFy+FDfO0w54j9he2D
         g80QpRhottoQtlpQ9EOdlte9Xu5yvdHdeAFTOUx33h7RRfFIP6ppq+G3qRBt4XtFyQ
         LALOpWE40Dm9wCvR/rkv2WTPYcnaZzID3sGhvWFQ=
Date:   Mon, 20 Apr 2020 12:42:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] soundwire: intel: Make sdw_intel_init static
Message-ID: <20200420071212.GV72691@vkoul-mobl>
References: <20200410115708.27708-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410115708.27708-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-04-20, 19:57, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/soundwire/intel_init.c:193:6: warning:
>  symbol 'sdw_intel_init' was not declared. Should it be static?

Applied, thanks

-- 
~Vinod
