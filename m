Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A1A2A2645
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgKBIkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgKBIj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:39:59 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC2C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 00:39:59 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id y12so13519986wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 00:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OMtdPb6LnBs2o8609X+/CDMxz2ZpifV70659Imyscbo=;
        b=lobBqDZ6esd91umHVbKgZ6eN7PdwOjk3UVerthjBgCJe0qEnQllqVFj2clXRdvKKgy
         wf+fI0izdvXxozyEWz4G77IMmJZiQSviDLAJKOdiZOe24u/JizFc4DRF2IIjH0LeOrdZ
         /at161502L4b+/QEgoh+x7zb/Cf73DqiWnd9DcYocLKGJEQS852xpVLczCtV+DTsyICm
         4ZoTMqcuKxDOJdMjXqOsEEZ+EB1UEFte3JU0Hdp68L9WBzKNgWb2d+bpH0W44QvP4mCW
         X8UABD2VFSpUGzqEi3tfvmTTVP1GszXzs3hUt7wyThINK1irLzJZO3049BnLlJYuVZ/a
         hFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OMtdPb6LnBs2o8609X+/CDMxz2ZpifV70659Imyscbo=;
        b=iWBnK/HxTQKnWNx/OWSoOLMGWl1lpaTnJ+pwDbeIsl7tsbJ44+F6hzufSTlE7AiASD
         0G9yrVFKDCsXIfzJhV2c6ghmCYWsuOZfLDEEGYbs/sZ0xYUuruwdoCg3N1nIt25H+YBU
         0CHR85Upa914+EKXZuvmd0+I6tcTNGYon42BDQoMYCEcZWqk0YHkbF55M5ej1hTuK6IZ
         znAFsMCgIN9K5422rKMxlloQMVPTcmNKKKigUYsc2du8hD6v5C2wYhFA+lQn2B3fMzXW
         ef44J09XMoUjhhwTa1dB1fYff+XamNJ8to+C1JU7QJAoH/Q/l/xh5rsLf4MUJSOKS5CW
         xb7Q==
X-Gm-Message-State: AOAM533nVQlgu24+M2fxeggEx5Kx7pCZeHZ2QvP94LTE4IrtWVOdGtBd
        B5TvrlZT4X30TBglU7VvuA2YPg==
X-Google-Smtp-Source: ABdhPJzReDGb8okG9azJgmiP0pibAPCPpScSyrXxzLi0JlXy64HWDBL7P6fToqKR0I+6OdG2NqJfig==
X-Received: by 2002:adf:f6cc:: with SMTP id y12mr18845510wrp.107.1604306398236;
        Mon, 02 Nov 2020 00:39:58 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o7sm21400949wrp.23.2020.11.02.00.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 00:39:57 -0800 (PST)
Date:   Mon, 2 Nov 2020 08:39:55 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Coiby Xu <coiby.xu@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] mfd: intel_soc_pmic: remove unnecessary
 CONFIG_PM_SLEEP
Message-ID: <20201102083955.GE4127@dell>
References: <20201029100647.233361-1-coiby.xu@gmail.com>
 <20201029100647.233361-3-coiby.xu@gmail.com>
 <20201029110029.GF4077@smile.fi.intel.com>
 <20201029142911.p54mbwbfaeymrqy5@Rk>
 <20201029152719.GC4127@dell>
 <CAHp75Vd6dV18x9BLOSSEqL-nVSRhAEc9zQCyOJF7P7tur86BDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd6dV18x9BLOSSEqL-nVSRhAEc9zQCyOJF7P7tur86BDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020, Andy Shevchenko wrote:

> On Thu, Oct 29, 2020 at 5:27 PM Lee Jones <lee.jones@linaro.org> wrote:
> > On Thu, 29 Oct 2020, Coiby Xu wrote:
> > > On Thu, Oct 29, 2020 at 01:00:29PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Oct 29, 2020 at 06:06:41PM +0800, Coiby Xu wrote:
> > > > > SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.
> > > >
> > > > Have you compiled this with
> > > >     % make W=1 ...
> > > > ?
> > > >
> > >
> > > Sorry my bad. I thought I had run "make modules" with CONFIG_PM_SLEEP
> > > disabled. I'll run "make W=1 M=..." for each driver after adding
> > > __maybe_unused in v2.
> >
> > No, thank you.  Just keep it as it is.
> >
> > The current code is space saving.
> 
> Perhaps you need to go thru __maybe_unused handling.
> There are pros and cons of each approach, but not above.

Do you know that all compilers drop the section?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
