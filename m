Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448E72AB86E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgKIMkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbgKIMkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:40:16 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14D4C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 04:40:15 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 4D05723F486;
        Mon,  9 Nov 2020 13:40:12 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.94
X-Spam-Level: 
X-Spam-Status: No, score=-2.94 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.040, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 78zzH0vFqXDi; Mon,  9 Nov 2020 13:40:10 +0100 (CET)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 0EDF223F810;
        Mon,  9 Nov 2020 13:40:09 +0100 (CET)
Date:   Mon, 9 Nov 2020 13:40:03 +0100
From:   Lars Poeschel <poeschel@lemonage.de>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, kernel test robot <lkp@intel.com>,
        Willy Tarreau <w@1wt.eu>, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org
Subject: Re: [auxdisplay]  b26deabb1d:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20201109124003.ppuzlyyy5blf3ixu@lem-wkst-02.lemonage>
References: <20201109062934.GA7739@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109062934.GA7739@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

And thanks for your report.

On Mon, Nov 09, 2020 at 02:29:34PM +0800, kernel test robot wrote:

> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.10.0-rc2-00008-gb26deabb1d91 .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email

Trying to reproduce your issue:

LANG=C bin/lkp qemu -k ~/projekte/linux-stable/arch/x86_64/boot/bzImage /tmp/job-script
result_root: /home/larsi/.lkp//result/trinity/300s/vm-snb-i386/yocto-i386-minimal-20190520.cgz/i386-randconfig-a002-20201105/gcc-9/b26deabb1d915fe87d395081bbd3058b938dee89/6
downloading initrds ...
/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/yocto-i386-minimal-20190520.cgz -N -P /home/larsi/.lkp/cache/osimage/yocto
17916 blocks
/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 https://download.01.org/0day-ci/lkp-qemu/osimage/pkg/yocto-i386-minimal-20190520.cgz/trinity-i386.cgz -N -P /home/larsi/.lkp/cache/osimage/pkg/yocto-i386-minimal-20190520.cgz
Failed to download osimage/pkg/yocto-i386-minimal-20190520.cgz/trinity-i386.cgz

It seems, that the trinity-i386.cgz file is not downloadable. Using a
webbrowser I can see an empty directory.
Can you help please ?

Thanks,
Lars
