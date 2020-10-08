Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924C7286F50
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgJHHYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 03:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgJHHYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:24:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93FBC061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 00:24:01 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z22so6085743wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 00:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=51bhbv7Q6y4/rGYHYq4fR0iaqpAhvfl/QOeD7oDUgoY=;
        b=Sz4LrZs5sa3octu3Z1A9s+T5d/i+MGIkvGmGM1rxCnwKGbOcznbtt/HDXrMEVDfsqa
         RslLmR8ukkTsWqHOlEReH3W5wtfyxJSAYdd7uz3y0RiR+T++OVv071N3AFA/xB26+qZN
         EnSTjmvZ6TACHOBMcXRD8raf3tsJdzVrp0KYJPpFrs/8w+KAG8MwsxkkU53RUk6WzSic
         wtbU9z8F3TuhPjMwzBE9YtYf46BUWPZQw4mQX+Rk9uns/YLCYagsHREzg6PLUWxizgMg
         SDfv+tlw8RTTJ3JkFuZ5aUE5ldEyM/XHr8r185QBx+pH6wb7tMC9vs57UHu8q9zsFHTN
         OIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=51bhbv7Q6y4/rGYHYq4fR0iaqpAhvfl/QOeD7oDUgoY=;
        b=L1RKCEmOPKYbIbA+D+LmY0wFmXBFoi3zfPHtCEIr05DmpnbvX7zwccyAuBONBeoXR+
         sTLgd5hpaozfxKAYITw1qpNiyc3WomCK5oQvdZMnCWfup7D8jX5klvJ9rHOuGTwE3R+m
         JhouZdC8YhMpLHRyDoi560y6jg8Ez93HxKl0W1qjEiCovBrMXrpRdM4XoOh1zXBbNmAE
         1dYIP2CrIWzTJNCqSnkH10f7f3MUJTC+Juc5MPtw0u/c+B9UZY4KqowZq8DE8U7e+77I
         Lb7ZGBwPUu50QQUSweKMiAaEDOEO3C3EGRyZAwW8F/ifjtmgvMs2pES5L5BuEJQBlBST
         sWMw==
X-Gm-Message-State: AOAM533MpFUgjwHuUbQgcGyZJCvTxDduYxLfsih6Qae8G43iEGVZWRUw
        6TUVWoqCV9P6jAA9OzQfZSruuw==
X-Google-Smtp-Source: ABdhPJx2zS+4ltiDHMYeaoKp07Jhp4uEQ4HL8oiyNbsAbmYlk1jLvA611SMEj/Hfn3iMJn7GnhL40w==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr6817704wmc.184.1602141840369;
        Thu, 08 Oct 2020 00:24:00 -0700 (PDT)
Received: from dell ([91.110.221.232])
        by smtp.gmail.com with ESMTPSA id o6sm5984050wrm.69.2020.10.08.00.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:23:59 -0700 (PDT)
Date:   Thu, 8 Oct 2020 08:23:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v2 1/6] mfd: intel-m10-bmc: support for MAX10 BMC
 Security Engine
Message-ID: <20201008072357.GD1763265@dell>
References: <20201003012412.16831-1-russell.h.weight@intel.com>
 <20201003012412.16831-2-russell.h.weight@intel.com>
 <20201007070059.GB1763265@dell>
 <c50c30b7-0693-3ff1-8d79-5d311d3831bd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c50c30b7-0693-3ff1-8d79-5d311d3831bd@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Oct 2020, Russ Weight wrote:
> On 10/7/20 12:00 AM, Lee Jones wrote:
> > On Fri, 02 Oct 2020, Russ Weight wrote:
> >
> >> Add macros and definitions required by the MAX10 BMC
> >> Security Engine driver.
> >>
> >> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> >> ---
> >> v2:
> >>   - These functions and macros were previously distributed among
> >>     the patches that needed them. They are now grouped together
> >>     in a single patch containing changes to the Intel MAX10 BMC
> >>     driver.
> >>   - Added DRBL_ prefix to some definitions
> >>   - Some address definitions were moved here from the .c files that
> >>     use them.
> >> ---
> >>  include/linux/mfd/intel-m10-bmc.h | 134 ++++++++++++++++++++++++++++++
> >>  1 file changed, 134 insertions(+)
> >>
> >> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> >> index c8ef2f1654a4..880f907302eb 100644
> >> --- a/include/linux/mfd/intel-m10-bmc.h
> >> +++ b/include/linux/mfd/intel-m10-bmc.h
> >> @@ -13,6 +13,9 @@
> >>   * m10bmc_raw_read - read m10bmc register per addr
> >> + * m10bmc_raw_bulk_read - bulk read max10 registers per addr
> >> + * m10bmc_raw_bulk_write - bulk write max10 registers per addr
> >> + * m10bmc_raw_update_bits - update max10 register per addr
> >>   * m10bmc_sys_read - read m10bmc system register per offset
> >> + * m10bmc_sys_update_bits - update max10 system register per offset
> >>   */
> > FWIW, I *hate* abstraction for the sake of abstraction.
> >
> > Please just use the Regmap API in-place instead.
> >
> I was following the discussion on the Max10 BMC driver to determine which way to go:
> 
> https://marc.info/?l=linux-kernel&m=159964043207829&w=2
> 
> My understanding was that the existing function wrappers were accepted because:
> 
> (1) The functions are adding dev_err() calls that would have to be replicated
> for each call if we don't create a new function.
> (2) The _sys_ macros are adding a base address offset, which facilitates
> sharing code between multiple devices (although only the n3000 is supported with
> the current patches).
> 
> Would you prefer that we handle these on a case by case basis? And only provide
> wrappers for the ones that have high usage?

Yes please.  As I said in the link above, avoid them it at all
possible.  If you and every other user needs to place an error message
after every single call, consider moving the error message into the
API itself.

There are 10's if not 100's of different API calls where users
normally place error messages following them.  To abstract them all
for each platform would be insane.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
