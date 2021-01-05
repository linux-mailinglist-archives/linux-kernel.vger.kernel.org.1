Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690852EAB77
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbhAENEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:04:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:21190 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729743AbhAENEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:04:47 -0500
IronPort-SDR: 0lKzZsZknrlN4Qapc4OY2q8WCqK9BMvK6ybjuc5cCRDiD/3j6iCH0JZzUCsP1lR1JRFgPIvrsO
 p9x8mgOBRqfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="176317813"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="176317813"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 05:03:01 -0800
IronPort-SDR: jptWPMLfWGX6lDuX7MiHAn8ipT9mgPZ6kJanzSCH5wVxQZ/U2gNXiw9a+2klpDQm32tI8BFx0U
 TIy11gsyWYFg==
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="569721207"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 05:02:57 -0800
Date:   Tue, 5 Jan 2021 14:59:52 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcin Rajwa <marcin.rajwa@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Amery Song <chao.song@intel.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: SOF: Intel: hda: Modify existing helper to
 disable WAKEEN
In-Reply-To: <20210104140853.228448-2-kai.heng.feng@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2101051458590.864696@eliteleevi.tm.intel.com>
References: <20210104140853.228448-1-kai.heng.feng@canonical.com> <20210104140853.228448-2-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 4 Jan 2021, Kai-Heng Feng wrote:

> Modify hda_codec_jack_wake_enable() to also support disable WAKEEN.
> In addition, this patch also moves the WAKEEN disablement call out of
> hda_codec_jack_check() into hda_codec_jack_wake_enable().

ack, this looks good:

Acked-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Br, Kai
