Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0972CC6B5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbgLBTcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgLBTcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:32:55 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6BAC0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:32:14 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id h7so949612pjk.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vbmUce51n0krhiz6IFENVF9pgBvxYw5qYTmdokIFBx0=;
        b=OB8tdF7XPPRvLbxT/HXse2cshrzol0nnx/yT4ZkqLQVLlE+61uDznkIYtRwOdu+Amf
         E8VOkgBUBS5QTKmNRPZdJs7ly7DcgNsV65BkQ3+puafMCrzr0EKTN4NbaqzIDBhxoIZI
         rNwt6GigZQSOoupZa4d6lCm4hHPIV4BhMI8m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vbmUce51n0krhiz6IFENVF9pgBvxYw5qYTmdokIFBx0=;
        b=J3LB/oSZqOmzw2N97lsPsACdgI9uoKiLj8hTX0J+rvcbxJpuMaEL6tX3QJILDulag/
         nxhE9dUjXmJqr1q91BMPYHcCeGQf+B78pbYYOKjnz5Zk+aZ6IeuS5EQYVPAB9LCPDY6A
         +H6IrXFYBMLI49wRlmcD9hBDez97S/rCJ+YsumCNMwG0RaTs8t6MYgYwrIPOlRWXiYxa
         8bloHNEPWVT41l5Muut72U7LCIj0LeyX9SmX4O3z8VqgP4sNs86K5gWIsc/PsfmCx21N
         TBvox/xX9GvKtDCLgKCjW7HdgHTAlbia1LhGaxMEMikIfEGNpvgqodl89Y2gLsOY/0Gm
         Cojw==
X-Gm-Message-State: AOAM530Q26YtEylXn9dG36fPoI+CBz2y8U57F9JbnvFQjqtOFUu6kTUz
        4CFG429Wp3oCVwu5RkUGSkd6/jXsM3sVyMX8
X-Google-Smtp-Source: ABdhPJytpYwxiUYLTOB6lkAHyir5C1sXgAEZpkqx9VFbqEwkCcZ4Tf5Qqh08BnlIYViekoyeFZ64+g==
X-Received: by 2002:a17:90a:4593:: with SMTP id v19mr1292857pjg.217.1606937534288;
        Wed, 02 Dec 2020 11:32:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x207sm573335pfc.171.2020.12.02.11.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:32:13 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:32:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "outgoing2/0000-cover-letter.patch@mx0b-0016f401.pphosted.com" 
        <outgoing2/0000-cover-letter.patch@mx0b-0016f401.pphosted.com>
Subject: Re: [EXT] Re: [PATCH v2 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Message-ID: <202012021126.20ACBBD@keescook>
References: <20201123111925.28999-1-bbudiredla@marvell.com>
 <202012011218.3B6566C5@keescook>
 <CY4PR1801MB207097391BD8DE37A0F49102DEF30@CY4PR1801MB2070.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1801MB207097391BD8DE37A0F49102DEF30@CY4PR1801MB2070.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 06:36:21AM +0000, Bhaskara Budiredla wrote:
> >From: Kees Cook <keescook@chromium.org>
> >On Mon, Nov 23, 2020 at 04:49:24PM +0530, Bhaskara Budiredla wrote:
> >Why isn't this just written as:
> >
> >config MMC_PSTORE
> >	bool "Log panic/oops to a MMC buffer"
> >	depends on MMC_BLOCK
> >	select PSTORE_BLK
> >	help
> >	  This option will let you create platform backend to store kmsg
> >	  crash dumps to a user specified MMC device. This is primarily
> >	  based on pstore/blk.
> >
> 
> The idea was to compile MMC_PSTORE as part of MMC_BLOCK driver,
> provided it is optionally enabled.
> The above arrangement compiles MMC_PSTORE 
> as module: if (CONFIG_MMC_PSTORE_BACKEND == y && CONFIG_MMC_BLOCK == m)
> as static:     if (CONFIG_MMC_PSTORE_BACKEND == y && CONFIG_MMC_BLOCK == y)

Ah, okay. If it's a tri-state, wouldn't it track CONFIG_MMC_BLOCK's
state? As in, does this work:

config MMC_PSTORE
	tristate "Log panic/oops to a MMC buffer"
	depends on MMC_BLOCK
	select PSTORE_BLK
	help
	  This option will let you create platform backend to store kmsg
	  crash dumps to a user specified MMC device. This is primarily
	  based on pstore/blk.

> >> +	if (strncmp(cxt->dev_name, disk_name, strlen(disk_name)))
> >> +		return;
> >
> >Why isn't this just strcmp()?
> 
> The mmc disk name (disk_name) doesn't include the partition number. 
> strncmp is restricted to something like /dev/mmcblk0, it doesn't cover full /dev/mmcblk0pn.
> The partition number check is carried out in the next statement.

Okay, gotcha; thanks!

> >> +	dev->flags = PSTORE_FLAGS_DMESG;
> >
> >Can't this support more than just DMESG? I don't see anything specific to that.
> >This is using pstore/zone ultimately, which can support whatever frontends it
> >needs to.
> 
> Yes, as of now the support is only for DMESG. We will extend this to other frontends
> on need basis.

Okay -- I assume this has mostly to do with not having erasure (below).

> >> +	dev->erase = NULL;
> >
> >No way to remove the records?
> 
> Yes, at this time, no removal of records.

Okay. (I think this might be worth mentioning in docs somewhere.)

-- 
Kees Cook
