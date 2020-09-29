Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C80527D3B9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 18:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgI2QfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 12:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbgI2QfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 12:35:12 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E777C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 09:35:10 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w12so4928157qki.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AvWrqu4w8v60zfj2vEQkFZY/xpWiyVwwYui+w1mVyjU=;
        b=fR1L6woBIk8eiQBenugUHgU9eVdCRDD/5atyqGvpoCazfJHmOMjvTeBvJs2Xdjheej
         jiV6lTQvsxMeEonqGZc2tVOZpqUQspfncpoVfSKFCqpn66Pohu9bIoAjIGrD6UGjMXrL
         stvCCTBoORB27HXTQOyygRY7pqwDWjZAtQ1unwlRab6EPjDztL+9F9XlqDB86NXlOWAy
         6LhARGXTHsRe0GBK4OAHZU9uZtcX+WqZ8c3q+cwp0000xZRGkSsdZnIg1RruYiey178l
         TB34YjYUQaFhc8I7AYm2DnNVKv6vWocOkXlOgdqYUhrn9fSTSXeQcek2kBFyAUa+XXQI
         aHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AvWrqu4w8v60zfj2vEQkFZY/xpWiyVwwYui+w1mVyjU=;
        b=jVjqcvxjIDrIcJjwjgQHlZmC88zg3aWCxjHPYglNZZduBhxdeQivIgM+sGIO4UAL60
         THgkV2cF0dWwn+8tsOX787fnYoEPcnse8EVS4YHw9cmquTchjLn64UURT/czl3aMOcTm
         F+hdDE9cBkrJqcP0fEtWDArBlNKlHrt4FrV8aKM+Y+fBq+oWQpf8qdOp1nvd1/W5a96i
         TPA2zTKLa5J/TRXCt6vsT1F6e1DcSL0SWbZG1EP13lKofuQoE5bNnokHrkXAKah0d70V
         5OTTMe/pHVEXzT1xlcC2yVfHpbrkYYdT2runDoC2atyQuHscQU1SDNP6yKrnvIS0DYY1
         HozQ==
X-Gm-Message-State: AOAM530HlusQFn5PoNptXb9BWSGZoGMbRIAy/3w5v7IwB2ZmdfsBvNks
        SOJNrM0TRIS7yEE6gSVW6FuZ2A==
X-Google-Smtp-Source: ABdhPJyewvSBGSVMwAlEAvWjCrriQubfC+7x0uBqT5YF2razgiDMHSz5KydCKgV0wLG7QOaWdDR93g==
X-Received: by 2002:a37:a04e:: with SMTP id j75mr5059496qke.400.1601397309354;
        Tue, 29 Sep 2020 09:35:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id z26sm4994871qkj.107.2020.09.29.09.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 09:35:08 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kNIap-003Aax-P1; Tue, 29 Sep 2020 13:35:07 -0300
Date:   Tue, 29 Sep 2020 13:35:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/8] selftests/vm: use a common gup_test.h
Message-ID: <20200929163507.GV9916@ziepe.ca>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
 <20200928062159.923212-3-jhubbard@nvidia.com>
 <20200928125739.GP9916@ziepe.ca>
 <6481e78f-c70d-133a-ff4a-325b5cd8fd5d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6481e78f-c70d-133a-ff4a-325b5cd8fd5d@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 01:10:24PM -0700, John Hubbard wrote:
> On 9/28/20 5:57 AM, Jason Gunthorpe wrote:
> > On Sun, Sep 27, 2020 at 11:21:53PM -0700, John Hubbard wrote:
> > > diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> > > index d1ae706d9927..9cc6bc087461 100644
> > > +++ b/tools/testing/selftests/vm/Makefile
> > > @@ -130,3 +130,5 @@ endif
> > >   $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
> > >   $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
> > > +
> > > +$(OUTPUT)/gup_test: ../../../../mm/gup_test.h
> > 
> > There is no reason to do this, the auto depends will pick up header
> > files, and gup_test.h isn't a generated file
> > 
> 
> It is less capable than you might think. Without the admittedly ugly technique
> above, it fails to build, and as you can see, the include paths that are fed to
> gcc are just a single one: usr/include:
> 
> $ make
> make --no-builtin-rules ARCH=x86 -C ../../../.. headers_install
> gcc -Wall -I ../../../../usr/include     gup_test.c
> /kernel_work/linux-next-github/tools/testing/selftests/kselftest_harness.h
> /kernel_work/linux-next-github/tools/testing/selftests/kselftest.h
> ../../../../mm/gup_test.h -lrt -o
> /kernel_work/linux-next-github/tools/testing/selftests/vm/gup_test
> make[1]: Entering directory '/kernel_work/linux-next-github'
> gup_test.c:10:10: fatal error: gup_test.h: No such file or directory
>    10 | #include "gup_test.h"
>       |          ^~~~~~~~~~~~

You are supposed to use

  #include "../../../../mm/gup_test.h"

I have no idea what weird behavior the makefile is triggering that the
above include works

Jason
