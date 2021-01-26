Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA734304191
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406130AbhAZPII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:08:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406124AbhAZPHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611673582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qi8UwE6Qmiu1KuWS8PgB1EdfHB74B6eg32KdKcjwVaY=;
        b=Yy1VNSXwX6kTanuT0Vb4BRGC9jV5buGQI1zkn/MxV2w3s5AMlgcR9cG3SAyDnb7X3YoQBw
        /9Gk7+QbG6r6jWMSnN/UUvGbnLAxMHriuEZLbj4MqkkPAnrhVdMbjYHWCNyCAZDiFWwrK+
        h+X4TH9BZFqtmuq8a8GskghCBC/sM6I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-D8VxDtiJNjCM28BLKRIx0Q-1; Tue, 26 Jan 2021 10:06:20 -0500
X-MC-Unique: D8VxDtiJNjCM28BLKRIx0Q-1
Received: by mail-qv1-f71.google.com with SMTP id b1so785548qvk.17
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qi8UwE6Qmiu1KuWS8PgB1EdfHB74B6eg32KdKcjwVaY=;
        b=XXvqFVT8mcmMxAJyLBPg4A4VAhoMyyZ6pQfIsPUFhd+r/7mrYn4h0bYIo79WwC1a3b
         hgomuMaPt3mAvhgTjQR7mYn9JhBwI8E6IKukcJ+lUN29LmpRwwjO+Zky6x4aAga+aUcx
         OtF+CO1ZbRb2jO3UceQgWw8iJ4jupbqQL/sdWf3VJCAn3mXvXlD/Rugx2oN8r5ySHS+a
         0p1HelTiqJoiohmkfEcYlCvHNHBut2shb6omloy7uSipHy2B3uclVpB/z/cWFGG3/KAC
         0m4LsKnoa3SBmz+kN7nzgxDHMXWcLprmmj3gJAeMPtBzWocIdU+6JU0Q5sXF2eAyJZ6X
         JilQ==
X-Gm-Message-State: AOAM530EMYU4vTmN2VEVi/VKPAmXlS1ROuv2oxhrT5TGVgy9DwUnN/5q
        tdgUKJWpI/0BdtAA504kEIJveyEI6ucjIeXDZn17iMVQb+nxvF96Db3LI9QpRc321I05sBDQRwm
        6S6wbHBXlKNYjRPCj+s/jIEU+
X-Received: by 2002:a0c:8e85:: with SMTP id x5mr5912594qvb.11.1611673580281;
        Tue, 26 Jan 2021 07:06:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkvTacOp9Nmqu9dKsH2VEK7Y5dOGzYE628PW7VS04bYssQxYzMpNCZ8WXXtjkccyqMknwRGw==
X-Received: by 2002:a0c:8e85:: with SMTP id x5mr5912570qvb.11.1611673580046;
        Tue, 26 Jan 2021 07:06:20 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 17sm15114656qtu.23.2021.01.26.07.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 07:06:19 -0800 (PST)
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Add entry for Intel MAX 10 mfd driver
To:     Xu Yilun <yilun.xu@intel.com>, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
References: <1611643836-7183-1-git-send-email-yilun.xu@intel.com>
 <1611643836-7183-5-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <5c75dafc-8103-100e-2b06-f0b229827ef0@redhat.com>
Date:   Tue, 26 Jan 2021 07:06:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1611643836-7183-5-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/21 10:50 PM, Xu Yilun wrote:
> This patch adds maintainer info for Intel MAX 10 mfd driver.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5aa18cb..10985d3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9132,6 +9132,15 @@ F:	include/linux/mei_cl_bus.h
>  F:	include/uapi/linux/mei.h
>  F:	samples/mei/*
>  

I am interested in reviewing these files like I do with

FPGA DFL DRIVERS

So can you add

R:    Tom Rix <trix@redhat.com>

if you have to rev this patchset ?

Else I will submit a followup.

Reviewed-by: Tom Rix <trix@redhat.com>

> +INTEL MAX 10 BMC MFD DRIVER
> +M:	Xu Yilun <yilun.xu@intel.com>
> +S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> +F:	Documentation/hwmon/intel-m10-bmc-hwmon.rst
> +F:	drivers/hwmon/intel-m10-bmc-hwmon.c
> +F:	drivers/mfd/intel-m10-bmc.c
> +F:	include/linux/mfd/intel-m10-bmc.h
> +
>  INTEL MENLOW THERMAL DRIVER
>  M:	Sujith Thomas <sujith.thomas@intel.com>
>  L:	platform-driver-x86@vger.kernel.org

