Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F8A280B64
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733204AbgJAXlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbgJAXl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:41:29 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E79C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:41:29 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cr8so379278qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9YGiMYLEFWMxP44IQznAdvlL7pES8GSYhxSh3+6yo0Y=;
        b=ANMv3FLowaO67DZBUhWtSpkpLjpR46ykbDH8/Vkq814cnccALRmrxF89cHd7jprMaa
         1q8oMjn7iuJJs139gXQHy1YgmCy1dLk8ZuNeP5nQ03RaWgVCuY7tMRTHAO7u5fEfyGzf
         lI4i5S9/+ft4RN4yYrNW5TLDz60axbCncGU3MerthTO3bnV5QdW0p0lm8a7eOlxK3J3U
         jjqJHwrJxR9J21APERDCxitSvqeAwYgu0TphzK1puwpoaq3ozgsF+X/QjTOZv0XwjLHi
         r8XhOqCiZPyBcISPZ63mmMYCU8h+5UjhF1QPBWftZ+amVGEsNzlMMyXgp3MKTGv/bQlA
         Ch8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9YGiMYLEFWMxP44IQznAdvlL7pES8GSYhxSh3+6yo0Y=;
        b=EeAEt5Ir61/FlrFuMpc7bnuoQw/oP2Afi859oLfOi3Yno588vH/oI7lN2YDk/NjiNW
         MQgPG9lfSDCW5VXkTPOWHaNAzZlwHPaH/7hVgF+OqsgMmsItyHhOWhKL4Y3/s6H2sZwe
         X6fIiYyZpzYweQHNJCsxyluBLy/FDXGKCG7sZY1tsTWOd4W7lYjJf/zfRVpfUdHTtloE
         pTPjTYMWv1xqpIVgYDFQ+Ca4qfPfE8cLWOrDQthw4sw0zEx3JNpzJJeGYrdlNRXDgKrw
         nNahC7mWnYG69stV2C9kGeO97H/51sifua6gEkazcNmnOlW1zJi5Weny7Yh46+EvVFCv
         3Z+Q==
X-Gm-Message-State: AOAM533WKOz8pA+++oi3H5bj4aqYJWtyHsW1Y3P/LkiDZ4PBQvdZa1lf
        57j0H+BiplIDs5m3S/Wx2mJgnw==
X-Google-Smtp-Source: ABdhPJxd2AyZtByeV7o2/IShOr8SdCiXS1oQbmwMZZV5I2AhHQOl2gIId8kORue5lUAX6bRGB26+Lg==
X-Received: by 2002:a0c:f48e:: with SMTP id i14mr10156591qvm.5.1601595688900;
        Thu, 01 Oct 2020 16:41:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id r17sm437460qtm.66.2020.10.01.16.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 16:41:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kO8CV-0052fJ-8d; Thu, 01 Oct 2020 20:41:27 -0300
Date:   Thu, 1 Oct 2020 20:41:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 3/4] mmap locking API: Don't check locking if the mm
 isn't live yet
Message-ID: <20201001234127.GG9916@ziepe.ca>
References: <20200930011944.19869-1-jannh@google.com>
 <CAG48ez03YJG9JU_6tGiMcaVjuTyRE_o4LEQ7901b5ZoCnNAjcg@mail.gmail.com>
 <20200930123000.GC9916@ziepe.ca>
 <CAG48ez2z1R8MLS0_pjhBSGnJC8RwaHMpiGdv8GhJUCrwtsLOPg@mail.gmail.com>
 <CAG48ez0fhY0twgriBDv9RU1YG8mBxg_KoK_YsLPWYo4feAQ=Sg@mail.gmail.com>
 <20200930232655.GE9916@ziepe.ca>
 <CAG48ez0i2++2Jg1Z-RyCKn-uZ-gcszVknAaCyXbJyptuMxbCsg@mail.gmail.com>
 <20201001191512.GF9916@ziepe.ca>
 <CAG48ez3GW9sRfZWwx+YpKdouAVT+o9zQR73-itJMbLCXTiUxBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3GW9sRfZWwx+YpKdouAVT+o9zQR73-itJMbLCXTiUxBw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 10:16:35PM +0200, Jann Horn wrote:

> > A subclass isn't right, it has to be a _nested annotation.
> >
> > nested locking is a pretty good reason to not be able to do this, this
> > is something lockdep does struggle to model.
> 
> Did I get the terminology wrong? I thought they were the same. The
> down_*_nested() APIs take an argument "subclass", with the default
> subclass for the functions without "_nested" being 0.

AFAIK a subclass at init time sticks with the lock forever, the
_nested ones are temporary overrides.

I think what you kind of want is to start out with
lockdep_set_novalidate_class() then switch to a real class once things
are finished. Not sure exactly how :)

Jason
