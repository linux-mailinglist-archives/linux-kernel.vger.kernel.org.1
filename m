Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62B42CF158
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgLDP4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:56:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:11990 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728708AbgLDP4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:56:11 -0500
IronPort-SDR: g0yVwsywaBGiDVXGjMOoE5/l4AhyBoSylQk1fD4wZYTZPfPBCc9fLvxVWjJDPzNx3cwEbPrXRR
 RiphtuWUvF7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="169888865"
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="169888865"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 07:54:24 -0800
IronPort-SDR: Vhp5Jswx9eGcKQL0ubW9XPAUESZ+FxyWye9LDRS0HSZNv0scOiPCBnG86xBRFFAihH/b2E8VKk
 RmWHc19aubeA==
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="373958798"
Received: from emogena-mobl1.amr.corp.intel.com (HELO [10.212.90.42]) ([10.212.90.42])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 07:54:22 -0800
Subject: Re: [PATCH v2] ASoC: intel: sof_rt5682: Add support for
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
References: <20201203154010.29464-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <64da393b-f591-7af0-a131-b40f49dcf804@linux.intel.com>
Date:   Thu, 3 Dec 2020 10:02:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203154010.29464-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/20 9:40 AM, Brent Lu wrote:
> This patch adds the driver data for two rt1011 speaker amplifiers on
> SSP1 and rt5682 on SSP0 for TGL platform. DAI format for rt1011 is
> leveraged from cml_rt1011_rt5682 which is 4-slot tdm with 100fs bclk.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>

Thanks Brent.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
