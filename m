Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632892C04C9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgKWLl3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Nov 2020 06:41:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:12280 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbgKWLl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:41:29 -0500
IronPort-SDR: AG6W93Bpxo9RNEsjq4Ejd+izKo3I+O6JkASrHXYEjjQvSoIxim0OW7KnUOYCotv+H+TTygFlHx
 L9JLBv6YlZ/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="171843013"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="171843013"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 03:41:28 -0800
IronPort-SDR: M0DrrngnZ5QAuafz2LKL8uJJcVxUHY8rHBEDDWflWBO/t/j2ONoT9kuRspRi89yLe6neB+9QDe
 /oHHqm27B2tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="536068727"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 23 Nov 2020 03:41:28 -0800
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Nov 2020 03:41:27 -0800
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 SHSMSX604.ccr.corp.intel.com (10.109.6.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Nov 2020 19:41:25 +0800
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Mon, 23 Nov 2020 11:41:23 +0000
From:   "Rojewski, Cezary" <cezary.rojewski@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lkp <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: RE: sound/soc/intel/catpt/loader.c:654 catpt_first_boot_firmware()
 warn: consider using resource_size() here
Thread-Topic: sound/soc/intel/catpt/loader.c:654 catpt_first_boot_firmware()
 warn: consider using resource_size() here
Thread-Index: AQHWwD/eDLOgu+KuP0GoPmNta8oBHKnVjTKAgAAM/lA=
Date:   Mon, 23 Nov 2020 11:41:23 +0000
Message-ID: <8cb2dcbdef2446238c6a1fe8e8b74504@intel.com>
References: <202011220325.oB7oeTEq-lkp@intel.com>
 <20201123105317.GZ4077@smile.fi.intel.com>
In-Reply-To: <20201123105317.GZ4077@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-23 11:53 AM, Andy Shevchenko wrote:
> On Sun, Nov 22, 2020 at 03:52:27AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   27bba9c532a8d21050b94224ffd310ad0058c353
>> commit: 6cbfa11d2694b8a1e46d6834fb9705d5589e3ef1 ASoC: Intel: Select catpt and deprecate haswell
>> date:   7 weeks ago
>> config: x86_64-randconfig-m001-20201122 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> smatch warnings:
>> sound/soc/intel/catpt/loader.c:654 catpt_first_boot_firmware() warn: consider using resource_size() here
> 
> ...
> 
>> a9aa6fb3eb6c7e Cezary Rojewski 2020-09-29  652  	for (res = cdev->dram.child; res->sibling; res = res->sibling)
>> a9aa6fb3eb6c7e Cezary Rojewski 2020-09-29  653  		;
>> a9aa6fb3eb6c7e Cezary Rojewski 2020-09-29 @654  	__request_region(&cdev->dram, res->end + 1,
> 
> 
> This sounds like false positive. From where it gets the idea of resource_size()
> for the *start* offset?!
> 

Indeed it is false positive. I've already explained this in:

RE: [bug report] ASoC: Intel: catpt: Firmware loading and context restore
https://www.spinics.net/lists/alsa-devel/msg117145.html

Regards,
Czarek

