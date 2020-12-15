Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13FF2DAD79
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgLOMvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:51:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729097AbgLOMut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608036561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGmxOp+lsZTAqb+3B7qIl/D1OZdN92HJYfxMLvkO2No=;
        b=IXkO9Ut3ErSk1CJ2ju6i5VKTJyw1lttZ8Wz6973KBcRymnSvH2DcNVF2H3JAIW8KSKgFCa
        wG3o1gEwsq8gWmx9RmRmLCRbT2Sl9kKIQhBF86Xr6iKIJUYKF3vVnPYSIDSwiI/GOOJAML
        8KooXRwqmrioZmI17vt7DCo9LWw2y3A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-C5Sc_3-DO8ezm6ewg_NmHw-1; Tue, 15 Dec 2020 07:49:20 -0500
X-MC-Unique: C5Sc_3-DO8ezm6ewg_NmHw-1
Received: by mail-ej1-f70.google.com with SMTP id d19so4019287ejo.18
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:49:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IGmxOp+lsZTAqb+3B7qIl/D1OZdN92HJYfxMLvkO2No=;
        b=QZtHBHgKrDn1O5ch4ABbT1Y+6fHRZv8iRBlfgoHzs3f+7vXz/Q4l8ld9b21A4VFwuE
         4uwz1lQ7zFjmZ3EdddZdH9fdcX8oqyTwsQq6SZiWUflg2QDqhae5iY9AkMCqUNkvYnyO
         2o7fE0ax7/D/5eeZi+y4wYVFqAvtUDZYB/TeMsm06CaCgyJG9La6rk7f8Y4DLjbPGmNv
         MT5pNWwISdg2HpfQi71VHpFGTi0heeaEW3BHYOB9YqxHWo7umIZUQoiLrgaa5kYKL10G
         4iZ6wT/XQ3mwdho2sUm264Ux6gzUGzLlN14VTinWKmzoGqfftFVKgekgMLIWNuzQ503u
         2p5A==
X-Gm-Message-State: AOAM531dAceqZ3ib+yP429m5USYvT1cep4j2+RGsDvvGsDox8tUfixqa
        I/IcfZhE1WA2vbR/fBawOGTrpzbd6oWkiDcY/xbsy9VZ4WPk88lZwIATZO7h5PWVwaQZFkQNHhW
        0k9XbursgcILCIOChLkvqG0mQ
X-Received: by 2002:a05:6402:1714:: with SMTP id y20mr2251005edu.2.1608036559086;
        Tue, 15 Dec 2020 04:49:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxdC979gOoM0XUlTY+f7JZajT+QM9AvZjK/ijPgI4e4+rYBIlyOZR0IQrrF9Jugpe/5Ejo5A==
X-Received: by 2002:a05:6402:1714:: with SMTP id y20mr2250993edu.2.1608036558891;
        Tue, 15 Dec 2020 04:49:18 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id r7sm18271356edv.39.2020.12.15.04.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 04:49:18 -0800 (PST)
Subject: Re: [PATCH v5 4/4] e1000e: Export S0ix flags to ethtool
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
        anthony.wong@canonical.com
References: <20201214192935.895174-1-mario.limonciello@dell.com>
 <20201214192935.895174-5-mario.limonciello@dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <71cd8bc2-2a34-5a27-64d8-56e5ac9c2b22@redhat.com>
