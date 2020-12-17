Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EB42DCB8F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 05:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgLQEAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 23:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgLQEAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 23:00:36 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8A6C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 19:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=D+U58Hlin8vRDbLHPWBD6r+oyxo4/x6yjr9/Sk9jqEQ=; b=xRE60jGqx6Dpad8UzoN9UBY+1n
        4zdt45djmBL52OQ9IY5+EhspykdCi7FbP0oePOksfOvOj3UdaUd1ae77tgd1CwuI6jl9opFxSmKrj
        cPmaYPT5qXzYnVAbRmKBaU9C2f9UDnUbGux/xH+3+wFOEJHoXm236cZdTczApRSteZXAjFmLh5Ud/
        bJMkOdEWjrajXBmKAJrR99rLBKnoldasCctTFnngNqBwklDDPgpvJUk84y6Q0YfWWNf7Fa/wIvXZf
        78O/m0CP4+qFpn+AiqFYTQseSLS4v/syrAPzsTIMqC5aBbBikrIVlNX0JXITFoJo0y/qmip6tWjvx
        qOMJtUiw==;
Received: from [2601:1c0:6280:3f0::64ea]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpkSF-0008VZ-1f; Thu, 17 Dec 2020 03:59:51 +0000
Subject: Re: [kbuild-all] Re: ERROR: "snd_soc_new_ac97_component" undefined!
To:     Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
References: <202012070230.Vq6VRv8j-lkp@intel.com>
 <ce6a995d-abb2-5599-cd42-bbf8143d3b35@infradead.org>
 <0c496357-7846-1200-39d5-b53fc650e0ac@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7d5afa57-e355-c52f-3743-d3db40594565@infradead.org>
Date:   Wed, 16 Dec 2020 19:59:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <0c496357-7846-1200-39d5-b53fc650e0ac@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/20 7:15 PM, Rong Chen wrote:
> 
> 
> On 12/11/20 8:16 AM, Randy Dunlap wrote:
>> On 12/6/20 10:11 AM, kernel test robot wrote:
>>> Hi Geert,
>>>
>>> First bad commit (maybe != root cause):
>>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   7059c2c00a2196865c2139083cbef47cd18109b6
>>> commit: ea00d95200d02ece71f5814d41b14f2eb16d598b ASoC: Use imply for SND_SOC_ALL_CODECS
>>> date:   10 months ago
>>> config: powerpc-randconfig-r012-20201207 (attached as .config)
>>> compiler: powerpc-linux-gcc (GCC) 9.3.0
>>> reproduce (this is a W=1 build):
>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ea00d95200d02ece71f5814d41b14f2eb16d598b
>>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>          git fetch --no-tags linus master
>>>          git checkout ea00d95200d02ece71f5814d41b14f2eb16d598b
>>>          # save the attached .config to linux build tree
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>     ERROR: "mpc5200_audio_dma_create" [sound/soc/fsl/mpc5200_psc_ac97.ko] undefined!
>>>     ERROR: "mpc5200_audio_dma_destroy" [sound/soc/fsl/mpc5200_psc_ac97.ko] undefined!
>>>>> ERROR: "snd_soc_new_ac97_component" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
>>>>> ERROR: "snd_soc_free_ac97_component" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
>>>     ERROR: "snd_soc_new_ac97_component" [sound/soc/codecs/snd-soc-ad1980.ko] undefined!
>>>     ERROR: "snd_soc_free_ac97_component" [sound/soc/codecs/snd-soc-ad1980.ko] undefined!
>>
>> I also see these:
>>
>> ERROR: modpost: "__regmap_init_ac97" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
>> ERROR: modpost: "regmap_ac97_default_volatile" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
>>
>> and the (usual) missing Kconfig warnings:    :(
>>
>> WARNING: unmet direct dependencies detected for SND_SOC_MPC5200_AC97
>>    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_MPC52xx [=y] && PPC_BESTCOMM [=n]
>>    Selected by [m]:
>>    - SND_MPC52xx_SOC_EFIKA [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_EFIKA [=y]
>>
>> WARNING: unmet direct dependencies detected for SND_SOC_STAC9766
>>    Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_SOC_AC97_BUS [=n]
>>    Selected by [m]:
>>    - SND_MPC52xx_SOC_EFIKA [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_EFIKA [=y]
>>
>> WARNING: unmet direct dependencies detected for HOTPLUG_CPU
>>    Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
>>    Selected by [y]:
>>    - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=y] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]
>>
>>
>>
>> Please begin including Kconfig warnings. I have asked previously but...
>>
>> thanks.
> 
> Hi Randy,
> 
> We have added Kconfig warnings in reports now. please see another report: https://lore.kernel.org/linux-block/202012170150.Y7ycOeI9-lkp@intel.com/

Great!  Thank you for doing this.

-- 
~Randy

