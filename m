Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAE629EE4C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgJ2ObZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgJ2ObZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:31:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB02C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:31:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w21so2474079pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U7FxLaozj1+g/d/80pm86gF5gLHoJ7+VkwwOa2exNoc=;
        b=PwK6pPqXgFw4G0Opvepb6OQ6jf1kn/X6eRVgCgtOJVW5tMMRLm0huiL+NDq6hplNcb
         6pk6nkcxJbEC85pzwm5v1+nmH9rPFzmtJbx4Mt5ag8hFr7Z0oWehmc8W41Afq/oAVgSX
         lEEedXrZBKoxQX86OMo+csnBKQ9nTK9G8MoPBsOUHlMxsydirZGFiazqXYI3+Icw5a5T
         qAEzDaYnfOieEFx2H2i5tUOXsBev3t83Vk3Y5IZF8Uuf0xrLZpY9tAL+al3cUrHu7cQp
         de9cEBgZMDZUQNkszoUVphEFmGAUFEEHZrXlOfmHQEefVHRdqUhI2sJBhZcYJALcOTRQ
         rfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U7FxLaozj1+g/d/80pm86gF5gLHoJ7+VkwwOa2exNoc=;
        b=gRuwnnpV1lxdIrWoFng5m163RwJr0rxQBiqh0wm6P/VyRkpNvZnD4W39oTc4Zywjnx
         rVJSn/x5qJoYoWhsTH1MPGPE63izQwFmabSaezP1sCnKKQ9NWzmXb6gUw9TAubyz2NJc
         2JQCDFTSlYj3gs5DAE0UPJWX4rMZPwt5vcMaAVcmwNgEF9UUGHDyVEEAp+Y0eTB2Eb2C
         /fE7sH5u845g2JF2LWQKZE/1Oor9iercF17FjyA4pUVK4JqXfNemFK+RxaSyFPxsxmA1
         7u+dtKFEr8ksA2oeotrVUAfuHsrS19KmsTwv4CK5tC6P20qmg22W4TRz7bZRvJWFz9O7
         2V+w==
X-Gm-Message-State: AOAM531ab2g7WtcEgeM3cLVZ8cMDgFpM7fAGq0zE1z6GB6JDByTaUgTi
        zwMXkNBHPaAH2XnDDpv9AFQ=
X-Google-Smtp-Source: ABdhPJxwkJ0sN3WlY/M8dxmKbJXtNWK3hC28OJtFuVlwDxvl83EWCLdKLUOOBu/hpzahRgEl3ZJZQg==
X-Received: by 2002:a17:90a:e2d2:: with SMTP id fr18mr93332pjb.98.1603981883303;
        Thu, 29 Oct 2020 07:31:23 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id j5sm10854pjb.56.2020.10.29.07.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 07:31:22 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Thu, 29 Oct 2020 22:29:11 +0800
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] mfd: intel_soc_pmic: remove unnecessary
 CONFIG_PM_SLEEP
Message-ID: <20201029142911.p54mbwbfaeymrqy5@Rk>
References: <20201029100647.233361-1-coiby.xu@gmail.com>
 <20201029100647.233361-3-coiby.xu@gmail.com>
 <20201029110029.GF4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201029110029.GF4077@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 01:00:29PM +0200, Andy Shevchenko wrote:
>On Thu, Oct 29, 2020 at 06:06:41PM +0800, Coiby Xu wrote:
>> SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.
>
>Have you compiled this with
>	% make W=1 ...
>?
>

Sorry my bad. I thought I had run "make modules" with CONFIG_PM_SLEEP
disabled. I'll run "make W=1 M=..." for each driver after adding
__maybe_unused in v2.

>
>--
>With Best Regards,
>Andy Shevchenko
>
>

--
Best regards,
Coiby
