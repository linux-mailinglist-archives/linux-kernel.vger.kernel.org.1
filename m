Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6942DD224
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 14:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgLQN2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 08:28:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727723AbgLQN2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608211596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5U7NOPUCjPUEQjTgtfUNAxSeMjqPb4vJZBLZCIjKxDY=;
        b=TwZ2Ja3//gr80AcoMk+7UCVgi2a44cGQG10aqTbywZHsbSRzBSyzfhuLBZ96KnBRUWLmmS
        eWtvN7sUamQngH6bl2OEe6orxSV6rOxSu4G4yCPTpC80UYtIyu0qdCyuPm3Il1UR1bf1/q
        yGi6aaAb/0a1+keYQLrLo1AQ4w4wAHI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-LRxEOPD7PgqkRiz3ScQfsw-1; Thu, 17 Dec 2020 08:26:32 -0500
X-MC-Unique: LRxEOPD7PgqkRiz3ScQfsw-1
Received: by mail-qk1-f198.google.com with SMTP id g26so14474866qkk.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 05:26:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5U7NOPUCjPUEQjTgtfUNAxSeMjqPb4vJZBLZCIjKxDY=;
        b=Q9QWGUS13gFOXtFrs78jW0NzQ/Gkik5rIgPEu0fOI6PaueV0poN49a+G5s/emTNr3R
         ODZ11uCHeQWfmgKPPlBj492SGoW8pu3Bnklk91r1vZsZG2EIgPWPu8LZ0g8h1gLT9zzE
         8LY17eiKuzkGZ2EEMuFdL5nyWkbAMA6YFu7Ns+EePw90TfHffj6Ywkqw7YUwz6PyJ9Wv
         2pyJrVxvd8pGHwxGJ8rCahyny16DsgpipM1ccugLNyoNgzZvld3XTHGggnAyUulID1Ti
         Xxkio8oUdy9jeMzuEWY92mEj7kleM5HuclrhF9jme+ugtdun8Xc2x358CFpMUbsptXlY
         oaUw==
X-Gm-Message-State: AOAM533+Jibl7Sk5/a0V8AVu5IWCYlEpTv2BD+b4YwJrLE1fYxXsHa+g
        s7Wht0oAh8KL01gLdL7wlEGg5bcMx7eo35Cj+i26iJ3Z3anlqEMx/4x+63A6VapEzeM7YeoWpcO
        PPelFROmj3Rh62+kyskVDnbRT
X-Received: by 2002:a05:622a:18d:: with SMTP id s13mr48353445qtw.306.1608211591961;
        Thu, 17 Dec 2020 05:26:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkro5zJ3CnJHz/PKvHRth687yzRn6OxoU9hVf5JGCVNJCettD54oSrTd6l6OyPySJ3gnv+Dg==
X-Received: by 2002:a05:622a:18d:: with SMTP id s13mr48353435qtw.306.1608211591752;
        Thu, 17 Dec 2020 05:26:31 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f19sm1699010qta.80.2020.12.17.05.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 05:26:31 -0800 (PST)
Subject: Re: [PATCH v3 3/3] Documentation: fpga: dfl: Add description for DFL
 UIO support
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
 <1608183881-18692-4-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <994de3b8-0374-40d1-2644-5604742a264e@redhat.com>
Date:   Thu, 17 Dec 2020 05:26:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1608183881-18692-4-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/16/20 9:44 PM, Xu Yilun wrote:
> This patch adds description for UIO support for dfl devices on DFL
> bus.

Thanks for the changes.

Reviewed-by: Tom Rix <trix@redhat.com>

> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v2: no doc in v1, add it for v2.
> v3: some documentation fixes.
> ---
>  Documentation/fpga/dfl.rst | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 0404fe6..b298ad9 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -7,6 +7,7 @@ Authors:
>  - Enno Luebbers <enno.luebbers@intel.com>
>  - Xiao Guangrong <guangrong.xiao@linux.intel.com>
>  - Wu Hao <hao.wu@intel.com>
> +- Xu Yilun <yilun.xu@intel.com>
>  
>  The Device Feature List (DFL) FPGA framework (and drivers according to
>  this framework) hides the very details of low layer hardwares and provides
> @@ -502,6 +503,32 @@ FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
>  could be a reference.
>  
>  
> +UIO support for DFL devices
> +===========================
> +The purpose of an FPGA is to be reprogrammed with newly developed hardware
> +components. New hardware can instantiate a new private feature in the DFL, and
> +then get a DFL device in their system. In some cases users may need a userspace
> +driver for the DFL device:
> +
> +* Users may need to run some diagnostic test for their hardwares.
> +* Users may prototype the kernel driver in user space.
> +* Some hardware is designed for specific purposes and does not fit into one of
> +  the standard kernel subsystems.
> +
> +This requires the direct access to the MMIO space and interrupt handling in
> +userspace. The dfl-uio-pdev module exposes the UIO device interfaces for this
> +purpose. It adds the uio_pdrv_genirq platform device with the resources of
> +the DFL feature, and lets the generic UIO platform device driver provide UIO
> +support to userspace.
> +
> +FPGA_DFL_UIO_PDEV should be selected to enable this feature.
> +
> +The DFL UIO driver has a special matching algorithem. It will match any DFL
> +device which could not be handled by other DFL drivers. In this way, it will
> +not impact the functionality of the features which are already supported by the
> +system.
> +
> +
>  Open discussion
>  ===============
>  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration

