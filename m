Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB0C303AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404285AbhAZKv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732071AbhAZCfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:35:51 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD08C061756
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:35:10 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id u17so30928472iow.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lczqUQvRroi6ojgAKtFrKCFdHrTeGAnR/7FkskeUK2s=;
        b=Wm5/gphKe2i1rzAwwQxv75dnBbaFUl4Kll5jAgojYB3Tf4VOeqhQ+spYRNBoJO52ro
         emkq+23R8G2/iw8Rubj+oWPISxXbpRHVelxcEFsE8SSthovxXGo9m48mzGu5Dcg2RI9e
         3UrLGLpk/hJOJEfhIQCVYv6qdkkTdTOuCHR7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lczqUQvRroi6ojgAKtFrKCFdHrTeGAnR/7FkskeUK2s=;
        b=GWroKe4r03+IbAZpuK/9BfPbyXocbLLWT1OHsMZ69zwlaPF1ZMbwm0Q+roMZo7pDih
         FrhJKYSk4xwJI/7a364m5+ifCUM03dLTdEx6c/QRvxfuDpg+/2zNPGzr5dElVuXHZ62i
         NQWq0WcOXvzwqHiCIkyaez90EQN8fkzw5mmSZBDXUj6X86mVW3OCboqtMkaek2PrLWpz
         Edl4SbR8C4XhNUZMuREt6vdHTSK/OQaIgPQyhL5JJFzCQVAo4GZWS3AmNvIX+NBuolLx
         eJFOl+ukkNOrB8jKU2edgnTffJLSLH252PAsss2SveWf8qJkGCSBsd5Qv/PWpeWGxBXG
         j7/g==
X-Gm-Message-State: AOAM5324pGdgt4ERdcg1MtMWMNhE8ycuOdlQ2s4/UwMR5yP0YVPkV4a9
        y/ympaT7maXw7qQB5q4pyan301leF5oK6Q==
X-Google-Smtp-Source: ABdhPJwNjJkBesNOlVh1qmhTtCG4WPVqr2YeBfxbxAX+/ztoJUO7FJlBXMQuO9XTm691wBmq4PhQMg==
X-Received: by 2002:a5d:980c:: with SMTP id a12mr2607880iol.196.1611628509858;
        Mon, 25 Jan 2021 18:35:09 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l14sm1471436ilc.33.2021.01.25.18.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 18:35:09 -0800 (PST)
Subject: Re: [PATCH v4 08/17] selftests/resctrl: Ensure sibling CPU is not
 same as original CPU
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
 <20201130202010.178373-9-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <80401879-21fb-baaa-ffed-7c5a7abc4768@linuxfoundation.org>
Date:   Mon, 25 Jan 2021 19:35:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130202010.178373-9-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/20 1:20 PM, Fenghua Yu wrote:
> From: Reinette Chatre <reinette.chatre@intel.com>
> 
> The resctrl tests can accept a CPU on which the tests are run and use
> default of CPU #1 if it is not provided. In the CAT test a "sibling CPU"
> is determined that is from the same package where another thread will be
> run.
> 
> The current algorithm with which a "sibling CPU" is determined does not
> take the provided/default CPU into account and when that CPU is the
> first CPU in a package then the "sibling CPU" will be selected to be the
> same CPU since it starts by picking the first CPU from core_siblings_list.
> 
> Fix the "sibling CPU" selection by taking the provided/default CPU into
> account and ensuring a sibling that is a different CPU is selected.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   tools/testing/selftests/resctrl/resctrlfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index d2cae4927b62..3f43bcf0b8d5 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -268,7 +268,7 @@ int get_core_sibling(int cpu_no)
>   	while (token) {
>   		sibling_cpu_no = atoi(token);
>   		/* Skipping core 0 as we don't want to run test on core 0 */
> -		if (sibling_cpu_no != 0)
> +		if (sibling_cpu_no != 0 && sibling_cpu_no != cpu_no)
>   			break;
>   		token = strtok(NULL, "-,");
>   	}
> 

Shouldn't this be fixed first before the cleanup and restructure
changes?

Please make this patch 3.

thanks,
-- Shuah
