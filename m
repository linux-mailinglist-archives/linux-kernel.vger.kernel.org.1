Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5B52534F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 18:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgHZQdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 12:33:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgHZQds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:33:48 -0400
Received: from localhost.localdomain (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFF49206FA;
        Wed, 26 Aug 2020 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598459628;
        bh=brdy0JqR2glpffx/r0kThUcBvo2d0EzJ3iqr15lOvi8=;
        h=From:To:Cc:Subject:Date:From;
        b=1ygBdOW3dC1CTkbTlZMd96EKiB4aF6+bBjHaJEndBO1OWYgdi7Kl3detrkIcyTtRp
         /elKUi9bMdn1rLA/My3zU82qDBs3wOJJGAUF0LoPYYx8byr+aAm5Xtqc4J3eLOoS2f
         qCGtrGUjIyynK+4eNNqxQ5cXk7gGb+MD8k04+ifk=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ryan Lee <ryans.lee@maximintegrated.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Shuming Fan <shumingf@realtek.com>
Subject: [PATCH v2 0/5] ASoC: Fix return check for devm_regmap_init_sdw()
Date:   Wed, 26 Aug 2020 22:03:35 +0530
Message-Id: <20200826163340.3249608-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to fix return check for devm_regmap_init_sdw()

Changes in v2:
 - Add missing patch for rt711
 - Add patch for rt700

Vinod Koul (5):
  ASoC: max98373: Fix return check for devm_regmap_init_sdw()
  ASoC: rt1308-sdw: Fix return check for devm_regmap_init_sdw()
  ASoC: rt711: Fix return check for devm_regmap_init_sdw()
  ASoC: rt715: Fix return check for devm_regmap_init_sdw()
  ASoC: rt700: Fix return check for devm_regmap_init_sdw()

 sound/soc/codecs/max98373-sdw.c | 4 ++--
 sound/soc/codecs/rt1308-sdw.c   | 4 ++--
 sound/soc/codecs/rt700-sdw.c    | 4 ++--
 sound/soc/codecs/rt711-sdw.c    | 4 ++--
 sound/soc/codecs/rt715-sdw.c    | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.26.2

