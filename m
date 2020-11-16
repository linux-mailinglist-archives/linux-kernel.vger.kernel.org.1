Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DFD2B4070
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgKPKFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKPKFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:05:15 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD81EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:05:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id B43DB23F982;
        Mon, 16 Nov 2020 11:05:10 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.94
X-Spam-Level: 
X-Spam-Status: No, score=-2.94 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.040, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DJABU5qdOwkp; Mon, 16 Nov 2020 11:05:09 +0100 (CET)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 6BB3423F2CB;
        Mon, 16 Nov 2020 11:05:08 +0100 (CET)
Date:   Mon, 16 Nov 2020 11:05:04 +0100
From:   Lars Poeschel <poeschel@lemonage.de>
To:     "Sang, Oliver" <oliver.sang@intel.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, lkp <lkp@intel.com>,
        Willy Tarreau <w@1wt.eu>, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>
Subject: Re: [LKP] Re: [auxdisplay]  b26deabb1d:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20201116100504.tccqktcgxwn4pyqd@lem-wkst-02.lemonage>
References: <20201109062934.GA7739@xsang-OptiPlex-9020>
 <20201109124003.ppuzlyyy5blf3ixu@lem-wkst-02.lemonage>
 <983cc8dc58a24dd1a839e05213fb1ffb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983cc8dc58a24dd1a839e05213fb1ffb@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 01:29:31PM +0000, Sang, Oliver wrote:
> 
> 
> > -----Original Message-----
> > From: Lars Poeschel <poeschel@lemonage.de>
> > Sent: Monday, November 9, 2020 8:40 PM
> > To: Sang, Oliver <oliver.sang@intel.com>
> > Cc: Miguel Ojeda <ojeda@kernel.org>; lkp <lkp@intel.com>; Willy Tarreau
> > <w@1wt.eu>; LKML <linux-kernel@vger.kernel.org>; Linux Memory
> > Management List <linux-mm@kvack.org>; lkp@lists.01.org
> > Subject: [LKP] Re: [auxdisplay] b26deabb1d:
> > BUG:kernel_NULL_pointer_dereference,address
> > 
> > Hi!
> > 
> > And thanks for your report.
> > 
> > On Mon, Nov 09, 2020 at 02:29:34PM +0800, kernel test robot wrote:
> > 
> > > To reproduce:
> > >
> > >         # build kernel
> > > 	cd linux
> > > 	cp config-5.10.0-rc2-00008-gb26deabb1d91 .config
> > > 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare
> > > modules_prepare bzImage
> > >
> > >         git clone https://github.com/intel/lkp-tests.git
> > >         cd lkp-tests
> > >         bin/lkp qemu -k <bzImage> job-script # job-script is attached
> > > in this email
> > 
> > Trying to reproduce your issue:
> > 
> > LANG=C bin/lkp qemu -k ~/projekte/linux-stable/arch/x86_64/boot/bzImage
> > /tmp/job-script
> > result_root: /home/larsi/.lkp//result/trinity/300s/vm-snb-i386/yocto-i386-
> > minimal-20190520.cgz/i386-randconfig-a002-20201105/gcc-
> > 9/b26deabb1d915fe87d395081bbd3058b938dee89/6
> > downloading initrds ...
> > /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8
> > https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/yocto-i386-
> > minimal-20190520.cgz -N -P /home/larsi/.lkp/cache/osimage/yocto
> > 17916 blocks
> > /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8
> > https://download.01.org/0day-ci/lkp-qemu/osimage/pkg/yocto-i386-minimal-
> > 20190520.cgz/trinity-i386.cgz -N -P /home/larsi/.lkp/cache/osimage/pkg/yocto-
> > i386-minimal-20190520.cgz
> > Failed to download osimage/pkg/yocto-i386-minimal-20190520.cgz/trinity-
> > i386.cgz
> > 
> > It seems, that the trinity-i386.cgz file is not downloadable. Using a webbrowser I
> > can see an empty directory.
> > Can you help please ?
> 
> sorry for this. just uploaded. https://download.01.org/0day-ci/lkp-qemu/osimage/pkg/yocto-i386-minimal-20190520.cgz/trinity-i386.cgz
> could you try again?

It is working now and I can reproduce the error.
Thank you!
