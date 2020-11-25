Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E30B2C481E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgKYTRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgKYTRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:17:50 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFBCC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=V5tEO7un/1L9BXBLMHg1SxH4W1cR6uLnVfylDMKC9+0=; b=OEQSErqBrm7o8mhEVbDwDZr6gt
        jLIFGFQm1dOclDabI9YmMzFn4KPPUTRyTHg/U1osTtb7LWQz2mJsmNATOHUocKx4CqAUtugfRZJ9b
        sMQifdWeyP0Nmo6L71dVWFogxQP90znyW9deDoJWw8mca4i/BXPx5n9aRu4h9sm1Jc5YFHpOZizy/
        +PoaKFrdsEdcTi+L4UmhYdB+WizphTGmfBfdH48YMK7sQQA5BWxytKQZE2e9BSlEBX57D1PSqNDzx
        J4rtz4V/hqpgyh1g93Btv5m6FkgaNuB4J0n/LCuwPOD44+YJJfMPyOe51H/ByxRxXMXm+48AugWt6
        etTAmSGQ==;
Received: from [2601:1c0:6280:3f0::cc1f]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ki0IT-0007Dh-Ff; Wed, 25 Nov 2020 19:17:45 +0000
Subject: Re: arch/powerpc/platforms/pseries/reconfig.c:394:30: error:
 'ofdt_proc_ops' defined but not used
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202011241521.8ozmsGaX-lkp@intel.com>
 <CAFqt6zYiKP+jK_=_wmcMPYQyCxhroKkdMVy7qXhksh-V6HM=EQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b1592971-2d67-39e7-e195-c5aa68ce382d@infradead.org>
Date:   Wed, 25 Nov 2020 11:17:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zYiKP+jK_=_wmcMPYQyCxhroKkdMVy7qXhksh-V6HM=EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/20 11:13 AM, Souptick Joarder wrote:
> On Tue, Nov 24, 2020 at 12:40 PM kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   d5beb3140f91b1c8a3d41b14d729aefa4dcc58bc
>> commit: 97a32539b9568bb653683349e5a76d02ff3c3e2c proc: convert everything to "struct proc_ops"
>> date:   10 months ago
>> config: powerpc-randconfig-r002-20201124 (attached as .config)
>> compiler: powerpc64le-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=97a32539b9568bb653683349e5a76d02ff3c3e2c
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout 97a32539b9568bb653683349e5a76d02ff3c3e2c
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> arch/powerpc/platforms/pseries/reconfig.c:394:30: error: 'ofdt_proc_ops' defined but not used [-Werror=unused-const-variable=]
>>      394 | static const struct proc_ops ofdt_proc_ops = {
>>          |                              ^~~~~~~~~~~~~
>>    cc1: all warnings being treated as errors
>> --
>>>> arch/powerpc/platforms/pseries/lparcfg.c:701:30: error: 'lparcfg_proc_ops' defined but not used [-Werror=unused-const-variable=]
>>      701 | static const struct proc_ops lparcfg_proc_ops = {
>>          |                              ^~~~~~~~~~~~~~~~
>>    cc1: all warnings being treated as errors
> 
> Both ofdt_proc_ops & lparcfg_proc_ops are used by proc_create().
> Not sure why it is throwing warnings.
> 

because this:

# CONFIG_PROC_FS is not set

>>
>> vim +/ofdt_proc_ops +394 arch/powerpc/platforms/pseries/reconfig.c
>>
>>    393
>>  > 394  static const struct proc_ops ofdt_proc_ops = {
>>    395          .proc_write     = ofdt_write,
>>    396          .proc_lseek     = noop_llseek,
>>    397  };
>>    398


-- 
~Randy

