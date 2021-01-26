Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF070303AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404308AbhAZKvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732112AbhAZCgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:36:44 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615B1C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:36:03 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id u17so30931068iow.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gmDO7EshcTKppovqoyoNjNbCH/OmA3ChUZ4PMkoUDdU=;
        b=YRqtxZnCJtvHcx/VP3OzZPc9CtyMAMC+2El8OWE+u6G7TkQPa8e6AVk+3tgd+IkZ28
         mHTeH2vNf77fJDNZpJzjlL6SK6/J6rS2LtgF3FMH6auGwkLDublKhRVwYgOdroc55NT+
         SIRM2ar80zuI281n004akgr6vd3cCBeek4tjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gmDO7EshcTKppovqoyoNjNbCH/OmA3ChUZ4PMkoUDdU=;
        b=FchuauK84c1NMI1PX0c9xygVt819rJtZFoys5agn2Rxoc2bSlKiBxKPnuWcPuiBOJJ
         P/6CqsjzcWSUrzbWeMMzpffR7muami6Z9IM6fl8ks+UuO6i9AM6X08DWYoThAU65D4RG
         BaJSyRgBNi+jQBsRUab4AFFAWo1mItSNm9F38wL7SG2njiWitzVZDT2+y78pc61gdEFN
         mN1P2borGoZH0vP88RxKvUqgSl5xvExwHM+7PkgNcALiSmJfJux5ZPudCfZfr7WwSEco
         k6gy/lV87fQ5IjzEusdH2C/TTEv7S7ZMw3blh5S3wLYVD26cpZ6ANymD2eWYYZPfQ5uc
         Muaw==
X-Gm-Message-State: AOAM533GuqEddXCM9Hee7RsgME2diQhgWa7C4pGF3nSFhuvQoE3rUVvL
        fTxld5QWdYZakATaRWYFH1EaeKpOF9WF4A==
X-Google-Smtp-Source: ABdhPJxmT8QrnoVfsrbL1dp9JIHWJ7CFF7ffX0+48iz6bOn9CB/KHBlC7PFZndOmwd0K4Vp5vOOksw==
X-Received: by 2002:a5e:c74b:: with SMTP id g11mr2592649iop.152.1611628562604;
        Mon, 25 Jan 2021 18:36:02 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o18sm11405932ioa.39.2021.01.25.18.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 18:36:02 -0800 (PST)
Subject: Re: [PATCH v4 09/17] selftests/resctrl: Fix missing options "-n" and
 "-p"
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
 <20201130202010.178373-10-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c7fe69f5-e793-b3aa-dda1-bc90ee1a7f95@linuxfoundation.org>
Date:   Mon, 25 Jan 2021 19:36:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130202010.178373-10-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/20 1:20 PM, Fenghua Yu wrote:
> resctrl test suite accepts command line arguments (like -b, -t, -n and -p)
> as documented in the help. But passing -n and -p throws an invalid option
> error. This happens because -n and -p are missing in the list of
> characters that getopt() recognizes as valid arguments. Hence, they are
> treated as invalid options.
> 
> Fix this by adding them to the list of characters that getopt() recognizes
> as valid arguments. Please note that the main() function already has the
> logic to deal with the values passed as part of these arguments and hence
> no changes are needed there.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   tools/testing/selftests/resctrl/resctrl_tests.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 0e036dbf5d17..ef09e0ef2366 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -73,7 +73,7 @@ int main(int argc, char **argv)
>   		}
>   	}
>   
> -	while ((c = getopt(argc_new, argv, "ht:b:")) != -1) {
> +	while ((c = getopt(argc_new, argv, "ht:b:n:p:")) != -1) {
>   		char *token;
>   
>   		switch (c) {
> 

Same comment. Please make this change before making the cleanup changes.

thanks,
-- Shuah
