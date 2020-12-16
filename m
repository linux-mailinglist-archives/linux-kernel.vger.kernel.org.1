Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4282DC108
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgLPNRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:17:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:50567 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgLPNRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:17:53 -0500
IronPort-SDR: 38jaG96W7bGFzt1OuUFNRVzhivjnJkxG4iuad/QJQ/34vdATx0Q9y3bLT6F1bSnxjEId9TBI1V
 o0SSzHdXohGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="172489077"
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="172489077"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 05:16:07 -0800
IronPort-SDR: 4sUBNzqBieO5bVce0WBSsq0cZlNgga0YyZxV4aP8k0toaa7y4WrOnChucWcCpgjsv9Sg4b/7ae
 liVW68dtqsJg==
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="338473869"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 05:16:04 -0800
Date:   Wed, 16 Dec 2020 15:13:19 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Colin King <colin.king@canonical.com>
cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: SOF: Fix spelling mistake in Kconfig "ond" ->
 "and"
In-Reply-To: <20201216125913.16041-1-colin.king@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2012161511510.864696@eliteleevi.tm.intel.com>
References: <20201216125913.16041-1-colin.king@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks Colin.

On Wed, 16 Dec 2020, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the Kconfig help text. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Br, kai