Date:   Tue, 15 Dec 2020 13:49:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201214192935.895174-5-mario.limonciello@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/14/20 8:29 PM, Mario Limonciello wrote:
> This flag can be used by an end user to disable S0ix flows on a
> buggy system or by an OEM for development purposes.
> 
> If you need this flag to be persisted across reboots, it's suggested
> to use a udev rule to call adjust it until the kernel could have your
> configuration in a disallow list.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/net/ethernet/intel/e1000e/e1000.h   |  1 +
>  drivers/net/ethernet/intel/e1000e/ethtool.c | 46 +++++++++++++++++++++
>  drivers/net/ethernet/intel/e1000e/netdev.c  |  9 ++--
>  3 files changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
> index ba7a0f8f6937..5b2143f4b1f8 100644
> --- a/drivers/net/ethernet/intel/e1000e/e1000.h
> +++ b/drivers/net/ethernet/intel/e1000e/e1000.h
> @@ -436,6 +436,7 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca);
>  #define FLAG2_DFLT_CRC_STRIPPING          BIT(12)
>  #define FLAG2_CHECK_RX_HWTSTAMP           BIT(13)
>  #define FLAG2_CHECK_SYSTIM_OVERFLOW       BIT(14)
> +#define FLAG2_ENABLE_S0IX_FLOWS           BIT(15)
>  
>  #define E1000_RX_DESC_PS(R, i)	    \
>  	(&(((union e1000_rx_desc_packet_split *)((R).desc))[i]))
> diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
> index 03215b0aee4b..06442e6bef73 100644
> --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
> @@ -23,6 +23,13 @@ struct e1000_stats {
>  	int stat_offset;
>  };
>  
> +static const char e1000e_priv_flags_strings[][ETH_GSTRING_LEN] = {
> +#define E1000E_PRIV_FLAGS_S0IX_ENABLED	BIT(0)
> +	"s0ix-enabled",
> +};
> +
> +#define E1000E_PRIV_FLAGS_STR_LEN ARRAY_SIZE(e1000e_priv_flags_strings)
> +
>  #define E1000_STAT(str, m) { \
>  		.stat_string = str, \
>  		.type = E1000_STATS, \
> @@ -1776,6 +1783,8 @@ static int e1000e_get_sset_count(struct net_device __always_unused *netdev,
>  		return E1000_TEST_LEN;
>  	case ETH_SS_STATS:
>  		return E1000_STATS_LEN;
> +	case ETH_SS_PRIV_FLAGS:
> +		return E1000E_PRIV_FLAGS_STR_LEN;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -2097,6 +2106,10 @@ static void e1000_get_strings(struct net_device __always_unused *netdev,
>  			p += ETH_GSTRING_LEN;
>  		}
>  		break;
> +	case ETH_SS_PRIV_FLAGS:
> +		memcpy(data, e1000e_priv_flags_strings,
> +		       E1000E_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
> +		break;
>  	}
>  }
>  
> @@ -2305,6 +2318,37 @@ static int e1000e_get_ts_info(struct net_device *netdev,
>  	return 0;
>  }
>  
> +static u32 e1000e_get_priv_flags(struct net_device *netdev)
> +{
> +	struct e1000_adapter *adapter = netdev_priv(netdev);
> +	u32 priv_flags = 0;
> +
> +	if (adapter->flags2 & FLAG2_ENABLE_S0IX_FLOWS)
> +		priv_flags |= E1000E_PRIV_FLAGS_S0IX_ENABLED;
> +
> +	return priv_flags;
> +}
> +
> +static int e1000e_set_priv_flags(struct net_device *netdev, u32 priv_flags)
> +{
> +	struct e1000_adapter *adapter = netdev_priv(netdev);
> +	unsigned int flags2 = adapter->flags2;
> +
> +	flags2 &= ~FLAG2_ENABLE_S0IX_FLOWS;
> +	if (priv_flags & E1000E_PRIV_FLAGS_S0IX_ENABLED) {
> +		struct e1000_hw *hw = &adapter->hw;
> +
> +		if (hw->mac.type < e1000_pch_cnp)
> +			return -EINVAL;
> +		flags2 |= FLAG2_ENABLE_S0IX_FLOWS;
> +	}
> +
> +	if (flags2 != adapter->flags2)
> +		adapter->flags2 = flags2;
> +
> +	return 0;
> +}
> +
>  static const struct ethtool_ops e1000_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS,
>  	.get_drvinfo		= e1000_get_drvinfo,
> @@ -2336,6 +2380,8 @@ static const struct ethtool_ops e1000_ethtool_ops = {
>  	.set_eee		= e1000e_set_eee,
>  	.get_link_ksettings	= e1000_get_link_ksettings,
>  	.set_link_ksettings	= e1000_set_link_ksettings,
> +	.get_priv_flags		= e1000e_get_priv_flags,
> +	.set_priv_flags		= e1000e_set_priv_flags,
>  };
>  
>  void e1000e_set_ethtool_ops(struct net_device *netdev)
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index b9800ba2006c..e9b82c209c2d 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -6923,7 +6923,6 @@ static __maybe_unused int e1000e_pm_suspend(struct device *dev)
>  	struct net_device *netdev = pci_get_drvdata(to_pci_dev(dev));
>  	struct e1000_adapter *adapter = netdev_priv(netdev);
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct e1000_hw *hw = &adapter->hw;
>  	int rc;
>  
>  	e1000e_flush_lpic(pdev);
> @@ -6935,7 +6934,7 @@ static __maybe_unused int e1000e_pm_suspend(struct device *dev)
>  		e1000e_pm_thaw(dev);
>  	} else {
>  		/* Introduce S0ix implementation */
> -		if (hw->mac.type >= e1000_pch_cnp)
> +		if (adapter->flags2 & FLAG2_ENABLE_S0IX_FLOWS)
>  			e1000e_s0ix_entry_flow(adapter);
>  	}
>  
> @@ -6947,11 +6946,10 @@ static __maybe_unused int e1000e_pm_resume(struct device *dev)
>  	struct net_device *netdev = pci_get_drvdata(to_pci_dev(dev));
>  	struct e1000_adapter *adapter = netdev_priv(netdev);
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct e1000_hw *hw = &adapter->hw;
>  	int rc;
>  
>  	/* Introduce S0ix implementation */
> -	if (hw->mac.type >= e1000_pch_cnp)
> +	if (adapter->flags2 & FLAG2_ENABLE_S0IX_FLOWS)
>  		e1000e_s0ix_exit_flow(adapter);
>  
>  	rc = __e1000_resume(pdev);
> @@ -7615,6 +7613,9 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (!(adapter->flags & FLAG_HAS_AMT))
>  		e1000e_get_hw_control(adapter);
>  
> +	if (hw->mac.type >= e1000_pch_cnp)
> +		adapter->flags2 |= FLAG2_ENABLE_S0IX_FLOWS;
> +
>  	strlcpy(netdev->name, "eth%d", sizeof(netdev->name));
>  	err = register_netdev(netdev);
>  	if (err)
> 

