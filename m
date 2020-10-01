Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8927F7FD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 04:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgJACaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 22:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgJACaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 22:30:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F49C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 19:30:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b17so1038302pji.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 19:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tlX3oNCWzR1oVsGNaEo8FF4pjDDLKV0813VAd4mxiWY=;
        b=Uv61jG6/KONhNXj/x/k20ve1Ug8quVbvZra5/QqbU7ILJyW6SJWIxTDJWwHQRu2+Uc
         B6mH1U7c3eArYDSM1TAv68c0pogsCgV3O8r3x8e2gT94mfxta4oIiU3m/EeCur+yMlZD
         LWVp77QcUbYtM4MYOTUaQqR8KIb/ZgSFF4U/Le+DdP9nEE4H6NROLlP5GT8ZvxQs0Ukn
         QlN7Uh4exBh/qghusj2scxNMbBK76ZtC3/7wdPd4+3ezmZbreI/U4w9iqRe6IhamXa5C
         8IytG3kVxoHNCxkoGuqDhtNEIeFlgT22umroSbce2ZaMkmnsQnceVrHqOOWt9BmxMBPz
         dWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tlX3oNCWzR1oVsGNaEo8FF4pjDDLKV0813VAd4mxiWY=;
        b=G/aASoA7jNDjxwLbrQj6ZSYqeJxdMZQqu7DCOUUvGGeucFE58kVf0/Js5HXw6kuUUi
         5q84zDHDIhcxMiItIm6ZNgionGDGPJqnLzz4X7Y46yPAJKDGEB+7Q271xtf3jdmiwfh1
         k57V9+GKF6rX4kTpfaDHWeiElx1Bdfk4ukN7ZVlPOuhQfQZmWMYvnVpNasnFj8YiRW7O
         2Yuq3kIKqUGiWfXCrhDO96p/RofZxbecaDe/+PreoeG/mT6XsZ5oxEvZVuZ2yaE9NRyX
         VfDT+l7QnLHA2yNtXOQOztQWZI8JJN4lPFBY3q12GmxwrosqFuwvaiHMcYNqsKNzRnK/
         kT3Q==
X-Gm-Message-State: AOAM531q7KaVdKM+3R8g8mHdLOUyG9htS4XP+jWsOIvp+sssi4Bqms/R
        C/oJMErzsM21g4GXccFGdX0NutyGhfUz5w==
X-Google-Smtp-Source: ABdhPJyAH0VxRrFXCMuhbr7LvSU8J/yGf7A9WJJh7S5RpOgQAvmIguYX9Gtj4jbzaYdFdflUn/YnYQ==
X-Received: by 2002:a17:90a:eb14:: with SMTP id j20mr2802914pjz.121.1601519444131;
        Wed, 30 Sep 2020 19:30:44 -0700 (PDT)
Received: from [10.230.29.112] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z9sm4134277pfk.118.2020.09.30.19.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 19:30:43 -0700 (PDT)
To:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
References: <20201001012810.4172-1-scott.branden@broadcom.com>
 <20201001012810.4172-13-scott.branden@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v5 12/15] misc: bcm-vk: add sysfs interface
Message-ID: <16725022-b967-deae-1223-f86a543f9f9d@gmail.com>
Date:   Wed, 30 Sep 2020 19:30:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201001012810.4172-13-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2020 6:28 PM, Scott Branden wrote:
> Add sysfs support to query the VK card status and monitor sense points.
> The vk-card-status and vk-card-mon details are provided in the README
> file in the bcm-vk driver directory.
> 
> Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
> Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---

[snip]

> +vk-card-status/
> +	bus			---> device PCIe bus
> +	card_state		---> summary of current card states
> +	chip_id
> +	firmware_status		---> summary of all firmware status
> +	firmware_version	---> summary of all firmware versions
> +	freq_core_mhz		---> running frequency in mHz
> +	freq_mem_mhz		---> memory frequency in mHz
> +	mem_size_mb		---> memory size in MByte
> +	os_state		---> current running state
> +	reset_reason		---> last reset reason
> +	rev_boot1		---> boot1 firmware revision
> +	rev_boot2		---> boot2 firmware revision
> +	rev_driver		---> host driver revision
> +	rev_flash_rom		---> Flash ROM revision
> +	sotp_boot1_rev_id	---> minimum boot1 revision required
> +	sotp_boot2_rev_id	---> minimum boot2 revision required
> +	sotp_dauth_1		---> authentication key hash
> +	sotp_dauth_1_valid	---> authentication key validity
> +	sotp_dauth_1_active_status -> authentication key active or not
> +	sotp_dauth_2
> +	sotp_dauth_2_valid
> +	sotp_dauth_2_active_status
> +	sotp_dauth_3
> +	sotp_dauth_3_valid
> +	sotp_dauth_3_active_status
> +	sotp_dauth_4
> +	sotp_dauth_4_valid
> +	sotp_dauth_4_active_status
> +	temp_threshold_lower_c	---> thermal low threshold in Celsius
> +	temp_threshold_upper_c	---> thermal high threshold in Celsius
> +	uptime_s		---> os up time in seconds
> +
> +vk-card-mon/
> +	alert_afbc_busy		---> AFBC block stuck
> +	alert_ecc		---> uncorrectable ECC error(s) occurred
> +	alert_ecc_warn		---> correctable ECC error(s) occurred
> +	alert_heartbeat_fail	---> host detects heartbeat discontinuation
> +				     from card
> +	alert_high_temp		---> high temperature threshold crossed
> +	alert_intf_ver_fail	---> interface not compatible based on version
> +	alert_low_temp_warn	---> low temperature threshold crossed
> +	alert_malloc_fail_warn	---> mem allocation failure(s) occurred
> +	alert_pcie_down		---> host detect pcie intf going down
> +	alert_ssim_busy		---> ssim block busy
> +	alert_sys_fault		---> system fault
> +	alert_wdog_timeout	---> watchdog timeout

Almost all of these should be supported using the HWMON framework 
instead of custom attributes that do not follow the HWMON naming 
conventions.

> +	firmware_status_reg
> +	mem_ecc			---> correctable ECC error count
> +	mem_uecc		---> uncorrectable ECC error count

Implementing an EDAC driver would be a bit overkill unless you have a 
way to signal ECC errors towards the host?

> +	boot_status_reg		---> boot status of card
> +	pwr_state		---> power state, 1-full, 2-reduced, 3-lowest
> +	temperature_sensor_1_c	---> CPU die temperature in Celsius
> +	temperature_sensor_2_c	---> DDR0 temperature in Celsius
> +	temperature_sensor_3_c	---> DDR1 temperature in Celsius

Likewise.

> +	utilization		---> runtime video transcoding consumption summary
> +	utilization_pix 	---> percentage of pixel processing used
> +	utilization_pix_used	---> pixel processing used
> +	utilization_pix_max	---> max pixel processing value which maps 100% load
> +	utilization_codec 	---> percentage of codec sessions used
> +	utilization_codec_used	---> codec sessions currently used
> +	utilization_codec_max	---> max codec sessions allowed
> +	voltage_18_mv		---> 1.8v voltage rail in mv
> +	voltage_33_mv		---> 3.3v voltage rail in mv

Likewise

> +
> +The sysfs entry supports only the read operation.

entries.
-- 
Florian
