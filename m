Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142222CC617
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389622AbgLBTAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388020AbgLBTAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:00:02 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378ADC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ii8aM0LMzKxzxgsDAhR5PajlMKVf1niS58psjZ+4G54=; b=j7LBQypVu4kxO/jXTS6bRSp9i+
        BE54y/VoaZK9AcvSwrhZluKt8cSLTHaTYJQWENOf0PFbGplCGlaeWweNrwcS6his0GT6c1FwyiW5h
        njZjfHB45eqBfYSNELBx3jFQM3BJEbvoGcKP3QlxoprHGEmLIHmygFBADhOFHZoF+XvE7gdp9cUKf
        M7tFtXVdpc5zBKghh7KMK+n3wVDXmEiTONBToUXVE7AYH8Ui8edkiFpmrurL0MI9w2myAcBh3gMp+
        ON4SYvo+uLfxp9I5VC2gl9ljjLPS7sts3YqB4ZV5noPZxl4rVt0c22mKjDlXgyX2nw6YPna2eTCvp
        TdeIy8Sw==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkXLO-0007ag-Mf; Wed, 02 Dec 2020 18:59:15 +0000
Subject: Re: [RFC PATCH] checkpatch: correctly detect lines of help text
To:     Joe Perches <joe@perches.com>,
        Nicolai Fischer <nicolai.fischer@fau.de>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
References: <133ac827-c0d2-c5c7-39d8-7d2c17de7c76@fau.de>
 <8436bc4191d92af283ea6aa7ca450e36da653e2e.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <16f0bfd4-61ca-48d8-c9ab-10bfc9a233ad@infradead.org>
Date:   Wed, 2 Dec 2020 10:59:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <8436bc4191d92af283ea6aa7ca450e36da653e2e.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/20 10:54 AM, Joe Perches wrote:
> On Wed, 2020-12-02 at 19:27 +0100, Nicolai Fischer wrote:
>> Currently, checkpatch uses keywords to determine the end
>> of a Kconfig help message which leads to false positives:
>>

> 
> I believe all the '---help---' lines have been converted to just 'help'
> so the '(?:---)?' bits here could be removed.

Yes.

> See:
> 
> commit 22a4ac026c15eba961883ed8466cb341e0447de1
> Author: Masahiro Yamada <masahiroy@kernel.org>
> Date:   Wed Jun 17 12:02:20 2020 +0900
> 
>     Revert "checkpatch: kconfig: prefer 'help' over '---help---'"
>     
>     This reverts commit 84af7a6194e493fae312a2b7fa5a3b51f76d9282.
>     
>     The conversion is done.
>     
>     Cc: Ulf Magnusson <ulfalizer@gmail.com>
>     Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> 
[]
> 
> Indentation can vary in the help blocks.  For instance:
> 
> arch/Kconfig:   help
> arch/Kconfig-     Functions will have the stack-protector canary logic added in>
> arch/Kconfig-     of the following conditions:
> arch/Kconfig-
> arch/Kconfig-     - local variable's address used as part of the right hand sid>
> arch/Kconfig-       assignment or function argument
> arch/Kconfig-     - local variable is an array (or union containing an array),
> arch/Kconfig-       regardless of array type or length
> arch/Kconfig-     - uses register local variables
> arch/Kconfig-
> 
> This doesn't allow blank lines for multi-paragraph help text either.
> 
> I think keyword parsing is necessary and some false positives are
> inevitable as the parsing logic in a line-by-line analyzer will
> always be incomplete.


There are also large hunks of block/Kconfig and drivers/hid/Kconfig
that don't use any indentation for help text...
in case that matters here.


-- 
~Randy

