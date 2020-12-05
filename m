Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417672CFB01
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 11:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgLEKc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 05:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgLEKX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 05:23:29 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB201C061A51
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 02:22:48 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id g18so5166210pgk.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 02:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A767yBV5nLDhDpN569Cxatt3mWD9/ZoreJ8vgdOMm0s=;
        b=DKz+i+l44WZtU2FGwxWrxYr/ZqGuX7ploEWaXNHX4zwTraOZt0LT8ibDltHH66D+J0
         1lmaPWa0u56NIKsrn2i+T3VEStXxYqoqWs0w6zGNhN6fopKYR9RKJ993qlmzVEmRBYYx
         kBd1YBwTPHEIOKqGsr9YuJrkDTIneOj39AJ9Y645gSTnz8vpfZM6Cns76UU9cbnH9AOi
         sE/SMyHvyDbdztd8AYJAuxzzE8Tj1fVR9OND/tNIjrJ5CQFo1h7RUo2wOK1lcGj3YZ9e
         49+BVF6Xw/nEmk0xm+l+AYGJIbpq6sy6G1gUPydpQ1mRuVKIMPR1YX4+CAw0H6IprhRe
         YGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A767yBV5nLDhDpN569Cxatt3mWD9/ZoreJ8vgdOMm0s=;
        b=XybmmPaz+VxzZPAYYEyikhVwntCLhoZSlEkRiPwQLqVzEqTFnf7X70eoHR7TKI77k5
         x0NZqAbbTFCQrl21cgDyqcy3b4WYaSCv5vlyJoBZ45fiElYp8w6zRJNN8d0lVTh2ZEyk
         UC2HlEjyBaZv2JsFVZM4xELlvKCddFo5xK45y6YexR+UCwRUSIOCE+6wRc9BtQiy8plS
         BKyiX3y/kS8VTz8Aee1iXcEh+cGEiTwj32WqbyBjmmBUKYaTvoOmETFNzgKXtqkoYS4i
         2mjDtoMPGPglPlvOrP+OEnsRc/n8w9j+WYw6CmuIqZ95/woWnsatGMMwfEmWPwyLVnf1
         770Q==
X-Gm-Message-State: AOAM53262CgNxYmJJAGaQbFozkAWp2hbq1JUmeSaULPU2pSb0c4/rKEA
        Imzh+4y8RqwfKRFgyhNzr60=
X-Google-Smtp-Source: ABdhPJyfbWnzoSQvPNCJNcQGdeLAgddXT17zRmPX3pf+0Mg9NppP7J4ZSgdfEBWNY0WdfxGc2O2zLA==
X-Received: by 2002:a62:ab0f:0:b029:197:f771:fe8e with SMTP id p15-20020a62ab0f0000b0290197f771fe8emr7740771pff.65.1607163768191;
        Sat, 05 Dec 2020 02:22:48 -0800 (PST)
Received: from ?IPv6:2402:3a80:405:a0b2:f8e7:94b7:3acf:b58e? ([2402:3a80:405:a0b2:f8e7:94b7:3acf:b58e])
        by smtp.gmail.com with ESMTPSA id c28sm8047445pfj.108.2020.12.05.02.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 02:22:47 -0800 (PST)
Subject: Re: [PATCH v6] checkpatch: add fix for non-standard signature -
 co-authored-by
To:     linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com, Joe Perches <joe@perches.com>,
        daniel@iogearbox.net, peterz@infradead.org,
        gregkh@linuxfoundation.org
References: <a2c74693-93ae-cd5a-7836-4ffff643fc09@gmail.com>
 <20201204144000.21734-1-yashsri421@gmail.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <b9048b9c-22cb-fc47-8e87-1c091a9cc822@gmail.com>
Date:   Sat, 5 Dec 2020 15:52:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201204144000.21734-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/20 8:10 pm, Aditya Srivastava wrote:
> Currently, checkpatch.pl warns us for BAD_SIGN_OFF on the usage of
> non-standard signatures.
> 
> An evaluation on v4.13..v5.8 showed that out of 539 warnings due to
> non-standard signatures, 43 are due to the use of 'Co-authored-by'
> tag, which may seem correct, but is not standard.
> 
> The standard signature equivalent for 'Co-authored-by' is
> 'Co-developed-by'.
> 
> Provide a fix by suggesting users with this signature alternative and
> replacing.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> applies perfectly on the latest next-20201204 branch
> 
> changes in v2: replace commit specific example with brief evaluation
> 
> changes in v3: provide rationale to users for every signature tag suggestion;
> modify commit message describing arrival to conclusion in a structured way
> 
> changes in v4: modify rationale for certain suggestions
> 
> changes in v5: remove the tag deletion suggestions, ie "Generated-by" and "Celebrated-by"; rebase on last accepted changes; modify commit message
> 
> changes in v6: reduce tag suggestions to only "Co-authored-by"; modify commit message accordingly; include complete version changelog
> 
>  scripts/checkpatch.pl | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4a026926139f..fc036d545d2d 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2832,6 +2832,9 @@ sub process {
>  
>  			if ($sign_off !~ /$signature_tags/) {
>  				my $suggested_signature = find_standard_signature($sign_off);
> +				if ($sign_off =~ /co-authored-by:/i) {
> +					$suggested_signature = "Co-developed-by:";
> +				}
>  				if ($suggested_signature eq "") {
>  					WARN("BAD_SIGN_OFF",
>  					     "Non-standard signature: $sign_off\n" . $herecurr);
> 

Hi Daniel and Peter
Sorry to disturb you. Actually we were planning to introduce a fix for
suggesting users to use "Co-developed-by" tag over "Co-authored-by"
and I noticed that you have earlier used "Co-authored-by" tag.

We feel that users perhaps use this tag as they are unaware of its
standard equivalent tag, "Co-developed-by"

Do you think that this fix will be beneficial for future users? If so,
can you please add your Acked-by to the patch?

Thanks
Aditya
