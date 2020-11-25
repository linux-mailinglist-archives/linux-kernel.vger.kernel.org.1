Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D3F2C38DA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 06:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgKYFwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 00:52:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgKYFwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 00:52:00 -0500
Received: from localhost (unknown [122.179.120.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D646208C3;
        Wed, 25 Nov 2020 05:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606283519;
        bh=3TsnI28YOrBSLpojTzDR4uEaUM9Fo2k4e+hHZUS++hE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozmQ4UeKydkeEsVKXsDHXAXgDLyMhdyo9hbJSW57EA4T2JFAxGgfIfHSc0AO9+0nv
         HN7EfuvDo1Swl83LcA+xeGveMXmbBpo5SfotKOoB3RsgXdmG8pRYaBHsfo9ncof989
         X5WxCc2e3ci6W+SjH0Ilc1bHmTjIk7ACFPTIDdfM=
Date:   Wed, 25 Nov 2020 11:21:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel test robot <lkp@intel.com>,
        Jonathan Marek <jonathan@marek.ca>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: drivers/soundwire/qcom.c:767: undefined reference to
 `slimbus_bus'
Message-ID: <20201125055155.GD8403@vkoul-mobl>
References: <202011030351.iq9CBMO3-lkp@intel.com>
 <e0d74391-18ae-0493-b8a1-cbeb6f00bde8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0d74391-18ae-0493-b8a1-cbeb6f00bde8@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 04-11-20, 19:32, Randy Dunlap wrote:
> On 11/2/20 11:47 AM, kernel test robot wrote:
> > All errors (new ones prefixed by >>):
> > 
> >    or1k-linux-ld: drivers/soundwire/qcom.o: in function `qcom_swrm_probe':
> >>> drivers/soundwire/qcom.c:767: undefined reference to `slimbus_bus'
> >>> or1k-linux-ld: drivers/soundwire/qcom.c:771: undefined reference to `slimbus_bus'
> > 
> > 09309093d5e8f87 Jonathan Marek       2020-09-08  770  #if IS_ENABLED(CONFIG_SLIMBUS)
> > 02efb49aa805cee Srinivas Kandagatla  2020-01-13 @771  	if (dev->parent->bus == &slimbus_bus) {
> > 5bd773242f75da3 Jonathan Marek       2020-09-05  772  #else
> > 5bd773242f75da3 Jonathan Marek       2020-09-05  773  	if (false) {
> > 5bd773242f75da3 Jonathan Marek       2020-09-05  774  #endif
> 
> config SOUNDWIRE_QCOM
> 	tristate "Qualcomm SoundWire Master driver"
> 	imply SLIMBUS
> 	depends on SND_SOC
> 
> The kernel config that was attached has:
> CONFIG_SOUNDWIRE_QCOM=y
> CONFIG_SLIMBUS=m
> 
> I expected that "imply" would make SLIMBUS=y since SOUNDWIRE_QCOM=y,
> but I guess that's not the case. :(
> 
> Any ideas about what to do here?

Sorry to have missed this earlier. I did some digging and found the
Kconfig code to be correct, but not the driver code. Per the
Documentation if we are using imply we should use IS_REACHABLE() rather
than IS_ENABLED.

This seems to take care of build failure for me on arm64 and x64 builds.

Can you confirm with below patch:

---><8---

From: Vinod Koul <vkoul@kernel.org>
Date: Wed, 25 Nov 2020 11:15:22 +0530
Subject: [PATCH] soundwire: qcom: Fix build failure when slimbus is module

Commit 5bd773242f75 ("soundwire: qcom: avoid dependency on
CONFIG_SLIMBUS") removed hard dependency on Slimbus for qcom driver but
it results in build failure when:
CONFIG_SOUNDWIRE_QCOM=y
CONFIG_SLIMBUS=m

drivers/soundwire/qcom.o: In function `qcom_swrm_probe':
qcom.c:(.text+0xf44): undefined reference to `slimbus_bus'

Fix this by using IS_REACHABLE() in driver which is recommended to be
sued with imply.

Fixes: 5bd773242f75 ("soundwire: qcom: avoid dependency on CONFIG_SLIMBUS")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index fbca4ebf63e9..6d22df01f354 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -799,7 +799,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	data = of_device_get_match_data(dev);
 	ctrl->rows_index = sdw_find_row_index(data->default_rows);
 	ctrl->cols_index = sdw_find_col_index(data->default_cols);
-#if IS_ENABLED(CONFIG_SLIMBUS)
+#if IS_REACHABLE(CONFIG_SLIMBUS)
 	if (dev->parent->bus == &slimbus_bus) {
 #else
 	if (false) {
-- 
2.26.2

-- 
~Vinod
