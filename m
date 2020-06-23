Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02853204BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 10:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbgFWIHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 04:07:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:36270 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbgFWIHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:07:24 -0400
IronPort-SDR: cDDdtKh1MV5MxNhi7BBoiqG79NA3c5NMS48K9iZxQx6dWIS/EmfuCU7dx5SHrdM/AbAX1qbJXD
 xno9n7v4jItg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="228661174"
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="228661174"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 00:37:17 -0700
IronPort-SDR: TIQYIZ7axz2/NXi2pAHolWo8voOrtqFtuAoqb0/Lo+SRI1Bh8JUK0+VeQdpC8Vkg7vT5aXxTfP
 XIwfkJvbjlIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="319080731"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2020 00:37:15 -0700
Subject: Re: [kbuild-all] Re: ld.lld: warning:
 drivers/built-in.a(misc/ds1682.o):(.data..compoundliteral) is being placed in
 '.data..compoundliteral'
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>
References: <202006180904.TVUXCf6H%lkp@intel.com>
 <150a9a49-8d61-ea34-94d4-fff158aae802@csgroup.eu>
 <CAKwvOd=s53vUELe311VSjxt2_eQd+RGNCf__n+cV+R=PQ_CdXQ@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <dd9c7024-c80b-ff28-e8bf-ac818f14c50f@intel.com>
Date:   Tue, 23 Jun 2020 15:36:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=s53vUELe311VSjxt2_eQd+RGNCf__n+cV+R=PQ_CdXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/20 12:32 AM, Nick Desaulniers wrote:
> On Fri, Jun 19, 2020 at 6:24 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>>
>> Le 18/06/2020 à 03:12, kernel test robot a écrit :
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   1b5044021070efa3259f3e9548dc35d1eb6aa844
>>> commit: 74016701fe5f873ae23bf02835407227138d874d powerpc/32s: Fix another build failure with CONFIG_PPC_KUAP_DEBUG
>> I'm really having hard time understanding the link between this commit
>> and the issue reported below.
>>
>> Can Clang people help understand what the problem might be ?
> For randconfigs, it might be the case that we're not clean in the
> first place. + Philip to provide more info on how the bisection
> pinpoints commits? (Is the same randconfig used repeatedly as part of
> a bisection?)

Hi,

The commit is not the root cause, bisection stopped at a wrong commit
because parent commit failed earlier before the ld.lld error, we're going
to optimize the bisect logic to avoid false positive.

Best Regards,
Rong Chen

