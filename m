Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532D526F822
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgIRIZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIRIZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:25:39 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F4C061756
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:25:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y15so4637739wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Vb71Z+MeV1BEDkNlM7QEBZ8lUbZvMv2RGG1/ciWp3s=;
        b=NMen24lu7xsFny6okUL+QZrTCN5APJEnM4kjKeecEAYh4CKrDczNNN6KefQNHaFtNj
         wfA+oHE9JZrnc3ZUdtsaYCj6ltqwXoAe6Ah/bOmRp2Y9Atg42wse0M8CN4FHvpHD83ki
         nBIhD2GHL4zP1G6X887C4ns96r3A9OeRtMAekBQEo636IYRlG5WIj43HgDAJZDjkl392
         3v/eNVerWQqdWuhMK0ZVQ21lknGXZTaQu7QXzPv7GGun8kMBFbFHbCZMyzTiBE4r2ERt
         mTj3yAk5Pi4Vhh8qQS+i3G8UySCTaKbxcsNrc1pWa9DxIZJw86msrAGbDn3PTia8w+Td
         zWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+Vb71Z+MeV1BEDkNlM7QEBZ8lUbZvMv2RGG1/ciWp3s=;
        b=AjbD7jLzLz8valHUn2L1imduZ4nsadXZmGwuNwiujMhgRTWLmd2kxq/I4Je1Dz2STx
         pRxnej0LZ6tYTcjm5nGszFqJMMhDd7beLW5I9vfgPc7JA74n2pL8eaOPA1vtumvnLZ/R
         QzxpF5OA/2NbxvnyyXFXAnGhfdJDpFkhOkm5hISxQAaYelIyfFlQzWdK8S1dL6Iy7hCy
         rc2x3hmQygwbtRSQg5Dj96f8033dECaM/A151uacEpF7roNnDq1E4z/ImjkQ1NcKEriY
         QI6IRUN+DzmS1zRI9bClG4A9p7nSK6kpjCXkMfYvPIqYbLSK9w/em/V0qC2xdtWcPvUE
         nCoQ==
X-Gm-Message-State: AOAM532FCyTPHhBCwhBZYXmHFckglmQaNeNFz7j70QFfMcFqi0+KHKhg
        VEkzRDkkcdLM9ToTRTtT0IR/A2q+RBY0XA==
X-Google-Smtp-Source: ABdhPJx3zSN5zodtIZ2Ucr9zKfN0DMcq3R2MLvmG6dp8XJLTOROcz8W5z6y7C6lqy0728Uf3sAthjA==
X-Received: by 2002:a1c:4303:: with SMTP id q3mr14225477wma.158.1600417537841;
        Fri, 18 Sep 2020 01:25:37 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:410:bb00:8580:abba:1230:2936? ([2a01:e0a:410:bb00:8580:abba:1230:2936])
        by smtp.gmail.com with ESMTPSA id t124sm3965209wmg.31.2020.09.18.01.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 01:25:37 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: linux-next: Tree for Sep 17 (net/ipv4/devinet.c)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
References: <20200917202313.143f66f3@canb.auug.org.au>
 <0b592973-55d6-b318-ed38-1d5fbd706e7a@infradead.org>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <42a4f790-6175-2835-2022-cbfcbe1e5504@6wind.com>
Date:   Fri, 18 Sep 2020 10:25:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0b592973-55d6-b318-ed38-1d5fbd706e7a@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17/09/2020 à 22:45, Randy Dunlap a écrit :
> On 9/17/20 3:23 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20200916:
>>
> 
> 
> Maybe some older versions of gcc just can't handle IS_ENABLED() inside an
> if (expression) very well.
> 
>> gcc --version
> gcc (SUSE Linux) 7.5.0
I tried with a (very old) gcc and I did not reproduce this error:
$ gcc --version
gcc (Debian 4.9.2-10+deb8u2) 4.9.2


> 
> This patch:
> 
> commit 9efd6a3cecdde984d67e63d17fe6af53c7c50968
> Author: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Date:   Wed May 13 15:58:43 2020 +0200
> 
>     netns: enable to inherit devconf from current netns
> 
> causes a build error:
> 
> ../net/ipv4/devinet.c: In function ‘devinet_init_net’:
> ../net/ipv4/devinet.c:2672:7: error: ‘sysctl_devconf_inherit_init_net’ undeclared (first use in this function); did you mean ‘devinet_init_net’?
>        sysctl_devconf_inherit_init_net == 3) {
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        devinet_init_net
> ../net/ipv4/devinet.c:2672:7: note: each undeclared identifier is reported only
> 
> 
