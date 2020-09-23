Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0569F275E61
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIWRLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgIWRLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:11:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E05C0613CE;
        Wed, 23 Sep 2020 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/wg4KjHuOTSDBwAr2JJlkUIkqB1lMyu0EEjvzUkym+4=; b=VyyuzdhTMRXCleLRew6SMTvbZH
        ayXizb78zAWewxNPZyTYPcJxceJDv/FZg0Bo0Wfb7ua1AwSahWxzrSTarpRSexEZP0fQlQcp4rkyn
        BbrJVMEOXrdROe1nPTaqgGNC1z5mPp84WSq8wqB9Wm8OPDdxSlk2JixfkytgGr19+5XwQ2pSQbGxY
        BDnAvXJ9VeSd3NWFGuvRx2lFR6muIqYcThe4uCDLvne9bAeh07QFyGTvMMbZL36ZdTwff0AZ9LN3x
        nz8R4HCzXann+1f7nNzaFWzer12eZRgOuAnYsUJR2iJF9chxsNZiv2dRdDbA7PYzU1KGyH+6ZFH4g
        W5P6JapA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kL8Iq-0006la-Vn; Wed, 23 Sep 2020 17:11:38 +0000
Subject: Re: [PATCH v4] Introduce support for Systems Management Driver over
 WMI for Dell Systems
To:     Divya Bharathi <divya27392@gmail.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Divya Bharathi <divya.bharathi@dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Prasanth KSR <prasanth.ksr@dell.com>
References: <20200923113015.110980-1-divya.bharathi@dell.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9b015765-de6f-3b2a-8804-e23864eb8806@infradead.org>
Date:   Wed, 23 Sep 2020 10:11:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923113015.110980-1-divya.bharathi@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/23/20 4:30 AM, Divya Bharathi wrote:
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 40219bba6801..4fd7a3f0a904 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -430,6 +430,18 @@ config DELL_WMI
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called dell-wmi.
>  
> +config DELL_WMI_SYSMAN
> +	tristate "Dell WMI Systems management WMI driver"

Could you drop one of those "WMI" strings or are both of them needed?

> +	depends on ACPI_WMI
> +	depends on DMI
> +	select NLS
> +	help
> +	  This driver allows changing BIOS settings on many Dell machines from
> +	  2018 and newer without the use of any additional software.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called dell-wmi-sysman.

thanks.
-- 
~Randy

