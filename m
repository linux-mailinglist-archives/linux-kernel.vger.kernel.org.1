Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88D627F774
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgJABd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJABd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:33:57 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B033C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:33:57 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l16so4511565ilt.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+FmrwvHedwK3YV/KwyhgZk7LHSdoJ+P1bZ0ID2sJGHI=;
        b=i2SjwU860nEJKqeTT+JocSpnAO3NvVnU1e1t+g/n/2xg1+HsXGq+fJRpFvOnOPIIX7
         qZiNOAYOyJTSxbxqc3lFotsmJpK9crKeapFa6XfQ5PgUvJDhOTNGiqK3L1rRb3/0H4MB
         o2Ebml47jJh8E20mD4bTHu+mvH/HTeXk8jWtZKUWVihH/AO7mX2FHOJ7uceNGpaGdCoL
         Dz6xKuKe03ijoDqD69l9X4WrJagawHjnW1x0I1vrt9tZP4gbToWnEWEdWZxt25bnh+j5
         i6Mmo2bLNePcr4oYxmuGa+3jAvdtOIUgmyJ3j9pzR3wxdfiDrNNGqSAmk10FreFhHBTL
         F2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=+FmrwvHedwK3YV/KwyhgZk7LHSdoJ+P1bZ0ID2sJGHI=;
        b=EGoBFjT+miJ3jV7A6l/YIJ1JFTaQKKlVIFiWUXcFbHcTWDXrcZ038XdTKDtbJ6VVYs
         GyZxY0eXZtw1kPUTnNGqi/mHEiLzeTUXue22WaIjbWVtI58LOoEui5elIehXH+fcPPct
         zxJBjcxTARJi0fqU9YZzdviizwg66kVoQPp6sz7p3ffNjZAfEFNeK9cwwSfkaq/QOvRN
         ww63OTqbl/6qbtzsCf7ubSi53TTry5Fio+OfxRALiDntS+4W0taKwsf8Zs20YoW2QxDd
         oKziWMHnKyrPq+pWDHzcE5OcVTGGZK/G4M+0RhkYHRDbDAwFKWvjmO8h/58a9aLg6FQK
         Mpgw==
X-Gm-Message-State: AOAM533gPtFnb0c0HnVB4Rv113kH/x8VuM/IggGc9k/HSgk7+2Qgq/HE
        NsZmcbp4GEswBMM9iFGr5sU57w==
X-Google-Smtp-Source: ABdhPJxQdwF92olKkZVppqrkd0k28VZMsCm+l80yjiMiQvgWeZ19bNjWgUzBUzySwlW+Pek05oxIng==
X-Received: by 2002:a92:b60d:: with SMTP id s13mr594313ili.118.1601516036658;
        Wed, 30 Sep 2020 18:33:56 -0700 (PDT)
Received: from localhost ([2601:441:27f:8f73:8a14:ee62:2db2:372a])
        by smtp.gmail.com with ESMTPSA id j15sm1979882ilo.81.2020.09.30.18.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:33:56 -0700 (PDT)
Date:   Wed, 30 Sep 2020 20:33:55 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, pavel@denx.de, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/166] 4.14.200-rc1 review
Message-ID: <20201001013355.meysosp4esmrbnpz@nuc.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, pavel@denx.de, stable@vger.kernel.org
References: <20200929105935.184737111@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200929105935.184737111@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 12:58:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.200 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Summary
------------------------------------------------------------------------

kernel: 4.14.200-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: 7b80cb61f2b2cf4f291246ded2d1c29e3797c095
git describe: v4.14.199-167-g7b80cb61f2b2
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14.199-167-g7b80cb61f2b2

No regressions (compared to build v4.14.199)

No fixes (compared to build v4.14.199)

Ran 29427 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64
- x86-kasan

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* linux-log-parser
* ltp-containers-tests
* ltp-cve-tests
* ltp-hugetlb-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-sched-tests
* ltp-tracing-tests
* v4l2-compliance
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* ltp-controllers-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-securebits-tests
* ssuite

--
Linaro LKFT
https://lkft.linaro.org
