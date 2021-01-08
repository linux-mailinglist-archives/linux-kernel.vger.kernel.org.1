Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E47E2EF3D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 15:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbhAHOV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 09:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbhAHOV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 09:21:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7333CC0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 06:20:46 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y17so9156227wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 06:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=D55vHgGqjN7EQYtgxDZVb7zOdCKWN0/YBCv3BZrkd+g=;
        b=DTAy8mSzjx6zd8aZdBqYN0ryA5xq/t7FQYSI7E4P0+PQcw2tirQgJsbg0+FawEGThV
         iYMQzXpitQgbrVYCirOntjKSFHkUJv4lAPgG+iZn36ghQeqQvrHHhOUJFKJqAr0TCXpT
         FTWMhDeIlNNP2bmVOvJSCyRENHa0Ot0UVAiWGA8E78LOiburbIw+X9v+nn1kaa5wHv7I
         EH91TWBP06fzOQmY5Trp8AMZ+3b8qs1SZo8Pb3pVedWYfiGofeEB8IJGw3ypM+R40MwL
         ArTi/nP51p3MQx4FlmJqvZS8GcXv2Vb2OMfDpysel+A6FEKlTjcS/qS1+4CEEXnGYr3s
         1UCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=D55vHgGqjN7EQYtgxDZVb7zOdCKWN0/YBCv3BZrkd+g=;
        b=VFkfev5ruwd85bQ1Ywy5gRGHu9FwxG3PiYN3mOVByxHysS8CJD5XjuJXamK/2iLXl7
         YWaSNjiZwM5nBITJmMmEktdCshx9WaaPe2cE6nxnJFFetEOdS18WPdGWSsI8f6jjywGw
         YnIK5S5SvLSRDNT8gUozXLZmKzp9tePWKyo+fPEOcVMOYxHCCTrcdfuL/GC0feZF8oKu
         +9Fcssksetw8wnPGOGhO3m6I6HcNTBYTlVnUZz4djmiZqIHwNIQt/FlXvA2jHkvAYmsx
         fG4eSf7TtWpWV3nvro2f5Erm+D8VS7vH67l0lC+A46kgBXBC0KXXbgDaBald5hHJfrSv
         8tYw==
X-Gm-Message-State: AOAM533UmpvEyKS995afvLAVf2KHbB+w0ARPFk0ho+9nD3/ZgNOn82WP
        UToUwDBjapKJ2+WNTmORGUKjBl1Wt0JrrMAj
X-Google-Smtp-Source: ABdhPJznbNn6QkzEeZCqzzzLhGkmwCv28JyCQ5JMAJE49g+AtiL5HrPK1IQggUqJf7cwU30sU+WuYA==
X-Received: by 2002:adf:ee10:: with SMTP id y16mr3962148wrn.296.1610115645077;
        Fri, 08 Jan 2021 06:20:45 -0800 (PST)
Received: from dell ([91.110.221.156])
        by smtp.gmail.com with ESMTPSA id u9sm12585159wmb.32.2021.01.08.06.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 06:20:44 -0800 (PST)
Date:   Fri, 8 Jan 2021 14:20:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] mfd: convert comma to semicolon
Message-ID: <20210108142042.GF1592923@dell>
References: <20210108092058.18576-1-zhengyongjun3@huawei.com>
 <20210108105355.GE1592923@dell>
 <ec135fa05918f7a2e34e5b6364c691ce0d3d8287.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec135fa05918f7a2e34e5b6364c691ce0d3d8287.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jan 2021, Joe Perches wrote:

> On Fri, 2021-01-08 at 10:53 +0000, Lee Jones wrote:
> > On Fri, 08 Jan 2021, Zheng Yongjun wrote:
> > 
> > You're still not using the correct subject format.
> > 
> > It should be:
> > 
> >  "mfd: <driver>: Description starting with an uppercase char"
> 
> IMO: overly pedantic

Duly noted.

This is something I usually fix-up myself.  However, since this is
something I already mentioned when reviewing the first iteration of
this patch (with proper feedback) and it seems to have been ignored,
I'm going to ask for a v3.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
