Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8631827486F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgIVSnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgIVSnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:43:06 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B77C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:43:06 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so1919465pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AOc4DnOR/AfJCb7O1YlqXCVVgO3c4FUkM/X5f+Xzp3M=;
        b=FHtOU4t3Tpe7QIuQmCTJz0l2N6Ox/POqHxEfuXG4fqF+rkXvXzpJ96tGrXx/UkHb1+
         F+Ch15P8R2lHavNQyUE+IQno9mhT9bE5TSVRcc/TwFNtbMXMDRHq2+qoisKfSxkEQ2gT
         AQb4hWQBVB0urL43ZHxkYaYUuH9ysNHrZR7pNwKWosl8hg07XAhm9xC+RaQJ+AqOg1RX
         DkbjBhFNY3TUF1vbz2EWk/cIKxGfcLInEpHWCqiIATk4QcjnetqEnnam4YHLfiZlXgvT
         kT+RUaD64sWxK4PgsFF1qo7pFF2Vo2Zq7TjK1EHFs/NL+z8UsedPu7JkWjpbosqSD9YP
         oxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AOc4DnOR/AfJCb7O1YlqXCVVgO3c4FUkM/X5f+Xzp3M=;
        b=S4FoUTYGt4ynBc7hAGpeCrJFPBj5StKLyS2mQHLD9+ek00iBaXfuEnZLtTxbTuB9dM
         JkL1G4rH/xvLkU3//MMqoj2zGTjGQTk8O6O5U/w2H1mEAqozXP4M0Bo0p/S+mA2AEWgC
         HLbJrSy1q1HX6nsFW5q0XA/b73cz4FKJ5TZZ9iJ+EIyfxOFJlq6A7C9V2K+K3AK/WN1n
         wdV9liq1uVGVAJWwH8Duc/89+3lIeBQn8Rb8yoBCT4j4LkHVhMUGNp1ynXV0Ayv2nE8I
         aFiLJhXXPaRfU/MMMkE/aekCrtiZ/pRYgdLbW1MqRVEDzIjNVHcJsUtdlGiY184OuOXE
         dsZg==
X-Gm-Message-State: AOAM533YZDa2BkvsRVh7zLA2lXwIfAeZoM1DRvnTJ/Zlh/tzu7cLhiYX
        MdC2rq9gysj8gVUaQqCd2k8=
X-Google-Smtp-Source: ABdhPJw5DgATqvxAw3bfOAIboduwo/Gxmk9LXH5h4qz7hRNCuDztoqlxvdV0k7yutr4ODKwzZeMRfg==
X-Received: by 2002:a17:90b:3252:: with SMTP id jy18mr4726795pjb.1.1600800185993;
        Tue, 22 Sep 2020 11:43:05 -0700 (PDT)
Received: from james-Aspire-E5-575G (c-71-231-36-179.hsd1.wa.comcast.net. [71.231.36.179])
        by smtp.gmail.com with ESMTPSA id ev19sm2872317pjb.42.2020.09.22.11.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 11:43:05 -0700 (PDT)
Date:   Tue, 22 Sep 2020 11:43:00 -0700
From:   James Browning <jamesbrowning137@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] staging: comedi: comedi.h: Fixed typos in comments
Message-ID: <20200922184300.7rd7uzuq27vz7su6@james-Aspire-E5-575G>
References: <20200921053018.64095-1-jamesbrowning137@gmail.com>
 <20200922075224.GA1789797@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922075224.GA1789797@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:52:24AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Sep 20, 2020 at 10:30:00PM -0700, James Browning wrote:
> > Removed repeated words "the" and "in"
> > 
> > Signed-off-by: James Browning <jamesbrowning137@gmail.com>
> > ---
> >  drivers/staging/comedi/comedi.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> What tree did you make this against?  It's already in my development
> tree and in linux-next, so I can't apply this again :(
> 
> thanks,
> 
> greg k-h

I made that patch on the 5.9-rc6 mainline tree. From now I will check the linux-next tree.

Thank you,
James
