Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4002A62B7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgKDK4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDK4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:56:32 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5F5C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 02:56:32 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id e2so1897205wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 02:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fyzPxnR8UJxjcgOllC6ebNxLgTMTivxZcNwre4SyrY8=;
        b=z7ijaovAKJicIJbI4Osgwe978sehwIGpR3O1F+n4tB77KYAkMo3Bn/C2ewjYD4jYoV
         ka8tzN4u9U8de7ZUXTCHxf+mP+UK5/6lAcyTTa3+TDdZYulJ3HQkJZHcIxsNkgjL3ykP
         +BfV8zQv/uQlDfF8PXR6Xp4spkLj2sbbJN3Njxb4s1e5oKotp7tqq7n4+6MpzBDExrlj
         GGkrzt6rj7wtuv0TzCbLlD5VSOz7qFPK3cq7IE0VqIgE9rc7+1h7PvGuGWr17dAnDaeB
         mbtKqljeHm5J6Wj0KVFBJlwMRBES/y34jG3AwyhfI0DcW0RrMfNxjUENHXsNxklWwzCy
         GDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fyzPxnR8UJxjcgOllC6ebNxLgTMTivxZcNwre4SyrY8=;
        b=uaiZrXqGos1MwT48tAxBgX6Lye1VwJZ72okO8fN0bD1JS8X1BK+oIcSXwAD3abCxbd
         PZKNVKyiQbw/33RRI/d5tiHGG7mEzc+8ben6J3H7B9bSaDYDLt0BOtsLgqyOSr3kHrRy
         /R+/TnIfmOY2GvAmbnMQIcrfOrwXEkjGAcrX0a2GRHHQXsH5tm9uYki4SN9ssenSfyAm
         vavEY64I9GXaySQEWNASy9S9yb9Qki+J7BBPuenRf8JoQV8gX+crkbgXW9m8OIeMFytD
         nD0k8XF4Lb2CNx9Issrje6l5LSn5jtctQvzSezMJ3W8Box7Dh4Ci4gvflh8U/gUoUJbE
         UvDA==
X-Gm-Message-State: AOAM5314QoebjilUXIZ6V3Xj2zpqNOToFNYSZyVJzZvT/FZMvHnsrKOR
        ZT1Sz7/XjVYL2JdFi6DJXUoJ6w==
X-Google-Smtp-Source: ABdhPJwoKr3L7lv6ttO52ealboW4PApD1+EOLK5q7e23vqkqaJU1rfKDnWr8C/hJI3Ov4X70DI40og==
X-Received: by 2002:a05:600c:2949:: with SMTP id n9mr3799964wmd.29.1604487391141;
        Wed, 04 Nov 2020 02:56:31 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id d3sm1801103wre.91.2020.11.04.02.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 02:56:30 -0800 (PST)
Date:   Wed, 4 Nov 2020 10:56:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/8] mfd: intel: Constify static struct resource
Message-ID: <20201104105628.GT4488@dell>
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
 <20200922192659.14535-3-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922192659.14535-3-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020, Rikard Falkeborn wrote:

> Constify a number of static struct resource. The only usage of the
> structs are to assign their address to the resources field in the
> mfd_cell struct. This allows the compiler to put them in read-only
> memory. Done with the help of Coccinelle.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/mfd/intel_msic.c              | 18 +++++++++---------
>  drivers/mfd/intel_soc_pmic_bxtwc.c    | 14 +++++++-------
>  drivers/mfd/intel_soc_pmic_chtdc_ti.c | 10 +++++-----
>  drivers/mfd/intel_soc_pmic_chtwc.c    |  4 ++--
>  drivers/mfd/intel_soc_pmic_crc.c      | 10 +++++-----
>  5 files changed, 28 insertions(+), 28 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
