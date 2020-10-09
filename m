Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D91728801B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 03:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgJIBtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 21:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgJIBtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 21:49:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF20C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 18:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=0z/3OP5iSJKJe4fPI5FMWeX6cDGvv0QTvMpDrz8u4OI=; b=HGejekAEO6Em8Dev2FtfZZK9mU
        mZDRIHSyyi3Q6ksDBFVDeySN8A+KcJLLzVQhNi7r6sHspOS3vwFPWDhlsniznQPW7uzhKsB5yvZJO
        MgBiYFjlcuIsbaRhLjRhEhA32zdOtjxv4bTaiuouWengP9EaVg8ST2WkudQdFEzPhA4+8CVGesqhH
        VspiT5IPKqGoHnT5DtkSFEeI+GBO9Xlj1l4hTTViX4Na2ECGSVxV63lyhnBgfHoeVY0jmyIxjonuS
        Y8VoaQZ0ze7pHkD5HNPYr4JRTffEKjWUI2TjQ9Ddi5WcyB4tchGc1QN7eAQ0W5nlsF2zKjdVf2Dt5
        AbxhuxXA==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQhWl-0007E5-AD; Fri, 09 Oct 2020 01:48:59 +0000
Subject: Re: [PATCH v4 01/17] docs: acrn: Introduce ACRN
To:     shuo.a.liu@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-2-shuo.a.liu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <08a5b43f-e75a-12ca-642b-133fef3606ba@infradead.org>
Date:   Thu, 8 Oct 2020 18:48:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200922114311.38804-2-shuo.a.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/20 4:42 AM, shuo.a.liu@intel.com wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> Add documentation on the following aspects of ACRN:
> 
>   1) A brief introduction on the architecture of ACRN.
>   2) I/O request handling in ACRN.
> 
> To learn more about ACRN, please go to ACRN project website
> https://projectacrn.org, or the documentation page
> https://projectacrn.github.io/.
> 
> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Sen Christopherson <sean.j.christopherson@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Fengwei Yin <fengwei.yin@intel.com>
> Cc: Zhi Wang <zhi.a.wang@intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: Yu Wang <yu1.wang@intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/virt/acrn/index.rst        | 11 +++
>  Documentation/virt/acrn/introduction.rst | 40 ++++++++++
>  Documentation/virt/acrn/io-request.rst   | 97 ++++++++++++++++++++++++
>  Documentation/virt/index.rst             |  1 +
>  MAINTAINERS                              |  7 ++
>  5 files changed, 156 insertions(+)
>  create mode 100644 Documentation/virt/acrn/index.rst
>  create mode 100644 Documentation/virt/acrn/introduction.rst
>  create mode 100644 Documentation/virt/acrn/io-request.rst
> 

> diff --git a/Documentation/virt/acrn/io-request.rst b/Documentation/virt/acrn/io-request.rst
> new file mode 100644
> index 000000000000..019dc5978f7c
> --- /dev/null
> +++ b/Documentation/virt/acrn/io-request.rst
> @@ -0,0 +1,97 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +I/O request handling
> +====================
> +
> +An I/O request of a User VM, which is constructed by the hypervisor, is
> +distributed by the ACRN Hypervisor Service Module to an I/O client
> +corresponding to the address range of the I/O request. Details of I/O request
> +handling are described in the following sections.
> +
> +1. I/O request
> +--------------
> +

...

> +
> +2. I/O clients
> +--------------
> +

...

> +
> +3. I/O request state transition
> +-------------------------------
> +
> +The state transitions of a ACRN I/O request are as follows.

                         of an ACRN

> +
> +::
> +
> +   FREE -> PENDING -> PROCESSING -> COMPLETE -> FREE -> ...
> +
> +- FREE: this I/O request slot is empty
> +- PENDING: a valid I/O request is pending in this slot
> +- PROCESSING: the I/O request is being processed
> +- COMPLETE: the I/O request has been processed
> +
> +An I/O request in COMPLETE or FREE state is owned by the hypervisor. HSM and
> +ACRN userspace are in charge of processing the others.
> +
> +4. Processing flow of I/O requests
> +-------------------------------
> +

...



thanks.
-- 
~Randy

