Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAC42B1639
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgKMHOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgKMHOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:14:22 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB36BC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 23:14:21 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p22so7178074wmg.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 23:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4QI6SfAI9N0lfol6VlALZrhipi1TT6Hr5ngbeo4Sa90=;
        b=BAQr+aKIlb/fjzdZ3GMdPzjaQqpaV4OjWLSMx5P6JSmQColWkhPrmHwlp4TdiIHTWW
         qXq2CVOv2nGbxrT2IXR7yRP30+Xru2MW+ispVKj3EF1ZKYz1Mx8sS482X/FM3RuKbiRK
         8Z2Q9Hz4SLWBEZyW5dDitfLSDarmJV6FXOQTH/rOPk/vDaLWH1x3sNggnKRip5ANd989
         Z8cfG8DQubAr5vcETDS3YPIQ8xOJW3+ePljND23FrTuVK81IUMlRk16MyDXFn3UhTek+
         x89vZSQrnqcFz98pkVGmN6Fl54hJprFBNJsbTVLNk5PmsqyDWuzM/Xm91Cpftb51sx1q
         jxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4QI6SfAI9N0lfol6VlALZrhipi1TT6Hr5ngbeo4Sa90=;
        b=CkkE6PmNHTvLxZrfqHyPVkokvhXNb+0xMZAkfZb147G7qy/YueXRCY6ZemUcPMU0EE
         8fSaqmId8ga4lpySKASZpImMlUfTgJ4R0grP6xAhvW09qv157hiD7f0nuooIk9ECNS8i
         gLjKmlV8KXnnja4/02uOwpdIDEI8LFqA7L4IIfx8hTUqCnAnt8fFvW83uGPmA+Nj1mqU
         YNJrcxWdzvSvqSRrLAhZFNkl+a8Mr2MErdoARWJYEyzCx14uZoAZNijqcPd7Doq3NDZP
         VR3XcP8NiIHzYFxmT1EibmH6eKRIG6Gb4GJeJra2GZxMIU3piRZKAoXaULJii4T7A1op
         JMMA==
X-Gm-Message-State: AOAM531zuRbi8hcqgSHXSd+IdsApAv/14ZUhzYFRkIXDWAepC0jTBmxI
        h6O/6oG46DGv8F0tB8B9iYjOhg==
X-Google-Smtp-Source: ABdhPJx/zlwXErDxPwnadj7ZFxWh6IsZ3JLfBdVKDwfuTSFznbkUW/tyVISjpue39TvsO5ZPIjddjw==
X-Received: by 2002:a05:600c:14d4:: with SMTP id i20mr1076002wmh.118.1605251660073;
        Thu, 12 Nov 2020 23:14:20 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 34sm9803212wrq.27.2020.11.12.23.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 23:14:19 -0800 (PST)
Date:   Fri, 13 Nov 2020 07:14:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Russell King <linux@armlinux.org.uk>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [Fonts]  9522750c66:  fio.read_iops 7.5% improvement
Message-ID: <20201113071417.GD2787115@dell>
References: <20201112140625.GA21612@xsang-OptiPlex-9020>
 <X64r4X/By+0BTc6a@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X64r4X/By+0BTc6a@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020, Greg Kroah-Hartman wrote:

> On Thu, Nov 12, 2020 at 10:06:25PM +0800, kernel test robot wrote:
> > 
> > Greeting,
> > 
> > FYI, we noticed a 7.5% improvement of fio.read_iops due to commit:
> > 
> > 
> > commit: 9522750c66c689b739e151fcdf895420dc81efc0 ("Fonts: Replace discarded const qualifier")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> I strongly doubt this :)

Ahh, I was going to put it on my CV (resume). ;)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
