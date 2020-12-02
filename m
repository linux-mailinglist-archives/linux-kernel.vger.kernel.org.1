Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE79B2CC15A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbgLBPxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:53:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:47180 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbgLBPxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:53:21 -0500
IronPort-SDR: VtiqZLQpjctfMv0QN5tUmpeOKHBVxPKRFwWa9jnts1DB9DSuXha3brjGZ6JqNpip2fQIza9GPV
 eOSnuzbEa/wQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="173194809"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="173194809"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 07:51:40 -0800
IronPort-SDR: 1saECTZ06J0Pd5CoYIuPgi5eATW5aWi8+qDgwlYZOHd3VIFz1dSC0xiV7ioAnAQHfGrLS1G/NE
 /4ISzNp5WTyA==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="539740422"
Received: from ajrodr4-mobl1.amr.corp.intel.com (HELO [10.213.167.252]) ([10.213.167.252])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 07:51:38 -0800
Subject: Re: [PATCH] ASoC: intel: sof_rt5682: Add support for
 tgl_rt1011_rt5682
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Dharageswari R <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Libin Yang <libin.yang@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>
References: <20201202015826.7678-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9d3d76fd-869c-ec20-0fa0-a0da88e32502@linux.intel.com>
Date:   Wed, 2 Dec 2020 09:18:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202015826.7678-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +struct {
> +	unsigned int tx;
> +	unsigned int rx;
> +} rt1011_tdm_mask[] = {
> +	{.tx = 0x4, .rx = 0x1},
> +	{.tx = 0x8, .rx = 0x2},
> +};

as noted in the GitHub review this should be static and possibly const.

