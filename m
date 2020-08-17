Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC26246349
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 11:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgHQJ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 05:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgHQJ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:26:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E03C06138A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:26:15 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r4so14200860wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4d1D1gqia1ws+AzPV3FMNytu1AxmR9roXL6Qk8hRD3s=;
        b=LAp1F+GRvX1jB4JkTE/71H9RJ0wG+s7VzyUoMlWwX1LLX0gj7UFh5z7SzfIWBl/LGI
         jqf3Pub1lyYlt7kvHM5pumrpBktFasnfDM6Ilu38oFaYfuOiQxk9kJnOGSPedj9VjSTc
         lLcaSoDD6ReWv/IkCDFMx77wG7H/guxsnHWq8Ww4RUJqmfy1OoJI6aS37Pff5T8HzMoW
         3Eox0HoGDWDaEzIiDeYaQnj5F5vIHD8NQYjcPPbK5dR+hqNXCoEB/rrG5y9dcqWIIelx
         QrjQ12Xl8YnGuAG1vTiEnWntgDxeZGMxTLB9SrAHceCpI6zMRgdJ+YweA2NDpMAezz9C
         oVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4d1D1gqia1ws+AzPV3FMNytu1AxmR9roXL6Qk8hRD3s=;
        b=WZUs4mM9EqeY96YoEcndlsFYOyU/5ctmm5uaUKJXUWjtKs+5Gi7xgZRx2PG+d2/4cz
         aoBT7KIFmn2HHZjhM5JeJ/NM7sT7f1G3/xKQEPzRzbTJIy6sMPJfa0tx/a15esrwzqlg
         jdxltrOyruiuygENDyd2wJbbifJwsztEE1jHHxyDAabqMj+er4YpnrNYawKrxwoGjso0
         1RyVdn0UxghhTyRzV6LhFxs8n+L8cuiO5mgq8L+blcd1zfg3CsZsMOxIJHrJu/iBYGjD
         PtD5+EYLRKEb3W1MjdiGiZxIFQdIwvlKuP9nWBJSP3pSFfx27V6lpykQd78TFJIdIhLb
         L+Pw==
X-Gm-Message-State: AOAM532OvZ5leWiI8/eQh9CK8Krrg31/v/f084KoIs++Xc1IhKmCXY6R
        NBDhRAj8OPIrIdIksdFHdJKpWQ==
X-Google-Smtp-Source: ABdhPJwyVadZr5eKwZa1k/L/GnpLw+oTPe0epTUW/dq8958EwyZvVYN49aHw/C5ZVuJBrB+BKf1jMg==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr15604654wrp.198.1597656373907;
        Mon, 17 Aug 2020 02:26:13 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 31sm30614869wrj.94.2020.08.17.02.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:26:13 -0700 (PDT)
Date:   Mon, 17 Aug 2020 10:26:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     David Miller <davem@davemloft.net>
Cc:     kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/30] Rid W=1 warnings in Networking
Message-ID: <20200817092611.GW4354@dell>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
 <20200814.204242.2048284550886688191.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200814.204242.2048284550886688191.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020, David Miller wrote:

> From: Lee Jones <lee.jones@linaro.org>
> Date: Fri, 14 Aug 2020 12:39:03 +0100
> 
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > There are quite a few W=1 warnings in the Networking code.  My
> > plan is to work through all of them over the next few weeks.
> > Hopefully it won't be too long before drivers/net builds clean
> > with W=1 enabled.
> 
> I applied the non-wireless changes here to my tree.

Thanks Dave, that's great.

Are there any more sub-groups that I need to be aware of, besides
wireless?  Or can everything else be grouped together?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
