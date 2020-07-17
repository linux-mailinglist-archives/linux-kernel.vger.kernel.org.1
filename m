Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025A32245F5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 23:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgGQVte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 17:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgGQVtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 17:49:33 -0400
Received: from embeddedor (unknown [201.162.167.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2EA320759;
        Fri, 17 Jul 2020 21:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595022573;
        bh=d6pg/moIc4Lfqu+IfBjkbjoSoRMlnQNHmTVvs1VG1nk=;
        h=Date:From:To:Cc:Subject:From;
        b=2FsjmqENNaKb2fIvhkjaY9xknfwSoNvX+heeZudSyESchWojQCWTVoy5V//d1bDev
         ssv6gOfMQnPh8DaqKaf1XzTwnYClT/4M8zjFMmX0HpN/Tkl+BDyNPM80B0ThNsNZ+M
         K651XniFOE0QEEJcqZ8ylRUhH6Dpr38HeVLNEPC0=
Date:   Fri, 17 Jul 2020 16:55:00 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] ASoC: Intel: Skylake: Avoid the use of one-element
 array
Message-ID: <20200717215500.GA13910@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are being deprecated[1]. Replace the one-element
array with a simple value type 'u8 reserved'[2], once it seems this
is just a placeholder for alignment.

[1] https://github.com/KSPP/linux/issues/79
[2] https://github.com/KSPP/linux/issues/86

Tested-by: kernel test robot <lkp@intel.com>
Link: https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/0-day/skylake-20200717.md
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 9889f728752c..5e93ad85e06d 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -97,7 +97,7 @@ struct skl_audio_data_format {
 	u8 number_of_channels;
 	u8 valid_bit_depth;
 	u8 sample_type;
-	u8 reserved[1];
+	u8 reserved;
 } __packed;
 
 struct skl_base_cfg {
-- 
2.27.0

