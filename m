Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58ECB1B3F68
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 12:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbgDVKhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 06:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbgDVKWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:22:30 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A98C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=COB45WWRDeS7asdi6sxpOB/WK31k8Jvbwlrl67Enpy0=; b=cBLkiGcND8h4GA0sDS7ZVYb1YN
        6sujbKm/e/UDCXyaewTqnnpiHRzfl7ob/gXhhdqggFSXNDUfrFB7n55ax81jmTLAoOpuza07of73k
        PTkAbhNVA2bgj4qvkaQmX7lokSs+b6ogv7+g8So0KtbI4gOpQJ6E5IthIbY0YAP/Ugq+KdQhfVt/r
        59ir+JaHdCMVeqgI00S6V+fA7KGsKfirVAqCCjEudYtGsqi8uYG87B2f5ezHYp6ebGJOeBRZ/WGpW
        f9YkJM+7M44JrWVcU1U88TkvrktYeiylAQz0afONtjjpXnyNemhEb0+O+zYGUh5MwyPl5F1b7R4z2
        kB4NT0YQ==;
Received: from [2a01:79c:cebf:7fb0:d967:6cf9:736f:4613] (port=38820)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1jRCWS-0006OE-N7; Wed, 22 Apr 2020 12:22:28 +0200
Subject: Re: [BISECTED]: Kernel panic (was: Linux 5.7-rc2)
From:   Harald Arnesen <harald@skogtun.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiQsJu-ZFjt7+c9FVD5R40khtZiihrT+7O3UaVvHYz=HQ@mail.gmail.com>
 <428bac87-b6dd-0867-c8f8-622cd606de3e@skogtun.org>
 <CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com>
 <20200421212347.GV2483@worktop.programming.kicks-ass.net>
 <1587546150.9537.84.camel@suse.cz>
 <aec3c60e-2794-7eb2-eb11-ff2781223e90@skogtun.org>
Message-ID: <ecdc6ffa-0137-4ca0-3bdb-cf37178ba4ff@skogtun.org>
Date:   Wed, 22 Apr 2020 12:22:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <aec3c60e-2794-7eb2-eb11-ff2781223e90@skogtun.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Arnesen [22.04.2020 11:37]:

> Giovanni Gherdovich [22.04.2020 11:02]:
>> 
>> Harald:
>> 
>> I'll echo Linus' request of testing that the patch series linked above fixes
>> the problem on your machine. Since you're testing -rc kernels and bisecting
>> bugs I assume you're comfortable with patching and compiling kernels, but if
>> that is not the case I am more than happy to assist by providing either an RPM
>> or a DEB package, depending on the distribution you're running. Let me know.

> Will try patching first, if I'm not successful, you may compile a DEB
> package for me.

I can confirm that my Thinkpad T510i boots normally with the four
patches added.

Thanks!
-- 
Hilsen Harald

