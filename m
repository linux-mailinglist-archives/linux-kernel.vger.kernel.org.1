Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035EF295E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898080AbgJVMYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:24:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:23179 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898061AbgJVMYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:24:16 -0400
IronPort-SDR: THW9++Y+97ZxwmRAyAa97sZw0u4/sOhRRzR1Ss61+W2NaeBXl28I8hVeEvKn/xbFljnyX8kneX
 lNxMh6sGzvVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="252215537"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="252215537"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 05:24:15 -0700
IronPort-SDR: izKfoBEC1SrYUAs5dKsY3D3UMSyFWuGcyqXv4O6KWv6soeJ5EPZ9E6bui2islngT6J6oiTlb4S
 phsliDgjZlaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="359237047"
Received: from lkp-server02.sh.intel.com (HELO 911c2f167757) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Oct 2020 05:24:13 -0700
Received: from kbuild by 911c2f167757 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kVZdc-0000Pi-Ep; Thu, 22 Oct 2020 12:24:12 +0000
Date:   Thu, 22 Oct 2020 20:23:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ed Wildgoose <lists@wildgooses.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, fe@dev.tdt.de, hdegoede@redhat.com,
        Ed Wildgoose <lists@wildgooses.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [RFC PATCH] x86: cmp_version() can be static
Message-ID: <20201022122318.GA44344@88a7b53954a2>
References: <20201021214151.32229-1-lists@wildgooses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021214151.32229-1-lists@wildgooses.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 pcengines-apuv2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index 45f7a89de2780c..2f579bf9917645 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -228,7 +228,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
 	{}
 };
 
-int cmp_version(const char *base, const char *test)
+static int cmp_version(const char *base, const char *test)
 {
 	int i;
 	int oct_base[4], oct_test[4];
