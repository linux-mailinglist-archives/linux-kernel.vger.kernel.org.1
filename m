Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FEE2B5329
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbgKPUqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbgKPUqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:46:54 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F67C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:46:54 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id ay21so20188580edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iAACKfn8rangRcEQUTh4m0a+pQ/FoGsxDIe/USx04Pc=;
        b=Ql53A8BcNpmbrA+SOhPrgNDRDNz3rChQJr1kwKh2FulIEi/3rK8mpwxPIwKXKzzJA9
         cUwWgdCsoVV9lrhObFRY83AzgFDfs3JctvKqgcLGDfNvThdzJPI08J2ux65VczgLnPbl
         sK1MCKBB6MYKHGRyJBky7eaEHIzNb6nnbVFzUF7IsS5Qj/gX6LCFLj0u9c9ICEE2MMI3
         /VbTvzK5rCLY71Des0WQTh8TUa1wx73c8bpOZIFPWNuQ87rZZLNOxbOIfmHKgrj8nuZg
         jf/dyftN1OP31FingYqmp8EYFSO3Bh3Q72Nljjv2iVMehtF1vxhB0MPbsdGgc/rpGZyM
         gxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iAACKfn8rangRcEQUTh4m0a+pQ/FoGsxDIe/USx04Pc=;
        b=mTF+5DYhZ3n38iiW9BdNXA8dmJ2dC9RVDQa8iDLoqfUgvETLf+1Iqgqbvef4Ou7Prf
         ayPmi7jrHL+1nf9qX2zlXNoF8OKdKz0g4fOqwkt/myh5NctevGHyZwuGPqaq/7TUE4Ew
         QKxdXuX8xXf7+IFEhbsq3vMiQCqi+4PEhz0fTHMSCZZB6ahhr1KWlwIBrL/s0sjxbe98
         wlr4LuAclfjcfB9jKppnB07Lwf/op6fsaBNfdXfZe39LtKLHtZB/POIlhbJHiplG4oJx
         jsQdQ6uNdI1/9cqBm7yFnnf0yP/3Le5yK1NQ/CMipR8HEUEOiblwhl1N/rA4lItWvuiS
         F0ZQ==
X-Gm-Message-State: AOAM5332eUzGGKWFQYc6RR1d47bKqu1F4WPghqYWWmpX6WybJura1Rfr
        Tv0kRoZV4Yi9yFC+iCyi7TQ=
X-Google-Smtp-Source: ABdhPJzEgI6lgq+IS1YB4MTYWmGSGYoDGNeoaA8Wv2A2qy4+Z8vZsdoIYhz5+C6+snWbjesAMBrXVw==
X-Received: by 2002:a05:6402:7c7:: with SMTP id u7mr17447179edy.351.1605559613261;
        Mon, 16 Nov 2020 12:46:53 -0800 (PST)
Received: from localhost.localdomain (ptr-d0vvtt9s69zjdfz9c1k.18120a2.ip6.access.telenet.be. [2a02:1811:b214:8000:467b:ead9:6950:d438])
        by smtp.gmail.com with ESMTPSA id l20sm10992048eja.40.2020.11.16.12.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 12:46:52 -0800 (PST)
From:   Emmanouil Perselis <perselis.e@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
        elder@kernel.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Emmanouil Perselis <perselis.e@gmail.com>
Subject: [PATCH] Fix warning for static const char * array in audio_manager_module.c
Date:   Mon, 16 Nov 2020 21:43:23 +0100
Message-Id: <20201116204322.2122-1-perselis.e@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <66314332-e66d-9b34-52f9-ae005df2be15@ieee.org>
References: <66314332-e66d-9b34-52f9-ae005df2be15@ieee.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/20 9:17 AM, Greg Kroah-Hartman wrote:
> On Sun, Nov 15, 2020 at 03:53:16PM +0100, Emmanouil Perselis wrote:
>> This patch fixes the warning "static const char * array should
>> probably be static const char * const" in
>> drivers/staging/greybus/audio_manager_module.c

>> I think Greg's patch bot is telling you that you need
>> to carbon-copy the mailing list on your patch submission,
>> not just address it to the maintainers.

Added addresses to carbon copy.

>>					-Alex

>>
>> Signed-off-by: Emmanouil Perselis <perselis.e@gmail.com>
>> ---
>>   drivers/staging/greybus/audio_manager_module.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
>> index 2bfd804183c4..6ef7381f4e85 100644
>> --- a/drivers/staging/greybus/audio_manager_module.c
>> +++ b/drivers/staging/greybus/audio_manager_module.c
>> @@ -158,7 +158,7 @@ static void send_add_uevent(struct gb_audio_manager_module *module)
>>   	char ip_devices_string[64];
>>   	char op_devices_string[64];
>>   
>> -	char *envp[] = {
>> +	static const char * const envp[] = {
>>   		name_string,
>>   		vid_string,
>>   		pid_string,
>> -- 
>> 2.20.1
>>
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - Your patch was sent privately to Greg.  Kernel development is done in
>    public, please always cc: a public mailing list with a patch
>    submission.  Using the tool, scripts/get_maintainer.pl on the patch
>    will tell you what mailing list to cc.
> 
> - You did not specify a description of why the patch is needed, or
>    possibly, any description at all, in the email body.  Please read the
>    section entitled "The canonical patch format" in the kernel file,
>    Documentation/SubmittingPatches for what is needed in order to
>    properly describe the change.
> 
> - You did not write a descriptive Subject: for the patch, allowing Greg,
>    and everyone else, to know what this patch is all about.  Please read
>    the section entitled "The canonical patch format" in the kernel file,
>    Documentation/SubmittingPatches for what a proper Subject: line should
>    look like.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
> 
> thanks,
> 
> greg k-h's patch email bot
> 


Signed-off-by: Emmanouil Perselis <perselis.e@gmail.com>
---
 drivers/staging/greybus/audio_manager_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
index 2bfd804183c4..6ef7381f4e85 100644
--- a/drivers/staging/greybus/audio_manager_module.c
+++ b/drivers/staging/greybus/audio_manager_module.c
@@ -158,7 +158,7 @@ static void send_add_uevent(struct gb_audio_manager_module *module)
 	char ip_devices_string[64];
 	char op_devices_string[64];
 
-	char *envp[] = {
+	static const char * const envp[] = {
 		name_string,
 		vid_string,
 		pid_string,
-- 
2.20.1

