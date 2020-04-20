Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B451B094B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 14:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDTM0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 08:26:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726318AbgDTM0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:26:30 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1CD75912263CA4F21767;
        Mon, 20 Apr 2020 20:26:29 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 20 Apr 2020 20:26:25 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <rdunlap@infradead.org>, <geert@linux-m68k.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ASoC: Fix dependency issues of SND_SOC
Date:   Tue, 21 Apr 2020 04:24:08 +0800
Message-ID: <20200420202410.47327-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dependency issues of SND_SOC introduced by commit ea00d95200d02 
("ASoC: Use imply for SND_SOC_ALL_CODECS").

Wei Li (2):
  ASoC: wm89xx: Fix build errors caused by I2C dependency
  ASoC: Fix wrong dependency of da7210 and wm8983

 sound/soc/codecs/Kconfig | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.17.1

