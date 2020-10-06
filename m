Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68A42851F1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 20:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgJFSze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 14:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFSze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 14:55:34 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74866C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 11:55:32 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id n6so7712478ioc.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 11:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+gegT3jr0JpIPHN9fPy/d2hMI1DFSkCPHU++vHIOrVA=;
        b=RNh8SbUw+7rlwZi6Wal8Q05HR0JhcaMY8AwPD4iI2Lx6JuDo1DfdAZeTJ9uM/t/qUp
         NiQFxY99Pn9dFXayg/nwTqYg56u9DiEysgg75OecuvbBWzPnN6BbudU3Mv8o71p/Fxl/
         nyOGOQVkTjVQHpa3H8WetZibAT76AQ6+sINCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+gegT3jr0JpIPHN9fPy/d2hMI1DFSkCPHU++vHIOrVA=;
        b=q8vGQa3oox7bQyK8Ja7vWy1naElBiljYdkYKOqcYuzRhrdLxId845YPdJAh2/BqDxe
         tX1Lu3rg7v1StqEnCep6NeZzR/IWXuexf6+X2wosRrFf+E4SojOQX0ilpEJAVPmePh9w
         l/mEBlQw2T632qJF9PCtFYY3/eOPrfmkICFrOu3XD4X9oR6NlnfNHcBw6Tb/XZA6Xg7W
         py8NBM2YE0RB7VHaZCqFpvcOblbi3GOE2NsZlOJMjIyr9N+GmyQ/rgoE9JMZ3FXunN0p
         t+NJjbSGf0YWiNd8+kIBmv0EAhyH4mPrBGoVvsqVoD4pIZJwI3gJxYoIAlI2dBzHhPE2
         uv9w==
X-Gm-Message-State: AOAM532so7csvg1M9e39eIdojrXAa29PNjQrsSoQbZDEWPWgOjNM7DVG
        o17wxdEC/Mcw2SoRMiKZAot3lA==
X-Google-Smtp-Source: ABdhPJwiHn2gU73JMOdLyqSxKmO9BovLVSyyR1pKyy0Y09exobDZD0OE/79Y3AwMxY1Q3MEAvvAFwg==
X-Received: by 2002:a05:6638:2208:: with SMTP id l8mr2772200jas.22.1602010531789;
        Tue, 06 Oct 2020 11:55:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t14sm2029565ilj.45.2020.10.06.11.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 11:55:31 -0700 (PDT)
Subject: Re: linux-next: manual merge of the akpm tree with the
 kselftest-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joe Perches <joe@perches.com>, John Hubbard <jhubbard@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201006220711.0ec49da3@canb.auug.org.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ebb15a68-0bef-ecb7-c323-2358f72ee183@linuxfoundation.org>
Date:   Tue, 6 Oct 2020 12:55:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201006220711.0ec49da3@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/20 5:07 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the akpm tree got a conflict in:
> 
>    tools/testing/selftests/vm/gup_test.c
> 
> between commit:
> 
>    aa803771a80a ("tools: Avoid comma separated statements")
> 
> from the kselftest-fixes tree and commit:
> 
>    5c64830675a6 ("mm/gup_benchmark: rename to mm/gup_test")
> 
> from the akpm tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Hi Stephen,

Thanks for fixing it. I will mention it in my pull request to Linus

thanks,
-- Shuah
