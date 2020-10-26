Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B814299AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406920AbgJZXfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:35:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:30095 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406870AbgJZXfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:35:30 -0400
IronPort-SDR: SwiQ0l4Dkrsh3PTiHHdulN6vvhV16kvnuBBCmIyngUc+NIHJphd83RFeyE9jcD67mCNduty4wP
 fLAB884Ktufg==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="232190068"
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="232190068"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 16:35:28 -0700
IronPort-SDR: Wy/LuMKPwNf18D0QFgq6hb9EeytvQuq6a+akzIesatlG+Vfr76cUY7Gitum4qiO6+BbSTzbpMv
 v+2rQpyxuDMw==
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="524475073"
Received: from tanguye1-mobl2.amr.corp.intel.com (HELO [10.209.126.195]) ([10.209.126.195])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 16:35:25 -0700
Subject: Re: [PATCH v3] ASoC: Intel: boards: Add CML_RT1015 m/c driver
To:     Keith Tzneg <matsufan@gmail.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Libin Yang <libin.yang@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Keith Tzeng <keith.tzeng@quanta.corp-partner.google.com>,
        Brent Lu <brent.lu@intel.com>, linux-kernel@vger.kernel.org
References: <1603515087-4092-1-git-send-email-keith.tzeng@quantatw.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0ade3e3c-c55d-d137-0af2-b2b32c16cfd7@linux.intel.com>
Date:   Mon, 26 Oct 2020 14:22:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603515087-4092-1-git-send-email-keith.tzeng@quantatw.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/20 11:51 PM, Keith Tzneg wrote:
> From: Keith Tzeng <keith.tzeng@quanta.corp-partner.google.com>
> 
> Machine driver to enable RT5682 on SSP0, DMIC, HDMI and RT1015 AMP on
> SSP1: Enabled 4 CH TDM playback with 24 bit data.

Same comment for the third time: there is no reason to add an entire 
machine driver just to replace one amplifier by another.

let's use an existing machine driver and use a quirk (DMI or table_id) 
to select the relevant amp for that device.

