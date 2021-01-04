Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6659C2E9874
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbhADPZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADPZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:25:37 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43131C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 07:24:57 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q18so32602872wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 07:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IJsReUFErPDMdNE4pFsI26poYyvfDbRtPn9zSVIt8/0=;
        b=BlQJfePcIHLDWx1dqvM/0YWSfeidEAdHBBS9Oi9zH+dVxOYGtIAGpOq2x1TXjiunrn
         JI3g/CkLRqnzY2UHOQnJSKigS9LwL9EXMoK6tLMpEVrXTRw2MNiYNvjHZX9xaguSMN3M
         8NY2ylMZLczGTUgPTz/CT8M7v83ydRkLSESyJqwY1EOT3jLZj3dYAp7mPo/tp5RNpAPJ
         HfOpCUmoFiqSIEmoaZVa44GwpcCaBhkYndRMGH0rqg8i55bvZuYywj7Kz7NdWgBVElyS
         cPugAvD8rXqnqHfgW2pDHH5iLum00/WhBbA5GPVAuiU4ppRiiGP+rARZko0IRWXgOygF
         saGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IJsReUFErPDMdNE4pFsI26poYyvfDbRtPn9zSVIt8/0=;
        b=o+Afz29eXVNq+n0BxLkrnZtFhr/zvWckkKvp9W6YH7wycuqkZKDDSy/9t91vdAgoFf
         xZmFzx3NlG0wLBUz7VZabwf/XMREiw+lRFjilO8aZBPm9PF2tpP5CjEHWQAFma87bBmQ
         UMJQzvn+7bcHKk00JBHzBOr7yUsDqnhWeOgYiB6UpR9ASOeh9rTg9QqfNIZHUjhh1tnp
         bbIJyi9HFEBVyBmTHLnvr0Vu20Ab70oLQUKzqhAT15Tb2yzZnPJRC2TLg/GQVw6BH/et
         /EAi5BiyZ6t587hnR1rhpM1hvqOK5bGFd4K07nIT2/cUKmZk+Dt+gK5S2JtnlneTwXKV
         aWLQ==
X-Gm-Message-State: AOAM530SqPAGlG1eJcmDNCdQxiiccuK1VN8tqEvzZk7WEgqEdzhSsj5/
        TNRaP0rWHX4aDEUvoGpSIRw=
X-Google-Smtp-Source: ABdhPJxVBne8FtNRL+IFINlrV2V2pALI5ujaiRJpJQPMCLhus1Xypuwg0D6XHgJEG9gvvfYtrkDxxw==
X-Received: by 2002:adf:f60b:: with SMTP id t11mr81981893wrp.401.1609773896048;
        Mon, 04 Jan 2021 07:24:56 -0800 (PST)
Received: from [192.168.2.202] (pd9ea302d.dip0.t-ipconnect.de. [217.234.48.45])
        by smtp.gmail.com with ESMTPSA id a14sm89944312wrn.3.2021.01.04.07.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 07:24:55 -0800 (PST)
Subject: Re: drivers/platform/surface/surface3-wmi.c:60:14: warning: variable
 'status' set but not used
To:     Hans de Goede <hdegoede@redhat.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <202012291140.j73hBz45-lkp@intel.com>
 <184b4ec6-65f1-5a22-487b-20cc0fb1b587@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <1a749e41-86da-8607-ec39-c91cf4107a9f@gmail.com>
Date:   Mon, 4 Jan 2021 16:24:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <184b4ec6-65f1-5a22-487b-20cc0fb1b587@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/21 3:52 PM, Hans de Goede wrote:
> Hi,
> 
> On 12/29/20 4:58 AM, kernel test robot wrote:
>> Hi Maximilian,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   dea8dcf2a9fa8cc540136a6cd885c3beece16ec3
>> commit: f23027ca3d48b6f93c5994069fb25b73539fdf34 platform/surface: Move Surface 3 WMI driver to platform/surface
>> date:   9 weeks ago
>> config: x86_64-randconfig-r001-20201221 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>> reproduce (this is a W=1 build):
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f23027ca3d48b6f93c5994069fb25b73539fdf34
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout f23027ca3d48b6f93c5994069fb25b73539fdf34
>>          # save the attached .config to linux build tree
>>          make W=1 ARCH=x86_64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     drivers/platform/surface/surface3-wmi.c: In function 's3_wmi_query_block':
>>>> drivers/platform/surface/surface3-wmi.c:60:14: warning: variable 'status' set but not used [-Wunused-but-set-variable]
>>        60 |  acpi_status status;
>>           |              ^~~~~~
> 
> I guess fixing this would require something like this:
> 
> From: Hans de Goede <hdegoede@redhat.com>
> Subject: [PATCH] platform/surface: surface3-wmi: Fix variable 'status' set but not used compiler warning
> 
> Explictly check the status rather then relying on output.pointer staying
> NULL on an error. This silences the following compiler warning:
> 
> drivers/platform/surface/surface3-wmi.c:60:14: warning: variable 'status' set but not used [-Wunused-but-set-variable]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/platform/surface/surface3-wmi.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/platform/surface/surface3-wmi.c b/drivers/platform/surface/surface3-wmi.c
> index 130b6f52a600..4b7f79c0b78e 100644
> --- a/drivers/platform/surface/surface3-wmi.c
> +++ b/drivers/platform/surface/surface3-wmi.c
> @@ -63,6 +63,10 @@ static int s3_wmi_query_block(const char *guid, int instance, int *ret)
>   
>   	mutex_lock(&s3_wmi_lock);
>   	status = wmi_query_block(guid, instance, &output);
> +	if (ACPI_FAILURE(status)) {
> +		error = -EIO;
> +		goto out_free_unlock;
> +	}
>   
>   	obj = output.pointer;
>   
> 
> Maximilian, can you review and/or test this fix please ?

Ah, this was on my TODO list (among looking at some other things in this
driver), sorry that I haven't gotten to it yet. I'd have proposed pretty
much the exact same thing.

One thing to note though: You should initialize obj with NULL. Keeping
it uninitialized may mess with kfree() under out_free_unlock.

Unfortunately I don't have access to a Surface 3 to test, but apart from
not initializing obj, this patch looks good to me. You may add my
reviewed-by tag once you've fixed that.

Also note that drivers/platform/x86/msi-wmi.c suffers from the same
problem in msi_wmi_query_block() and should receive a similar fix.

Regards,
Max
