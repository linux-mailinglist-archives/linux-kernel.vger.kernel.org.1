Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670AC27AE94
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 15:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgI1NCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 09:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgI1NCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 09:02:47 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E4AC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 06:02:47 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id y11so609909qtn.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0vw0hzc9LBmLPORF1IWKKNtSKYXmHXVZRRprHQAaYXo=;
        b=GskZscDezG2KqdkACqV8aTol4TYVU67vtXhjpLjLmCHlsc8eztYkj/KyG0nACG75+R
         rNXcSTO6VBIBqXAyqHCAAJSdD5fzv77e73XzOz1w28Mmdl/OIxqRk7eyhlZrjHnSem/a
         UknUSWtU4yOGXyh1VjK3hZXYJstYNsRdBhJEgOic5any935sWaTBJDMjURDxaX7yzafb
         Q6x9bblYnRjtCuKvu5dxw+A+srcuScuD9W/eelwqZphZeKEtrk9k4W8FEY0IUZH/1AKu
         yVv+ZuBDofv3kNcMtRhxiCa6c985NzKdNUOYA6A2qDno6+R3gm3meQARiy+gYA3PbBZq
         AogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0vw0hzc9LBmLPORF1IWKKNtSKYXmHXVZRRprHQAaYXo=;
        b=lpXrWMwJtu+ghOFw0gItv0QvMmTTJ1e6gW6UtImaweWAkrAEz7J5MR9m/UyW4Yzt+l
         cdc4azy/s49R+kqgeebpcU/3PPoTJH+944+ZrU4q/7y5g4HQBm8CmoVhsc7TRBcYL9b2
         Vyq23OGeDfp/mzYqT5Z5PUO3hAOctaJyDl3TqpvmCK7nejjVDtQn9QGxmWz/Nso21ecv
         NAhH1KH/IiWrcyWjnlXqE4ofmAC7M6rmm49CtIIrBTYiTHE1LlOCGc4o2ZGFQjvEYxs+
         7BoHfUQ3nHhSzBkJ/TF0O2LdsN8GLoGm65cXRF/WKHikv8SH0H7GBkQSKjG1cylAUZDN
         6XEw==
X-Gm-Message-State: AOAM532hRAgJsRe2V6YY7uHKwOPdkwGYhxuXGxi3BVNTNXpwtovMfRlm
        LGn8KQn8csU2MOeBozi3l67TFA==
X-Google-Smtp-Source: ABdhPJxNelY8OktJZyftNDCq39TaQIPExwt+riZUsci5Sw5qww94PXK5KPyw8lwkqStl+sFd9YRKLA==
X-Received: by 2002:ac8:7b3d:: with SMTP id l29mr1463274qtu.366.1601298166224;
        Mon, 28 Sep 2020 06:02:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 76sm876952qkl.127.2020.09.28.06.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 06:02:45 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kMsnl-001us3-0v; Mon, 28 Sep 2020 10:02:45 -0300
Date:   Mon, 28 Sep 2020 10:02:45 -0300
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
Subject: Re: [PATCH 8/8] selftests/vm: hmm-tests: remove the libhugetlbfs
 dependency
Message-ID: <20200928130245.GQ9916@ziepe.ca>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
 <20200928062159.923212-9-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928062159.923212-9-jhubbard@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 11:21:59PM -0700, John Hubbard wrote:

> @@ -76,8 +79,6 @@ TEST_FILES := test_vmalloc.sh
>  KSFT_KHDR_INSTALL := 1
>  include ../lib.mk
>  
> -$(OUTPUT)/hmm-tests: LDLIBS += -lhugetlbfs
> -
>  ifeq ($(ARCH),x86_64)
>  BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
>  BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
> @@ -130,3 +131,22 @@ endif
>  $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
>  
>  $(OUTPUT)/gup_test: ../../../../mm/gup_test.h
> +
> +$(OUTPUT)/hmm-tests: local_config.h
> +
> +# HMM_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
> +$(OUTPUT)/hmm-tests: LDLIBS += $(HMM_EXTRA_LIBS)
> +
> +local_config.mk local_config.h: check_config.sh
> +	./check_config.sh
> +
> +EXTRA_CLEAN += local_config.mk local_config.h
> +
> +ifeq ($(HMM_EXTRA_LIBS),)
> +all: warn_missing_hugelibs
> +
> +warn_missing_hugelibs:
> +	@echo ; \
> +	echo "Warning: missing libhugetlbfs support. Some HMM tests will be skipped." ; \
> +	echo
> +endif
> diff --git a/tools/testing/selftests/vm/check_config.sh b/tools/testing/selftests/vm/check_config.sh
> new file mode 100755
> index 000000000000..651a4b192479
> +++ b/tools/testing/selftests/vm/check_config.sh
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Probe for libraries and create header files to record the results. Both C
> +# header files and Makefile include fragments are created.
> +
> +OUTPUT_H_FILE=local_config.h
> +OUTPUT_MKFILE=local_config.mk
> +
> +# libhugetlbfs
> +tmpname=$(mktemp)
> +tmpfile_c=${tmpname}.c
> +tmpfile_o=${tmpname}.o
> +
> +echo "#include <sys/types.h>"        > $tmpfile_c
> +echo "#include <hugetlbfs.h>"       >> $tmpfile_c
> +echo "int func(void) { return 0; }" >> $tmpfile_c
> +
> +gcc -c $tmpfile_c -o $tmpfile_o >/dev/null 2>&1

This gcc has to come from some makefile variable

This is kind of janky :\

Could we just not use libhugetlbfs? Doesn't it all just boil down to
creating a file in /dev/huge? Eg look at tools/testing/selftests/vm/hugepage-mmap.c

Jason
