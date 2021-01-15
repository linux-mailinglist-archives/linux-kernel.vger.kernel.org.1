Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25892F73C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 08:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbhAOHjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 02:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731639AbhAOHjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:39:01 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD54C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:38:21 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q18so8248437wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SKYcZbYG9eptuZ1pIfoqc9cfYPZ8PZ7RbNuqsEwrHDo=;
        b=vyT3RGfUvKHNaM3pOCPLG987rdXnQLDYaLilZfBdfZLtxmi+pWh1lSEqB6opqKUTbH
         ltLB8F4BdCjvhh5I/I6EGE6Ns/h09gbMuaI4leGkwcf0utIko32gjfNuYEmiuwkfmFol
         sksVIhCp8onMxb8FANJnsa6rcQO7OnGwJKRPfZX5uUPDZMAbil4Q/aIk4Oym682byM5Q
         Bd929ofdJBciH8DnwHeAX8CTDfQD/0qyWE2kNRnn/1qcQhmdrq06j+qQ2d9eQQC+jmqF
         GpbPggJLuu40wu5zh6V44/yB1ubCQFXP7pELfl4mNb/U+LPAbYaeNeoFYWi7LMOc13yT
         4+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SKYcZbYG9eptuZ1pIfoqc9cfYPZ8PZ7RbNuqsEwrHDo=;
        b=KnrD3L6th+RnbVCheV29Acj3kTIiuMby4EWrQpcMsUJx0IDhxj3hy7Nma+DD0V+7eP
         I9zuGm8LoNv+UvjY5wqiAU0g1ZjfUxawUl2EqWtEtxNeyj866LXzgQN0tOPzxpCMlp9A
         596IBUkxxgjr542xBqFFM7eTx5TQZWBFp2iCtcofK70iZ4svF0e83CF4jaFe+gCK5A2A
         p6kUkl+V9v/a0H6l+wIgcGvdy5vLvVDOwV7NJLE+rZ3K2hY/baSotWjupgrZWmDuFNX1
         sejwFWd5dUG/ytrDqLtj0rnU+s8WueE6ogbJTyDuWyhZRwoMw37CtRQTbFjvIOIWTANG
         4dVg==
X-Gm-Message-State: AOAM533JJUVSY1fn/8faYSux9FqmvIzXHHv8XVtGhJ/bWdJtRVSi9KH6
        s1l8t4mD/pXUg0R5Egpcr66pRg==
X-Google-Smtp-Source: ABdhPJzIje5Wvd3kFdL+JWcBRK239NLWBZ09K29D0+SNDyMVcMQL93fIPddwlCLSNUPjILYhGJlXsQ==
X-Received: by 2002:a05:6000:1884:: with SMTP id a4mr11794375wri.42.1610696299950;
        Thu, 14 Jan 2021 23:38:19 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id o14sm11669939wmc.28.2021.01.14.23.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 23:38:18 -0800 (PST)
Date:   Fri, 15 Jan 2021 07:38:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v4 1/1] mfd: intel-m10-bmc: expose mac address and count
Message-ID: <20210115073817.GD3975472@dell>
References: <20210114231648.199685-1-russell.h.weight@intel.com>
 <20210114231648.199685-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114231648.199685-2-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021, Russ Weight wrote:

> Create two sysfs entries for exposing the MAC address
> and count from the MAX10 BMC register space. The MAC
> address is the first in a sequential block of MAC addresses
> reserved for the FPGA card. The MAC count is the number
> of MAC addresses in the reserved block.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v4:
>   - Changed local variables macaddr1 and macaddr2 to macaddr_low
>     and macaddr_high
>   - Change macros M10BMC_MACADDR1 and M10BMC_MACADDR2 to
>     M10BMC_MAC_LOW and M10BMC_MAC_HIGH
> v3:
>   - Updated Date and KernelVersion in ABI documentation
> v2:
>   - Updated the documentation for the mac_address and mac_count
>     sysfs nodes to clarify their usage.
>   - Changed sysfs _show() functions to use sysfs_emit() instead
>     of sprintf.
> ---
>  .../ABI/testing/sysfs-driver-intel-m10-bmc    | 21 +++++++++
>  drivers/mfd/intel-m10-bmc.c                   | 43 +++++++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h             |  9 ++++
>  3 files changed, 73 insertions(+)

Changed the subject line to start with an uppercase char and used more
width in the commit message and applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
