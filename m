Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0BB289E13
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 05:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbgJJDvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 23:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbgJJDkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 23:40:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB28C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 20:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=wix0OR8IOfPgSne8A99eWONXUDggFI/kUCZD+8EgRMw=; b=qkRhSrZTa/NwMUwIqh3XeSDfTj
        3nGzzbuex3jPg54qibCknHX7pcxOjodP6seN5QL1lBF078fBDKHpwymDLA7gDNceGyd6aGCvWiwKE
        CtmX2uZRqUiewz8gCkhIcxKxiXa6yB++/jnFy8CJQU/h+6qQrbGsjBHvBPrnlo0iFNAzdRyXPsa2q
        tB6BWQvda0y5DgrF2/pcQUyEVEPTLcGL2wqYG8pvVMKyY2ZKadyvRjbfKrMT2vnBv4fWrh9AjJvak
        QRWbEj174ex8sJ1XgFgp2QZvzITO8Li9DvQO0GI5a/NSSHPyV3wpX2Z5Tgwd02d/xKTsvELRMvgao
        TFb4oC8w==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kR5LT-0002U7-LI; Sat, 10 Oct 2020 03:14:56 +0000
Subject: Re: [PATCH 1/4] drivers core: Introduce CPU type sysfs interface
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
 <20201003011745.7768-2-ricardo.neri-calderon@linux.intel.com>
 <de7b5aa2-9866-c93e-0f1b-4ffff82d2f1e@infradead.org>
 <20201006011550.GG6041@ranerica-svr.sc.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <011d6f26-0a8c-a726-a81c-cd18df43c366@infradead.org>
Date:   Fri, 9 Oct 2020 20:14:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201006011550.GG6041@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/20 6:15 PM, Ricardo Neri wrote:
> On Fri, Oct 02, 2020 at 08:27:41PM -0700, Randy Dunlap wrote:
>> On 10/2/20 6:17 PM, Ricardo Neri wrote:
>>> +/**
>>> + * arch_get_cpu_type() - Get the CPU type number
>>> + * @cpu:	Index of the CPU of which the index is needed
>>> + *
>>> + * Get the CPU type number of @cpu, a non-zero unsigned 32-bit number that
> 
> Thank you for your feedback Randy!
> 
>> Are you sure that @cpu is non-zero?
> 
> This is the intent. Maybe it can be reworked to return -EINVAL instead?
> I gues it is plausible but less likely that an arch defines a type as
> 0xffffffea;

You lost me here.

>>
>>> + * uniquely identifies a type of CPU micro-architecture. All CPUs of the same
>>> + * type have the same type number. Type numbers are defined by each CPU
>>> + * architecture.
>>> + */
>>> +u32 __weak arch_get_cpu_type(int cpu)
>>> +{
>>> +	return 0;
>>> +}
>>
>> arch_get_cpu_type() in patch 4/4 allows @cpu to be 0.
> 
> It should not return 0 if the system does not have
> X86_FEATURE_HYBRID_CPU. The currently existing CPU types are all
> non-zero as per the Intel SDM. Am I missing anything?

@cpu is a cpu index, not a cpu type.

-- 
~Randy

