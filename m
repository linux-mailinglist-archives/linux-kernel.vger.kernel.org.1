Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B808303ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404480AbhAZKwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732217AbhAZCjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:39:39 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5A1C061756
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:38:56 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id u8so17748302ior.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T1589MF1oJGrp0vPpxwWqo/ZGxjr0Fx97A8pKUqLZXE=;
        b=YHiBw+LS0WPpSrgnv28Eg/ZxAU7hDJ2/Fft8VX7KhJdKwqng5Iat/BWikL/NeMo+0T
         5KRlYMu7zmWO7Kja/XBiplZ4HWr9D/MtfHkf7mI6Z+zXK/2BeaKJ1aEWv04rEnFJx8x/
         4sJqgyDJgFEXS6D9bsimXOpflATEthQYvyX14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T1589MF1oJGrp0vPpxwWqo/ZGxjr0Fx97A8pKUqLZXE=;
        b=nGd+d78NfAbWCDD34fgei+msHZJL1L2N+6jbNdzdGa7+czOfKpHZzMqzJPvJ1oqqOF
         UBodjD9WDprcguMLljcu3FxUDasphincWzrEuJP3IVngzRsKg4f/9syrDeBYXZd7UWXZ
         BJrQRDiBSV9DjpCB5k2TbvqgT72SclcOqMQsJDRGEYNvts8ZytBYAfn7LMuLspb3ptcr
         aFk16Ok7j9pS4Yuih9Xij6oQF1e1r3qql7PRmpMN1bsi6+7ChrLMfcBUqVBxt1uWjZsc
         L5VJ9KOuDFtA190rkixyuiXpCnO/b8ICwPnzEcEF1rRUTmXx2yz5Hgj7dHpYDfcy0pY3
         8ZbA==
X-Gm-Message-State: AOAM532SyILvZRN9NYZ5oj2hBiZSLxtwODNml2xAMUOBfQ6vOPttbumq
        EhpIFJmyl/D/8bdTAgsutsx8g+vY/Jk71g==
X-Google-Smtp-Source: ABdhPJwJ2QmCRBI5WX62wiBK1aWdjQ/efE4YhpQ3eJmp3v2tsFW4k3ylUpddn+WF9IYee66gKjhlyA==
X-Received: by 2002:a92:6907:: with SMTP id e7mr2767908ilc.134.1611628735425;
        Mon, 25 Jan 2021 18:38:55 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b8sm3866751iow.44.2021.01.25.18.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 18:38:54 -0800 (PST)
Subject: Re: [PATCH v4 11/17] selftests/resctrl: Enable gcc checks to detect
 buffer overflows
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        David Binderman <dcb314@hotmail.com>,
        Babu Moger <babu.moger@amd.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
 <20201130202010.178373-12-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <11b8d4ef-c1ef-f00a-bf02-ea23e79065d6@linuxfoundation.org>
Date:   Mon, 25 Jan 2021 19:38:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130202010.178373-12-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/20 1:20 PM, Fenghua Yu wrote:
> David reported a buffer overflow error in the check_results() function of
> the cmt unit test and he suggested enabling _FORTIFY_SOURCE gcc compiler
> option to automatically detect any such errors.
> 
> Feature Test Macros man page describes_FORTIFY_SOURCE as below
> 
> "Defining this macro causes some lightweight checks to be performed to
> detect some buffer overflow errors when employing various string and memory
> manipulation functions (for example, memcpy, memset, stpcpy, strcpy,
> strncpy, strcat, strncat, sprintf, snprintf, vsprintf, vsnprintf, gets, and
> wide character variants thereof). For some functions, argument consistency
> is checked; for example, a check is made that open has been supplied with a
> mode argument when the specified flags include O_CREAT. Not all problems
> are detected, just some common cases.
> 
> If _FORTIFY_SOURCE is set to 1, with compiler optimization level 1 (gcc
> -O1) and above, checks that shouldn't change the behavior of conforming
> programs are performed.
> 
> With _FORTIFY_SOURCE set to 2, some more checking is added, but some
> conforming programs might fail.
> 
> Some of the checks can be performed at compile time (via macros logic
> implemented in header files), and result in compiler warnings; other checks
> take place at run time, and result in a run-time error if the check fails.
> 
> Use of this macro requires compiler support, available with gcc since
> version 4.0."
> 
> Fix the buffer overflow error in the check_results() function of the cmt
> unit test and enable _FORTIFY_SOURCE gcc check to catch any future buffer
> overflow errors.
> 
> Reported-by: David Binderman <dcb314@hotmail.com>
> Suggested-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   tools/testing/selftests/resctrl/Makefile   | 2 +-
>   tools/testing/selftests/resctrl/cmt_test.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index d585cc1948cc..6bcee2ec91a9 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,5 +1,5 @@
>   CC = $(CROSS_COMPILE)gcc
> -CFLAGS = -g -Wall
> +CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
>   SRCS=$(wildcard *.c)
>   OBJS=$(SRCS:.c=.o)
>   
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index 188b73b5a2cc..ac1a33d9ce12 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -81,7 +81,7 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
>   		return errno;
>   	}
>   
> -	while (fgets(temp, 1024, fp)) {
> +	while (fgets(temp, sizeof(temp), fp)) {
>   		char *token = strtok(temp, ":\t");
>   		int fields = 0;
>   
> 

This should be fixed first before the other changes.

thanks,
-- Shuah
