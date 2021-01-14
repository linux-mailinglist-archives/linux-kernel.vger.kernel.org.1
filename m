Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594A92F6919
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbhANSI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:08:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:45051 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729629AbhANSI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:08:56 -0500
IronPort-SDR: KV6UanaHD34YZw68CiVBR5cXLxz0H/tULKhEcVpHUKFnJLPHPKeRjU6U2J2Ofc7A5eBzEbGV2U
 udOHxGzqvmOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="158190143"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="158190143"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 10:07:07 -0800
IronPort-SDR: Va8hRLnaZRfDY91UW1iUE9xz4iXJaGkp1Z0hlGNZ0SYVGwkzOGJIziPRg+SClfgnyrm/y/Urvf
 9OG67BbkJY2g==
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="382356824"
Received: from dvarelam-mobl1.amr.corp.intel.com (HELO [10.212.182.202]) ([10.212.182.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 10:07:05 -0800
Subject: Re: [Sound-open-firmware] [PATCH 1/2] [v2] ALSA: hda: fix
 SND_INTEL_DSP_CONFIG dependency
To:     Arnd Bergmann <arnd@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rander Wang <rander.wang@linux.intel.com>,
        sound-open-firmware@alsa-project.org
References: <20210112203250.2576775-1-arnd@kernel.org>
 <CAK8P3a0+YmZTzYYk0D5HpBEB7Kp=ryx1U4KRKCyz4XYM3v9rAQ@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4ad60e25-b1d5-9be1-a2bc-8bec9e4e85c1@linux.intel.com>
Date:   Thu, 14 Jan 2021 12:07:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0+YmZTzYYk0D5HpBEB7Kp=ryx1U4KRKCyz4XYM3v9rAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/21 9:09 AM, Arnd Bergmann wrote:
> On Tue, Jan 12, 2021 at 9:32 PM Arnd Bergmann <arnd@kernel.org> wrote:
>>
> 
>> ---
>> v2: fix various build issues in the first version, now passes
>>      all randconfig builds I tried
> 
> Please disregard this version, while I have a tree that passes
> the randconfig builds now, this was not the patch from it that
> I wanted to send...

No worries, I reworked the PCI case completely. Still running tests to 
make sure there's no regression
https://github.com/thesofproject/linux/pull/2683


