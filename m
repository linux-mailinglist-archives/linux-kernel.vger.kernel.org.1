Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6BA2A9985
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgKFQfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKFQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:35:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0436C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 08:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Mi++7Ijnb42KHECfpuYc1VsulMmGQUxbO+n52hSpq8A=; b=pAvxqmxyFd8d0pUQChyFBiNVl/
        uiTTqaYyK4vNkBeECF4108Oi4J8DSFjKemQ1oqxZCueGYNcM9FfsbSocDNxIg4dv4b8zQsf5/tW8b
        8ucn1rtOBNtIFJkbxNPUdOCv+lO5v/1RhXgD4xF85F4UOcllXbRnvdiD1Knf5KJNbICLaYHWA9FF8
        svhDWRFx92VjJnKQX4fjz+yAFI9sd65IWP4ruve5cdCv065oNDvPwM2hZRR1qnFH5AZBqITzFbDOO
        6ORx3e9hw0CcT3IHzFtFseGyeQL8hqZfOMjpuYtKFKkHg1/uXNAk9FrIqiB51BtIS+d9+IFjCM2mm
        LYGKaDJA==;
Received: from [2601:1c0:6280:3f0::a1cb]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb4hj-0006X5-OG; Fri, 06 Nov 2020 16:35:12 +0000
Subject: Re: [PATCH v6 00/25] Make charlcd device independent
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Lars Poeschel <poeschel@lemonage.de>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201103095828.515831-1-poeschel@lemonage.de>
 <CANiq72mDG8YJLcpKuE+noUQY5B9K6Cc71ado_dyLFVVf_xzKwA@mail.gmail.com>
 <20201106101135.xesjdqg2z3hgpqnv@lem-wkst-02.lemonage>
 <CANiq72niN_gB7Nq_+Vnf9CrBhFZF0_cew-kdj=rAURJ0DWJxnQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <76f9cd1b-3ace-e8a8-aaee-8d64e0900603@infradead.org>
Date:   Fri, 6 Nov 2020 08:35:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CANiq72niN_gB7Nq_+Vnf9CrBhFZF0_cew-kdj=rAURJ0DWJxnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/20 4:17 AM, Miguel Ojeda wrote:
> On Fri, Nov 6, 2020 at 11:11 AM Lars Poeschel <poeschel@lemonage.de> wrote:
>>
>> I got an email [1] with a report about a build failure in
>> hd44780_common. The fix is simple but I don't know the process from here
>> on. Should I post a v7 of the whole patchset or only a follow-up patch
>> for the fix ?
> 
> Either would work (I can rebase it on my side). However, in order to
> give credit to Randy, if the fix is integrated into a previous patch,
> then I am not sure where we would put the Reported-by.
> 
> Randy, what people usually do for your reports on -next (or what do you prefer)?

Hi Miguel,

I'm not sure that I understand the question...

Include
Reported-by: Randy Dunlap <rdunlap@infradead.org>
if possible. If not, then don't. It's not a big deal.

Integrate the fix from Lars in whatever way works for you.

cheers. :)

-- 
~Randy
