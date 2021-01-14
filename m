Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB68B2F5E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbhANKTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbhANKTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:19:18 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF76CC061573
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:18:38 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id y23so4175754wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wAakycYNxuMPN23IKoXKPSyjLn9l0yXbUCSaMXXlXH8=;
        b=GMPtv8skSXgzRDCoRuInWuGdMqV+UPPY0wEf8gnSyYEljbZ5qWLYn8vTdYQ3mb1nCT
         HMS3IX6soc8CakvdkKwhR+XCRwNATh0mWPw5Lz1ij4mMh0DHmYZzyxUd1/vIHXKrgVBJ
         jGkdxJmhElgHJnT9fSK0Xdte1IVPTt3S7XeQajO5/LW7hkco4oyv72ewdqrRLxT0Ki7e
         XRYfn5AU6+51kBnKpMQteNm0yZhVAalx2gAnDc4gM8kQO6MU/UKJeD9xo8DGCsemFAaz
         zNzCfSffBLqEVx1I/t/PwuMBkvTlLYX80sn3Nc0v8Km6AYFz3AqgVE48giNi9GlKrYD1
         UwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wAakycYNxuMPN23IKoXKPSyjLn9l0yXbUCSaMXXlXH8=;
        b=nACTvIZ2Eh2f4zFKsZJEF8KjL5BS6oFPDkfHmaMukocWg4vUql/FPyq6Z6tVzktD76
         uQjQW82Nk+wg3LABBVdvG9OFHUnkBae5TLbuUrvEt35KqMXm+5t+i0j1GK5sq2KEVLzM
         ZoCqXeNvXMglMEaBz7qrCaSHGOT71ezOmwNpXzxIVvk0bniW9rc2QbQDHFOKruvmK8Ol
         tRcL2p5EZZpkXYi7qP+YOJahSD8jIiN1q4zctK0Z3YD7FZTFEn7YvyW+uABaVD2Om5+4
         wQxKLU5xUEjqfCW8qevFqYTjLXqOYpvN/kSvdMbY5BI3cxAi94hsjFrKwbgQM8jhLUGm
         ONlg==
X-Gm-Message-State: AOAM532U4TZpZqgLaZ3hy8uqKadGDUBnuSB5FwiwOYQ5XYAeczO314XE
        U17QCH5F+wjuxcrKqnHtPVysjlcLB2ZVQYpt
X-Google-Smtp-Source: ABdhPJxU5HZR9X63Y6/Sjxx5lEFN6NfgX5JTruN5gARfYJpnwsYacPuiwaz8N0Ufi4VzhWv6Po4q4w==
X-Received: by 2002:a7b:cd91:: with SMTP id y17mr3086707wmj.171.1610619517433;
        Thu, 14 Jan 2021 02:18:37 -0800 (PST)
Received: from dell ([91.110.221.178])
        by smtp.gmail.com with ESMTPSA id s19sm6622123wrf.72.2021.01.14.02.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 02:18:36 -0800 (PST)
Date:   Thu, 14 Jan 2021 10:18:35 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mfd: iqs62x: Remove superfluous whitespace above
 fallthroughs
Message-ID: <20210114101835.GN3975472@dell>
References: <1609707369-11297-1-git-send-email-jeff@labundy.com>
 <1609707369-11297-2-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1609707369-11297-2-git-send-email-jeff@labundy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Jan 2021, Jeff LaBundy wrote:

> Previously, all instances of the /* fall through */ comment were
> preceded by a newline to improve readability.
> 
> Now that /* fall through */ comments have been replaced with the
> fallthrough pseudo-keyword, the leftover whitespace looks out of
> place and can simply be removed.
> 
> Fixes: df561f6688fe ("treewide: Use fallthrough pseudo-keyword")
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
>  drivers/mfd/iqs62x.c | 3 ---
>  1 file changed, 3 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
