Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27AA2AD2A3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgKJJlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJJlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:41:15 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062B3C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 01:41:15 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so2347287wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 01:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FpGYJhDvWK5QFQyGVGzTwx199bOezzbp8yUQnaBAqhA=;
        b=z1FkXYMrjZ61/g5+TiA3+uQbcP0BwaGKojKYZqoprO1EpyKXxFED8yggOxudY+WSfn
         ofbwOQSsVmAN2CwuTFWmrdeb3XfsFBdxtI2yitO1vEMjZXuOh5FTAx4L9L+9TXE9xEh5
         ETeVhj9TKHMBlglBmUgRq/G1hBrvINoTsfF36vnDxXKP29niGmsVYrAa+6Igc2DCJtfM
         +JVDxu1jrfdlpXrOuive05LAgGh+2RxnKq6Atce+JA4hSUzCkyS+F2jOwHMMM0Ur6JI1
         811Goaf1fdH+uzMu4qeylrud5JCOQT5FRFyLYwgzP5d8ieCENuD1EeKIWtqc1J/U3YgU
         xxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FpGYJhDvWK5QFQyGVGzTwx199bOezzbp8yUQnaBAqhA=;
        b=C/nP2hQ9wLcEQVwcdlrSgEkgsykr4V4MfJJz1I4F1tCHva9bPMYfzP43tCnbRtFCqC
         ylJlXu64c5mJWCtqKOl3tnGt1oAfboAY26/rcx3e9hJm2rAj9Jqs914CrpGAPdcnV4cR
         B1yUR+jX55kBS/rjmOy6AGjP/4Y4c5mst74iL/H5/wgVDhG/7vHCIFiESqAR7dyM5WGI
         Sh1hJ0+/2Y0w/AvQfcr3UG3vTywljoDlI42baX6GA3CsUALWegezo5e4mxO7FKnpPVnx
         FzvmrNjoW+8LSsnLl4fxXZoYBo0+dDcmbs6fuThhg4y+3e0/TL17OHhv3QZ6voKuc53O
         Nu7A==
X-Gm-Message-State: AOAM531/HTOtu7lU0yit8UWckwZuYqUK9jTyPpYLvY6Kzn7PJuepx+10
        RoTAJRlJ6YRLv+qAKJbrOl56og==
X-Google-Smtp-Source: ABdhPJz9GPiQ64tc5Xh9sXsmgb4hk4Z94zN9LrviqA4mXIdYOneWhbgIHv0Sezdp554Cwip1SzZtHw==
X-Received: by 2002:a1c:df04:: with SMTP id w4mr3699025wmg.3.1605001273758;
        Tue, 10 Nov 2020 01:41:13 -0800 (PST)
Received: from dell ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id u203sm1408076wme.32.2020.11.10.01.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 01:41:13 -0800 (PST)
Date:   Tue, 10 Nov 2020 09:41:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 15/20] drm/radeon/r600d: Move 'rc600_*' prototypes into
 shared header
Message-ID: <20201110094111.GG2063125@dell>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
 <20201109211855.3340030-16-lee.jones@linaro.org>
 <CADnq5_NvitEQWH3Z+5EgOH3zJn=P5YTqwHQo4LLQLi0Hj0Dpww@mail.gmail.com>
 <20201110072242.GF2063125@dell>
 <20201110090247.GB2027451@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110090247.GB2027451@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020, Sam Ravnborg wrote:

> Hi Lee,
> 
> > > the *d.h headers are supposed to just be hardware definitions.  I'd
> > > prefer to keep driver stuff out of them.
> > 
> > That's fine (I did wonder if that were the case).
> > 
> > I need an answer from you and Sam whether I can create new headers.
> > 
> > For me, it is the right thing to do.
> 
> Please follow the advice of Alex for the radeon driver.

Great.  Thanks for resolving this Sam.

Will fix all occurrences.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