>
> + Kees, idk if this is the warning from the orphan section placement,
> if any of those patches have landed?
>
> + Fangrui, who might know more about this warning from LLD.
>
>> Christophe
>>
>>> date:   2 weeks ago
>>> config: powerpc-randconfig-r032-20200617 (attached as .config)
>>> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 487ca07fcc75d52755c9fe2ee05bcb3b6eeeec44)
>>> reproduce (this is a W=1 build):
>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>           chmod +x ~/bin/make.cross
>>>           # install powerpc cross compiling tool for clang build
>>>           # apt-get install binutils-powerpc-linux-gnu
>>>           git checkout 74016701fe5f873ae23bf02835407227138d874d
>>>           # save the attached .config to linux build tree
>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>>>
>>>>> ld.lld: warning: drivers/built-in.a(misc/ds1682.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.29) is being placed in '.data..compoundliteral.29'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.31) is being placed in '.data..compoundliteral.31'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.33) is being placed in '.data..compoundliteral.33'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.bss..compoundliteral.35) is being placed in '.bss..compoundliteral.35'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.37) is being placed in '.data..compoundliteral.37'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.39) is being placed in '.data..compoundliteral.39'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.41) is being placed in '.data..compoundliteral.41'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.43) is being placed in '.data..compoundliteral.43'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.45) is being placed in '.data..compoundliteral.45'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.47) is being placed in '.data..compoundliteral.47'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.49) is being placed in '.data..compoundliteral.49'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.51) is being placed in '.data..compoundliteral.51'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.53) is being placed in '.data..compoundliteral.53'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.55) is being placed in '.data..compoundliteral.55'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.57) is being placed in '.data..compoundliteral.57'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.59) is being placed in '.data..compoundliteral.59'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.61) is being placed in '.data..compoundliteral.61'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.63) is being placed in '.data..compoundliteral.63'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.65) is being placed in '.data..compoundliteral.65'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.67) is being placed in '.data..compoundliteral.67'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.69) is being placed in '.data..compoundliteral.69'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.71) is being placed in '.data..compoundliteral.71'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.73) is being placed in '.data..compoundliteral.73'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.75) is being placed in '.data..compoundliteral.75'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.77) is being placed in '.data..compoundliteral.77'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.79) is being placed in '.data..compoundliteral.79'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.81) is being placed in '.data..compoundliteral.81'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.83) is being placed in '.data..compoundliteral.83'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.85) is being placed in '.data..compoundliteral.85'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.87) is being placed in '.data..compoundliteral.87'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.89) is being placed in '.data..compoundliteral.89'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.91) is being placed in '.data..compoundliteral.91'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.93) is being placed in '.data..compoundliteral.93'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.95) is being placed in '.data..compoundliteral.95'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.97) is being placed in '.data..compoundliteral.97'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.99) is being placed in '.data..compoundliteral.99'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.101) is being placed in '.data..compoundliteral.101'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.103) is being placed in '.data..compoundliteral.103'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.105) is being placed in '.data..compoundliteral.105'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.107) is being placed in '.data..compoundliteral.107'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.109) is being placed in '.data..compoundliteral.109'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.111) is being placed in '.data..compoundliteral.111'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.113) is being placed in '.data..compoundliteral.113'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.115) is being placed in '.data..compoundliteral.115'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.117) is being placed in '.data..compoundliteral.117'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.119) is being placed in '.data..compoundliteral.119'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.121) is being placed in '.data..compoundliteral.121'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.123) is being placed in '.data..compoundliteral.123'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.125) is being placed in '.data..compoundliteral.125'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.127) is being placed in '.data..compoundliteral.127'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.129) is being placed in '.data..compoundliteral.129'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.131) is being placed in '.data..compoundliteral.131'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.133) is being placed in '.data..compoundliteral.133'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.135) is being placed in '.data..compoundliteral.135'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.137) is being placed in '.data..compoundliteral.137'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.139) is being placed in '.data..compoundliteral.139'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.141) is being placed in '.data..compoundliteral.141'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.143) is being placed in '.data..compoundliteral.143'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.145) is being placed in '.data..compoundliteral.145'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.147) is being placed in '.data..compoundliteral.147'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.149) is being placed in '.data..compoundliteral.149'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.151) is being placed in '.data..compoundliteral.151'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.153) is being placed in '.data..compoundliteral.153'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.155) is being placed in '.data..compoundliteral.155'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.157) is being placed in '.data..compoundliteral.157'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.159) is being placed in '.data..compoundliteral.159'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.161) is being placed in '.data..compoundliteral.161'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.163) is being placed in '.data..compoundliteral.163'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.165) is being placed in '.data..compoundliteral.165'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.167) is being placed in '.data..compoundliteral.167'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.169) is being placed in '.data..compoundliteral.169'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.171) is being placed in '.data..compoundliteral.171'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.173) is being placed in '.data..compoundliteral.173'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.175) is being placed in '.data..compoundliteral.175'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.177) is being placed in '.data..compoundliteral.177'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.179) is being placed in '.data..compoundliteral.179'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.181) is being placed in '.data..compoundliteral.181'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.183) is being placed in '.data..compoundliteral.183'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.185) is being placed in '.data..compoundliteral.185'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.187) is being placed in '.data..compoundliteral.187'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.189) is being placed in '.data..compoundliteral.189'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.191) is being placed in '.data..compoundliteral.191'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.193) is being placed in '.data..compoundliteral.193'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.195) is being placed in '.data..compoundliteral.195'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.197) is being placed in '.data..compoundliteral.197'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.199) is being placed in '.data..compoundliteral.199'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.201) is being placed in '.data..compoundliteral.201'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.203) is being placed in '.data..compoundliteral.203'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.205) is being placed in '.data..compoundliteral.205'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.207) is being placed in '.data..compoundliteral.207'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.209) is being placed in '.data..compoundliteral.209'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.211) is being placed in '.data..compoundliteral.211'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.213) is being placed in '.data..compoundliteral.213'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.215) is being placed in '.data..compoundliteral.215'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.217) is being placed in '.data..compoundliteral.217'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.219) is being placed in '.data..compoundliteral.219'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.221) is being placed in '.data..compoundliteral.221'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.223) is being placed in '.data..compoundliteral.223'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.225) is being placed in '.data..compoundliteral.225'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.227) is being placed in '.data..compoundliteral.227'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.229) is being placed in '.data..compoundliteral.229'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.231) is being placed in '.data..compoundliteral.231'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.233) is being placed in '.data..compoundliteral.233'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.235) is being placed in '.data..compoundliteral.235'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.237) is being placed in '.data..compoundliteral.237'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.239) is being placed in '.data..compoundliteral.239'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.241) is being placed in '.data..compoundliteral.241'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.243) is being placed in '.data..compoundliteral.243'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.245) is being placed in '.data..compoundliteral.245'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.247) is being placed in '.data..compoundliteral.247'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.249) is being placed in '.data..compoundliteral.249'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.251) is being placed in '.data..compoundliteral.251'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.253) is being placed in '.data..compoundliteral.253'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.255) is being placed in '.data..compoundliteral.255'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.257) is being placed in '.data..compoundliteral.257'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.259) is being placed in '.data..compoundliteral.259'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.261) is being placed in '.data..compoundliteral.261'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.263) is being placed in '.data..compoundliteral.263'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.265) is being placed in '.data..compoundliteral.265'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.267) is being placed in '.data..compoundliteral.267'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.269) is being placed in '.data..compoundliteral.269'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.271) is being placed in '.data..compoundliteral.271'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.273) is being placed in '.data..compoundliteral.273'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.275) is being placed in '.data..compoundliteral.275'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.277) is being placed in '.data..compoundliteral.277'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.279) is being placed in '.data..compoundliteral.279'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.281) is being placed in '.data..compoundliteral.281'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.283) is being placed in '.data..compoundliteral.283'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.285) is being placed in '.data..compoundliteral.285'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.287) is being placed in '.data..compoundliteral.287'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.289) is being placed in '.data..compoundliteral.289'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.294) is being placed in '.data..compoundliteral.294'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.295) is being placed in '.data..compoundliteral.295'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.296) is being placed in '.data..compoundliteral.296'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.297) is being placed in '.data..compoundliteral.297'
>>>>> ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>>>> ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compoundliteral.18) is being placed in '.data..compoundliteral.18'
>>> ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compoundliteral.19) is being placed in '.data..compoundliteral.19'
>>> ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compoundliteral.20) is being placed in '.data..compoundliteral.20'
>>> ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compoundliteral.21) is being placed in '.data..compoundliteral.21'
>>> ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compoundliteral.22) is being placed in '.data..compoundliteral.22'
>>>>> ld.lld: warning: drivers/built-in.a(hwmon/max6650.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>>>> ld.lld: warning: drivers/built-in.a(hwmon/max6650.o):(.data..compoundliteral.15) is being placed in '.data..compoundliteral.15'
>>> ld.lld: warning: drivers/built-in.a(hwmon/max6650.o):(.data..compoundliteral.16) is being placed in '.data..compoundliteral.16'
>>> ld.lld: warning: drivers/built-in.a(hwmon/max6650.o):(.data..compoundliteral.17) is being placed in '.data..compoundliteral.17'
>>>>> ld.lld: warning: drivers/built-in.a(hwmon/max31790.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>>>> ld.lld: warning: drivers/built-in.a(hwmon/max31790.o):(.data..compoundliteral.2) is being placed in '.data..compoundliteral.2'
>>> ld.lld: warning: drivers/built-in.a(hwmon/max31790.o):(.data..compoundliteral.3) is being placed in '.data..compoundliteral.3'
>>> ld.lld: warning: drivers/built-in.a(hwmon/max31790.o):(.data..compoundliteral.4) is being placed in '.data..compoundliteral.4'
>>>>> ld.lld: warning: drivers/built-in.a(hwmon/tmp102.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>>>> ld.lld: warning: drivers/built-in.a(hwmon/tmp102.o):(.data..compoundliteral.10) is being placed in '.data..compoundliteral.10'
>>> ld.lld: warning: drivers/built-in.a(hwmon/tmp102.o):(.data..compoundliteral.11) is being placed in '.data..compoundliteral.11'
>>> ld.lld: warning: drivers/built-in.a(hwmon/tmp102.o):(.data..compoundliteral.12) is being placed in '.data..compoundliteral.12'
>>>>> ld.lld: warning: drivers/built-in.a(cpufreq/cpufreq-dt-platdev.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>>>> ld.lld: warning: drivers/built-in.a(hid/hid-cp2112.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>>>> ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>>>> ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundliteral.2) is being placed in '.data..compoundliteral.2'
>>> ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundliteral.3) is being placed in '.data..compoundliteral.3'
>>> ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundliteral.4) is being placed in '.data..compoundliteral.4'
>>> ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundliteral.5) is being placed in '.data..compoundliteral.5'
>>> ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundliteral.6) is being placed in '.data..compoundliteral.6'
>>> ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundliteral.7) is being placed in '.data..compoundliteral.7'
>>> ld.lld: warning: net/built-in.a(ipv6/addrconf_core.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>> ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
>>> ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
>>> ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'
>>>>> ld.lld: warning: drivers/built-in.a(misc/ds1682.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.29) is being placed in '.data..compoundliteral.29'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.31) is being placed in '.data..compoundliteral.31'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.33) is being placed in '.data..compoundliteral.33'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.bss..compoundliteral.35) is being placed in '.bss..compoundliteral.35'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.37) is being placed in '.data..compoundliteral.37'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.39) is being placed in '.data..compoundliteral.39'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.41) is being placed in '.data..compoundliteral.41'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.43) is being placed in '.data..compoundliteral.43'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.45) is being placed in '.data..compoundliteral.45'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.47) is being placed in '.data..compoundliteral.47'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.49) is being placed in '.data..compoundliteral.49'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.51) is being placed in '.data..compoundliteral.51'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.53) is being placed in '.data..compoundliteral.53'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.55) is being placed in '.data..compoundliteral.55'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.57) is being placed in '.data..compoundliteral.57'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.59) is being placed in '.data..compoundliteral.59'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.61) is being placed in '.data..compoundliteral.61'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.63) is being placed in '.data..compoundliteral.63'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.65) is being placed in '.data..compoundliteral.65'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.67) is being placed in '.data..compoundliteral.67'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.69) is being placed in '.data..compoundliteral.69'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.71) is being placed in '.data..compoundliteral.71'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.73) is being placed in '.data..compoundliteral.73'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.75) is being placed in '.data..compoundliteral.75'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.77) is being placed in '.data..compoundliteral.77'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.79) is being placed in '.data..compoundliteral.79'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.81) is being placed in '.data..compoundliteral.81'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.83) is being placed in '.data..compoundliteral.83'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.85) is being placed in '.data..compoundliteral.85'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.87) is being placed in '.data..compoundliteral.87'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.89) is being placed in '.data..compoundliteral.89'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.91) is being placed in '.data..compoundliteral.91'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.93) is being placed in '.data..compoundliteral.93'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.95) is being placed in '.data..compoundliteral.95'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.97) is being placed in '.data..compoundliteral.97'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.99) is being placed in '.data..compoundliteral.99'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.101) is being placed in '.data..compoundliteral.101'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.103) is being placed in '.data..compoundliteral.103'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.105) is being placed in '.data..compoundliteral.105'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.107) is being placed in '.data..compoundliteral.107'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.109) is being placed in '.data..compoundliteral.109'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.111) is being placed in '.data..compoundliteral.111'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.113) is being placed in '.data..compoundliteral.113'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.115) is being placed in '.data..compoundliteral.115'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.117) is being placed in '.data..compoundliteral.117'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.119) is being placed in '.data..compoundliteral.119'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.121) is being placed in '.data..compoundliteral.121'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.123) is being placed in '.data..compoundliteral.123'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.125) is being placed in '.data..compoundliteral.125'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.127) is being placed in '.data..compoundliteral.127'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.129) is being placed in '.data..compoundliteral.129'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.131) is being placed in '.data..compoundliteral.131'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.133) is being placed in '.data..compoundliteral.133'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.135) is being placed in '.data..compoundliteral.135'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.137) is being placed in '.data..compoundliteral.137'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.139) is being placed in '.data..compoundliteral.139'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.141) is being placed in '.data..compoundliteral.141'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.143) is being placed in '.data..compoundliteral.143'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.145) is being placed in '.data..compoundliteral.145'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.147) is being placed in '.data..compoundliteral.147'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.149) is being placed in '.data..compoundliteral.149'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.151) is being placed in '.data..compoundliteral.151'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.153) is being placed in '.data..compoundliteral.153'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.155) is being placed in '.data..compoundliteral.155'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.157) is being placed in '.data..compoundliteral.157'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.159) is being placed in '.data..compoundliteral.159'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.161) is being placed in '.data..compoundliteral.161'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.163) is being placed in '.data..compoundliteral.163'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.165) is being placed in '.data..compoundliteral.165'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.167) is being placed in '.data..compoundliteral.167'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.169) is being placed in '.data..compoundliteral.169'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.171) is being placed in '.data..compoundliteral.171'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.173) is being placed in '.data..compoundliteral.173'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.175) is being placed in '.data..compoundliteral.175'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.177) is being placed in '.data..compoundliteral.177'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.179) is being placed in '.data..compoundliteral.179'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.181) is being placed in '.data..compoundliteral.181'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.183) is being placed in '.data..compoundliteral.183'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.185) is being placed in '.data..compoundliteral.185'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.187) is being placed in '.data..compoundliteral.187'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.189) is being placed in '.data..compoundliteral.189'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.191) is being placed in '.data..compoundliteral.191'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.193) is being placed in '.data..compoundliteral.193'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.195) is being placed in '.data..compoundliteral.195'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.197) is being placed in '.data..compoundliteral.197'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.199) is being placed in '.data..compoundliteral.199'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.201) is being placed in '.data..compoundliteral.201'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.203) is being placed in '.data..compoundliteral.203'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.205) is being placed in '.data..compoundliteral.205'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.207) is being placed in '.data..compoundliteral.207'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.209) is being placed in '.data..compoundliteral.209'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.211) is being placed in '.data..compoundliteral.211'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.213) is being placed in '.data..compoundliteral.213'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.215) is being placed in '.data..compoundliteral.215'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.217) is being placed in '.data..compoundliteral.217'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.219) is being placed in '.data..compoundliteral.219'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.221) is being placed in '.data..compoundliteral.221'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.223) is being placed in '.data..compoundliteral.223'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.225) is being placed in '.data..compoundliteral.225'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.227) is being placed in '.data..compoundliteral.227'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.229) is being placed in '.data..compoundliteral.229'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.231) is being placed in '.data..compoundliteral.231'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.233) is being placed in '.data..compoundliteral.233'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.235) is being placed in '.data..compoundliteral.235'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.237) is being placed in '.data..compoundliteral.237'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.239) is being placed in '.data..compoundliteral.239'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.241) is being placed in '.data..compoundliteral.241'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.243) is being placed in '.data..compoundliteral.243'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.245) is being placed in '.data..compoundliteral.245'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.247) is being placed in '.data..compoundliteral.247'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.249) is being placed in '.data..compoundliteral.249'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.251) is being placed in '.data..compoundliteral.251'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.253) is being placed in '.data..compoundliteral.253'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.255) is being placed in '.data..compoundliteral.255'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.257) is being placed in '.data..compoundliteral.257'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.259) is being placed in '.data..compoundliteral.259'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.261) is being placed in '.data..compoundliteral.261'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.263) is being placed in '.data..compoundliteral.263'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.265) is being placed in '.data..compoundliteral.265'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.267) is being placed in '.data..compoundliteral.267'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.269) is being placed in '.data..compoundliteral.269'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.271) is being placed in '.data..compoundliteral.271'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.273) is being placed in '.data..compoundliteral.273'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.275) is being placed in '.data..compoundliteral.275'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.277) is being placed in '.data..compoundliteral.277'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.279) is being placed in '.data..compoundliteral.279'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.281) is being placed in '.data..compoundliteral.281'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.283) is being placed in '.data..compoundliteral.283'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.285) is being placed in '.data..compoundliteral.285'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.287) is being placed in '.data..compoundliteral.287'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.289) is being placed in '.data..compoundliteral.289'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.294) is being placed in '.data..compoundliteral.294'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.295) is being placed in '.data..compoundliteral.295'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.296) is being placed in '.data..compoundliteral.296'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.297) is being placed in '.data..compoundliteral.297'
>>>>> ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>>>> ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compoundliteral.18) is being placed in '.data..compoundliteral.18'
>>> ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compoundliteral.19) is being placed in '.data..compoundliteral.19'
>>> ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compoundliteral.20) is being placed in '.data..compoundliteral.20'
>>> ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compoundliteral.21) is being placed in '.data..compoundliteral.21'
>>> ld.lld: warning: drivers/built-in.a(hwmon/ina3221.o):(.data..compoundliteral.22) is being placed in '.data..compoundliteral.22'
>>>>> ld.lld: warning: drivers/built-in.a(hwmon/max6650.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>>>> ld.lld: warning: drivers/built-in.a(hwmon/max6650.o):(.data..compoundliteral.15) is being placed in '.data..compoundliteral.15'
>>> ld.lld: warning: drivers/built-in.a(hwmon/max6650.o):(.data..compoundliteral.16) is being placed in '.data..compoundliteral.16'
>>> ld.lld: warning: drivers/built-in.a(hwmon/max6650.o):(.data..compoundliteral.17) is being placed in '.data..compoundliteral.17'
>>>>> ld.lld: warning: drivers/built-in.a(hwmon/max31790.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>>>> ld.lld: warning: drivers/built-in.a(hwmon/max31790.o):(.data..compoundliteral.2) is being placed in '.data..compoundliteral.2'
>>> ld.lld: warning: drivers/built-in.a(hwmon/max31790.o):(.data..compoundliteral.3) is being placed in '.data..compoundliteral.3'
>>> ld.lld: warning: drivers/built-in.a(hwmon/max31790.o):(.data..compoundliteral.4) is being placed in '.data..compoundliteral.4'
>>> ld.lld: warning: drivers/built-in.a(hwmon/tmp102.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>> ld.lld: warning: drivers/built-in.a(hwmon/tmp102.o):(.data..compoundliteral.10) is being placed in '.data..compoundliteral.10'
>>> ld.lld: warning: drivers/built-in.a(hwmon/tmp102.o):(.data..compoundliteral.11) is being placed in '.data..compoundliteral.11'
>>> ld.lld: warning: drivers/built-in.a(hwmon/tmp102.o):(.data..compoundliteral.12) is being placed in '.data..compoundliteral.12'
>>> ld.lld: warning: drivers/built-in.a(cpufreq/cpufreq-dt-platdev.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>> ld.lld: warning: drivers/built-in.a(hid/hid-cp2112.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>> ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>> ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundliteral.2) is being placed in '.data..compoundliteral.2'
>>> ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundliteral.3) is being placed in '.data..compoundliteral.3'
>>> ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundliteral.4) is being placed in '.data..compoundliteral.4'
>>> ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundliteral.5) is being placed in '.data..compoundliteral.5'
>>> ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundliteral.6) is being placed in '.data..compoundliteral.6'
>>> ld.lld: warning: net/built-in.a(ipv6/addrlabel.o):(.data..compoundliteral.7) is being placed in '.data..compoundliteral.7'
>>> ld.lld: warning: net/built-in.a(ipv6/addrconf_core.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>> ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
>>> ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
>>> ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'
>>> ld.lld: warning: drivers/built-in.a(misc/ds1682.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral) is being placed in '.data..compoundliteral'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.29) is being placed in '.data..compoundliteral.29'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.31) is being placed in '.data..compoundliteral.31'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.33) is being placed in '.data..compoundliteral.33'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.bss..compoundliteral.35) is being placed in '.bss..compoundliteral.35'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.37) is being placed in '.data..compoundliteral.37'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.39) is being placed in '.data..compoundliteral.39'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.41) is being placed in '.data..compoundliteral.41'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.43) is being placed in '.data..compoundliteral.43'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.45) is being placed in '.data..compoundliteral.45'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.47) is being placed in '.data..compoundliteral.47'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.49) is being placed in '.data..compoundliteral.49'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.51) is being placed in '.data..compoundliteral.51'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.53) is being placed in '.data..compoundliteral.53'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.55) is being placed in '.data..compoundliteral.55'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.57) is being placed in '.data..compoundliteral.57'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.59) is being placed in '.data..compoundliteral.59'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.61) is being placed in '.data..compoundliteral.61'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.63) is being placed in '.data..compoundliteral.63'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.65) is being placed in '.data..compoundliteral.65'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.67) is being placed in '.data..compoundliteral.67'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.69) is being placed in '.data..compoundliteral.69'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.71) is being placed in '.data..compoundliteral.71'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.73) is being placed in '.data..compoundliteral.73'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.75) is being placed in '.data..compoundliteral.75'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.77) is being placed in '.data..compoundliteral.77'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.79) is being placed in '.data..compoundliteral.79'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.81) is being placed in '.data..compoundliteral.81'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.83) is being placed in '.data..compoundliteral.83'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.85) is being placed in '.data..compoundliteral.85'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.87) is being placed in '.data..compoundliteral.87'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.89) is being placed in '.data..compoundliteral.89'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.91) is being placed in '.data..compoundliteral.91'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.93) is being placed in '.data..compoundliteral.93'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.95) is being placed in '.data..compoundliteral.95'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.97) is being placed in '.data..compoundliteral.97'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.99) is being placed in '.data..compoundliteral.99'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.101) is being placed in '.data..compoundliteral.101'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.103) is being placed in '.data..compoundliteral.103'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.105) is being placed in '.data..compoundliteral.105'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.107) is being placed in '.data..compoundliteral.107'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.109) is being placed in '.data..compoundliteral.109'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.111) is being placed in '.data..compoundliteral.111'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.113) is being placed in '.data..compoundliteral.113'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.115) is being placed in '.data..compoundliteral.115'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.117) is being placed in '.data..compoundliteral.117'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.119) is being placed in '.data..compoundliteral.119'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.121) is being placed in '.data..compoundliteral.121'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.123) is being placed in '.data..compoundliteral.123'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.125) is being placed in '.data..compoundliteral.125'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.127) is being placed in '.data..compoundliteral.127'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.129) is being placed in '.data..compoundliteral.129'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.131) is being placed in '.data..compoundliteral.131'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.133) is being placed in '.data..compoundliteral.133'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.135) is being placed in '.data..compoundliteral.135'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.137) is being placed in '.data..compoundliteral.137'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.139) is being placed in '.data..compoundliteral.139'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.141) is being placed in '.data..compoundliteral.141'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.143) is being placed in '.data..compoundliteral.143'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.145) is being placed in '.data..compoundliteral.145'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.147) is being placed in '.data..compoundliteral.147'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.149) is being placed in '.data..compoundliteral.149'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.151) is being placed in '.data..compoundliteral.151'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.153) is being placed in '.data..compoundliteral.153'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.155) is being placed in '.data..compoundliteral.155'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.157) is being placed in '.data..compoundliteral.157'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.159) is being placed in '.data..compoundliteral.159'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.161) is being placed in '.data..compoundliteral.161'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.163) is being placed in '.data..compoundliteral.163'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.165) is being placed in '.data..compoundliteral.165'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.167) is being placed in '.data..compoundliteral.167'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.169) is being placed in '.data..compoundliteral.169'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.171) is being placed in '.data..compoundliteral.171'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.173) is being placed in '.data..compoundliteral.173'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.175) is being placed in '.data..compoundliteral.175'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.177) is being placed in '.data..compoundliteral.177'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.179) is being placed in '.data..compoundliteral.179'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.181) is being placed in '.data..compoundliteral.181'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.183) is being placed in '.data..compoundliteral.183'
>>> ld.lld: warning: drivers/built-in.a(net/phy/mdio_bus.o):(.data..compoundliteral.185) is being placed in '.data..compoundliteral.185'
>>>
>>> ---
>>> 0-DAY CI Kernel Test Service, Intel Corporation
>>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>>
>
>

