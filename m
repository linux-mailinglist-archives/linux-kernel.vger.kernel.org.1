Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F5B28F396
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbgJONqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45818 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387634AbgJONql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602769599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uCozRPJayXzsdVCpvZ8ffIGTYIbEnNyuAmtCfUAJ+2A=;
        b=d905vs37RIfdzxoJN4lBVdFV81jQSsYYObmpfzKhUjPwXi3Qp2FF3RKLY9rgLiqU6QFKxC
        kEk9c4lmYPnia1gprTWw4DAHMXyES2pZFjeiUCufH6QJIcoWMMs5KNgXREwZvXDMYjzDEP
        1coMKL4RVkbMSDGOaNiTsyuZHNEdotg=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-TM8mgKXjOU2-jlC9Hkf7VQ-1; Thu, 15 Oct 2020 09:46:36 -0400
X-MC-Unique: TM8mgKXjOU2-jlC9Hkf7VQ-1
Received: by mail-ot1-f69.google.com with SMTP id a12so961896otp.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uCozRPJayXzsdVCpvZ8ffIGTYIbEnNyuAmtCfUAJ+2A=;
        b=djKshABuVSf9HvzLKMcsdr+M7zPTsoQGV5TH3Si/1p9Bg2AIZkImniuDbf3mppIG//
         hWo6bT+FXv01q7wBAQFbit80j3QKycgkbVpotOfmgPeT4M8jUCv70laE7BY+JMOq9ZsZ
         /gLjzkoJlmKTwqmuwW6k0DeWOKEsqQZn48adY0mmwL3V4QUlI9KY8o9sKzKlasOT/8Uh
         08ZrowoaZavbqpI3yErwAPzktPnxRr0tMOw5a0aTOUYupQaNQGAAKEQvx61DEBvMCvLI
         ywUFZwkWPJ6FOjC6PAgRF4p3/x7exsz68CsqHu3VA2yjJeZTtqLzUrMpuJS3+egk61YY
         pJAg==
X-Gm-Message-State: AOAM533yymOBD4GGAUlOMJOkD8KLjJl+uPqRM0edXrZLe6zqyy4Z5rYo
        IgM88jiU+ayjilaz8U9pob4hK+PyHg2UQOaO6mo6d35JtO/nDjv/prrS7MiS2fn8vs7v6xjJnDt
        K2aMF2TcXt5l6Ii0yE15c2IuM
X-Received: by 2002:a05:6830:1de6:: with SMTP id b6mr2761966otj.37.1602769595578;
        Thu, 15 Oct 2020 06:46:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVQw352URDrBKs/bqRnq7mFEEVp1UVno4HCu8PoybVHyD+06YQdNLKL0RZYq74pIIvB4LsdA==
X-Received: by 2002:a05:6830:1de6:: with SMTP id b6mr2761946otj.37.1602769595308;
        Thu, 15 Oct 2020 06:46:35 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h25sm1105625otj.41.2020.10.15.06.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 06:46:34 -0700 (PDT)
Subject: Re: [PATCH v10 0/6] add DFL bus support to MODULE_DEVICE_TABLE()
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, krzk@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1602746193-10626-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e531ddb4-61f9-6f86-0d45-8d721e114db2@redhat.com>
Date:   Thu, 15 Oct 2020 06:46:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1602746193-10626-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To me, this set looks ready to go.

Tom

On 10/15/20 12:16 AM, Xu Yilun wrote:
> Patch #1 is a fix of the fields in struct dfl_device & dfl_device_id.
>
> Patch #2, 3, 4 add dfl bus support to MODULE_DEVICE_TABLE(), they also
> move the necessary definitions in head file to public folders so that
> scatter dfl drivers could use them.
>
> Patch #5 is the dfl driver for N3000 Nios private feature, this is the
> first use case of dfl bus.
>
> Patch #6 is the dfl driver for DFL EMIF private feature.
>
>
> Main changes from v1:
> - A new patch (Patch #3) to fix the description.
> - Rename the dfl-bus.h to dfl.h
> - Updated the MAINTAINERS under FPGA DFL DRIVERS.
> - Improve comments and minor fixes.
>
> Main changes from v2:
> - Change the bus name from "dfl" to "fpga-dfl", also rename related
>   variables, functions ...
> - Changes the data type of fpga_dfl_device_id.type from u8 to u16
> - Explicitly defines the values of enum fpga_dfl_id_type
> - Delete the comments for the valid bits of type & feature_id
> - changes MODALIAS format for fpga dfl devices
>
> Main changes from v3:
> - Change the bus name back to "dfl".
> - Add 2 patches (#5, 6) for dfl drivers.
> - Delete the retimer FEC mode configuration via module_parameter for
>   Patch #5
> - Merge the patch "Make m10_n3000_info static" (https://lore.kernel.org/linux-fpga/52d8411e-13d8-1e91-756d-131802f5f445@huawei.com/T/#t)
>   into Patch #5
> - Add static prefix for emif attributes macro for Patch #6
>
> Main changes from v9:
> - Add the description for struct dfl_device_id in mod_devicetable.h
> - Move the dfl.h from include/linux/fpga to include/linux
> - some code refactor and minor fixes for dfl-n3000-nios
>
> Xu Yilun (6):
>   fpga: dfl: fix the definitions of type & feature_id for dfl devices
>   fpga: dfl: move dfl_device_id to mod_devicetable.h
>   fpga: dfl: add dfl bus support to MODULE_DEVICE_TABLE()
>   fpga: dfl: move dfl bus related APIs to include/linux/dfl.h
>   fpga: dfl: add support for N3000 Nios private feature
>   memory: dfl-emif: add the DFL EMIF private feature driver
>
>  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +
>  .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  47 ++
>  MAINTAINERS                                        |   3 +-
>  drivers/fpga/Kconfig                               |  11 +
>  drivers/fpga/Makefile                              |   2 +
>  drivers/fpga/dfl-n3000-nios.c                      | 588 +++++++++++++++++++++
>  drivers/fpga/dfl.c                                 |   4 +-
>  drivers/fpga/dfl.h                                 |  85 +--
>  drivers/memory/Kconfig                             |   9 +
>  drivers/memory/Makefile                            |   2 +
>  drivers/memory/dfl-emif.c                          | 207 ++++++++
>  include/linux/dfl.h                                |  86 +++
>  include/linux/mod_devicetable.h                    |  24 +
>  scripts/mod/devicetable-offsets.c                  |   4 +
>  scripts/mod/file2alias.c                           |  13 +
>  15 files changed, 1023 insertions(+), 87 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
>  create mode 100644 drivers/fpga/dfl-n3000-nios.c
>  create mode 100644 drivers/memory/dfl-emif.c
>  create mode 100644 include/linux/dfl.h
>

