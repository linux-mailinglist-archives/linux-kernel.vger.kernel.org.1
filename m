Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528781F76C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 12:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFLKaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 06:30:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:17570 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgFLKaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:30:13 -0400
IronPort-SDR: MLYq0/+hhbKCmc57Svh3BZyGYCNkqPrU3M/fewo21KCc12LjCojxbIaphjRp3OBGqELj9nqSX1
 tQjDjkz/Xghw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 03:30:05 -0700
IronPort-SDR: FB7TDU6toUsBW8rgmmhkVAjuNlzXccIiopAQ9bo5sN9VfuAVt0LvcsBhAlbL8R29lkBq7UN9Vh
 fvLdMhYVQ04Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,502,1583222400"; 
   d="scan'208";a="419425987"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga004.jf.intel.com with ESMTP; 12 Jun 2020 03:30:00 -0700
Date:   Fri, 12 Jun 2020 13:29:52 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Brent Lu <brent.lu@intel.com>
cc:     alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: SOF: Intel: hda: unsolicited RIRB response
Message-ID: <alpine.DEB.2.22.394.2006121325470.3186@eliteleevi.tm.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brent,

On Fri, 12 Jun 2020, Brent Lu wrote:

> Port commit 6d011d5057ff ("ALSA: hda: Clear RIRB status before reading
> WP") from legacy HDA driver to fix the get response timeout issue.
> Current SOF driver does not suffer from this issue because sync write
> is enabled in hda_init. The issue will come back if the sync write is
> disabled for some reason.

better to align the logic, so I'm ok to take this patch to SOF. 
Can you fix the summary though:

- ASoC: SOF: Intel: hda: unsolicited RIRB response
+ ASoC: SOF: Intel: hda: Clear RIRB status before reading WP

Br, Kai
