Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0BA25E8FC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 18:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgIEQKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 12:10:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51198 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgIEQKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 12:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599322235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nqX3XQ0T1IWMwfBEotLqq00Fr1HGlhM7aJKTBGTueVI=;
        b=Yi3KY1Lw0aT8+RjW6XklhNjp3lzmvHNDMoHj/ZieJlxfV7RrDNm6hzJ+rvJhDoOfQUtwBm
        jXFBptVtQE2z7tUhDpbcGMtq1J8wNHMw75IrqTYjXn88+wNSLp5d2ne+pKwltXAsEKITu1
        wNUNrlSGAeoZDb0ui370p1+b3vc+ULU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-NRQw2yUHMJ2G6bh1tGBYNA-1; Sat, 05 Sep 2020 12:10:31 -0400
X-MC-Unique: NRQw2yUHMJ2G6bh1tGBYNA-1
Received: by mail-qv1-f69.google.com with SMTP id p20so5472920qvl.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 09:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nqX3XQ0T1IWMwfBEotLqq00Fr1HGlhM7aJKTBGTueVI=;
        b=b3GhrEU9JwptZgIf2uQSTuMfqdDoIHsJCEfkET7+HdK+8VcrcGAVoat8fCdPKBhZNP
         xk7ubAqdStHOgEcXMyX4aED8Qm2Kb7aZfWK4SV6keVBrKrX0Zfyj4jEXtbHDeaHsRjx8
         QapkTR3L8GRZLY49oFgTIFbtCx9E8MY6x3NHO0+ez2PU/iYmldrY3KuGlUFVtNI6VO29
         1pKNyJ2e4DfmUu/nDOc5JZC7p6Y5CtUpl7TQvO0ISYr6JtyRmm2qgG4j1wRrU+17316q
         nNEe0smkVK4gonfy4w75/5VFx22DsVzGM1ZnbFw+FW15xcjDF2nSlEL0qMNta6x9SEyf
         xCgw==
X-Gm-Message-State: AOAM533MpIP+Ss5PIwuP0pnJkTy8nsuwgGloeVV3a9txb+0pRrSgts1k
        2zLcy9oUOQ0iyzCDfeGR6GrIwJc0xWZrdEJkVI6UbXVVtwlBqueWUQW/JRdVndBFz90GuUFtbAt
        txyxi7tsYmHr9Trkp9n1KOESZ
X-Received: by 2002:ac8:b83:: with SMTP id h3mr13637290qti.113.1599322210648;
        Sat, 05 Sep 2020 09:10:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhafC+rMHgk4CqKuJZuHADakjMkBCaUodiB3WieRJ8qFCIeCrAQVOG0Wqfi+XZVoaN+YNpVw==
X-Received: by 2002:ac8:b83:: with SMTP id h3mr13637267qti.113.1599322210308;
        Sat, 05 Sep 2020 09:10:10 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j190sm7071726qkd.22.2020.09.05.09.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2020 09:10:09 -0700 (PDT)
Subject: Re: [PATCH v1 00/12] Intel FPGA Security Manager Class Driver
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <fa61fd85-71ae-77fb-a364-44a1df483957@redhat.com>
Date:   Sat, 5 Sep 2020 09:10:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200904235305.6254-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/4/20 4:52 PM, Russ Weight wrote:
> These patches depend on the patchset: "add regmap-spi-avmm & Intel
> Max10 BMC chip support" which is currently under review.

https://marc.info/?l=linux-kernel&m=159782274232229&w=2

regmap-spi-avmm is in linux-next.

max10 is not. however applying it does not resolve resolve git am conflicts with yesterday's linux-next.  I normally build the larger patchsets as a test.

>            --------------------------------------------------
>
> This patchset introduces the Intel Security Manager class driver
> for managing secure updates on Intel FPGA Cards. It also provides
> the n3000bmc-secure mfd sub-driver for the MAX10 BMC for the n3000
> Programmable Acceleration Cards (PAC). The n3000bmc-secure driver
> is implemented using the Intel Security Manager class driver.
>
> The Intel Security Manager class driver provides a common API for
> user-space tools to manage updates for Secure FPGA devices. Device
> drivers that instantiate the Intel Security Manager class driver will
> interact with the HW secure update engine in order to transfer
> new FPGA and BMC images to FLASH so that they will be automatically
> loaded when the FPGA card reboots.
>
> The API consists of sysfs nodes and supports the following functions:
>
> (1) Instantiate and monitor a secure update
> (2) Display security information including: Root Entry Hashes (REH),
>     Cancelled Code Signing Keys (CSK), and flash update counts for
>     both BMC and FPGA images.
>
> Secure updates make use of the request_firmware framework, which
> requires that image files are accessible under /lib/firmware. A request
> for a secure update returns immediately, while the update itself
> proceeds in the context of a kernel worker thread. Sysfs files provide
> a means for monitoring the progress of a secure update and for
> retrieving error information in the event of a failure.
>
> The n3000bmc-secure driver instantiates the Intel Security Manager
> class driver and provides the callback functions required to support
> secure updates on Intel n3000 PAC devices.

This is a good description.  Because security manager is a new interface, there should be a Documentation/fpga/ifpga-sec-mgr.rst to collect this description.

How will these devices be discovered ? n3000 is a dfl device, will there be a dfl feature id for it at some point ? 

Can you describe if/how the security manager would live outside of dfl ?  I am wondering why this shouldn't be dfl-sec-mgr. 

I did not see any version handling.  How would this sw adapt to a newer or older version of the bmc interface?

Tom

>
> Russ Weight (12):
>   fpga: fpga security manager class driver
>   fpga: create intel max10 bmc security engine
>   fpga: expose max10 flash update counts in sysfs
>   fpga: expose max10 canceled keys in sysfs
>   fpga: enable secure updates
>   fpga: add max10 secure update functions
>   fpga: expose sec-mgr update status
>   fpga: expose sec-mgr update errors
>   fpga: expose sec-mgr update size
>   fpga: enable sec-mgr update cancel
>   fpga: expose hardware error info in sysfs
>   fpga: add max10 get_hw_errinfo callback func
>
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 151 ++++
>  MAINTAINERS                                   |   8 +
>  drivers/fpga/Kconfig                          |  20 +
>  drivers/fpga/Makefile                         |   6 +
>  drivers/fpga/ifpga-sec-mgr.c                  | 669 ++++++++++++++++++
>  drivers/fpga/intel-m10-bmc-secure.c           | 557 +++++++++++++++
>  include/linux/fpga/ifpga-sec-mgr.h            | 201 ++++++
>  include/linux/mfd/intel-m10-bmc.h             | 116 +++
>  8 files changed, 1728 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>  create mode 100644 drivers/fpga/ifpga-sec-mgr.c
>  create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
>  create mode 100644 include/linux/fpga/ifpga-sec-mgr.h
>

