Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFDB283D2A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgJERQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgJERQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:16:15 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E614207EA;
        Mon,  5 Oct 2020 17:16:11 +0000 (UTC)
Date:   Mon, 5 Oct 2020 18:16:08 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     will@kernel.org, james.morse@arm.com, tglx@linutronix.de,
        mingo@redhat.com, dyoung@redhat.com, bhe@redhat.com,
        corbet@lwn.net, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, bhsharma@redhat.com, horms@verge.net.au,
        robh+dt@kernel.org, arnd@arndb.de, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v12 6/9] arm64: kdump: reimplement crashkernel=X
Message-ID: <20201005171608.GC14576@gaia>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-7-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907134745.25732-7-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 09:47:42PM +0800, Chen Zhou wrote:
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 53acbeca4f57..1b24072f2bae 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -238,7 +238,18 @@ static void __init request_standard_resources(void)
>  		    kernel_data.end <= res->end)
>  			request_resource(res, &kernel_data);
>  #ifdef CONFIG_KEXEC_CORE
> -		/* Userspace will find "Crash kernel" region in /proc/iomem. */
> +		/*
> +		 * Userspace will find "Crash kernel" or "Crash kernel (low)"
> +		 * region in /proc/iomem.
> +		 * In order to distinct from the high region and make no effect
> +		 * to the use of existing kexec-tools, rename the low region as
> +		 * "Crash kernel (low)".
> +		 */
> +		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
> +				crashk_low_res.end <= res->end) {
> +			crashk_low_res.name = "Crash kernel (low)";
> +			request_resource(res, &crashk_low_res);
> +		}

With the changes in this series (including the above), how do the
current kexec-tools behave? Do they pick just the high region and the
loaded kernel will subsequently fail to boot?

-- 
Catalin
