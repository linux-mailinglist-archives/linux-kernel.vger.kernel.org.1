Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94ED92B0674
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgKLN3h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Nov 2020 08:29:37 -0500
Received: from mga04.intel.com ([192.55.52.120]:64944 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbgKLN3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:29:37 -0500
IronPort-SDR: 0a31ktOjL+zqrac1GfoHpoEQS/XwBhEPylj6UdLX2cWPfLwXFLzNqaAx3zysnyDY+FUD7CBR1n
 amdZvWmv9DZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="167722673"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="167722673"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 05:29:34 -0800
IronPort-SDR: dqrTRAykzlK2/BBPW5JRG71JJct+F4DPwiFjOExy0eAEsWYVNfXI5SjAKYPTgvlQwV5rcajp34
 OL9D4C9hAAeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="323637625"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 12 Nov 2020 05:29:34 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Nov 2020 05:29:33 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Nov 2020 21:29:31 +0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.1713.004;
 Thu, 12 Nov 2020 21:29:31 +0800
From:   "Sang, Oliver" <oliver.sang@intel.com>
To:     Lars Poeschel <poeschel@lemonage.de>
CC:     Miguel Ojeda <ojeda@kernel.org>, lkp <lkp@intel.com>,
        Willy Tarreau <w@1wt.eu>, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "Sang, Oliver" <oliver.sang@intel.com>
Subject: RE: [LKP] Re: [auxdisplay]  b26deabb1d:
 BUG:kernel_NULL_pointer_dereference,address
Thread-Topic: [LKP] Re: [auxdisplay]  b26deabb1d:
 BUG:kernel_NULL_pointer_dereference,address
Thread-Index: AQHWtpV8lMndfo9euk63Z8UNc8IVGanD/Gsg
Date:   Thu, 12 Nov 2020 13:29:31 +0000
Message-ID: <983cc8dc58a24dd1a839e05213fb1ffb@intel.com>
References: <20201109062934.GA7739@xsang-OptiPlex-9020>
 <20201109124003.ppuzlyyy5blf3ixu@lem-wkst-02.lemonage>
In-Reply-To: <20201109124003.ppuzlyyy5blf3ixu@lem-wkst-02.lemonage>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Lars Poeschel <poeschel@lemonage.de>
> Sent: Monday, November 9, 2020 8:40 PM
> To: Sang, Oliver <oliver.sang@intel.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>; lkp <lkp@intel.com>; Willy Tarreau
> <w@1wt.eu>; LKML <linux-kernel@vger.kernel.org>; Linux Memory
> Management List <linux-mm@kvack.org>; lkp@lists.01.org
> Subject: [LKP] Re: [auxdisplay] b26deabb1d:
> BUG:kernel_NULL_pointer_dereference,address
> 
> Hi!
> 
> And thanks for your report.
> 
> On Mon, Nov 09, 2020 at 02:29:34PM +0800, kernel test robot wrote:
> 
> > To reproduce:
> >
> >         # build kernel
> > 	cd linux
> > 	cp config-5.10.0-rc2-00008-gb26deabb1d91 .config
> > 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare
> > modules_prepare bzImage
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> job-script # job-script is attached
> > in this email
> 
> Trying to reproduce your issue:
> 
> LANG=C bin/lkp qemu -k ~/projekte/linux-stable/arch/x86_64/boot/bzImage
> /tmp/job-script
> result_root: /home/larsi/.lkp//result/trinity/300s/vm-snb-i386/yocto-i386-
> minimal-20190520.cgz/i386-randconfig-a002-20201105/gcc-
> 9/b26deabb1d915fe87d395081bbd3058b938dee89/6
> downloading initrds ...
> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8
> https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/yocto-i386-
> minimal-20190520.cgz -N -P /home/larsi/.lkp/cache/osimage/yocto
> 17916 blocks
> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8
> https://download.01.org/0day-ci/lkp-qemu/osimage/pkg/yocto-i386-minimal-
> 20190520.cgz/trinity-i386.cgz -N -P /home/larsi/.lkp/cache/osimage/pkg/yocto-
> i386-minimal-20190520.cgz
> Failed to download osimage/pkg/yocto-i386-minimal-20190520.cgz/trinity-
> i386.cgz
> 
> It seems, that the trinity-i386.cgz file is not downloadable. Using a webbrowser I
> can see an empty directory.
> Can you help please ?

sorry for this. just uploaded. https://download.01.org/0day-ci/lkp-qemu/osimage/pkg/yocto-i386-minimal-20190520.cgz/trinity-i386.cgz
could you try again?

> 
> Thanks,
> Lars
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
