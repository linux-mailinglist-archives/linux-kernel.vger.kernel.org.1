Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55482C46D6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbgKYRbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730585AbgKYRbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:31:48 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5199FC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 09:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=sIqavWIU/mrQicWvL0KfH6FQlzXzymdAsQA6+ryFvwo=; b=GaOiLhHXFI1cPUREWJAWySfCgB
        vg5y+YLo7nORpAdr0HWaaFeSubqzDYU+8wMpUb0b1pulyrv0YyiWX1J7e5eka3GKfOptTIHuJ54UZ
        5Up61/EtrJCtU/OIw/rO5fAVl3GEwI6cCrzFBpmY6k84Oje9NoYlEAwvT/nDYOjPOpnd8ef1HlURL
        hNLBw03Wkhe5S4m3Spch6bilsdZxIxoPPdtm5D6hzcSxLInh68frjtekBh3+f+OA7ChYiamzH9AEG
        i5H5SUL3LQMgLmLKy2ZhB6dlQlUq6TNIaYXTuF+xTcPprqyjVQ99hyaq95FFFsfgmFIvMKN9PGqPZ
        dvUBbotw==;
Received: from [2601:1c0:6280:3f0::1935] (helo=dragon.site)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khydo-0005Eo-Vu; Wed, 25 Nov 2020 17:31:41 +0000
Subject: Re: drivers/soundwire/qcom.c:767: undefined reference to
 `slimbus_bus'
To:     Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel test robot <lkp@intel.com>,
        Jonathan Marek <jonathan@marek.ca>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <202011030351.iq9CBMO3-lkp@intel.com>
 <e0d74391-18ae-0493-b8a1-cbeb6f00bde8@infradead.org>
 <20201125055155.GD8403@vkoul-mobl>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6e298ed8-dc23-7a1f-1bb1-44ba2f43ee07@infradead.org>
Date:   Wed, 25 Nov 2020 09:31:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125055155.GD8403@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/20 9:51 PM, Vinod Koul wrote:
> Hi Randy,
> 
> On 04-11-20, 19:32, Randy Dunlap wrote:
>> On 11/2/20 11:47 AM, kernel test robot wrote:
>>> All errors (new ones prefixed by >>):
>>>
>>>     or1k-linux-ld: drivers/soundwire/qcom.o: in function `qcom_swrm_probe':
>>>>> drivers/soundwire/qcom.c:767: undefined reference to `slimbus_bus'
>>>>> or1k-linux-ld: drivers/soundwire/qcom.c:771: undefined reference to `slimbus_bus'
>>>
>>> 09309093d5e8f87 Jonathan Marek       2020-09-08  770  #if IS_ENABLED(CONFIG_SLIMBUS)
>>> 02efb49aa805cee Srinivas Kandagatla  2020-01-13 @771  	if (dev->parent->bus == &slimbus_bus) {
>>> 5bd773242f75da3 Jonathan Marek       2020-09-05  772  #else
>>> 5bd773242f75da3 Jonathan Marek       2020-09-05  773  	if (false) {
>>> 5bd773242f75da3 Jonathan Marek       2020-09-05  774  #endif
>>
>> config SOUNDWIRE_QCOM
>> 	tristate "Qualcomm SoundWire Master driver"
>> 	imply SLIMBUS
>> 	depends on SND_SOC
>>
>> The kernel config that was attached has:
>> CONFIG_SOUNDWIRE_QCOM=y
>> CONFIG_SLIMBUS=m
>>
>> I expected that "imply" would make SLIMBUS=y since SOUNDWIRE_QCOM=y,
>> but I guess that's not the case. :(
>>
>> Any ideas about what to do here?
> 
> Sorry to have missed this earlier. I did some digging and found the
> Kconfig code to be correct, but not the driver code. Per the
> Documentation if we are using imply we should use IS_REACHABLE() rather
> than IS_ENABLED.
> 
> This seems to take care of build failure for me on arm64 and x64 builds.
> 
> Can you confirm with below patch:
> 
> ---><8---
> 
> From: Vinod Koul <vkoul@kernel.org>
> Date: Wed, 25 Nov 2020 11:15:22 +0530
> Subject: [PATCH] soundwire: qcom: Fix build failure when slimbus is module
> 
> Commit 5bd773242f75 ("soundwire: qcom: avoid dependency on
> CONFIG_SLIMBUS") removed hard dependency on Slimbus for qcom driver but
> it results in build failure when:
> CONFIG_SOUNDWIRE_QCOM=y
> CONFIG_SLIMBUS=m
> 
> drivers/soundwire/qcom.o: In function `qcom_swrm_probe':
> qcom.c:(.text+0xf44): undefined reference to `slimbus_bus'
> 
> Fix this by using IS_REACHABLE() in driver which is recommended to be
> sued with imply.

   used

> 
> Fixes: 5bd773242f75 ("soundwire: qcom: avoid dependency on CONFIG_SLIMBUS")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>   drivers/soundwire/qcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index fbca4ebf63e9..6d22df01f354 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -799,7 +799,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>   	data = of_device_get_match_data(dev);
>   	ctrl->rows_index = sdw_find_row_index(data->default_rows);
>   	ctrl->cols_index = sdw_find_col_index(data->default_cols);
> -#if IS_ENABLED(CONFIG_SLIMBUS)
> +#if IS_REACHABLE(CONFIG_SLIMBUS)
>   	if (dev->parent->bus == &slimbus_bus) {
>   #else
>   	if (false) {
> 

