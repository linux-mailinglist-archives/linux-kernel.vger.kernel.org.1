Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD07246606
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 14:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgHQMIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 08:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgHQMIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:08:47 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B2C82072E;
        Mon, 17 Aug 2020 12:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597666127;
        bh=TocOjnaqa2TbaSJHcqyENljI//WPudw/4XS9bdbhXC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=11Bg5V99Vtxexq4TbAPee6betJmt3dUihsnlpEPZWErE3yPfSe3yGZqWvSVgWPGIJ
         4TMH6JKh/WLd5m8rC7cAn/fBI29MvVvTXOAWFbcc/9x9vaeyvum5afv2Bqb/vn/3qX
         ygVSINDm/pHUL9wky5E4FTf5wYDXof94yS6PfSi8=
Date:   Mon, 17 Aug 2020 17:38:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 00/13] soundwire: intel: add power management support
Message-ID: <20200817120841.GQ2639@vkoul-mobl>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-20, 04:37, Bard Liao wrote:
> This series adds power management support for Intel soundwire links.

I had applied except 3 & 9 (few skipped in middle due to conflict while
applying), BUT I get a build failure on patch 2 onwards :(

drivers/soundwire/intel_init.c: In function ‘sdw_intel_cleanup’:
drivers/soundwire/intel_init.c:72:4: error: implicit declaration of function ‘pm_runtime_disable’ [-Werror=implicit-function-declaration]
   72 |    pm_runtime_disable(&link->pdev->dev);

I suspect due to missing header? I was on x64 build with allmodconfig

So only patch 1 is applied and pushed now

-- 
~Vinod
