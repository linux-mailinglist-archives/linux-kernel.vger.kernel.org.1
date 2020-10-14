Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3541028DCB9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbgJNJTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbgJNJTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:41 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1E5C0F26E1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 19:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Y4PZ2VTmQ8zBR48egbxk77NAAyz4jeh+ZC7YAyDEI/M=; b=dIkH3k8yxdoWT+xpUe+4g+BxWZ
        3EOwXsKPper3YKayL/jjbVFPf8Xa9C2XlXDIvY0sGaZRkvCwbwGzt+HaHDpek9WsJuSEmdputcyIW
        G86/EUQ8tvfv6VySqTR+9iCIZJh8L+vwUmay8HS2zdIIigb4i4qiFHkf2/c9QK/LM5MKLmrEAwKl6
        BTWWe3oBlNLDhLoNoIfoqXN2Vm5M76wiK6mS0rQ2mlwWhvjURCGPZCHxUDwc/FN/awi2oHgrJl75C
        xpVinvdPtVJ+szGqGZAtyeCQEBbKyDlU5Ff4ToXdaXXUhHiynfSBW5vUuN8lk/FeBf0xDjDNRvYTc
        vQ4T0sww==;
Received: from [2601:1c0:6280:3f0::507c] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSWxz-0005zg-BG; Wed, 14 Oct 2020 02:56:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ASoC: sof: cleanup Kconfig files
Date:   Tue, 13 Oct 2020 19:56:30 -0700
Message-Id: <20201014025633.4879-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: sound-open-firmware@alsa-project.org
Cc: alsa-devel@alsa-project.org

Some general editing of sound/soc/sof/ Kconfig files:

 [PATCH 1/3] ASoC: sof: imx: fix Kconfig punctuation
 [PATCH 2/3] ASoC: sof: intel: fix Kconfig punctuation and wording
 [PATCH 3/3] ASoC: sof: Kconfig: fix Kconfig punctuation and wording

 sound/soc/sof/Kconfig       |   42 +++++++++++------------
 sound/soc/sof/imx/Kconfig   |   10 ++---
 sound/soc/sof/intel/Kconfig |   62 +++++++++++++++++-----------------
 3 files changed, 57 insertions(+), 57 deletions(-)
