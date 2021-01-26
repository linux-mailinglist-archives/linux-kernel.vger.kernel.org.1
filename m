Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473F8304213
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406249AbhAZPRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406232AbhAZPQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:16:42 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E23C0698C1;
        Tue, 26 Jan 2021 07:16:02 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id w124so18804929oia.6;
        Tue, 26 Jan 2021 07:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zpobjr8cydpUMwWxANyp1xlUOzZG3PHs5brNhMOWooM=;
        b=f+0ZQqhHHTVwPxxu8wj3FFWbSId8HWWt7OotjUFHSGiNSAB8WUdK9CrNnl66VVCHDb
         2TQNQmtnBFZpTkIiaJxGEx+5bVpm8tuTpfojFMR12cAZi66XQGMW1detPESoRGkzzlJU
         W0xjmxxvRY+nFVpgBGmSfWj4KRIbVWeUghLcB7Lm+wqTRC1VYOCC+2IdF01mStmS2iff
         lq8v6rLO9EydXYIRq80BlAMIP+9SUIuXXVJtMm6qaVf31jpAtdCU8VVnyFvUY6J18O96
         XWCkwdZFNsh2u+O+Pw9rqMeX64ptzWK5KB5QqSLxT39wCM5eNP/azVrkBxb1OwuIoF7D
         tZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Zpobjr8cydpUMwWxANyp1xlUOzZG3PHs5brNhMOWooM=;
        b=o5+bXezHfr6MoTyYpjf/qUqReoEsVj43t7GR4rd4hZyjvzwYBbv/EOpH6xgLAwVnuq
         9XbYGkslUjTSLY0Z0OCID0MHthJ6Ebu4xPDI76PoOTmexuMjPzu56iMVPOUoePw79tUR
         YzADaNdbJR5XucU3yAqs9Wg219JCcHgIqvEcerpFRY1rBKJYjl5q5iEHap1GCsTbpYvG
         8f8clzt/ypymDGLh6HY8I7zMHwwJu/6vGrjWrdGf3girgx7Y2+U1PVspnJcsc3X1xhwn
         zlBH4M39oV6wgC0N0pBMLBpngxHYnpvTDP6u+Hbq1AU48OlcF4z3zngrtfTEy/nY66p/
         msqA==
X-Gm-Message-State: AOAM533Uv1K4JXhPcXvPNUGBxxhzjYOgnXtbP4fkQ68Mfnf8uALqzzwh
        GlyWOAgSFPQDk92op/S3dmpMEqvsDM8=
X-Google-Smtp-Source: ABdhPJyR2RT/MEh+fireg0P1i60eSIJ9JoCy5JFpqFnX3086b7crRx/Kf921nTfInmz08HCE7Zt5EA==
X-Received: by 2002:aca:3b89:: with SMTP id i131mr103487oia.102.1611674161804;
        Tue, 26 Jan 2021 07:16:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 66sm3263912otw.75.2021.01.26.07.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 07:16:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: connector: Add SVDM VDO properties
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        hdegoede@redhat.com, badhri@google.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210126084544.682641-1-kyletso@google.com>
 <20210126084544.682641-3-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <55d175fe-863e-7fb5-073a-d18f62e59038@roeck-us.net>
Date:   Tue, 26 Jan 2021 07:15:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126084544.682641-3-kyletso@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 12:45 AM, Kyle Tso wrote:
> Add bindings of VDO properties of USB PD SVDM so that they can be
> defined in device tree.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Are you also going to update
Documentation/devicetree/bindings/connector/usb-connector.yaml ?

Thanks,
Guenter

> ---
>  include/dt-bindings/usb/pd.h | 53 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
> index 0352893697f0..b99cb4a0cd12 100644
> --- a/include/dt-bindings/usb/pd.h
> +++ b/include/dt-bindings/usb/pd.h
> @@ -93,4 +93,55 @@
>  #define FRS_DEFAULT_POWER      1
>  #define FRS_5V_1P5A            2
>  #define FRS_5V_3A              3
> - #endif /* __DT_POWER_DELIVERY_H */
> +
> +/*
> + * SVDM Identity Header
> + * --------------------
> + * <31>     :: data capable as a USB host
> + * <30>     :: data capable as a USB device
> + * <29:27>  :: product type (UFP / Cable / VPD)
> + * <26>     :: modal operation supported (1b == yes)
> + * <25:23>  :: product type (DFP) (SVDM version 2.0+ only; set to zero in version 1.0)
> + * <22:21>  :: connector type (SVDM version 2.0+ only; set to zero in version 1.0)
> + * <20:16>  :: Reserved, Shall be set to zero
> + * <15:0>   :: USB-IF assigned VID for this cable vendor
> + */
> +/* SOP Product Type (UFP) */
> +#define IDH_PTYPE_NOT_UFP       0
> +#define IDH_PTYPE_HUB           1
> +#define IDH_PTYPE_PERIPH        2
> +#define IDH_PTYPE_PSD           3
> +#define IDH_PTYPE_AMA           5
> +
> +/* SOP' Product Type (Cable Plug / VPD) */
> +#define IDH_PTYPE_NOT_CABLE     0
> +#define IDH_PTYPE_PCABLE        3
> +#define IDH_PTYPE_ACABLE        4
> +#define IDH_PTYPE_VPD           6
> +
> +/* SOP Product Type (DFP) */
> +#define IDH_PTYPE_NOT_DFP       0
> +#define IDH_PTYPE_DFP_HUB       1
> +#define IDH_PTYPE_DFP_HOST      2
> +#define IDH_PTYPE_DFP_PB        3
> +
> +#define VDO_IDH(usbh, usbd, ufp_cable, is_modal, dfp, conn, vid)                \
> +	((usbh) << 31 | (usbd) << 30 | ((ufp_cable) & 0x7) << 27                \
> +	 | (is_modal) << 26 | ((dfp) & 0x7) << 23 | ((conn) & 0x3) << 21        \
> +	 | ((vid) & 0xffff))
> +
> +/*
> + * Cert Stat VDO
> + * -------------
> + * <31:0>  : USB-IF assigned XID for this cable
> + */
> +#define VDO_CERT(xid)		((xid) & 0xffffffff)
> +
> +/*
> + * Product VDO
> + * -----------
> + * <31:16> : USB Product ID
> + * <15:0>  : USB bcdDevice
> + */
> +#define VDO_PRODUCT(pid, bcd)   (((pid) & 0xffff) << 16 | ((bcd) & 0xffff))
> +#endif /* __DT_POWER_DELIVERY_H */
> 

