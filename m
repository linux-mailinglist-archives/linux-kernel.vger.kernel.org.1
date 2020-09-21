Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07346271976
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgIUCsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:48:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:56183 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgIUCsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:48:06 -0400
IronPort-SDR: syKJTURLJdC6nOuabqVcMJoW24IhxKX+iqhhx7IxqmvsKKKVEU1vx5ujelAW8EXkGsfox+QSC7
 79sz3awSQqyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="178376024"
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="178376024"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 19:47:58 -0700
IronPort-SDR: gak2c7b4wJjDxzUuMDDeaOOyXBKuUuZIGwtSEmZpL0eOLtdzNzFRwebiK6YyfvJTitWsnYA2sD
 GPUwQNIeglew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="453794662"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 20 Sep 2020 19:47:56 -0700
Date:   Mon, 21 Sep 2020 10:43:26 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, mdf@kernel.org,
        yilun.xu@intel.com
Subject: Re: [PATCH v2] add the FPGA Device Feature List (DFL) EMIF support
Message-ID: <20200921024326.GA8971@yilunxu-OptiPlex-7050>
References: <1600234622-8815-1-git-send-email-yilun.xu@intel.com>
 <20200920162205.GA10210@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920162205.GA10210@kozik-lap>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 06:22:05PM +0200, Krzysztof Kozlowski wrote:
> On Wed, Sep 16, 2020 at 01:37:01PM +0800, Xu Yilun wrote:
> > The patchsets "Modularization of DFL private feature drivers" & "add dfl 
> > bus support to MODULE_DEVICE_TABLE()" are all queued to linux-next. So
> > there is no dependency now.
> 
> What do you mean there is no dependency? The DFL is required here and it
> won't compile without these patches:

Sorry, actually I mean the dependencies have been queued to linux-next.
I didn't realize patch dependency problems across maintainer's trees.

I'll try to contact Moritz if this patch could be applied via his tree.

Thanks,
Yilun

> 
>   CC      drivers/memory/dfl-emif.o
> ../drivers/memory/dfl-emif.c:10:10: fatal error: linux/fpga/dfl.h: No such file or directory
>  #include <linux/fpga/dfl.h>
>           ^~~~~~~~~~~~~~~~~~
> compilation terminated.
> 
> This simply cannot go in without dependency.
> 
> I described in your v1 submission what is needed here:
> "Anyway I will need a stable tag with mentioned dependencies or this
> will wait for the next cycle."
> 
> Best regards,
> Krzysztof
