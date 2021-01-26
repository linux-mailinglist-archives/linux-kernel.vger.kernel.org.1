Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACF1303B51
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392209AbhAZLRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387977AbhAZIRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:17:54 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28AEC061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:17:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id e15so1922959wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5buVyeTLTKpasz7tym5h0KIOcgupAiBfbyJMBDHnH9c=;
        b=bSp+AggNzSBm65rDhpFgg6Rk+1S8mcwjB0cua/2KbqO3vNdNoNMnTsONCaiyK5IJx+
         bSSfWcnb/B9Y65vqr6RtI01LVEl/KQSpymMlVlEZZ9T6Vl2l2QLeijiT/QVqBBAg64K2
         qHQsWisSKyCuLCEr7Cv3IbFCDLbnH9VhURhSpWoeopdXMpth09N/U3J2XRI0XJcnhVY9
         wM7qTfOQlFfjHN3F+OI2uCBIoc4S+a9aRiUIo1Lbh65U3Uhy7t+OecPqe2OIpgHF/ZrX
         KwvzCNUIeSeuPyS+5NSJkguwfs6yzBA/B9KnNvAnfRLLp2q25jIktadJjm/cwOJ/suhA
         PGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5buVyeTLTKpasz7tym5h0KIOcgupAiBfbyJMBDHnH9c=;
        b=keo69awBeJQNemq+EPZ2qf/zcz2GxhHUj34YGIINfZdzmh/sxWoT2D09f13870O5jB
         fyEqBO1BeoI0mchfOfg388o1XSEgGyVAC8ur8Znm/eMlCqB6ObnInYCGQJxn9CUESoA3
         x8/KW1FI4HjCFJ98PThpi6poWbmYLgxBUjzL67GKXv5dbcJnF3Fju/GPM2D7ieBQRzjl
         EyFqOkmmhmKl3ifQdlmcIvdECw721hVt7DhHuH5H2jxXu8ef0u+OksFPNMdGYUTd9qSR
         Wy3amnw237TItA9GHHqZgdwwlbbEO2SVVayNFGQqJMVXKFD+YDp2CXC9ZhbpWVPdkvM4
         O7iQ==
X-Gm-Message-State: AOAM533CL0KtM3Uubm9N3HW/YsD9NW2Cvcp1LO+WxvLT2l7rBpk0kefC
        GWqz6prlST73V8Xjkn0T4dF1MVWfdFs2VxKw
X-Google-Smtp-Source: ABdhPJyEYbplDoWTymaW1pVkK7DR7MNRUcccW8AYYYe7KxPusvCbkYlYuCwKI1E3dVODE4Y0saChKQ==
X-Received: by 2002:a1c:46c5:: with SMTP id t188mr3512053wma.170.1611649026537;
        Tue, 26 Jan 2021 00:17:06 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y6sm24718077wrp.6.2021.01.26.00.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 00:17:05 -0800 (PST)
Date:   Tue, 26 Jan 2021 08:17:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: max8997: Replace 8998 with 8997
Message-ID: <20210126081704.GC4903@dell>
References: <20210124170528.1230932-1-timon.baetz@protonmail.com>
 <20210125084347.GU4903@dell>
 <20210125205059.4773adfc.timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210125205059.4773adfc.timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021, Timon Baetz wrote:

> On Mon, 25 Jan 2021 08:43:47 +0000, Lee Jones wrote:
> > On Sun, 24 Jan 2021, Timon Baetz wrote:
> > 
> > > Replace occurrences of 8998 with 8997.  
> > 
> > Because ...
> 
> ... it is the max8997 header. Do you want me to extend the commit
> message?

Yes.

Please explain the intention of the patch and why it is required.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
