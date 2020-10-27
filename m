Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BBC29AB09
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899438AbgJ0LlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:41:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:28522 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2899428AbgJ0LlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:41:04 -0400
IronPort-SDR: jLpDQpN31GgyRmy1qxNl+I4SHUhgsg14GIz9rJDFvbrg4o7J7GSK/cOnLKkjge/KUPG5ag+Zys
 qbO5/E0tKn5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="147919100"
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="147919100"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 04:41:04 -0700
IronPort-SDR: SUivjGOGsc0c2mmPKR5lmGTTCBFs/D170rHhrqy8P1w337Ch8cRtlYiR/V0I4x/W5Fu9YN0bCY
 IdkxspCNIPuA==
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="525856545"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 04:41:02 -0700
Date:   Tue, 27 Oct 2020 13:38:56 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        kai.vehmanen@linux.intel.com, linux-kernel@vger.kernel.org,
        hui.wang@canonical.com
Subject: Re: [PATCH v2 3/4] ALSA: hda: Separate runtime and system suspend
In-Reply-To: <20201027054001.1800-4-kai.heng.feng@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2010271317430.864696@eliteleevi.tm.intel.com>
References: <20201027054001.1800-1-kai.heng.feng@canonical.com> <20201027054001.1800-4-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks, this looks like a good improvement! Some minor notes:

On Tue, 27 Oct 2020, Kai-Heng Feng wrote:

> Both pm_runtime_force_suspend() and pm_runtime_force_resume() have
> some implicit checks, so it can make code flow more straightfoward if we
> separate runtime and systemd suspend callbacks.

straightforward -> straightforward

and systemd? Maybe just "system suspend"? :)

> While at it, also remove AZX_DCAPS_SUSPEND_SPURIOUS_WAKEUP, as the
> original bug commit a6630529aecb ("ALSA: hda: Workaround for spurious
> wakeups on some Intel platforms") solves doesn't happen with this
> patch.

Hmm, so this was gone already with the v1 version (so not related to 
programming the WAKEEN when going to system suspend)?

> @@ -143,6 +143,7 @@ struct azx {
>  	unsigned int align_buffer_size:1;
>  	unsigned int region_requested:1;
>  	unsigned int disabled:1; /* disabled by vga_switcheroo */
> +	unsigned int prepared:1;

I wonder if "pm_prepared" would be better as ALSA API has a prepare method 
as well and this is not related. OTOH, if ok to Takashi, ok for me as 
well. 

> +	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) &
> +		   ~STATESTS_INT_MASK);

This would fit to one line now. 

Br, Kai
