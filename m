Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221B52E32C3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 22:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgL0VOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 16:14:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40307 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbgL0VOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 16:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609103563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h6DblsvkQcBaI8Wi2z8PNad4xomPrNWUmS5lSu1NYpw=;
        b=C0JESMdsAIZO1Am6qeL3eCkx/LWdOUeIwVYEqnMXqnwpL1Ro6KwgVcY7y5y5WJehImDq8p
        a/HAgiSkQYqqh+GT9QKHuLiAyaXvemnxDk8kWC33+h0hI/gHCUnbrFmkCrlZfPR9rXo9m0
        v5lXG3jMnU8rKqNlH1VkJjvsx5EYlkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-mPobGU11NJ-A6I5uw4mowA-1; Sun, 27 Dec 2020 16:12:40 -0500
X-MC-Unique: mPobGU11NJ-A6I5uw4mowA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9B03E75A;
        Sun, 27 Dec 2020 21:12:38 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-25.ams2.redhat.com [10.36.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B069C62A24;
        Sun, 27 Dec 2020 21:12:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 01/14] mfd: arizona: Add jack pointer to struct arizona
Date:   Sun, 27 Dec 2020 22:12:19 +0100
Message-Id: <20201227211232.117801-2-hdegoede@redhat.com>
In-Reply-To: <20201227211232.117801-1-hdegoede@redhat.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Arizona driver uses the MFD framework to create several
sub-devices for the Arizona codec and then uses a driver per function.

The jack-detect support for the Arizona codec is handled by the
extcon-arizona driver. This driver exports info about the jack state
to userspace through the standard extcon sysfs class interface.

But standard Linux userspace does not monitor/use the extcon sysfs
interface for jack-detection.

Add a jack pointer to the shared arizona data struct, this allows
the ASoC machine driver to create a snd_soc_jack and then pass this
to the extcon-arizona driver to report jack-detect state, so that
jack-detection works with standard Linux userspace.

The extcon-arizona code already depends on (waits for with -EPROBE_DEFER)
the snd_card being registered by the machine driver, so this does not
cause any ordering issues.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/linux/mfd/arizona/core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mfd/arizona/core.h b/include/linux/mfd/arizona/core.h
index 6d6f96b2b29f..5eb269bdbfcb 100644
--- a/include/linux/mfd/arizona/core.h
+++ b/include/linux/mfd/arizona/core.h
@@ -115,6 +115,7 @@ enum arizona_type {
 #define ARIZONA_NUM_IRQ                   75
 
 struct snd_soc_dapm_context;
+struct snd_soc_jack;
 
 struct arizona {
 	struct regmap *regmap;
@@ -148,6 +149,7 @@ struct arizona {
 	bool ctrlif_error;
 
 	struct snd_soc_dapm_context *dapm;
+	struct snd_soc_jack *jack;
 
 	int tdm_width[ARIZONA_MAX_AIF];
 	int tdm_slots[ARIZONA_MAX_AIF];
-- 
2.28.0

