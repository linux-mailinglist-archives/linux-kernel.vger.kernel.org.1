Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0ACC2D3199
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 19:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbgLHR71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgLHR70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:59:26 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44034C061749;
        Tue,  8 Dec 2020 09:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=xpPrMtRvHw9uqYWab0h0BufwacaQTlL6o1POPE2Agm0=; b=ujqn2sNEqBW65hdKJbVwhyiG1I
        q4h6IPSVJMUPyS8qmJfMk3lQTvdUQ/axMqLnNICqsLCh3A0jm7G1ifHG9cR3Fnsh0HhGPojPvl39k
        VEoEAIS6jB/Ik5kgCUOspdU6i/lw2M5sWEvMVtApWv4YoTC/HjtWgLGR/T7UP/Z5x9swPOVQSnCOd
        a+DFbupqke6wOcA6HjN+2ufyF2MqIkGP4Ic6ZhPUpaR5lDQyWUgKCtjp1wSLWZPOyDicUUYPwel6B
        0kjRicsFxiqa7Rqrhr3nGXAB2PfMNCXELi13TMqybrAjLsIQr0JG9/IXRhxNOrWJn1DfcfSv+aOJm
        x18Tfs8g==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmhG3-0007v4-7W; Tue, 08 Dec 2020 17:58:39 +0000
Subject: Re: [PATCH] Update documentation to reflect what
 TAINT_CPU_OUT_OF_SPEC means nowadays
To:     Jonathan Corbet <corbet@lwn.net>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>
Cc:     Borislav Petkov <bp@alien8.de>, Stephen Kitt <steve@sk2.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Eric Biggers <ebiggers@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Naoki Hayama <naoki.hayama@lineo.co.jp>,
        Yue Hu <huyue2@yulong.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201202153244.709752-1-me@mathieu.digital>
 <20201208105439.23e2349b@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1254edd7-25ee-b73d-da2c-194d38ba7890@infradead.org>
Date:   Tue, 8 Dec 2020 09:58:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201208105439.23e2349b@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/20 9:54 AM, Jonathan Corbet wrote:
> On Wed,  2 Dec 2020 16:32:43 +0100
> Mathieu Chouquet-Stringer <me@mathieu.digital> wrote:
> 
>> 	Hello Jonathan,
>>
>> Here's a patch updating the meaning of TAINT_CPU_OUT_OF_SPEC after
>> Borislav introduced changes in a7e1f67ed29f and upcoming patches in tip.
>>
>> TAINT_CPU_OUT_OF_SPEC now means a bit more what it implies as the
>> flag isn't set just because of a CPU misconfiguration or mismatch.
>> Historically it was for SMP kernel oops on an officially SMP incapable
>> processor but now it also covers CPUs whose MSRs have been incorrectly
>> poked at from userspace, drivers being used on non supported
>> architectures, broken firmware, mismatched CPUs, ...
>>
>> Update documentation and script to reflect that.
>>
>> Signed-off-by: Mathieu Chouquet-Stringer <me@mathieu.digital>
> 
> Hearing no objection, I've applied this.


Hm, I was glad to read this new info since my old testing laptop
now tells me that it needs a microcode update.  :(


-- 
~Randy

