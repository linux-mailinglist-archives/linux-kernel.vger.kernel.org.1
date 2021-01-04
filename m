Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321B82E903F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 06:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbhADFwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 00:52:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:30478 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbhADFwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 00:52:31 -0500
IronPort-SDR: oKb31h6wa6aheULMDFeAn+fCHx+JFgRah71k39ivNOIYzq9OiZyam0L5g+PmKEb+k/evHxmMjg
 sKN9QAH+vSRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="177069682"
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="177069682"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2021 21:51:51 -0800
IronPort-SDR: XDzgff0mVm6XiApff2SJJR+BJlp/nfXL92WO76UlpKpdFSagRS3ewPLxS6FdCfAi3vDIpAVvd4
 BMN3AOD+aoDw==
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="349772348"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.170.207]) ([10.249.170.207])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2021 21:51:49 -0800
Subject: Re: [kbuild-all] Re: ERROR: ".crypto_skcipher_setkey" undefined!
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        kernel test robot <lkp@intel.com>
Cc:     Eric Biggers <ebiggers@google.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202101030238.zELW4VPr-lkp@intel.com>
 <20210104052111.GA18507@gondor.apana.org.au>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <5896922a-5895-d240-e436-d3789f18cd58@intel.com>
Date:   Mon, 4 Jan 2021 13:51:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210104052111.GA18507@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/2021 1:21 PM, Herbert Xu wrote:
> On Sun, Jan 03, 2021 at 02:37:42AM +0800, kernel test robot wrote:
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     ERROR: ".kmem_cache_alloc" [net/nfc/nfc.ko] undefined!
>>     ERROR: ".__ubsan_handle_type_mismatch_v1" [net/nfc/nfc.ko] undefined!
>>     ERROR: ".find_next_zero_bit" [net/nfc/nfc.ko] undefined!
> 
> ...
> 
>>>> ERROR: ".crypto_skcipher_setkey" [net/ceph/libceph.ko] undefined!
> 
> This looks like a bug in lkp.  Could you please have a look?

Hi Herbert,

Sorry for the inconvenience, the bot is not smart enough, we'll
optimize it to avoid such report.

Best Regards,
Rong Chen

> 
> Thanks,
> 
