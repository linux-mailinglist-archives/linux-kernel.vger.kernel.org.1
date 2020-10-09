Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7557D288EA4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 18:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389644AbgJIQT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 12:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389523AbgJIQT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:19:28 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B18C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 09:19:27 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id o18so9956819edq.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Wo3GQt6leaI+dEFdoiBhU3rEXywu8hm1tVt2jcDCuE=;
        b=gaLYRn5XMJhSd0yMPv/fSjokN8gSCgwk0c/hem9RD2l1v29pBVmvoANsxAznEzHXgW
         MtpsvrreNA/R9j9avZPwrpgrdtlOvNVEt8c19t32tNTg2Btu+RXZyq9oUQUlngFyB/tN
         h0BCE67KWAX9Y6EI+TSdqiVVI1Jw/s+WddjGHsQb68xF9zEEGuBVROSg4fEmrt4j8yk9
         djaytII6T38DGObIhkdRd113DdzrT8j+jxHxZZyA0C+UvrkUekucZje20qXff0P6M4jm
         HfR0i0VhEOBMkFs2lcu2JZtzLdViTX6iNMfPJNa5xtm8BsLGhq4Ip57/Q89MImFrWo1H
         PSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Wo3GQt6leaI+dEFdoiBhU3rEXywu8hm1tVt2jcDCuE=;
        b=gtO8Hpg2Dbc++mXGbDsZVZ/l7TSwgJ1f3C2KtKLBU1rdMnBMOqyL9aOjScoGK4aQwK
         Ox9OqeiYc+0vYTRnP8/4mDT8be0KGBQ7ORjExqV3utkw9IHU02lIQ1Ez8uPWSlFNS390
         bM3EysJTftCqWDtwhkn3gjZhMz4p1gt+B/cPH61pNhClYnHvT+aOWZhmxiEI6xW5cfZ/
         0Kkwy/JLsR4hOIFmyZO0Zd0oZiJ+gCKPuz3j3f4yitW5/QJyOrxY0NBfeBHbzNJbM5fg
         UQ2/rN75Q0ICUCUX7+H94dGCISljY6hOFDGtWDkSWRymJujAsSpBEBgIkbLoU2hwWEfj
         e6Hw==
X-Gm-Message-State: AOAM533qmvyr1P7Ga5C/JLnCqF4uxkHvjEH+DTCoTq0uFvzd5ftG4Jy2
        Hyq0gnXPbjlSU99OV4fh0LYyxvroIH8=
X-Google-Smtp-Source: ABdhPJyPNMC6jUhJUqrp8O8ULL3mjWXLSE11IcNDo8B1LxTa2j6cnhygiRGKgnW9KKo729ATyIBnbQ==
X-Received: by 2002:a50:abc3:: with SMTP id u61mr15176759edc.253.1602260365676;
        Fri, 09 Oct 2020 09:19:25 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:b916:75c5:e328:ad7c])
        by smtp.gmail.com with ESMTPSA id t4sm6552821ejj.6.2020.10.09.09.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 09:19:24 -0700 (PDT)
Date:   Fri, 9 Oct 2020 18:19:24 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild@lists.01.org, Dan Carpenter <error27@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: sound/pci/au88x0/au88x0_core.c:2029 vortex_adb_checkinout()
 warn: signedness bug returning '(-22)'
Message-ID: <20201009161924.wc4omcb22ppaqcx2@ltop.local>
References: <20201009120043.GL1042@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009120043.GL1042@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 03:00:43PM +0300, kernel test robot wrote:
> Hi Luc,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c85fb28b6f999db9928b841f63f1beeb3074eeca
> commit: 80591e61a0f7e88deaada69844e4a31280c4a38f kbuild: tell sparse about the $ARCH
> config: powerpc64-randconfig-m031-20201008 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> sound/pci/au88x0/au88x0_core.c:2029 vortex_adb_checkinout() warn: signedness bug returning '(-22)'
> sound/pci/rme9652/hdsp.c:4085 snd_hdsp_channel_info() warn: impossible condition '(hdsp->channel_map[channel] < 0) => (0-255 < 0)'
> 
> Old smatch warnings:
> sound/pci/au88x0/au88x0_core.c:2046 vortex_adb_checkinout() warn: signedness bug returning '(-12)'
> sound/pci/rme9652/hdsp.c:3338 snd_hdsp_proc_read() warn: argument 5 to %lx specifier is cast from pointer
> sound/pci/rme9652/hdsp.c:5305 snd_hdsp_create() warn: 'hdsp->iobase' not released on lines: 5237.
> sound/pci/rme9652/hdsp.c:5305 snd_hdsp_create() warn: 'pci' not released on lines: 5237.
> 
> vim +2029 sound/pci/au88x0/au88x0_core.c
> 
> ^1da177e4c3f415 Linus Torvalds  2005-04-16  2001  static char
>                                                          ^^^^
> Is char unsigned on PowerPC?  I thought that was only on s390.

All PowerPC machines or cross compiler I have access to give me:
	$ gcc -E -dD -o - - < /dev/null | grep __CHAR_UNSIGNED__
	#define __CHAR_UNSIGNED__ 1

and the PPC ABI requires it so.
 
-- Luc
