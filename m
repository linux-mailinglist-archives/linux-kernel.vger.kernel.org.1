Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8BB294817
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 08:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408716AbgJUGWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 02:22:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39113 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408696AbgJUGWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 02:22:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id t21so1353989eds.6;
        Tue, 20 Oct 2020 23:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KK0puVMylKVFsz5Ij2GE7BsLqagR7c/6Vy0xC2TGpG0=;
        b=asJIKksmwn0jI5iEpl5/z3mvnPDC9BCC2S8YMU4ihFvBEi8eWBVDMqXxeYWnIQUzSU
         akez2B2unHbkMH/bDcAzft/cHGkSZHr02nBpV9zCpkYdXt+WPqs8Vo6DbY2FXKdQ+gw5
         R/m/cZ9RFW9GslwH8qkZoOxPLtP2fUch9vJFi+XL1N+ngKsFiEPsSuxT4PiWeORHJpPk
         9hN/CpP3/X4tie3zMEn/s5/HPAbrFwC88abF/cETyGrw9qiGdx9WgJA1J2THmy35ZhDW
         qADmCrEpRmA8oYS5Zi7BJ8xr6KKuGSIiUlR/1/KJG0LhoMBsEWb5QQ1NWOfImQ7dP7xd
         SK4g==
X-Gm-Message-State: AOAM5330NZ5lObOSTxNTEemR9s7fjvRcnzNGvu2LuXRSYuWX/ihXz0VI
        5TWivphjXp7Ud72AcR5S25GP/1uQ0vU=
X-Google-Smtp-Source: ABdhPJxlUnn8a6oyuaMRlV0coVtB13jakU2hgR+Y2a5ysNTvNh/6mbDi2LniGdEfPIOCUSxmH1lrYQ==
X-Received: by 2002:a50:ef0e:: with SMTP id m14mr1537840eds.5.1603261362691;
        Tue, 20 Oct 2020 23:22:42 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id t15sm1352835edr.27.2020.10.20.23.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 23:22:41 -0700 (PDT)
Subject: Re: Segfault in pahole 1.18 when building kernel 5.9.1 for arm64
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     =?UTF-8?Q?=c3=89rico_Rolim?= <erico.erc@gmail.com>,
        dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Hao Luo <haoluo@google.com>, Andrii Nakryiko <andriin@fb.com>
References: <CAFDeuWM7D-Upi84-JovKa3g8Y_4fjv65jND3--e9u-tER3WmVA@mail.gmail.com>
 <82b757bb-1f49-ab02-2f4b-89577d56fec9@kernel.org>
 <20201020122015.GH2294271@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <f7246cb6-901e-0bc3-eb18-194d1754da53@kernel.org>
Date:   Wed, 21 Oct 2020 08:22:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020122015.GH2294271@kernel.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 10. 20, 14:20, Arnaldo Carvalho de Melo wrote:
>> Yeah, I observe the very same. I reported it at:
>> https://bugzilla.suse.com/show_bug.cgi?id=1177921
> 
> Would it be possible to try with
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=tmp.libbtf_encoder
> ?

Yes, that branch fixes the crashes and the kernel build finishes. The 
zero-sized symbol error remains.

So what should distributions do now -- should we switch to a pahole 
snapshot for a while?

thanks,
-- 
js
