Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777552FD70E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbhATRa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:30:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390085AbhATPoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611157372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4xoPl7f7dmT5aOUReJjLzM6dF2ItlZGEpQCpVAbQ4zc=;
        b=RTW8CGLNdd8UYodaOdD19fK4NExo+Ledi7k359vYZNZn+oDou165Hzd4zh7w0C+OIO39oD
        e1bbLbSnz21JmvsLTLx99a6FWbjAF9k1N4JK9AAUcQS55N3G4MiyV+x/2Sf0y3zlajGeUA
        18LsrkXNsiDdwhgtS51ji/OvxrM0DYc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-Qe-GiRugMX-L-MYLNevHug-1; Wed, 20 Jan 2021 10:42:51 -0500
X-MC-Unique: Qe-GiRugMX-L-MYLNevHug-1
Received: by mail-qt1-f198.google.com with SMTP id j1so21655329qtd.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 07:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4xoPl7f7dmT5aOUReJjLzM6dF2ItlZGEpQCpVAbQ4zc=;
        b=VrLxyaWCg77mj46tCyWyW+XXeO9193kMb4K0f481cyxyPOpcBkm6jS96bjLfPMj/4I
         xtPMzc808ZsL9COwpMp+8Co3DaavjYTMrsd2bL/Ub9mURRDHgOHzhCjNDjbpw/1eNJCK
         YuLnRojH18KP+Q6KC/y0pCnpZemQ2vvXWwrYkJ/qA1KCqCZGgroehEbxM8MQ9AS3mXuZ
         08OJSTglGRrCyDP+8A2xekiWQNgAh6fuBQ6BpAH0vwpyTU5sm6JL4gQWoujUE4Z7IFIt
         ZmSb3ZseAXjJ1ETGhmlnOtUTR0K+ku3akj76HEqht4TzcUBSENyb8tJIYsvKrqugglr2
         Uo4A==
X-Gm-Message-State: AOAM532VSKrMEy/E1oK5ayG+oGd+Ngojx6DzQFM/qMesTAT7WUcjPAtT
        iVEPyX51gwMeg9BuaIB2fUzgX+2xCWupPuIl77HMyzpFHd5o9RRfQ3ngEQYITc04rJGXoggdfxn
        NMfslcVZrx5kZkHT96EmCNvVZ
X-Received: by 2002:a05:622a:193:: with SMTP id s19mr9246523qtw.366.1611157370516;
        Wed, 20 Jan 2021 07:42:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy46vy4uYUvy6DMhSSyHnsnDFPDaeWOJ/qyijYFVvsNUPBxATo2WmZu5W+eiGMK3DC8hv0tEA==
X-Received: by 2002:a05:622a:193:: with SMTP id s19mr9246505qtw.366.1611157370331;
        Wed, 20 Jan 2021 07:42:50 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b13sm1368221qto.43.2021.01.20.07.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:42:49 -0800 (PST)
Subject: Re: [PATCH 1/2] mfd: intel-m10-bmc: fix the register access range
To:     Xu Yilun <yilun.xu@intel.com>, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
References: <1611110081-10056-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b885ffbf-b8be-5c75-7552-739c405bac80@redhat.com>
Date:   Wed, 20 Jan 2021 07:42:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1611110081-10056-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A side note..

I think it would be good if the intel-m10-bmc.* files were tracked in the MAINTAINERS files.

I was surprised the Lee was the only reviewer.  Maybe Yilun or Matt should also be added.

On 1/19/21 6:34 PM, Xu Yilun wrote:
> This patch fixes the max register address of MAX 10 BMC. The range
> 0x20000000 ~ 0x200000fc are for control registers of the QSPI flash
> controller, which are not accessible to host.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
>  include/linux/mfd/intel-m10-bmc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index c8ef2f1..06da62c 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -11,7 +11,7 @@
>  
>  #define M10BMC_LEGACY_SYS_BASE		0x300400
>  #define M10BMC_SYS_BASE			0x300800
> -#define M10BMC_MEM_END			0x200000fc
> +#define M10BMC_MEM_END			0x1fffffff
Reviewed-by: Tom Rix <trix@redhat.com>
>  
>  /* Register offset of system registers */
>  #define NIOS2_FW_VERSION		0x0

