Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1242627A601
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 05:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgI1Ds6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 23:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgI1Ds6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 23:48:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D8EC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 20:48:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k13so8127871pfg.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 20:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZV6EaZka+YS38XpEGu1E1E1iX6vM8ZuAlooQUItDZRo=;
        b=HBHUhXR7ZqoG2yX3ZC7TJhyejEavXYSPVxrPnZuRY80LuKNI2PY9obUsgEwi2Q1ovk
         Y7C/NWUnVraBe58M+MdOEAwoK8jYUBfBqSZJQQxIYFduUnTcou/ArToAruPTnC8DGy25
         0Uf90AC4JMtwPeevzzW108wYgG1mNvuwaHIab0O7xB/eo301XCLNrjHcp03GiVCQD4Gn
         64rh6R+v1s3e9JIrwc+l8ggNy/5IxaiKNxlHIhVxBIfEj3pjN84C7xD/BhPOtaRZ4fbe
         GzqRZEEHMqID2/SMolQi4sY64yfw5IblpVUjVNlRTYFABhPx7aZTDkut9m6dO5B7W2IW
         lfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZV6EaZka+YS38XpEGu1E1E1iX6vM8ZuAlooQUItDZRo=;
        b=X0wy+lipv8aM2jyVSKMpjMfMWmwTOnBOnHXsmzl5sZbBQ9+/8nAjSW6nkB4cTzheAu
         U5BdLe5w9eWaD/0pANMkAzsLh+T7HwPg96nCkPPvrhzZ3ByERtlYmx1ZD0+2aTXbEjtZ
         sRjthRN2yFKGKOsvd0btW7o4EPTJaML+/pF/DE5Hb9cjl1/Pm0yOLv8tivQCaNxwCNO9
         R0jSJGvBvP2ZUD5hOt5Ey6rBQE6y5aah098nVUse02G59SqFBTIpkDlh97dxGjDQe5cM
         l/yY3VwbO156u9VwNv6KGH1Em3PYAkhDSpuL59jkz3tAFQjLJhcMV7dYV5f8lRZRIjBl
         5mrQ==
X-Gm-Message-State: AOAM531MejISKxkxcSSj6sce6HnFlecHpHdaRbkOgTEQ5lSYC72gOgfK
        LlUZBEOBkW8YxzrqhpgMOe3g
X-Google-Smtp-Source: ABdhPJxr04SzUUBxi2QhB/l2mv24dNYBRg9YDRrGEkfxaPtcWX1bXsbxuYYxZ4T49N9w/YyraZvkpg==
X-Received: by 2002:a17:902:8b81:b029:d2:42a6:ba2 with SMTP id ay1-20020a1709028b81b02900d242a60ba2mr9281844plb.24.1601264937888;
        Sun, 27 Sep 2020 20:48:57 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6003:40df:7c40:5a87:eb86:87b0])
        by smtp.gmail.com with ESMTPSA id w192sm9597176pfd.156.2020.09.27.20.48.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Sep 2020 20:48:57 -0700 (PDT)
Date:   Mon, 28 Sep 2020 09:18:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] bus: mhi: core: Move MHI_MAX_MTU to external header
 file
Message-ID: <20200928034852.GD3605@Mani-XPS-13-9360>
References: <20200927033652.11789-1-manivannan.sadhasivam@linaro.org>
 <20200927033652.11789-6-manivannan.sadhasivam@linaro.org>
 <20200927101734.GA85724@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927101734.GA85724@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 12:17:34PM +0200, Greg KH wrote:
> On Sun, Sep 27, 2020 at 09:06:52AM +0530, Manivannan Sadhasivam wrote:
> > From: Hemant Kumar <hemantk@codeaurora.org>
> > 
> > Currently this macro is defined in internal MHI header as
> > a TRE length mask. Moving it to external header allows MHI
> > client drivers to set this upper bound for the transmit
> > buffer size.
> > 
> > Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/bus/mhi/core/internal.h | 1 -
> >  include/linux/mhi.h             | 3 +++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> If no one is using this change, then please don't make it until someone
> needs it.
> 
> So submit it when you have a user please.
> 

Okay, will drop it.

Thanks,
Mani

> thanks,
> 
> greg k-h
