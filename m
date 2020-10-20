Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC63B293739
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389919AbgJTI4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:56:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:62918 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389938AbgJTI4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:56:10 -0400
IronPort-SDR: ki12G4yFSql0FzMTRGNJEy6OaFSvSgsoWPHmt9QtVMf4FQ+9MwwyVyx25l71Qu6aS9fwXrqepR
 dGD6cxDnpD3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="167296737"
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="167296737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 01:56:09 -0700
IronPort-SDR: 095BdRa+j8h8zH0MGWtN/hlBfC//dclv2M5qc7ndjmdiDmX+ALdGtG+QNijs71FnYFZJGOGEjT
 Ak1MaRIVPs8Q==
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="532973518"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 01:56:02 -0700
Subject: Re: [kbuild-all] Re: drivers/pinctrl/renesas/pinctrl-rzn1.c:183:52:
 sparse: sparse: dubious: x | !y
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <202010201527.PTQTs5C6-lkp@intel.com>
 <CAMuHMdWRXQEoa2w6NHP-GwkyS=SN5GpZk=GOxOUsisHJRntsOw@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <d72de238-869d-8684-a74d-ef43ae33979f@intel.com>
Date:   Tue, 20 Oct 2020 16:55:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWRXQEoa2w6NHP-GwkyS=SN5GpZk=GOxOUsisHJRntsOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/20 3:49 PM, Geert Uytterhoeven wrote:
> Hi Kernel Test Robot,
>
> On Tue, Oct 20, 2020 at 9:42 AM kernel test robot <lkp@intel.com> wrote:
>> First bad commit (maybe != root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   270315b8235e3d10c2e360cff56c2f9e0915a252
>> commit: 077365a941166f3a7f5894017f9d26d17cdec00e pinctrl: Rename sh-pfc to renesas
>> date:   5 weeks ago
>> config: x86_64-randconfig-s032-20201020 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>> reproduce:
>>          # apt-get install sparse
>>          # sparse version: v0.6.3-dirty
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=077365a941166f3a7f5894017f9d26d17cdec00e
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 077365a941166f3a7f5894017f9d26d17cdec00e
>>          # save the attached .config to linux build tree
>>          make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> "sparse warnings: (new ones prefixed by >>)"
>>>> drivers/pinctrl/renesas/pinctrl-rzn1.c:183:52: sparse: sparse: dubious: x | !y
>>     drivers/pinctrl/renesas/pinctrl-rzn1.c:189:52: sparse: sparse: dubious: x | !y
> This is a false positive, cfr.
> https://lore.kernel.org/linux-renesas-soc/CAMuHMdV=aWj9ePL9gAa-vsmLLUZkY4ip2337am8A7ktxg7Yniw@mail.gmail.com/

Hi Geert,

Thanks for the information, we'll double check such warning in the future.

Best Regards,
Rong Chen
