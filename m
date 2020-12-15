Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F96C2DAD7E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgLOMuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:50:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728651AbgLOMu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608036540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HfnEmXVCvWEtNGidGU85iErTRrcxXd3EOjRoy0dunP0=;
        b=AcwqnQlnCqlmyVA7/UbjgxHToOMXuzuW1ux5/9C2uWYTAH8T8QAr7Rs9hI4v4LuzSpKPIH
        wHkYp8TxIhIulqKdTVCjmxerq9EHcju/PT2B0+JYUHWCv8RCOC+hhZK5g9rwDfeU+4hHpc
        coaUcYq8UTutgN8l3G6HUDEch5UOkLE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-FFV-XyNFNGKoB-HkoPqjtw-1; Tue, 15 Dec 2020 07:48:54 -0500
X-MC-Unique: FFV-XyNFNGKoB-HkoPqjtw-1
Received: by mail-ed1-f70.google.com with SMTP id p17so9933809edx.22
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HfnEmXVCvWEtNGidGU85iErTRrcxXd3EOjRoy0dunP0=;
        b=PFuDoeTswJ9Q2hNMGRaAlph2zNmIeCmROwAYN8ftLeTD0vNzUQUZ4qtf/l+6gpd4lk
         S6AoUqpZMA+8WFZRgSiVC75JYhqQh3HIXOhtghlr8RhVhYEwNBZo1xUxRBHgOGcCazFK
         cOLBjTehwKk6K+7eovfLNXtPIUof1Q1QqPBekfAeTSW5wvI77vCWbtA56sLMVkE9KNSV
         KfrgurcXZ2urpXvH6kzI+pPuNH1uAegzjcgDLHAs8ABD5pvqhCQ/aKpxCuH72+r9nrfD
         3Xxdjxo2Ri1sJub91nmWt8myz9VwKN0F0namMuw48A/B4ZPIy0GnunnsyDuacgWzpy6i
         cjJg==
X-Gm-Message-State: AOAM531z9vNFMbTcqHAgLbOQwgVqwewMFUkArnorxfyQ6zHvA+1ac5sr
        kQeZ2tEIpGqrgMMz9LE+88oR04GGnNqZsRpqlCXiiCfepU1aUu95EqWCM4brGqNdvJiwG0PEMh4
        ZlUd7bx3bhdDOODVkD1GVw2tH
X-Received: by 2002:a50:8b61:: with SMTP id l88mr29871069edl.250.1608036533764;
        Tue, 15 Dec 2020 04:48:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNkkewQL6MyNw6bD9dkbMNy4qt9EM3bJFOkpnJdelAtOE8uSiyRs8eJKAZQoMwet3SB4vPpg==
X-Received: by 2002:a50:8b61:: with SMTP id l88mr29871042edl.250.1608036533499;
        Tue, 15 Dec 2020 04:48:53 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id q25sm18272780eds.85.2020.12.15.04.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 04:48:52 -0800 (PST)
Subject: Re: [PATCH v5 2/4] e1000e: bump up timeout to wait when ME
 un-configures ULP mode
To:     Mario Limonciello <mario.limonciello@dell.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        intel-wired-lan@lists.osuosl.org
Cc:     linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Netfin <sasha.neftin@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Stefan Assmann <sassmann@redhat.com>,
        David Miller <davem@davemloft.net>, darcari@redhat.com,
        Yijun.Shen@dell.com, Perry.Yuan@dell.com,
        anthony.wong@canonical.com, Aaron Ma <aaron.ma@canonical.com>,
        Mark Pearson <markpearson@lenovo.com>
References: <20201214192935.895174-1-mario.limonciello@dell.com>
 <20201214192935.895174-3-mario.limonciello@dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0a037084-d2ec-a92c-7ba4-c270072a9ad7@redhat.com>
Date:   Tue, 15 Dec 2020 13:48:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201214192935.895174-3-mario.limonciello@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/14/20 8:29 PM, Mario Limonciello wrote:
> Per guidance from Intel ethernet architecture team, it may take
> up to 1 second for unconfiguring ULP mode.
> 
> However in practice this seems to be taking up to 2 seconds on
> some Lenovo machines.  Detect scenarios that take more than 1 second
> but less than 2.5 seconds and emit a warning on resume for those
> scenarios.
> 
> Suggested-by: Aaron Ma <aaron.ma@canonical.com>
> Suggested-by: Sasha Netfin <sasha.neftin@intel.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> CC: Mark Pearson <markpearson@lenovo.com>
> Fixes: f15bb6dde738cc8fa0 ("e1000e: Add support for S0ix")
> BugLink: https://bugs.launchpad.net/bugs/1865570
> Link: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20200323191639.48826-1-aaron.ma@canonical.com/
> Link: https://lkml.org/lkml/2020/12/13/15
> Link: https://lkml.org/lkml/2020/12/14/708
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 9aa6fad8ed47..fdf23d20c954 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -1240,6 +1240,9 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
>  		return 0;
>  
>  	if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID) {
> +		struct e1000_adapter *adapter = hw->adapter;
> +		bool firmware_bug = false;
> +
>  		if (force) {
>  			/* Request ME un-configure ULP mode in the PHY */
>  			mac_reg = er32(H2ME);
> @@ -1248,16 +1251,23 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
>  			ew32(H2ME, mac_reg);
>  		}
>  
> -		/* Poll up to 300msec for ME to clear ULP_CFG_DONE. */
> +		/* Poll up to 2.5 seconds for ME to clear ULP_CFG_DONE.
> +		 * If this takes more than 1 second, show a warning indicating a firmware
> +		 * bug */
>  		while (er32(FWSM) & E1000_FWSM_ULP_CFG_DONE) {
> -			if (i++ == 30) {
> +			if (i++ == 250) {
>  				ret_val = -E1000_ERR_PHY;
>  				goto out;
>  			}
> +			if (i > 100 && !firmware_bug)
> +				firmware_bug = true;
>  
>  			usleep_range(10000, 11000);
>  		}
> -		e_dbg("ULP_CONFIG_DONE cleared after %dmsec\n", i * 10);
> +		if (firmware_bug)
> +			e_warn("ULP_CONFIG_DONE took %dmsec.  This is a firmware bug\n", i * 10);
> +		else
> +			e_dbg("ULP_CONFIG_DONE cleared after %dmsec\n", i * 10);
>  
>  		if (force) {
>  			mac_reg = er32(H2ME);
> 

