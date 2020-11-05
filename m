Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AD02A7613
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 04:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbgKEDdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 22:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgKEDdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 22:33:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BBAC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 19:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=L3zOV15Bgjs3dnrs7SWT24aj9bdUSoUf03dVFP7rC+4=; b=XOxtkBzEqqYW150pcncGSvuHXS
        AZyPuH+5NwACs7WgWDKJp+HnLDPPS/CWqwL/cxRUOGLBoFpYwpqXJeCUwg4BzK4jrBw3KGgtOaq/4
        /cf7XDvV05NYAKkh7F9X+9JbiBJH864zOgKyn5tgzH07c4gugCo2rMjb3Mrmu++9oXhR7sXo3Ggte
        Jt/39g3UobuFppScyctrkENIVne8YVpApB+FQF1rEFJ5r98DFazPPQUWCYhnI/PCnkRB3yHMq4XZx
        5JAQpmVJOYS+WEi8XYjMrlqne5XCm5SX5HG+rcIqMK8v4lzgyCwDthGfytmYrHUPAzgtsdzoYlekA
        YnzYAdZw==;
Received: from [2601:1c0:6280:3f0::60d5]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaW10-0005wQ-Kb; Thu, 05 Nov 2020 03:32:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: drivers/soundwire/qcom.c:767: undefined reference to
 `slimbus_bus'
To:     kernel test robot <lkp@intel.com>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <202011030351.iq9CBMO3-lkp@intel.com>
Message-ID: <e0d74391-18ae-0493-b8a1-cbeb6f00bde8@infradead.org>
Date:   Wed, 4 Nov 2020 19:32:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <202011030351.iq9CBMO3-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/20 11:47 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3cea11cd5e3b00d91caf0b4730194039b45c5891
> commit: 09309093d5e8f8774e4a3a0d42b73cf47e9421cf soundwire: qcom: fix SLIBMUS/SLIMBUS typo
> date:   8 weeks ago
> config: openrisc-randconfig-r005-20201102 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09309093d5e8f8774e4a3a0d42b73cf47e9421cf
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 09309093d5e8f8774e4a3a0d42b73cf47e9421cf
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    or1k-linux-ld: drivers/soundwire/qcom.o: in function `qcom_swrm_probe':
>>> drivers/soundwire/qcom.c:767: undefined reference to `slimbus_bus'
>>> or1k-linux-ld: drivers/soundwire/qcom.c:771: undefined reference to `slimbus_bus'
> 
> vim +767 drivers/soundwire/qcom.c
> 
> 02efb49aa805cee Srinivas Kandagatla  2020-01-13  756  
> 02efb49aa805cee Srinivas Kandagatla  2020-01-13  757  static int qcom_swrm_probe(struct platform_device *pdev)
> 02efb49aa805cee Srinivas Kandagatla  2020-01-13  758  {
> 02efb49aa805cee Srinivas Kandagatla  2020-01-13  759  	struct device *dev = &pdev->dev;
> 02efb49aa805cee Srinivas Kandagatla  2020-01-13  760  	struct sdw_master_prop *prop;
> 02efb49aa805cee Srinivas Kandagatla  2020-01-13  761  	struct sdw_bus_params *params;
> 02efb49aa805cee Srinivas Kandagatla  2020-01-13  762  	struct qcom_swrm_ctrl *ctrl;
> 02efb49aa805cee Srinivas Kandagatla  2020-01-13  763  	int ret;
> 02efb49aa805cee Srinivas Kandagatla  2020-01-13  764  	u32 val;
> 02efb49aa805cee Srinivas Kandagatla  2020-01-13  765  
> 02efb49aa805cee Srinivas Kandagatla  2020-01-13  766  	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
> 02efb49aa805cee Srinivas Kandagatla  2020-01-13 @767  	if (!ctrl)
> 02efb49aa805cee Srinivas Kandagatla  2020-01-13  768  		return -ENOMEM;
> 02efb49aa805cee Srinivas Kandagatla  2020-01-13  769  
> 09309093d5e8f87 Jonathan Marek       2020-09-08  770  #if IS_ENABLED(CONFIG_SLIMBUS)
> 02efb49aa805cee Srinivas Kandagatla  2020-01-13 @771  	if (dev->parent->bus == &slimbus_bus) {
> 5bd773242f75da3 Jonathan Marek       2020-09-05  772  #else
> 5bd773242f75da3 Jonathan Marek       2020-09-05  773  	if (false) {
> 5bd773242f75da3 Jonathan Marek       2020-09-05  774  #endif

> :::::: The code at line 767 was first introduced by commit
> :::::: 02efb49aa805cee643a643ab61a1118c2fd08b80 soundwire: qcom: add support for SoundWire controller
> 
> :::::: TO: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> :::::: CC: Vinod Koul <vkoul@kernel.org>


config SOUNDWIRE_QCOM
	tristate "Qualcomm SoundWire Master driver"
	imply SLIMBUS
	depends on SND_SOC

The kernel config that was attached has:
CONFIG_SOUNDWIRE_QCOM=y
CONFIG_SLIMBUS=m

I expected that "imply" would make SLIMBUS=y since SOUNDWIRE_QCOM=y,
but I guess that's not the case. :(

Any ideas about what to do here?

-- 
~Randy

