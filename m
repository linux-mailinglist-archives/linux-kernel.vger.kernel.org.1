Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102C32F1C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389220AbhAKRQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbhAKRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:16:29 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD855C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:15:48 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id n142so177929qkn.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZDQtjpzWlThTvUR8JGp930g6ClfiZJRTxI3mFior2ls=;
        b=pmIA98f0B580BobMIBBe7f3lr3GF+Bdfo46Pac7pAN+bzeL7FWQ0K2Azr9W4pmXaYh
         XWlRvOWKrNc2qaPEAQsHKlcpv6U+Gg8JRw8orVcxKSELIxpa3ICKLCee/erXxYtvE7yO
         MBjq9oYelK/ShpYzez8AUwLTPWUOrz0orDC+cuFG/aMuMtxcoPH97gIhbgT81mUGwAVM
         Gwmy2plnv7ORsWYH6pLaMS/7T9CDKVsgulcQoAzk1sFKMKMz/8axMYXqmkYMnPZcYsCG
         l2mXFwYyIMzxYMS/kzKA0wCrbNRZLGkf+bpvoC2y1OZ6RQIwmP5jugo1QThPdEFemT7J
         cAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZDQtjpzWlThTvUR8JGp930g6ClfiZJRTxI3mFior2ls=;
        b=YtZxyTbMrwcm+gCFBKVe1YLPEqp3E6W8fc/xeUp7aGPWA3EyZ5zWIzXfNxMXInigeO
         MxOUyDHHDOUM4hq8GYraRwiwqZ9NUJ14Rjo1zSZhcoFFEa/d1V2HPqWyMll1cI2GrDO3
         XQJYWbjRlAVLUz8B7SyEiaLa11Z2iemT+/KEtjonzlkBvV0w8W1uKY2Aq6x4ZQBPrPkF
         Qsnv56HsGKwgNHAdFkyS2hHotPzNGrb/AbK/TYcqInX51DuygCBKd2NtCQEmaFXGR9iy
         pwXiaxb9ATHJezkL4tZly926fRChl01xuTrtHSsqEm4/6T55GtMNt+ZAzJMDLu9hvtHI
         C9Rg==
X-Gm-Message-State: AOAM531tujed3SCraqkjuZkGNg6vfQ7va7M2pCIs4TGg7Uq2q0hPunH8
        wSZcgmEhi0fI9suOaLcaNSM=
X-Google-Smtp-Source: ABdhPJxCFXGspjNsnw/jPVggO/X2yck4esa3grZFTkE7lCgg0zyuNcbU9oEiZ9+mqOqMIr/8ksdbxA==
X-Received: by 2002:a37:9205:: with SMTP id u5mr272362qkd.345.1610385348068;
        Mon, 11 Jan 2021 09:15:48 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-255-32.pitbpa.fios.verizon.net. [108.39.255.32])
        by smtp.gmail.com with ESMTPSA id 134sm231898qkh.62.2021.01.11.09.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 09:15:47 -0800 (PST)
Date:   Mon, 11 Jan 2021 12:15:45 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v5 0/4] drivers/soc/litex: support 32-bit subregisters,
 64-bit CPUs
Message-ID: <20210111171545.GJ2094049@errol.ini.cmu.edu>
References: <20201227161320.2194830-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201227161320.2194830-1-gsomlo@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping :)

On Sun, Dec 27, 2020 at 11:13:16AM -0500, Gabriel Somlo wrote:
> This series expands on commit 22447a99c97e ("drivers/soc/litex: add LiteX
> SoC Controller driver"), adding support for handling both 8- and 32-bit
> LiteX CSR (MMIO) subregisters, on both 32- and 64-bit CPUs.
> 
> Notes v5:
> 	- added patch (4/4) taking 'litex_[set|get]_reg()' private
> 	- additional optimization of [_]litex_set_reg() in 3/4
> 
> Notes v4:
> 	- improved "eloquence" of some 3/3 commit blurb paragraphs
> 	- fixed instance of "disgusting" comment style :)
> 	- litex_[get|set]_reg() now using size_t for 'reg_size' argument
> 	- slightly tighter shift calculation in litex_set_reg()
> 
> Notes v3:
> 	- split into smaller, more self-explanatory patches
> 	- more detailed commit blurb for "main payload" (3/3) patch
> 	- eliminate compiler warning on 32-bit architectures
> 
> Notes v2:
> 	- fix typo (s/u32/u64/) in litex_read64().
> 
> Notes v1:
> 	- LITEX_SUBREG_SIZE now provided by Kconfig.
> 	- it's not LITEX_REG_SIZE, but rather LITEX_SUBREG_ALIGN!
> 	- move litex_[get|set]_reg() to include/linux/litex.h and mark
> 	  them as "static inline";
> 	- redo litex_[read|write][8|16|32|64]() using litex_[get|set]_reg()
> 	  (compiler should produce code as efficient as hardcoded shifts,
> 	   but also automatically matching LITEX_SUBREG_SIZE).
> 
> Gabriel Somlo (4):
>   drivers/soc/litex: move generic accessors to litex.h
>   drivers/soc/litex: separate MMIO from subregister offset calculation
>   drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs
>   drivers/soc/litex: make 'litex_[set|get]_reg()' methods private
> 
>  drivers/soc/litex/Kconfig          |  14 ++-
>  drivers/soc/litex/litex_soc_ctrl.c |  76 +-------------
>  include/linux/litex.h              | 154 +++++++++++++++++++----------
>  3 files changed, 119 insertions(+), 125 deletions(-)
> 
> -- 
> 2.26.2
> 
