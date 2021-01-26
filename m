Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A99303ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbhAZKtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731918AbhAZCcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:32:46 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB53C061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:32:04 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id q129so30850678iod.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MAU7/7hEpMIOh7k5GnIrvpgElglZG4jn3tanb6iaJ/8=;
        b=iM9EWkXoU/6vXayBRiC27meQMn+xjIRZFeYZBNL/b7zUCFxeE3umnq8XixpquD/7bK
         7IcGbTHqPpthDEHEhs7imGr3Xzm/Wt6YljuItkvrRCGpXRGvkoRHL12rnC9Q9WGVDKEc
         OBVusu/XOIvrVXNfPWGf8EY1gMoQaXVIArEyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MAU7/7hEpMIOh7k5GnIrvpgElglZG4jn3tanb6iaJ/8=;
        b=enTOCMjiJpoeg0nRkvkyF1LEfwNK8GjzqGsZ018EktZaPQsGotdsnvV0eNfPC7hZdU
         KzJlmXo+4Si3brzvK9FxpCdSTjMf3NsbRzCYGltmjTHBBBhLrDPTuzUkm8fw8sBttyOM
         HFQR8/dhC+Zk23LJJJWe8kFR0xclKXCaOMWtuhw5sQMywAIwhFfMkc1QTRyFsczIfwB5
         F25llC34cqMWHIWZufluUYLc3QaLQHQgHKT4bqsUCZE226C4wcNd9e6Oo8mMRqGzMJYv
         46xCGeFViWWhvtK2EO29rqz4pZMyGJGZgo3Am6e8QYZGOH/7pXTHxRHBF2IYEeHgqUeW
         FEdg==
X-Gm-Message-State: AOAM530xWCOGns4v/hisaHTjP7cr3A2wKFAk/FerlCFrec0DhhZDuFra
        +1weQumlWsDKgtG4Sm+uWENBynH4buN9wQ==
X-Google-Smtp-Source: ABdhPJxNk7iMEN6oJ5YC8yRz6PsxI5QcQKa9As8fiGEiOp/2Q7fxyJKEaRe73i8W6DfCkoq6AEkwUQ==
X-Received: by 2002:a92:cb47:: with SMTP id f7mr2797043ilq.169.1611628323893;
        Mon, 25 Jan 2021 18:32:03 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b2sm4214845iot.4.2021.01.25.18.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 18:32:03 -0800 (PST)
Subject: Re: [PATCH v4 06/17] selftests/resctrl: Check for resctrl mount point
 only if resctrl FS is supported
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
 <20201130202010.178373-7-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8dcd0720-de6e-52b6-6e10-de2c96fda25d@linuxfoundation.org>
Date:   Mon, 25 Jan 2021 19:32:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130202010.178373-7-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/20 1:19 PM, Fenghua Yu wrote:
> check_resctrlfs_support() does the following
> 1. Checks if the platform supports resctrl file system or not by looking
>     for resctrl in /proc/filesystems
> 2. Calls opendir() on default resctrl file system path
>     (i.e. /sys/fs/resctrl)
> 3. Checks if resctrl file system is mounted or not by looking at
>     /proc/mounts
> 
> Steps 2 and 3 will fail if the platform does not support resctrl file
> system. So, there is no need to check for them if step 1 fails.
> 
> Fix this by returning immediately if the platform does not support
> resctrl file system.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   tools/testing/selftests/resctrl/resctrlfs.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 2c574d143ff0..c676557b376d 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -579,6 +579,9 @@ bool check_resctrlfs_support(void)
>   	printf("%sok kernel supports resctrl filesystem\n", ret ? "" : "not ");

Same comment. Please use kselftest API in kselftest.h for TAP.

>   	tests_run++;
>   
> +	if (!ret)
> +		return ret;
> +
>   	dp = opendir(RESCTRL_PATH);
>   	printf("%sok resctrl mountpoint \"%s\" exists\n",
>   	       dp ? "" : "not ", RESCTRL_PATH);

Same comment. Please use kselftest API in kselftest.h for TAP.
> 

Otherwise looks good.

thanks,
-- Shuah
