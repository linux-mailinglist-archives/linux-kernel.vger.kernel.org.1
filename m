Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A3D282DBD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 23:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgJDVTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 17:19:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbgJDVTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 17:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601846385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06iaICtcuc3VXJ0eesmmXr9qpVUOEqKPKqC4TYV3xdY=;
        b=GOiqw0aFaj5+yg/r5Ae3MGHLlqMcntCicE9yjqDRtbPmBX32BO+yBc9Eya/MA8ukGbwY4v
        izmOMTMwmB4xXdy3d04ViGETRcfTXwAVErkT7hjaGEGD2aoyqwjM26gWEypMtAIs74Zn4J
        II2sT75Z//i4iXrajeBr5K2A5ugtBaM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-lgpI1WeeP7yKVEQ5r6Q6uQ-1; Sun, 04 Oct 2020 17:19:44 -0400
X-MC-Unique: lgpI1WeeP7yKVEQ5r6Q6uQ-1
Received: by mail-qt1-f199.google.com with SMTP id y20so3750977qta.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 14:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=06iaICtcuc3VXJ0eesmmXr9qpVUOEqKPKqC4TYV3xdY=;
        b=TsSdueHrgWhDvkhuYSx1vercAMPitVGd4Lu02wSsaVjQUA7mNWjwMc0bLHLm2FZ3AC
         VuzGhMylq57/Mf8QhiihdQ01yEPGQqadH5mtfpG45BFLc7G3uB89IrcTbKsqVix6FxG+
         Xh7s0+kEg2qFDBFSWYPcHtAIQG8s2rXddxcbEQDiqyHgvKIVXK9RC84OGBOJJBOoUAT6
         jE7J3ij+XqVzH4NcYrdhGefvfD00y5GCd4MKY1PJpLxyd18wVpLPKyhDFKznk5Kip0g3
         LMTcSuWcPB0HZNmTVcyFlH9sjOlO1BaKA5qgVCjsqWDBFxuC8gDLTRQj56BqIuqi1/1x
         T2mQ==
X-Gm-Message-State: AOAM5309lFUKHZfby74t/qjCpDjhkh3pm61pd582GqVxqthn5e7/RvT7
        5poZe7o9hyJ6HV2zGnrx4qP4JBmgg15o4egVMhrinpn7zOkprt2mFiqF3m0BOp587+dz1UzmEsI
        FLXDaba3yQW4quED51Ke4C5/A
X-Received: by 2002:a05:620a:2e7:: with SMTP id a7mr10996295qko.48.1601846383598;
        Sun, 04 Oct 2020 14:19:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqGzeBxcINGKW21EThNrahjbd0kD2ava9Dvg0YQQ6xSNAUNOgxWZLwO9n9KJvImKU6vX2DRA==
X-Received: by 2002:a05:620a:2e7:: with SMTP id a7mr10996274qko.48.1601846383285;
        Sun, 04 Oct 2020 14:19:43 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f24sm5961833qkk.136.2020.10.04.14.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 14:19:42 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] Intel FPGA Security Manager Class Driver
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201002223701.1317-1-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <04ff94d2-833b-6776-0256-c2e0d9ad9989@redhat.com>
Date:   Sun, 4 Oct 2020 14:19:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201002223701.1317-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/2/20 3:36 PM, Russ Weight wrote:
> The Intel FPGA Security Manager class driver provides a common
> API for user-space tools to manage updates for secure Intel FPGA
> devices. Device drivers that instantiate the Intel Security
> Manager class driver will interact with a HW secure update
> engine in order to transfer new FPGA and BMC images to FLASH so
> that they will be automatically loaded when the FPGA card reboots.
>
> A significant difference between the FPGA Manager and the Intel FPGA 
> Security Manager is that the FPGA Manager does a live update (Partial
> Reconfiguration) to a device whereas the Intel FPGA Security Manager
> updates the FLASH images for the Static Region and the BMC so that
> they will be loaded the next time the FPGA card boots. Security is
> enforced by hardware and firmware. The security manager interacts
> with the firmware to initiate an update, pass in the necessary data,
> and collect status on the update.
>
> The n3000bmc-secure driver is the first driver to use the Intel FPG
> Security Manager. This driver was previously submittied in the same
> patch set, but has been split out in to a separate patch set for V2.
> Follow-on Intel devices will also make use of this common API for
> secure updates.
>
> In addition to managing secure updates of the FPGA and BMC images,
> the Intel FPGA Security Manager update process may also used to
> program root entry hashes and cancellation keys for the FPGA static
> region, the FPGA partial reconfiguration region, and the BMC.
>
> Secure updates make use of the request_firmware framework, which
> requires that image files are accessible under /lib/firmware. A request
> for a secure update returns immediately, while the update itself
> proceeds in the context of a kernel worker thread. Sysfs files provide
> a means for monitoring the progress of a secure update and for
> retrieving error information in the event of a failure.
>
> The API consists of sysfs nodes and supports the following functions:
>
> (1) Instantiate and monitor a secure update
> (2) Display security information including: Root Entry Hashes (REH),
>     Cancelled Code Signing Keys (CSK), and flash update counts for
>     both BMC and FPGA images.
>
> Changelog v1 -> v2:
>   - Separated out the MAX10 BMC Security Engine to be submitted in
>     a separate patch-set.
>   - Bumped documentation dates and versions
>   - Split ifpga_sec_mgr_register() into create() and register() functions
>   - Added devm_ifpga_sec_mgr_create()
>   - Added Documentation/fpga/ifpga-sec-mgr.rst 
>   - Changed progress state "read_file" to "reading"
>   - Added sec_error() function (similar to sec_progress())
>   - Removed references to bmc_flash_count & smbus_flash_count (not supported)
>   - Removed typedefs for imgr ops
>   - Removed explicit value assignments in enums
>   - Other minor code cleanup per review comments 
>
> Russ Weight (7):
>   fpga: sec-mgr: intel fpga security manager class driver
>   fpga: sec-mgr: enable secure updates
>   fpga: sec-mgr: expose sec-mgr update status
>   fpga: sec-mgr: expose sec-mgr update errors
>   fpga: sec-mgr: expose sec-mgr update size
>   fpga: sec-mgr: enable cancel of secure update
>   fpga: sec-mgr: expose hardware error info
>
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 143 ++++
>  Documentation/fpga/ifpga-sec-mgr.rst          |  50 ++
>  Documentation/fpga/index.rst                  |   1 +
>  MAINTAINERS                                   |   9 +
>  drivers/fpga/Kconfig                          |   9 +
>  drivers/fpga/Makefile                         |   3 +
>  drivers/fpga/ifpga-sec-mgr.c                  | 781 ++++++++++++++++++
>  include/linux/fpga/ifpga-sec-mgr.h            | 137 +++
>  8 files changed, 1133 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>  create mode 100644 Documentation/fpga/ifpga-sec-mgr.rst
>  create mode 100644 drivers/fpga/ifpga-sec-mgr.c
>  create mode 100644 include/linux/fpga/ifpga-sec-mgr.h

Russ,

This set has all the changes I was looking for.

Thanks,

Tom

