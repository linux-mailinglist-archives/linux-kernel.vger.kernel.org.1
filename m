Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72518271A31
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 06:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgIUEpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 00:45:55 -0400
Received: from cmta17.telus.net ([209.171.16.90]:58107 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgIUEpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 00:45:55 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 00:45:54 EDT
Received: from [192.168.20.38] ([209.89.189.71])
        by cmsmtp with SMTP
        id KDaCkn9JOrd15KDaEkY1eT; Sun, 20 Sep 2020 22:37:46 -0600
X-Telus-Authed: Z2lsbGI0
X-Authority-Analysis: v=2.3 cv=cLmeTWWN c=1 sm=1 tr=0
 a=lXP6RixAJDH2mbiCOq84ew==:117 a=lXP6RixAJDH2mbiCOq84ew==:17
 a=IkcTkHD0fZMA:10 a=VV5-G85skxbwr1oMt8sA:9 a=QEXdDO2ut3YA:10
To:     linux-kernel@vger.kernel.org
From:   bob <gillb4@telusplanet.net>
Subject: kernel v5.9-rc6 not compiling
Message-ID: <fdc4e3dc-e1ff-f525-44bb-9f70c86a282f@telusplanet.net>
Date:   Sun, 20 Sep 2020 22:37:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CMAE-Envelope: MS4wfAaVw7TN+lHXteBBYkZhK3kfogtr0xEnzbztWpm5KDZe3Pn7E0RUPvvKoUx6KZx2AUe/reiPikwbFRutZ9cAQybAdOBykUOQ4F0CHKi0bBUpkR2LSTSS
 DycynvB7Sf7wQkuCMNS0n/T7PI3UmSvfPAQFtDBaDXHmoWFKcuBzwg9FJhaGQFEgC0lIP1BwintRmw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I've been building kernels weekly since 1996.  Never had one not 
build before today.  v5.9-rc6 does not compile.

Error:

   AR      drivers/gpu/built-in.a
make: *** [Makefile:1784: drivers] Error 2
   CALL    scripts/checksyscalls.sh
   CALL    scripts/atomic/check-atomics.sh
   DESCEND  objtool
   CHK     include/generated/compile.h
   CC      drivers/dax/super.o
drivers/dax/super.c:325:6: error: redefinition of ‘dax_supported’
   325 | bool dax_supported(struct dax_device *dax_dev, struct 
block_device *bdev,
       |      ^~~~~~~~~~~~~
In file included from drivers/dax/super.c:16:
./include/linux/dax.h:162:20: note: previous definition of 
‘dax_supported’ was here
   162 | static inline bool dax_supported(struct dax_device *dax_dev,
       |                    ^~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:283: drivers/dax/super.o] Error 1
make[1]: *** [scripts/Makefile.build:500: drivers/dax] Error 2
make: *** [Makefile:1784: drivers] Error 2
sed: can't read modules.order: No such file or directory
make: *** [Makefile:1416: _modinst_] Error 2
sh ./arch/x86/boot/install.sh 5.9.0-rc6 arch/x86/boot/bzImage \
     System.map "/boot"

  *** Missing file: arch/x86/boot/bzImage
  *** You need to run "make" before "make install".

make[1]: *** [arch/x86/boot/Makefile:160: install] Error 1
make: *** [arch/x86/Makefile:274: install] Error 2
You may need to edit your /etc/default/grub file


... so its not like I'm stuck, I can pick any of a number of old kernels 
from the bootloader.  And I've had a lot of rc kernels over the years 
that would build, but weren't finished (occasionally I would get an oops 
in dmesg).  Again pick another kernel from the bootloader, preferrably a 
more stable non-rc one. But I don't think I've ever had a kernel not 
compile before.  I'm waiting for the nouveau drivers to firm up, but DAX 
is page cache for ext2/3/4 file systems (and I use ext4).  Hopefully my 
report is useful.  Thank you.

