Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA552820C8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 05:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgJCD15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 23:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgJCD15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 23:27:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B59CC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 20:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=QQSZoOnloLMD7/ZhvOjy+/MmtuG47S2C6q8QYmBfaLg=; b=VcshOLvwQUeuRpKaTWGm+Y8U+2
        GRyNs41czvUF8AZ+KMGn6OYdMKpAkL4xDTfHCc5jZd1CuaGmGbOdFIg9mRr4tW8Tiwvpab8i4oeRF
        WIAZphlvKmRzjuWSvAvl7BB5Bz2JKcJsWT/j/hojTdMro6nEHkgMgvJQIUXIXRV7rKTdLTRNvTAZH
        cuxUqeAV7TTvCfNZp3XCzoRgtSTfCzrevvewoIMbGerSRSV6m/pKRYyTmW/eGryGPa52L7eWUOgFn
        OOLN+9peMY/pWJEn6gLx3C1TYQo/vBRdNGBF8DSa8A6m3UcspAJVbfnWBOuS+jwMd/l3cVhhO4SxD
        nfhT8bQg==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOYD7-000129-6I; Sat, 03 Oct 2020 03:27:49 +0000
Subject: Re: [PATCH 1/4] drivers core: Introduce CPU type sysfs interface
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
 <20201003011745.7768-2-ricardo.neri-calderon@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <de7b5aa2-9866-c93e-0f1b-4ffff82d2f1e@infradead.org>
Date:   Fri, 2 Oct 2020 20:27:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201003011745.7768-2-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/20 6:17 PM, Ricardo Neri wrote:
> +/**
> + * arch_get_cpu_type() - Get the CPU type number
> + * @cpu:	Index of the CPU of which the index is needed
> + *
> + * Get the CPU type number of @cpu, a non-zero unsigned 32-bit number that

Are you sure that @cpu is non-zero?


> + * uniquely identifies a type of CPU micro-architecture. All CPUs of the same
> + * type have the same type number. Type numbers are defined by each CPU
> + * architecture.
> + */
> +u32 __weak arch_get_cpu_type(int cpu)
> +{
> +	return 0;
> +}

arch_get_cpu_type() in patch 4/4 allows @cpu to be 0.


-- 
~Randy

