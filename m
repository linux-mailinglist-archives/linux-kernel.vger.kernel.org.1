Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791FB2666B8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgIKRb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:31:58 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:54199 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgIKRbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:31:44 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 581EA1BF206;
        Fri, 11 Sep 2020 17:31:41 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/3] tlv320aic3xx4 updates
Date:   Fri, 11 Sep 2020 19:31:37 +0200
Message-Id: <20200911173140.29984-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While doing a kernel update on a sama5-based board I figured out the
sound system was not working anymore, the debug session led me to the
following commits. As I am not an audio expert at all, I am fully open
to comments and suggestions.

Thanks,
Miquèl

Miquel Raynal (3):
  ASoC: tlv320aic32x4: Ensure a minimum delay before clock stabilization
  ASoC: tlv320aic32x4: Fix bdiv clock rate derivation
  ASoC: tlv320aic32x4: Enable fast charge

 sound/soc/codecs/tlv320aic32x4-clk.c |  9 ++++++++-
 sound/soc/codecs/tlv320aic32x4.c     | 17 ++++++++++++++---
 sound/soc/codecs/tlv320aic32x4.h     |  7 +++++++
 3 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.20.1

