Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE7C271946
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgIUCZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgIUCZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:25:54 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D816EC061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 19:25:53 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id p15so6539559qvk.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 19:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lFSktLUg4vlJvFR6j+da57CRrfVvfFDzsNGXcJskpWg=;
        b=WijXhVtHinjwUial10pwIzB6tFdj9f7sYNeCvlh7wyq3AT2G2FbkKm5BieT99Q56Wd
         VYRcXPC1N91NugEuLTa6orlyl6dmthJJa9WtSs5RJDe/31LNgPXVPQRmiu52d+HPXdqV
         RONcqR38ovOMJ9pqh4hv4s5YjWVlv2Xl3x3hfPuJzkqcxrA+JPR3TeL+FbbzG2Kz7Wog
         nIC/Iy9R8gaWyINgl8SEn3hy23QYrK8UTz4CmdkY+sXZs/xeEsP8AHXnResdLuW/R69X
         M2l7U01gK4o2hW57vddMS4qdm4WPOYneDsJvwCmID1/4P00fAqnCRrped7wtIbjkAR8l
         BEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lFSktLUg4vlJvFR6j+da57CRrfVvfFDzsNGXcJskpWg=;
        b=WU+uy1aRDgz6H2zPbUHLb4T5Bs3BJmN2bzyoh631kL/UK+f8pGinBtOBJAvRWfLL9D
         pNyawD3g7U6PHnTp9B4B0+rF5WhVat/MaQ1y4kkRIxjVXjdvznTVQcrj8Q1MzMpV8ALk
         g9QPX+OHVQUatqxOVf5yOLNU+Yc/t8F+RAaY3HRBgZbNyHKjnP4oN8siBy7VLnhMC+yt
         WHcBaQuMiZKYwdtCZW+uVTUIM/yqSnrjSlhp/2uvH1NR0QI/BIFQ0JQAbzgxi5P0PVQP
         C8/nEry5X/8TkfWNU4+71Xn20PqQJbe5+6oZ0OWlUQPgQScc5A8SFpiL1lEzclwjSRDa
         FoLg==
X-Gm-Message-State: AOAM530t9xzMLXmdidgxYLIPyk0Sce0hSTX4FA6HpZE7eLYcje7XBqb9
        NTEyNgXxqJG/JvzNAxZAMfA=
X-Google-Smtp-Source: ABdhPJxB3XAhWC2X9pslRsVbnBITL/SE6RQDK8MbXF4CJ3WmAPUe41uo94GaO/8AlPphAuQKeZySoQ==
X-Received: by 2002:a0c:e788:: with SMTP id x8mr41799676qvn.27.1600655152779;
        Sun, 20 Sep 2020 19:25:52 -0700 (PDT)
Received: from arch-chirva.localdomain (pool-68-133-6-220.bflony.fios.verizon.net. [68.133.6.220])
        by smtp.gmail.com with ESMTPSA id w44sm9044859qth.9.2020.09.20.19.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 19:25:52 -0700 (PDT)
Date:   Sun, 20 Sep 2020 22:25:50 -0400
From:   Stuart Little <achirvasub@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org
Cc:     kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 5.9.0-rc6 fails =?utf-8?Q?to_?=
 =?utf-8?Q?compile_due_to_'redefinition_of_=E2=80=98dax=5Fsupported?=
 =?utf-8?B?4oCZJw==?=
Message-ID: <20200921022550.GE3027080@arch-chirva.localdomain>
References: <20200921010359.GO3027113@arch-chirva.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200921010359.GO3027113@arch-chirva.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An update on this: I've done a bisect, with the following result.

--- cut here ---

e2ec5128254518cae320d5dc631b71b94160f663 is the first bad commit
commit e2ec5128254518cae320d5dc631b71b94160f663
Author: Jan Kara <jack@suse.cz>
Date:   Sun Sep 20 08:54:42 2020 -0700

    dm: Call proper helper to determine dax support
    
    DM was calling generic_fsdax_supported() to determine whether a device
    referenced in the DM table supports DAX. However this is a helper for "leaf" device drivers so that
    they don't have to duplicate common generic checks. High level code
    should call dax_supported() helper which that calls into appropriate
    helper for the particular device. This problem manifested itself as
    kernel messages:
    
    dm-3: error: dax access failed (-95)
    
    when lvm2-testsuite run in cases where a DM device was stacked on top of
    another DM device.
    
    Fixes: 7bf7eac8d648 ("dax: Arrange for dax_supported check to span multiple devices")
    Cc: <stable@vger.kernel.org>
    Tested-by: Adrian Huang <ahuang12@lenovo.com>
    Signed-off-by: Jan Kara <jack@suse.cz>
    Acked-by: Mike Snitzer <snitzer@redhat.com>
    Reported-by: kernel test robot <lkp@intel.com>
    Link: https://lore.kernel.org/r/160061715195.13131.5503173247632041975.stgit@dwillia2-desk3.amr.corp.intel.com
    Signed-off-by: Dan Williams <dan.j.williams@intel.com>

 drivers/dax/super.c   |  4 ++++
 drivers/md/dm-table.c | 10 +++++++---
 include/linux/dax.h   | 22 ++++++++++++++++++++--
 3 files changed, 31 insertions(+), 5 deletions(-)

--- end ---

On Sun, Sep 20, 2020 at 09:03:59PM -0400, Stuart Little wrote:
> I am trying to compile for an x86_64 machine (Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz). The config file I am currently using is at
> 
> https://termbin.com/xin7
> 
> The build for 5.9.0-rc6 fails with the following errors:
> 
> --- cut here ---
> 
> drivers/dax/super.c:325:6: error: redefinition of ‘dax_supported’
>   325 | bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
>       |      ^~~~~~~~~~~~~
> In file included from drivers/dax/super.c:16:
> ./include/linux/dax.h:162:20: note: previous definition of ‘dax_supported’ was here
>   162 | static inline bool dax_supported(struct dax_device *dax_dev,
>       |                    ^~~~~~~~~~~~~
>   CC      lib/memregion.o
>   CC [M]  drivers/gpu/drm/drm_gem_vram_helper.o
> make[2]: *** [scripts/Makefile.build:283: drivers/dax/super.o] Error 1
> make[1]: *** [scripts/Makefile.build:500: drivers/dax] Error 2
> make[1]: *** Waiting for unfinished jobs....
> 
> --- end ---
> 
> That's earlier on, and then later, at the end of the (failed) build:
> 
> make: *** [Makefile:1784: drivers] Error 2
> 
> The full build log is at
> 
> https://termbin.com/ihxj
> 
> but I do not see anything else amiss. 5.9.0-rc5 built fine last week.
