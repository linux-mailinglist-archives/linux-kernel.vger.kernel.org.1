Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097E128628B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgJGPra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJGPra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:47:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488BDC061755;
        Wed,  7 Oct 2020 08:47:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n15so2774803wrq.2;
        Wed, 07 Oct 2020 08:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/hMNzHJ7FYxd5Mn8H/MY5sEnMVgbQcegdjJ/0LXwsY=;
        b=jX2PvHrR4/IsRYLr2iXIm4vpfn3I9JtVqholXT4GEH6A6pL6J0y8FmQlJmD5qxdhtY
         QZ0X3WnpBPC31ZA1ghT59lmR12kAWXJlzf4A6Ofy+E/O3wiWmEPeGjSbYWeK2HRofv4v
         JbnOTqjIlNQDiCP6oDiaKY9ojaeiShyJJ5+qJdubU/VUSkA7szDNQpLaxlBfQ5qfaJUM
         u7W8G2tRCaofr/ud1tmOXU/u4RfVHXG5vVb+oWR5dGil+QQdr8p3pem9VVgSnfokz94x
         /tOzkgHZ4ig00/Cs2gr/hiHKcweqewgAgsFYIOz353DfU1D3YSF1cZreF4HxJ82dtOaF
         RlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/hMNzHJ7FYxd5Mn8H/MY5sEnMVgbQcegdjJ/0LXwsY=;
        b=dSlrvboIpmPAZ82s9+hUyc+IpdImcleGG/KE4L2oEyZehX0bRHZWh++trF5d4vmIIt
         NMMgtTeQk0JUrI+l+Il3+Xd+e3ljloBsFsGR68RXTtKsUeJ9uE9+NkUZT6LW5xPQsHiH
         hxGjI684/nMYeBUMXRnb+ohiCKhbhogquJWBrHLFPrrkMnwii0o+uG2fMhdFXxvSq/aN
         Mt1QhxKZLyt8VmJm7HWracan1O61e5UDNgiCl/dHf4MRBlOGZwGs/4IbWPOOXXNj8jus
         KU6i127UNnV6pBBNhulj9C/E1mJqr9W2iOxz02cUqH1NXIfayKPqUvXOHivzVSa8Ag/y
         AxFA==
X-Gm-Message-State: AOAM531NZpGyhn4Kbqb99EM/z23/FIwiUzoeliht/+BAKMS732ZhozQG
        bmt84YIY0lLrpcVXNhl83vDOZL4LA1AgkZSRKKhT2CgNopRtHIvi
X-Google-Smtp-Source: ABdhPJwZLTyHbRyjHtOMfSy4/CMXdndzDV3XsGNHbEr0CXpTQYj6NXUCgBDIWWIr3c527n9uqxTuVhP/9MBb0I1VIi4=
X-Received: by 2002:a5d:548f:: with SMTP id h15mr4334852wrv.108.1602085648859;
 Wed, 07 Oct 2020 08:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201007035108.31078-1-david.e.box@linux.intel.com> <20201007035108.31078-3-david.e.box@linux.intel.com>
In-Reply-To: <20201007035108.31078-3-david.e.box@linux.intel.com>
From:   Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date:   Wed, 7 Oct 2020 11:47:02 -0400
Message-ID: <CAE2upjSbSw1cbR3oThQ-Tc4nR6-bbDvtUU28rkE9iD3vWsY9Jg@mail.gmail.com>
Subject: Re: [PATCH 2/4] platform/x86: intel_pmc_core: Add Intel RocketLake
 (RKL) support
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     david.e.box@intel.com, dvhart@infradead.org, andy@infradead.org,
        gayatri.kammela@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Rui Zhang <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 11:51 PM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> From: Gayatri Kammela <gayatri.kammela@intel.com>
>
> Add RocketLake to the list of the platforms that intel_pmc_core driver
> supports for pmc_core device. RocketLake reuses all the TigerLake PCH IPs.

Just a nit here - I guess the convention was to leave a space in IP
names such as "Tiger Lake", "Rocket Lake" like it's done in previous
patches too. I am not sure whether it's a new convention but it's good
to be consistent throughout the series.

Other than that, the series is:
Reviewed-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>

>
>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: David E. Box <david.e.box@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Rui Zhang <rui.zhang@intel.com>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index d959fa698ec5..f0347ee8a4d6 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -1155,6 +1155,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>         X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,           &tgl_reg_map),
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,        &tgl_reg_map),
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,      &icl_reg_map),
> +       X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,          &tgl_reg_map),
>         {}
>  };
>
> --
> 2.20.1
>


-- 
Thanks,
Rajneesh
