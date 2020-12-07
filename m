Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4485B2D1CA8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgLGWCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgLGWCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:02:47 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0CDC061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:02:07 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id x15so13734647ilq.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 14:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ss8WaLcdokkmrrcznGv29pZQDMMRYrY5tuFVliI7mtk=;
        b=PBo4wGrW4sBGEHPUF7gOtM+tS0xrZECiPlkWeruaBNoiyEg8pGqn1wVDB32B6JGzlR
         D8BOLrzFapLOmsbKoUkwfzwU+K4vIjzzPrI2d6yUfkWi7WKaZZT+8lFL/mpiqqcfu6QU
         xFY3OGWDHmtNuPnZgGh8hXmOLCxvA9kv0xpwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ss8WaLcdokkmrrcznGv29pZQDMMRYrY5tuFVliI7mtk=;
        b=QRVYwUnliZpHnEaxLsbR8DEdoUi6Vk/+xCjV99Yaf3FWcdpdA4di8eSCnjA5I95CzD
         zCdFPkrK8NAnw9Tu7ckeOj3qTxNznBRbqBqSXCaZ7sqR51iSISnbSD9gELips1tHEFCO
         E2R1o+EDuB/AbBVyxXUmph79JFflFP3LPwZAjAcoQBSGb0GaBWI36by1gt5WZuX70Qdl
         ahFW6hRBseYyjTIvDfKSoQ27GVSVDnUB/qPHscpxtAc0Vi4pQDByiGP8M+eGO7knmuvy
         Y/UAJzEI9kPgzaF7EYyl/rySqLsjcNncOulz6tJH6Gvi8dlJahMsQ1zqvtBHdESmBsIR
         hTKQ==
X-Gm-Message-State: AOAM530llkvNetO7KvfIt1bE0cfl5oNA4YY96Br2gjpOLS51pMLxSCdq
        HnrIMuYoLJ8VCOyYhvj5VQkI1A==
X-Google-Smtp-Source: ABdhPJzPEyUQeEVsy6nRdD5rgAQc+77hH8qv1yE332FTA4Lm0VzqcIS33QFKR8GErOIulLDQFvPrzw==
X-Received: by 2002:a92:ac08:: with SMTP id r8mr3961124ilh.166.1607378526701;
        Mon, 07 Dec 2020 14:02:06 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h15sm6726176iow.13.2020.12.07.14.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 14:02:05 -0800 (PST)
Subject: Re: [PATCH v2] selftests/clone3: Fix build error
To:     Xingxing Su <suxingxing@loongson.cn>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1606447017-10640-1-git-send-email-suxingxing@loongson.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <22c84b2d-2a1c-8947-c217-27888bfbcd51@linuxfoundation.org>
Date:   Mon, 7 Dec 2020 15:02:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1606447017-10640-1-git-send-email-suxingxing@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/20 8:16 PM, Xingxing Su wrote:
> When compiling the selftests with the -std=gnu99 option the build can
> fail with.
> 
> Following build error:
> 
>    test_core.c: In function ‘test_cgcore_destroy’:
>    test_core.c:87:2: error: ‘for’ loop initial declarations are only
>    allowed in C99 mode
>      for (int i = 0; i < 10; i++) {
>      ^
>    test_core.c:87:2: note: use option -std=c99 or -std=gnu99 to compile
> 
> Add -std=gnu99 to the clone3 selftest Makefile to fix this.
> 
> Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>   tools/testing/selftests/clone3/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
> index ef7564c..88354a8 100644
> --- a/tools/testing/selftests/clone3/Makefile
> +++ b/tools/testing/selftests/clone3/Makefile
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -g -I../../../../usr/include/
> +CFLAGS += -g -std=gnu99 -I../../../../usr/include/
>   LDLIBS += -lcap
>   
>   TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
> 

Applied to linux-kselftest fixes for 5.11-rc1

thanks,
-- Shuah
