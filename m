Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2B42FF928
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 01:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbhAUX5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 18:57:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:62741 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbhAUX5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:57:10 -0500
IronPort-SDR: Dy0Hn5B9Nw6CaIdQNXw67vdc0NT322CaCJkc9O79RzxnkKpY3OkzBpnxkIMGnP5S2TsMls/ZwH
 eQ62mLMDbEYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="198109696"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="198109696"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 15:56:20 -0800
IronPort-SDR: MDFgs0Fmqz0OzeT9BLDYmbbMO8ohbDTsFGPpy9En1Wtmc1ebQgiV3sH1wKuMWXRS7wR/KxJWRA
 AxcXXb5iZmug==
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="467658087"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.217.24])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 15:56:20 -0800
Subject: Re: [PATCH v8 0/1] Intel MAX10 BMC Macros for Secure Update
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20210121225555.302548-1-russell.h.weight@intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <6be5e8f1-d6c5-cdc8-4342-7dfa60bbed4f@intel.com>
Date:   Thu, 21 Jan 2021 15:56:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121225555.302548-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/21 2:55 PM, Russ Weight wrote:
> This patch was previously patch 1 of 6 in the patch-series entitled
> "Intel MAX10 BMC Secure Update Driver". This is the only patch in
> the series that is subject to conflicts with other ongoing changes
> and is separated here to simplify maintenance of the patchset.
>
> This patch creates a number of macro definitions that are required
> for the Intel MAX10 BMC Secure Update Driver.

Please apply this patch first. It was previously accepted but has not
landed in linux-next yet.
https://marc.info/?l=linux-kernel&m=161066634118704&w=2
>
> Changelog v7 -> v8:
>   - Rebased on next-20210121
>   - Separated out from patchset: "Intel MAX10 BMC Secure Update Driver"
> Changelog v6 -> v7:
>   - No change
> Changelog v5 -> v6:
>   - No change
> Changelog v4 -> v5:
>   - Renamed USER_FLASH_COUNT to STAGING_FLASH_COUNT
> Changelog v3 -> v4:
>   - No change
> Changelog v2 -> v3:
>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
>     Update driver"
>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>     underlying functions will be called directly.
> Changelog v1 -> v2:
>   - These functions and macros were previously distributed among
>     the patches that needed them. They are now grouped together
>     in a single patch containing changes to the Intel MAX10 BMC
>     driver.
>   - Added DRBL_ prefix to some definitions
>   - Some address definitions were moved here from the .c files that
>     use them.
>
> Russ Weight (1):
>   mfd: intel-m10-bmc: support for MAX10 BMC Secure Updates
>
>  include/linux/mfd/intel-m10-bmc.h | 85 +++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>

