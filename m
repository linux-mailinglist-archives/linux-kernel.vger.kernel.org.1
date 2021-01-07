Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4769D2ED541
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbhAGROz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbhAGROz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:14:55 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78CCC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 09:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=3RoonU/YcEe0gg0vqaGauY9MST17giXfSJb9Q67uaxw=; b=g/CuNus7wOcueBuWo8MBWtn7ya
        +O/c5+5K1ulmzEaoRMqEuLA61Z9Zsd5h2KmBxgH8BcYDdE8bnQhn1wSGmJAYbXvjCCxKD5mFVsehQ
        n3PajQltHaduvIyh19a1etCPXDH9Tc/4IoXVOMdqWKhGUR/X45gbvg0Rj4rulTpQy1br0uCsMf2lX
        7ibfGCz9NkvY2Hveb/Ip0x8qjtTYOElQgAiH+cY1KawtvOL+ggDsPZJuM/F5g8jljhYRc04UqDZvL
        V7GMEivt7ZehVi3Al1Ow3Jf0kNaQF/xSyvEKPiFOJHYnB8Xb16Vl1/a3qI80mUgeCPAWNseiTXHQZ
        Qn7VAC1w==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxYrS-0003wR-4b; Thu, 07 Jan 2021 17:14:10 +0000
Subject: Re: undefined reference to `led_classdev_unregister'
To:     kernel test robot <lkp@intel.com>,
        Kurt Kanzenbach <kurt@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <202101061932.tXwNws1g-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7b677508-94b8-aa73-6844-2ab3dea91058@infradead.org>
Date:   Thu, 7 Jan 2021 09:14:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <202101061932.tXwNws1g-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/21 3:22 AM, kernel test robot wrote:
> Hi Kurt,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
> commit: 7d9ee2e8ff1541c60dcb5cfdf41def9659204c3e net: dsa: hellcreek: Add PTP status LEDs
> date:   9 weeks ago
> config: microblaze-randconfig-r016-20210106 (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d9ee2e8ff1541c60dcb5cfdf41def9659204c3e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 7d9ee2e8ff1541c60dcb5cfdf41def9659204c3e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=microblaze 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Now fixed in the netdev tree:

https://git.kernel.org/netdev/net/c/7f847db30408

> All errors (new ones prefixed by >>):
> 
>    microblaze-linux-ld: drivers/net/dsa/hirschmann/hellcreek_ptp.o: in function `hellcreek_ptp_setup':
>>> (.text+0xf80): undefined reference to `led_classdev_register_ext'
>>> microblaze-linux-ld: (.text+0xf94): undefined reference to `led_classdev_register_ext'
>    microblaze-linux-ld: drivers/net/dsa/hirschmann/hellcreek_ptp.o: in function `hellcreek_ptp_free':
>>> (.text+0x1018): undefined reference to `led_classdev_unregister'
>>> microblaze-linux-ld: (.text+0x1024): undefined reference to `led_classdev_unregister'


-- 
~Randy

