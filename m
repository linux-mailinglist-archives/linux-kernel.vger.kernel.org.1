Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50B72DD23D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 14:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgLQNhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 08:37:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726613AbgLQNhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608212156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SgJOBcxRN4tEtPumxdF20iYY88fFb0qgiurqky0v6BE=;
        b=FQbBuYZ4cSHEj3r0F3D1uJU1sSaajuDHxkXnkUbyeVizfothBKEayzHLFzIRPPJYfIuOQM
        YYK9YQmZqxtXNknieQFY4rSRHeCS7wz4h50RSQsugfulYzLpExR1NX1X57/iUT0AgFDm3p
        6NYHYXD1/fmx8GYNFMDB9GmxgzHTt74=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-ZbFaL8geNEKkO1I-nwmxUg-1; Thu, 17 Dec 2020 08:35:55 -0500
X-MC-Unique: ZbFaL8geNEKkO1I-nwmxUg-1
Received: by mail-qt1-f199.google.com with SMTP id a11so19643984qto.16
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 05:35:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SgJOBcxRN4tEtPumxdF20iYY88fFb0qgiurqky0v6BE=;
        b=FLXuAQHvrg34mvAKyv0N0CUgsJ1VJxh5C+xNChf1khkbA3wYtKR9wo88wjmxXahU9E
         ODRIkD9/y4HCVBdtB0c8eFsNGAEn3oRNmK6pPhE5elG9LJTZ8UKc8vZXy9tk3pTPjZ+F
         s2NFgSFqNZzCaSYQg29QqG34/O+cNGm+8SZChLuZoatFr49JWJjZ6QdIrv3kR0iL4py9
         0cyecr8RSwUgX7HV/VLZMnzExReLOC7ACxtgZhiHEAaR6rvdeNQnCpT7lEapS6OJEuTi
         EngrNt2Lgk8REXXF5fdOXPja0yPtwP/YHrTryPvp+u+W96Lk4Vf8GB3AFAKaP2kSINdZ
         Iq7Q==
X-Gm-Message-State: AOAM530Q5Jz4oZDC9ft+ycd2XemURIFnH0sskYMjyc3cCdFPoJr6EHMI
        0eMCiDMp0wAlZOsiwHdGwko8U+QqA/K4EDf037Rscz5pL6YRE4RMFaJVyAeYEzW0h7DCsrtqhAa
        EUu1q4Ehu+l69cmDYP/8ppO5O
X-Received: by 2002:a05:620a:ec7:: with SMTP id x7mr48049241qkm.405.1608212154532;
        Thu, 17 Dec 2020 05:35:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPs+dQeJxIwLKOCxSjTEM23FpThc6Rq1C2Qh0/YIA30/RVV77JmZbVHRRLj3GBEXH8+F6uGw==
X-Received: by 2002:a05:620a:ec7:: with SMTP id x7mr48049217qkm.405.1608212154332;
        Thu, 17 Dec 2020 05:35:54 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s19sm53162qta.35.2020.12.17.05.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 05:35:53 -0800 (PST)
Subject: Re: [PATCH v3 0/3] UIO support for dfl devices
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <85d48e41-0185-0938-b0ed-93d0f825e761@redhat.com>
Date:   Thu, 17 Dec 2020 05:35:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/16/20 9:44 PM, Xu Yilun wrote:
> This patchset supports some dfl device drivers written in userspace.
>
> In the patchset v1, the "driver_override" interface should be used to bind
> the DFL UIO driver to DFL devices. But there is concern that the
> "driver_override" interface is not OK itself. So in v2, we use a new
> matching algorithem. The "driver_override" interface is abandoned, the DFL
> UIO driver matches any DFL device which could not be handled by other DFL
> drivers. So the DFL UIO driver could be used for new DFL devices which are
> not supported by kernel, also it will not impact the devices which are
> already got supported.

This set looks good to me.

Moritz,

Is it possible to get this into 5.11 ?

Tom

>
> Main changes from v1:
> - switch to the new matching algorithem. It matches DFL devices which could
>   not be handled by other DFL drivers.
> - refacor the code about device resources filling.
> - add the documentation.
>
> Main changes from v2:
> - split the match ops changes in dfl.c to an independent patch.
> - move the declarations needed for dfl-uio-pdev from include/linux/dfl.h
>   to driver/fpga/dfl.h
> - some minor fixes.
>
>
> Xu Yilun (3):
>   fpga: dfl: add the match() ops for dfl driver
>   fpga: dfl: add the userspace I/O device support for DFL devices
>   Documentation: fpga: dfl: Add description for DFL UIO support
>
>  Documentation/fpga/dfl.rst  |  27 +++++++++++
>  drivers/fpga/Kconfig        |  10 ++++
>  drivers/fpga/Makefile       |   1 +
>  drivers/fpga/dfl-uio-pdev.c | 110 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl.c          |  22 +++++++--
>  drivers/fpga/dfl.h          |   5 ++
>  include/linux/dfl.h         |   3 ++
>  7 files changed, 173 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/fpga/dfl-uio-pdev.c
>

