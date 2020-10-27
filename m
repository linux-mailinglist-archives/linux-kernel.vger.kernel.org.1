Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5307E29CD56
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 02:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgJ1BiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 21:38:18 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:46764 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832981AbgJ0XM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 19:12:29 -0400
Received: by mail-il1-f195.google.com with SMTP id a20so3033791ilk.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 16:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IzmqPB1puGOHsvhueEOlE8eXJd/vgq2Jd8OPbR8IPAM=;
        b=PfNpxTr4eOMHuntStW7oFjw7a6QhzSfUZ8KYnCpgYIgAHTG9wjLZnMKHK1SojB79R8
         2wFCHTRNKPDQ/gTFvj6sSE/gThldpxrYWNDN4Vd/6IDW7XEMVBu/i0KmYPYM4jK8T9Yr
         9dLqLRm33HbhP4rDXx/cSTrceB2RcMA0wV7Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IzmqPB1puGOHsvhueEOlE8eXJd/vgq2Jd8OPbR8IPAM=;
        b=tRpLd/3K8fdEa8BcGPoDk68UIKnzPQpeZchZIz5Z3XRUE7xSXlka3g0PQyCUDtz20g
         TZaf85+/yRc5MNjoZfm1lSYjs2KTYFQlshBewNg/fW/6P8D9Q3fI4AeY68vNoCTc/4/6
         HHtdbYmebvtaI99s032eA0NfhJFK8+XGQS48cgjyfY2MU2acd6X/JLwaQ7oVKK4xv9Yz
         56Jly7j1xD1vi7vrpMOAscC0oj/eHb04k1j9OJtavUbqsbs1EJ2pawRpNVu3g4+jltM5
         oEOWmFspe6Nti2GsuU78wG3UdHPoTRK+OHnum2Dk/O9pYfqMF2Io9DC4W1Iu94hhs0oR
         xQYw==
X-Gm-Message-State: AOAM531FOxBQjc271Rw/lGpyjfqxKfvIru4Ng6v0K9S0NmHn545cOtdo
        TEYCw7ZcmT33GWfF04i/7HGI7A==
X-Google-Smtp-Source: ABdhPJzEWlsqYvdWniHqNDADoZ721JW5NWRo0RnMwfmzMhHwSQ3zyxkQgt6PX9MVCmUsRQ6fM+hsgw==
X-Received: by 2002:a92:1307:: with SMTP id 7mr3770123ilt.142.1603840347497;
        Tue, 27 Oct 2020 16:12:27 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s10sm1586129ilh.33.2020.10.27.16.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 16:12:26 -0700 (PDT)
Subject: Re: [PATCH 00/13] selftests fixes
To:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <700bf9e6-1fbf-3b29-8df8-8625b2967e18@linuxfoundation.org>
Date:   Tue, 27 Oct 2020 17:12:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 6:26 AM, Tommi Rantala wrote:
> Hi, small fixes to issues I hit with selftests.
> 
> Tommi Rantala (13):
>    selftests: filter kselftest headers from command in lib.mk
>    selftests: pidfd: fix compilation errors due to wait.h
>    selftests: add vmaccess to .gitignore
>    selftests/harness: prettify SKIP message whitespace again
>    selftests: pidfd: use ksft_test_result_skip() when skipping test
>    selftests: pidfd: skip test on kcmp() ENOSYS
>    selftests: pidfd: add CONFIG_CHECKPOINT_RESTORE=y to config
>    selftests: pidfd: drop needless linux/kcmp.h inclusion in
>      pidfd_setns_test.c
>    selftests: android: fix multiple definition of sock_name
>    selftests: proc: fix warning: _GNU_SOURCE redefined
>    selftests: core: use SKIP instead of XFAIL in close_range_test.c
>    selftests: clone3: use SKIP instead of XFAIL
>    selftests: binderfs: use SKIP instead of XFAIL
> 
>   tools/testing/selftests/android/ion/ipcsocket.c           | 1 +
>   tools/testing/selftests/android/ion/ipcsocket.h           | 2 --
>   .../selftests/clone3/clone3_cap_checkpoint_restore.c      | 2 +-
>   tools/testing/selftests/core/close_range_test.c           | 8 ++++----
>   .../selftests/filesystems/binderfs/binderfs_test.c        | 8 ++++----
>   tools/testing/selftests/kselftest_harness.h               | 2 +-
>   tools/testing/selftests/lib.mk                            | 2 +-
>   tools/testing/selftests/pidfd/config                      | 1 +
>   tools/testing/selftests/pidfd/pidfd_getfd_test.c          | 5 ++++-
>   tools/testing/selftests/pidfd/pidfd_open_test.c           | 1 -
>   tools/testing/selftests/pidfd/pidfd_poll_test.c           | 1 -
>   tools/testing/selftests/pidfd/pidfd_setns_test.c          | 1 -
>   tools/testing/selftests/pidfd/pidfd_test.c                | 2 +-
>   tools/testing/selftests/proc/proc-loadavg-001.c           | 1 -
>   tools/testing/selftests/proc/proc-self-syscall.c          | 1 -
>   tools/testing/selftests/proc/proc-uptime-002.c            | 1 -
>   tools/testing/selftests/ptrace/.gitignore                 | 1 +
>   17 files changed, 19 insertions(+), 21 deletions(-)
> 

Thanks for fixing these.

Applied all except 03/13 which is already fixed.

thanks,
-- Shuah
