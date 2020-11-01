Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAB52A2044
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 18:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgKARTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 12:19:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726790AbgKARTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 12:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604251190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=MG7ZjUbnC9bYoypOenWcBrCKIrvzFUn3uVH6so601go=;
        b=VQVN8oSKAsAhFom+7GqxYIUstnv9WBKkpfXOcecColT72saRMrpzGylHrldKaW1spL8V/6
        VS8wjAL8XsF5BoWDDSU8vrfdKiKeFkgIkZQXaMJM5zoEhR++x7098QnCvTV81do5FdlbBO
        Dq360x2dHwZvimDhhzoZIIPf4JjdOu4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-roFaA-wCP1SeJKJ9En6iFw-1; Sun, 01 Nov 2020 12:19:49 -0500
X-MC-Unique: roFaA-wCP1SeJKJ9En6iFw-1
Received: by mail-oo1-f70.google.com with SMTP id 4so4686778ooc.21
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 09:19:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MG7ZjUbnC9bYoypOenWcBrCKIrvzFUn3uVH6so601go=;
        b=BgJlg2w/+DBoYdXEJxToPkS3epwvAIR3MtT2Sx2ICvLkD3icK1UO9LssDYMLhcr3De
         iskL/QyWubckHbJOLNdQBn8dtw+HHU37Oa57Md91LFmqyaQYmWdfHCJLIvbWGMYvFNdM
         W01d6YvqbqDhaORARVTGTRa/vZ+DMLkJ2mOrKdnPl89VkKcdXSuLwOr2TOA2IwlXlLV5
         zcfUCPCB8lNsV/B+cLbuKr1yQYJyE13RrVsSF6WAuFFTdj5JqAEh67fASHldfSGaMple
         ppG9kzAhQr60crkZHt3p5zT9aO7ngk3EscyjC78btKPsXpEdPjOP4F4iIda4g0L66M+P
         6+rQ==
X-Gm-Message-State: AOAM533FelG4IMfdRShrNKnjsFId46IeuhPDHcm13k+VvEKRVTim00Zb
        E8v8bih9f8YRAZ95wAqqbQmRZkpLmWF7IhsqVkPr5lotyYFXlq+LWXyDoETvgILUjW0BUXxs4AB
        uswUZU+znk4xThdRkDG21swLL
X-Received: by 2002:a4a:d0a4:: with SMTP id t4mr9281664oor.21.1604251188726;
        Sun, 01 Nov 2020 09:19:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpjmkZMmnB1Awl//UN6quNahuHTPKTNd6C8do/e/GSTG+H002yN77vGHXnBRFYcAFHCape1g==
X-Received: by 2002:a4a:d0a4:: with SMTP id t4mr9281653oor.21.1604251188562;
        Sun, 01 Nov 2020 09:19:48 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q24sm206054otm.22.2020.11.01.09.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 09:19:48 -0800 (PST)
From:   trix@redhat.com
To:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        amit.kucheria@linaro.org, rafael.j.wysocki@intel.com,
        yuehaibing@huawei.com, andriy.shevchenko@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ASoC: Intel: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 09:19:43 -0800
Message-Id: <20201101171943.2305030-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/intel/atom/sst/sst.c | 2 +-
 sound/soc/intel/catpt/loader.c | 2 +-
 sound/soc/intel/catpt/pcm.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index e90590559185..e21e11dac000 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -186,7 +186,7 @@ int sst_driver_ops(struct intel_sst_drv *sst)
 			"SST Driver capabilities missing for dev_id: %x",
 			sst->dev_id);
 		return -EINVAL;
-	};
+	}
 }
 
 void sst_process_pending_msg(struct work_struct *work)
diff --git a/sound/soc/intel/catpt/loader.c b/sound/soc/intel/catpt/loader.c
index 8a5f20abcadb..40c22e4bb263 100644
--- a/sound/soc/intel/catpt/loader.c
+++ b/sound/soc/intel/catpt/loader.c
@@ -304,7 +304,7 @@ static int catpt_load_block(struct catpt_dev *cdev,
 	default:
 		sram = &cdev->dram;
 		break;
-	};
+	}
 
 	dst_addr = sram->start + blk->ram_offset;
 	if (alloc) {
diff --git a/sound/soc/intel/catpt/pcm.c b/sound/soc/intel/catpt/pcm.c
index ba653ebea7d1..1775540ac92b 100644
--- a/sound/soc/intel/catpt/pcm.c
+++ b/sound/soc/intel/catpt/pcm.c
@@ -92,7 +92,7 @@ catpt_get_stream_template(struct snd_pcm_substream *substream)
 		break;
 	default:
 		break;
-	};
+	}
 
 	return catpt_topology[type];
 }
@@ -419,7 +419,7 @@ static int catpt_dai_apply_usettings(struct snd_soc_dai *dai,
 		break;
 	default:
 		return 0;
-	};
+	}
 
 	list_for_each_entry(pos, &component->card->snd_card->controls, list) {
 		if (pos->private_data == component &&
-- 
2.18.1

