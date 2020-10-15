Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EB628E967
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 02:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgJOANg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 20:13:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:4037 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgJOANg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 20:13:36 -0400
IronPort-SDR: xUWvyZhHy6fnqvK1Cu6JPFbi0iEDQATuEHzopM7gPm84Vab433HfMrQRNA+ZosB+xoCugQ8K5f
 N3kxrZwI26VQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="166284010"
X-IronPort-AV: E=Sophos;i="5.77,376,1596524400"; 
   d="scan'208";a="166284010"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 17:13:35 -0700
IronPort-SDR: FxvRj/GMzbx1Ro7eyHNMx2as62crxY9JB5nZqdSTz5Tu9uB8iy6YnnkIfBLjvZeGwBRRqXr64P
 kCXfz3/rYZsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,376,1596524400"; 
   d="scan'208";a="314331522"
Received: from lkp-server01.sh.intel.com (HELO 77f7a688d8fd) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Oct 2020 17:13:33 -0700
Received: from kbuild by 77f7a688d8fd with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kSqth-0000Mw-8l; Thu, 15 Oct 2020 00:13:33 +0000
Date:   Thu, 15 Oct 2020 08:13:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Auchter <michael.auchter@ni.com>,
        srinivas.kandagatla@linaro.org, pantelis.antoniou@konsulko.com,
        frowand.list@gmail.com
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Auchter <michael.auchter@ni.com>
Subject: [RFC PATCH] nvmem: core: nvmem_of_notifier can be static
Message-ID: <20201015001328.GA31200@033f2984987c>
References: <20201014214128.1091738-3-michael.auchter@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014214128.1091738-3-michael.auchter@ni.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 859431c15d5bc3..6dd79075fdd9b0 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1671,7 +1671,7 @@ static int of_nvmem_notify(struct notifier_block *nb, unsigned long action,
 	return NOTIFY_OK;
 }
 
-struct notifier_block nvmem_of_notifier = {
+static struct notifier_block nvmem_of_notifier = {
 	.notifier_call = of_nvmem_notify,
 };
 #endif /* CONFIG_OF_DYNAMIC */
