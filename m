Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBAB282D8D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 22:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgJDUng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 16:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbgJDUng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 16:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601844214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jZ2kTKiFO3mkdMEg8ILVmGdnJBT4O9bHhq3zxcUrH+w=;
        b=Bo5uogp13x+1oRrnOkluZdDjuSl/X5JsZUryijUibsBfBsCC6xAwlzwRjDOs+mwHWEPjln
        Cs2O0FdR5k6JE4HRUhmS1kByIvls0Gea4R8G1q3805r+UD0IZ2ZSemwb8aOTwcq38HjpOJ
        WPYshUJzSL+suzw7pSuy6nQlbl7+/S8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-9tnsKgXzOdyhgMW45NQ8uA-1; Sun, 04 Oct 2020 16:43:33 -0400
X-MC-Unique: 9tnsKgXzOdyhgMW45NQ8uA-1
Received: by mail-qk1-f200.google.com with SMTP id m186so5225186qkf.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 13:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jZ2kTKiFO3mkdMEg8ILVmGdnJBT4O9bHhq3zxcUrH+w=;
        b=VjSjr8iDwSJ6/Hpt/VOawfIydmIZrtiHHl4/s5XbMdtaPjif19JWSM7EI916QeSeHQ
         Pse3earwOCddAT2i+xzOqQDYZnp7TYh41JEbkkSVWmP2MP61BYOYRGguA4FaYHkAB/V8
         NNGfsd2uKuMhLxgpvajF0tOJFGcWKORgOUSEhfLoaEb8SC6JCKfJuO0eXYzFvggT6aB0
         +O7ES7b7tDYSZI2j+mbjvrJy3B30Ac2+ySdl2qznUirEsc+nDQf5T0OqIk5Cr89lXzFB
         0VlwohKr3xDeJM1hKoOZjIa1xOXjGFiS0Blzm6rDyc9vLBAExPKYSr3Z33U0/TrHUs3Q
         J3tQ==
X-Gm-Message-State: AOAM533YI9RoEeQ2McMZuq8DlwfaMvFKTvvNYOCguHZkqlgmwUSvHFIQ
        1GSuwRercWh5YBTHGz9hLr9rc8MpbUMd6pASOaq8Eak4GlfcFOJq8A+euh6XVApmWrcsuqJiB1D
        OcGNYwP6iim/Rv/sZMPttFxTu
X-Received: by 2002:ac8:70d8:: with SMTP id g24mr10035870qtp.221.1601844212662;
        Sun, 04 Oct 2020 13:43:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+GbC8nBNvRHq2uFSKkOacyczKoG8HTcDjmrTKr+v+rjzitUTE3Whsdyx9T/BNAyK0MOmyDA==
X-Received: by 2002:ac8:70d8:: with SMTP id g24mr10035850qtp.221.1601844212405;
        Sun, 04 Oct 2020 13:43:32 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j9sm6048077qtq.36.2020.10.04.13.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 13:43:31 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] fpga: sec-mgr: intel fpga security manager class
 driver
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201002223701.1317-1-russell.h.weight@intel.com>
 <20201002223701.1317-2-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <171cfcae-07a2-51a4-64bc-4cdf58c2226a@redhat.com>
Date:   Sun, 4 Oct 2020 13:43:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201002223701.1317-2-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/2/20 3:36 PM, Russ Weight wrote:
> Create the Intel Security Manager class driver. The security
> manager provides interfaces to manage secure updates for the
> FPGA and BMC images that are stored in FLASH. The driver can
> also be used to update root entry hashes and to cancel code
> signing keys.
>
> This patch creates the class driver and provides sysfs
> interfaces for displaying root entry hashes, canceled code
> signing keys and flash counts.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v2:
>   - Bumped documentation dates and versions
>   - Added Documentation/fpga/ifpga-sec-mgr.rst 
>   - Removed references to bmc_flash_count & smbus_flash_count (not supported)
>   - Split ifpga_sec_mgr_register() into create() and register() functions
>   - Added devm_ifpga_sec_mgr_create()
>   - Removed typedefs for imgr ops
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     |  67 +++
>  Documentation/fpga/ifpga-sec-mgr.rst          |  50 ++
>  Documentation/fpga/index.rst                  |   1 +
>  MAINTAINERS                                   |   9 +
>  drivers/fpga/Kconfig                          |   9 +
>  drivers/fpga/Makefile                         |   3 +
>  drivers/fpga/ifpga-sec-mgr.c                  | 432 ++++++++++++++++++
>  include/linux/fpga/ifpga-sec-mgr.h            |  81 ++++
>  8 files changed, 652 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>  create mode 100644 Documentation/fpga/ifpga-sec-mgr.rst
>  create mode 100644 drivers/fpga/ifpga-sec-mgr.c
>  create mode 100644 include/linux/fpga/ifpga-sec-mgr.h

Thanks for the changes, looks good.

Reviewed-by: Tom Rix <trix@redhat.com>


