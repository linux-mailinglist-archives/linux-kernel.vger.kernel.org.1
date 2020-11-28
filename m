Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAAE2C720F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbgK1Vuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733311AbgK1SSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:18:18 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F58DC0254B5;
        Sat, 28 Nov 2020 08:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=3Noat+yyK6D08TvzV/W7gvzzSdlFSLHu5xt9LycWN3E=; b=fPfWrljI0oWmXaKdMSjVP21uos
        QMvZUiAe0aSYKKY6k+NIJ9rSZUE3cTagJ6S/SyMghCIhm3RI13nGca9vRrxEkiV47kRZlcoVVwF2I
        BbsF37hvIdwSery8ikXSRVMpvwELfZzrzKMKQRCFiO1tYW5nTqXMBMvZ3Lb86XRxHZFbrUOc0DdmW
        eudwOqPbjemOxLB2q2GQWGpc0UDoNHEt7dWObCDJJmtl/tW70my3aVZ4e96APukIehPSB0fXUKM47
        V9zy06enjSWi6auAt1JRn/k8avvFldQ5IHdn+maau5+Zr8ZBwBx0iZEtA9CCLBXGzfEkUQ+JE1p35
        I5CrtOVQ==;
Received: from [2601:1c0:6280:3f0::cc1f]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kj3ZT-0005f2-J2; Sat, 28 Nov 2020 16:59:39 +0000
Subject: Re: [PATCH v2 5/5] x86/platform/uv: Update sysfs document file
To:     Mike Travis <mike.travis@hpe.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Mark Gross <mgross@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20201128034227.120869-1-mike.travis@hpe.com>
 <20201128034227.120869-6-mike.travis@hpe.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b28fbb49-6b25-97d6-7e33-7f5e2ced9699@infradead.org>
Date:   Sat, 28 Nov 2020 08:59:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128034227.120869-6-mike.travis@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/20 7:42 PM, Mike Travis wrote:
> Update sysfs Document file to include moved /proc leaves.
> 
> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> ---
>  Documentation/ABI/testing/sysfs-firmware-sgi_uv | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-firmware-sgi_uv b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
> index 50e25ce80fa2..b377f1470ba2 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv
> +++ b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
> @@ -7,10 +7,25 @@ Description:
>  
>  		Under that directory are a number of read-only attributes:
>  
> +			archtype
> +			hub_type
> +			hubless
>  			partition_id
>  			coherence_id
>  			uv_type
>  
> +		The archtype entry contains the UV architecture type that
> +		is used to select arch-dependent addresses and features.
> +		If can be set via the OEM_ID in the ACPI MADT table or by

		It

> +		UVsystab entry both passed from UV BIOS.
> +


thanks.
-- 
~Randy

