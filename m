Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E482A0D10
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbgJ3SDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:03:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:31256 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgJ3SDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:03:41 -0400
IronPort-SDR: ldkwhEqbMLytJoOxYXUSUxJRIXo8daXvh8aRzbp95kRr5yk9dlobplfE65Gp2o7/Jlk8/ouCab
 tvrAT5ysS70g==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="147929953"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="147929953"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 11:03:41 -0700
IronPort-SDR: Zju8Tqf+Dr10H+s+LbQXlYDo5BteOucn0MS4mZK4vR/PhJVV2jEqojAmzDdsSSc9FZ1BkGT/jY
 TznzYUauRoYw==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="351357510"
Received: from rdchavez-mobl2.amr.corp.intel.com (HELO [10.212.91.180]) ([10.212.91.180])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 11:03:39 -0700
Subject: Re: [PATCH v2 0/2] Add rt1015 support to CML boards
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jason Yan <yanaijie@huawei.com>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>
References: <20201030170559.20370-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f85e56df-f413-d199-c2dd-2d9f1713e3b2@linux.intel.com>
Date:   Fri, 30 Oct 2020 13:03:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030170559.20370-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/20 12:05 PM, Brent Lu wrote:
> First patch adds tdm 4-slot 100fs DAI setting to avoid jitter of using
> 64fs on CML boards. Second patch is a DMI quirk for HP Dooly.
> 
> Changes since v1:
> -Add comment on Dooly's DMI quirk
> 
> Brent Lu (2):
>    ASoC: intel: sof_rt5682: Add support for cml_rt1015_rt5682
>    ASoC: intel: sof_rt5682: Add quirk for Dooly

For the series

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Brent!

> 
>   sound/soc/intel/boards/sof_rt5682.c           | 65 +++++++++++++++++--
>   .../intel/common/soc-acpi-intel-cml-match.c   | 13 ++++
>   2 files changed, 73 insertions(+), 5 deletions(-)
> 
