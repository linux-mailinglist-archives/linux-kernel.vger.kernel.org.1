Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1542820CF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 05:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgJCDdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 23:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgJCDdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 23:33:24 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D08C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 20:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1w/xDELexyceMpnpX4cZ0ccxk3CfwvJUx3W6sTZcBLo=; b=ReeiCWFSbOimOWozQqvVs5lqoU
        UmotBNthSfWplEOU7T6i6dX2AszYskwxqhOfxfQrEMkTrnWL9X6VX/MGhGcv5dQhBkx5qLLAYfBvf
        MNiF1f25nPus88y8cSls1dUI9BW34fMXrBR3OUGB7HlKw9BaH/pdU3umSnljuW+72UlQfehTXFlRY
        5SX5Ok5dHldu67U1ftb8lMqGWWL2UhP/8DwDYLPeTVxDgtXOYRJq6kjg/ye3zPAUNlzQMzh3DgCVc
        L0MM7GNW0W03th44usHvQ0yAsG4cPVKkXLa2+bxh8ySW67V+RnYUKfQXnvPMrxSFImgPTb1lYKtQg
        UX1czmRA==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOYIO-0001NX-3q; Sat, 03 Oct 2020 03:33:16 +0000
Subject: Re: [PATCH 4/4] x86/cpu/topology: Implement the CPU type sysfs
 interface
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
        Kan Liang <kan.liang@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
 <20201003011745.7768-5-ricardo.neri-calderon@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <03d465a6-f49d-8b83-8fed-111e9eb6e5c5@infradead.org>
Date:   Fri, 2 Oct 2020 20:33:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201003011745.7768-5-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/20 6:17 PM, Ricardo Neri wrote:
> +u32 arch_get_cpu_type(int cpu)
> +{
> +	struct cpuinfo_x86 *c = &cpu_data(cpu);
> +
> +	if (cpu < 0 || cpu >= nr_cpu_ids)
> +		return 0;
> +
> +	return c->x86_cpu_type;> +}

Hi,

Consider using
#include <linux/nospec.h>
and array_index_nospec() to avoid speculation problems on cpu_data.

cheers.
-- 
~Randy

