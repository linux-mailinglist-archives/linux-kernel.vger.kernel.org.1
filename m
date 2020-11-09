Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DB82AB1E0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 08:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgKIHrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 02:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgKIHrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:47:46 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E016C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 23:47:46 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id d9so9328273oib.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 23:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n13PinZTPhP6AdpzFjlFN14w77t83uFOC/qxFyrGcZw=;
        b=QjcRLv/QQoPd/OIoKU7yh0Cx+7J2BnZM25Y0imBCpOM596FC1y0akyMt6pVqC0+sYF
         ip5ifFDPgSOms/ItK7coaqDb1iVCqmVCWS1kJOVe80qjNRweDi8EyFMzdPWZJ2BrOIaT
         pI0HTLybv0yuWoK6RWo/acSn6LCyXC9tMVimckDYvLmftpE4dFf7EGoxBFcSq9/CciIW
         SWvk004eHjY4XMxt+EoFcnvE9xlA+WRoOoEVSXCdXoJmv4E6TdgKyidZPvmbty8dBkyR
         LPoX/qHkOjen452LcWdU3ECgmwQXGwnwaVvalUHI8YOKYpafkI43x5rOL+gDwiOxR8Of
         SKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n13PinZTPhP6AdpzFjlFN14w77t83uFOC/qxFyrGcZw=;
        b=nBKt7QkhMYuq5ctYwCIQ1LAU9/d+/PL9WdFFlug9B9F/6SCh4VgvW6cJAi4+hVtw+W
         lN1Lb0wT/bj9cVV+n5KjJ22waxCmnLg50skl3NTVn2LJB8YvMFjSRBWD/g2cYt/pupd6
         Y9mISwvNNWqTro/fGitnfJx8V2aOpO2MHKm4jhdLbRmsclfK4p3eA9/ZodhLhFZxit7l
         l6dp0w056PBkAIMNCZE0QkDmsf3Uav4JpQmlSozOBcB6/T7ahZ7N3Zm3oxrxoZUWyrK9
         vJwqnZSFVxMpSDFNDSymNQJN4zW2oiYXLK+Ds4WVNnN0jUXmajpKJqPz+4s2TplOhXrP
         YqKQ==
X-Gm-Message-State: AOAM532rwvq4IMmN/IbW1WAvy/ReRV92QZMOMGX8abHBzDFVO9p3ktDh
        7v5xtvwV6Ku6+GsCa9Uvi6sQvzTNMzc47e02rczsog==
X-Google-Smtp-Source: ABdhPJwHZA03m8Gi/fFh27mh0ThaPDr93lgpvXgEIojXbWf/Mbym3vOvlnrMhOvrPr74oCtLw9AdGo4sZYRik3MyA3g=
X-Received: by 2002:aca:d987:: with SMTP id q129mr8629267oig.5.1604908065604;
 Sun, 08 Nov 2020 23:47:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604470183.git.Rijo-john.Thomas@amd.com>
In-Reply-To: <cover.1604470183.git.Rijo-john.Thomas@amd.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 9 Nov 2020 08:47:34 +0100
Message-ID: <CAHUa44F4L+B=Kr_-hprhMRjgjfnQPRdzPsxq0WFABB6WPKqyog@mail.gmail.com>
Subject: Re: [PATCH 0/2] AMD-TEE driver bug fixes
To:     Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc:     Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rijo,

On Wed, Nov 4, 2020 at 7:26 AM Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>
> AMD-TEE driver keeps track of shared memory buffers and their
> corresponding buffer id's in a global linked list. These buffers are
> used to share data between x86 and AMD Secure Processor. This patchset
> fixes issues related to maintaining mapped buffers in a shared linked
> list.
>
> Rijo Thomas (2):
>   tee: amdtee: fix memory leak due to reset of global shm list
>   tee: amdtee: synchronize access to shm list
>
>  drivers/tee/amdtee/amdtee_private.h |  8 ++++----
>  drivers/tee/amdtee/core.c           | 26 +++++++++++++++++++-------
>  2 files changed, 23 insertions(+), 11 deletions(-)

This series looks good. I'll pick it up.

Thanks,
Jens
