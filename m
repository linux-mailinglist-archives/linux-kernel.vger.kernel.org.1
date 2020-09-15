Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF2426B916
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgIPA44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbgIOLRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600168624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=woQDJzqYhg7fywcaDyz/edYf2Kcu8mkUs5XrNK4Tz2w=;
        b=QCmGfzH//GpsDhvv4Oy36yKkzJJ0+fH9rLyILNe0wq3pItmcP2GfEalEvOR7gNKpZwc05T
        PRBR979h9RWBYEnBAGAEtPdXjuU3yjVmFkQGXmBADRlId5TDcuPwkyPzms/wSjN0FHBqYu
        QDElLGexgdi/mmxt80fIe+Xj8jUMEdM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-t_Q7-aKdNG6hINjAzpoBAA-1; Tue, 15 Sep 2020 07:17:02 -0400
X-MC-Unique: t_Q7-aKdNG6hINjAzpoBAA-1
Received: by mail-wr1-f72.google.com with SMTP id v12so1101054wrm.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=woQDJzqYhg7fywcaDyz/edYf2Kcu8mkUs5XrNK4Tz2w=;
        b=m/wQ8K7/CrjSM3ts63j4dwsk0CTQ8OO1TWVeoF23DaZc6oUZIOjmrF5oK/Ka5Ni8Xx
         XwlMGXMDJJ/fpSbxom5kbYDozXlrQyQP9/I/xR2/klxl07PKHFRCDbJfkOImKIlyD+8w
         zQhTIL52cJxVOWcBzRyPxVDBsAlgiky6XAeeT6dW3Y3RYSJgOISErdGuSdgEIHFdcjkT
         3t605wha5hWA89b9j/VBoYRHmMijKkelkBUtMCYlGPy3ANyq6xFBaN40YSo5sO/Yx21E
         B64XHujvBdqbecvFRwll0nFByloxyegi1ty3wZHP5ynB8wc4P/yEcmUAjMscpTM5pLvv
         lchw==
X-Gm-Message-State: AOAM532jufIA3M/CzuWXBzN71ROQlJHVM1yKl7Rc0Om4dzC4zUxjabBy
        MUdzZQTElOBtXV3/Ii0YujNbMN3DUopMfF82EPGPT2QMwv3DVzD09G2q64bL0P/EztffWfgSV/I
        4HkkWXfYgJHGOg/Bnt5BvVlLd
X-Received: by 2002:adf:e58b:: with SMTP id l11mr22315905wrm.210.1600168621432;
        Tue, 15 Sep 2020 04:17:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1+xzFGs26g7aJCk9FSSsiFCpkMroz/Chp7v9K3IdFtvipyWWejeB5dTWSLfG+tS8/srkFkQ==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr22315875wrm.210.1600168621197;
        Tue, 15 Sep 2020 04:17:01 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w21sm25728597wmk.34.2020.09.15.04.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 04:17:00 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list\:GENERIC INCLUDE\/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH RFC v1 13/18] asm-generic/hyperv: introduce hv_device_id and auxiliary structures
In-Reply-To: <20200914115928.83184-5-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org> <20200914115928.83184-5-wei.liu@kernel.org>
Date:   Tue, 15 Sep 2020 13:16:59 +0200
Message-ID: <87k0wvjnmc.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> We will need to identify the device we want Microsoft Hypervisor to
> manipulate.  Introduce the data structures for that purpose.
>
> They will be used in a later patch.
>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  include/asm-generic/hyperv-tlfs.h | 79 +++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 83945ada5a50..faf892ce152d 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -612,4 +612,83 @@ struct hv_set_vp_registers_input {
>  	} element[];
>  } __packed;
>  
> +enum hv_device_type {
> +	HV_DEVICE_TYPE_LOGICAL = 0,
> +	HV_DEVICE_TYPE_PCI = 1,
> +	HV_DEVICE_TYPE_IOAPIC = 2,
> +	HV_DEVICE_TYPE_ACPI = 3,
> +};
> +
> +typedef u16 hv_pci_rid;
> +typedef u16 hv_pci_segment;
> +typedef u64 hv_logical_device_id;
> +union hv_pci_bdf {
> +	u16 as_uint16;
> +
> +	struct {
> +		u8 function:3;
> +		u8 device:5;
> +		u8 bus;
> +	};
> +} __packed;
> +
> +union hv_pci_bus_range {
> +	u16 as_uint16;
> +
> +	struct {
> +		u8 subordinate_bus;
> +		u8 secondary_bus;
> +	};
> +} __packed;
> +
> +union hv_device_id {
> +	u64 as_uint64;
> +
> +	struct {
> +		u64 :62;
> +		u64 device_type:2;
> +	};
> +
> +	// HV_DEVICE_TYPE_LOGICAL

Nit: please no '//' comments.

> +	struct {
> +		u64 id:62;
> +		u64 device_type:2;
> +	} logical;
> +
> +	// HV_DEVICE_TYPE_PCI
> +	struct {
> +		union {
> +			hv_pci_rid rid;
> +			union hv_pci_bdf bdf;
> +		};
> +
> +		hv_pci_segment segment;
> +		union hv_pci_bus_range shadow_bus_range;
> +
> +		u16 phantom_function_bits:2;
> +		u16 source_shadow:1;
> +
> +		u16 rsvdz0:11;
> +		u16 device_type:2;
> +	} pci;
> +
> +	// HV_DEVICE_TYPE_IOAPIC
> +	struct {
> +		u8 ioapic_id;
> +		u8 rsvdz0;
> +		u16 rsvdz1;
> +		u16 rsvdz2;
> +
> +		u16 rsvdz3:14;
> +		u16 device_type:2;
> +	} ioapic;
> +
> +	// HV_DEVICE_TYPE_ACPI
> +	struct {
> +		u32 input_mapping_base;
> +		u32 input_mapping_count:30;
> +		u32 device_type:2;
> +	} acpi;
> +} __packed;
> +
>  #endif

-- 
Vitaly

