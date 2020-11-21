Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EAF2BBCAD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 04:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgKUDcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 22:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKUDcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 22:32:05 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D77C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=TpVpQQfZRxzUgrkLaW1LRIBqXiIdLLw8aooTmtrs9Fc=; b=oZejvN00kyZFbSTskSGk6TDJj6
        sPhi7xULrvjxk8UElbyKpMAE6PWz0Ct9S8/f4c6ip7EnTy2rKwvjFl/8LaovdnFlyZflmbCBwyIHr
        C6WRa1nWoDDMFHho56wqxCeoI1Jiu9bK1OjmaVEXSIulJHcVmT1A2VycZJYwjACM4OtVoZd8aoDtc
        ZpFnSzF6WzaCYemZsqwo7XIxRfbPp0sB/43Lr8by3fujT2IlxoAp1K2dOg0duYqlDBUGvPmtCWctJ
        q/7wLL46heQdZh+3xNKjM4CgoilOOUurl1xXM+uRimVxCbCvFSV8uxhV304kKlV3Rljpx42u2I7rL
        Op0Qq58g==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kgJcz-0001wa-VZ; Sat, 21 Nov 2020 03:31:58 +0000
Subject: Re: [PATCH v3 4/4] Documentation/admin-guide: Change doc for
 split_lock_detect parameter
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
References: <20201121023624.3604415-1-fenghua.yu@intel.com>
 <20201121023624.3604415-5-fenghua.yu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d90ce156-5c44-e0b2-276e-a818ce99317f@infradead.org>
Date:   Fri, 20 Nov 2020 19:31:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201121023624.3604415-5-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 11/20/20 6:36 PM, Fenghua Yu wrote:
> +			ratelimit:N -
> +				  Set rate limit to N bus locks per second
> +				  for bus lock detection. 0 < N <= HZ/2 and
> +				  N is approximate. Only applied to non-root
> +				  users.

Sorry, but I don't know what this means. I think it's the "and N is appropriate"
that is confusing me.

	0 < N <= HZ/2 and N is appropriate.

-- 
~Randy

