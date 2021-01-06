Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036C22EC40B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 20:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbhAFThB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 14:37:01 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:59230 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbhAFThA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 14:37:00 -0500
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2021 14:37:00 EST
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 3A054B04596
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 20:28:03 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:mime-version:x-mailer:message-id
        :date:date:subject:subject:to:from:from; s=dkim; t=1609961282;
         x=1610825283; bh=UFekAn+Esjbm1Jzl4lfFfkN34+YRVkJ57d84p7XBf3w=; b=
        Zn59ZQVygDHkmANskSCP8DJucFqxHb5qZiLSGZVh63KHOMVzCl1yFXbX8CzQarik
        3LWb+jLnR/zT6NLm1Wji6+N05amMT8sBA/if+EJGzBN9RhbHWPkW66/Orixe5dT7
        ZOPDLMYZUXY+l06HkEUUMi79oQeRxZj8M38uoZFW2Gg=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-10 required=4.5
        tests=[ALL_TRUSTED=-1, BAYES_00=-1.9]
        autolearn=unavailable autolearn_force=no
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FYFUgJnAjOb7 for <linux-kernel@vger.kernel.org>;
        Wed,  6 Jan 2021 20:28:02 +0100 (CET)
Received: from ubuntu.localdomain (146-241-198-163.dyn.eolo.it [146.241.198.163])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id D9D3EB04373;
        Wed,  6 Jan 2021 20:28:01 +0100 (CET)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Marjan Pascolo <marjan.pascolo@trexom.it>, wens@csie.org,
        daniel@ffwll.ch, airlied@linux.ie, treding@nvidia.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 0/2] drm/sun4i: fix DCLK and improve its handling
Date:   Wed,  6 Jan 2021 20:27:58 +0100
Message-Id: <20210106192800.164052-1-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch is a tested by me fix, while the second need testing to
understand if it works correctly with any sunxi SoC with DE peripheral.
Already tested SoCs are:
- A20
- A33

Need testing:
- A10
- A10s
- A13

Giulio Benetti (2):
  drm/sun4i: tcon: fix inverted DCLK polarity
  drm/sun4i: tcon: improve DCLK polarity handling

 drivers/gpu/drm/sun4i/sun4i_tcon.c | 20 +-------------------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
 2 files changed, 2 insertions(+), 19 deletions(-)

-- 
2.25.1

