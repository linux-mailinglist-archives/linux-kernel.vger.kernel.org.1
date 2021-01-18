Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D3F2FA864
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407085AbhARReA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:34:00 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:28763 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436527AbhARRbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:31:22 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DKJhX0S9Yz9txQD;
        Mon, 18 Jan 2021 18:30:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZaCSH8ZfAc0y; Mon, 18 Jan 2021 18:30:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DKJhW47ZQz9txPj;
        Mon, 18 Jan 2021 18:30:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A80C8B7B6;
        Mon, 18 Jan 2021 18:30:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FsaQn5CKJ16a; Mon, 18 Jan 2021 18:30:25 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 39BD98B7AE;
        Mon, 18 Jan 2021 18:30:24 +0100 (CET)
Subject: Re: {standard input}:577: Error: unsupported relocation against base
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202101051834.FGH835Vs-lkp@intel.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <98587e13-d22f-973f-1e16-f7a811f71016@csgroup.eu>
Date:   Mon, 18 Jan 2021 15:24:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <202101051834.FGH835Vs-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 05/01/2021 à 11:58, kernel test robot a écrit :
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
> commit: 8b8319b181fd9d6821703fef1228b4dcde613a16 powerpc/44x: Don't support 440 when CONFIG_PPC_47x is set

I see no link with that commit. Looks like the problem has been existing for some time.
It exists on the commit before that one, it exists on v5.9 and it exists on v5.10 with that commit 
reverted.

> date:   5 weeks ago
> config: powerpc-randconfig-p002-20210105 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8b8319b181fd9d6821703fef1228b4dcde613a16
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 8b8319b181fd9d6821703fef1228b4dcde613a16
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     {standard input}: Assembler messages:
>>> {standard input}:577: Error: unsupported relocation against base
>     {standard input}:580: Error: unsupported relocation against base
>     {standard input}:583: Error: unsupported relocation against base
>     {standard input}:586: Error: unsupported relocation against base
>     {standard input}:589: Error: unsupported relocation against base
>     {standard input}:592: Error: unsupported relocation against base
>     {standard input}:595: Error: unsupported relocation against base
>     {standard input}:598: Error: unsupported relocation against base
>     {standard input}:601: Error: unsupported relocation against base
>     {standard input}:604: Error: unsupported relocation against base
>     {standard input}:607: Error: unsupported relocation against base
>     {standard input}:610: Error: unsupported relocation against base
>     {standard input}:613: Error: unsupported relocation against base
>     {standard input}:616: Error: unsupported relocation against base
>     {standard input}:619: Error: unsupported relocation against base
>     {standard input}:622: Error: unsupported relocation against base
>     {standard input}:625: Error: unsupported relocation against base
>     {standard input}:628: Error: unsupported relocation against base
>     {standard input}:631: Error: unsupported relocation against base
>     {standard input}:634: Error: unsupported relocation against base
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
