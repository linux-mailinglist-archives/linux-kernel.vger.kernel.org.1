Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D8B2E2F4C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 23:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgLZWhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 17:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgLZWhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 17:37:51 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A41C061757
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 14:37:11 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l23so4422926pjg.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 14:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=asPoBdEKmKqtRAP4kOudpK9yPqTcR06ZjdhL7PqW1D8=;
        b=ZZvT9cHQJb+YcqAEPWWT+1Gbl1tVY1hoaJ+8DuK8Okv8XZILJ1aaNrtubdAk9kjfHT
         A2qp/flE6asHY6QgPXZAEWyl1PSDZbNDqYGSU4HxD0XcnlRdIIfxJ6/nLNZ/REvbysi3
         t1kfFM6tZpeMVIoTHH7nSnaGLuUdOzSwlXhClYGOW9E5BHYkT+YIW/uO4P9lOBBMKhto
         NZgy85s5xbVRsh0cn7InTL/YKslR4rP6eq334vClc3t4h1Rby3pDaUwYwYpXpcjzq+It
         fCq3uVl+kRUf3pxG+0bzzwka/PVTW0ecfcq1JG+TDMoY9Iuc2D77VuzqRBe0sH2xgqdp
         Q0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=asPoBdEKmKqtRAP4kOudpK9yPqTcR06ZjdhL7PqW1D8=;
        b=YRxe9/lW9ZbqKMNKC1gLenALg4AecQL3JZRhpnQPvFxWf1eh5AmzSN1f/haiPx9UpY
         eGz6TbMufHqc5Xw6oAQ9k1TKUu4qDmAoQ1DCTJbAICxMVRMdr5x0O8uvox2YS+P1p6YZ
         kd2aG9YE1p+p9gT8evV1EFBeY3OIMHtRyfhKGSZ5S0/ZahvmR6pnnjU2/UOjSok/bjky
         6+prp8xkDmrvlV6hcPp9kbZLzW3ZwMefaVrvEdRsx64PzYN2W75t6lxQPCtbHMIW3eNa
         qRkApvOXZt7+JY8zS/1UHToeScmcgSHpgsgmbsoXvlPc3QUY5F0HGkYf4NmO4ew+6O65
         TZVw==
X-Gm-Message-State: AOAM532xpynxUq9EKsoqIwcy/t+QgcPIne0XqRQjlxqaw3tSKOw5LUqd
        ZG1WrkIxI6roQYtKr7dSVQo=
X-Google-Smtp-Source: ABdhPJxFniMNfZPIspqr983Eahf6DVjzTLSe6dUuXa/biJhtaVh43d+dmt/SPb4493dIoNDGqyFOiA==
X-Received: by 2002:a17:902:6b84:b029:dc:3419:b558 with SMTP id p4-20020a1709026b84b02900dc3419b558mr33883468plk.19.1609022230758;
        Sat, 26 Dec 2020 14:37:10 -0800 (PST)
Received: from localhost (g39.222-224-245.ppp.wakwak.ne.jp. [222.224.245.39])
        by smtp.gmail.com with ESMTPSA id d4sm31428371pfo.127.2020.12.26.14.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 14:37:09 -0800 (PST)
Date:   Sun, 27 Dec 2020 07:37:07 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     mholenko@antmicro.com, kgugala@antmicro.com,
        linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v4 0/3] drivers/soc/litex: support 32-bit subregisters,
 64-bit CPUs
Message-ID: <20201226223707.GO3168563@lianli.shorne-pla.net>
References: <20201226001649.2061703-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201226001649.2061703-1-gsomlo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 07:16:46PM -0500, Gabriel Somlo wrote:
> This series expands on commit 22447a99c97e ("drivers/soc/litex: add LiteX
> SoC Controller driver"), adding support for handling both 8- and 32-bit
> LiteX CSR (MMIO) subregisters, on both 32- and 64-bit CPUs.
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
> Gabriel Somlo (3):
>   drivers/soc/litex: move generic accessors to litex.h
>   drivers/soc/litex: separate MMIO from subregister offset calculation
>   drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs

Thanks, this look good to me right now.  I will wait for other reviewers to
chime in over the next week or two after the holidays.

Some minor things:
  - It's customary to add "Changes since xx" on each patch after "---",
    See: https://kernelnewbies.org/PatchTipsAndTricks
  - Did you run your patches through "./scripts/checkpatch.pl"?
  - Did you use "./scripts/get_maintainer.pl" to create the cc list?  I usually
    run:  git send-email --to linux-kernel --cc-cmd ./scripts/get_maintainer.pl ...
    From your cc list it seems you did, but maybe did it manually. (I setup
    .get_maintainer.conf with --no-rolestats for this to work)
  - In general check out:
    https://www.kernel.org/doc/html/latest/process/submit-checklist.html

-Stafford

>  drivers/soc/litex/Kconfig          |  12 +++
>  drivers/soc/litex/litex_soc_ctrl.c |  76 +--------------
>  include/linux/litex.h              | 151 +++++++++++++++++++----------
>  3 files changed, 115 insertions(+), 124 deletions(-)
> 
> -- 
> 2.26.2
> 
