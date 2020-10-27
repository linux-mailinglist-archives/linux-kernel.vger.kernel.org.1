Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3C129C02B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1817025AbgJ0RMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:12:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:40472 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1786275AbgJ0RMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:12:13 -0400
IronPort-SDR: TkVPNnlHh87Qmna1IG0JUXndEZBmXEqMKIKmwG11ESwyskO78nt8bIkvsd1qQqB+YjwM//nYaq
 29qBgTDmcDzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="232310100"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="232310100"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 10:12:11 -0700
IronPort-SDR: HXsMrvAkjPUr8QiYpDno6fpZ8tfqF1mxLHLXQH6Xn3teK+iOteaHRF5Fr8kcllVbacPe5rOquO
 BlWKPwfFKDNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="350662076"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by fmsmga004.fm.intel.com with ESMTP; 27 Oct 2020 10:12:11 -0700
Subject: Re: [PATCH v3 40/56] firmware: stratix10-svc: fix kernel-doc markups
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <f417f0605346b2d72b1a7f5b3989c9aca29729df.1603469755.git.mchehab+huawei@kernel.org>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <42c3c7bf-bbdb-cba8-af58-37fb3637f443@linux.intel.com>
Date:   Tue, 27 Oct 2020 12:31:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f417f0605346b2d72b1a7f5b3989c9aca29729df.1603469755.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Richard Gong <richard.gong@linux.intel.com>

On 10/23/20 11:33 AM, Mauro Carvalho Chehab wrote:
> There are some common comments marked, instead, with kernel-doc
> notation, which won't work.
> 
> While here, rename an identifier, in order to match the
> function prototype below kernel-doc markup.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   include/linux/firmware/intel/stratix10-svc-client.h | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index a93d85932eb9..ebc295647581 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -6,7 +6,7 @@
>   #ifndef __STRATIX10_SVC_CLIENT_H
>   #define __STRATIX10_SVC_CLIENT_H
>   
> -/**
> +/*
>    * Service layer driver supports client names
>    *
>    * fpga: for FPGA configuration
> @@ -15,7 +15,7 @@
>   #define SVC_CLIENT_FPGA			"fpga"
>   #define SVC_CLIENT_RSU			"rsu"
>   
> -/**
> +/*
>    * Status of the sent command, in bit number
>    *
>    * SVC_STATUS_OK:
> @@ -50,7 +50,7 @@
>   #define SVC_STATUS_ERROR		5
>   #define SVC_STATUS_NO_SUPPORT		6
>   
> -/**
> +/*
>    * Flag bit for COMMAND_RECONFIG
>    *
>    * COMMAND_RECONFIG_FLAG_PARTIAL:
> @@ -58,7 +58,7 @@
>    */
>   #define COMMAND_RECONFIG_FLAG_PARTIAL	1
>   
> -/**
> +/*
>    * Timeout settings for service clients:
>    * timeout value used in Stratix10 FPGA manager driver.
>    * timeout value used in RSU driver
> @@ -218,7 +218,7 @@ void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr);
>   int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg);
>   
>   /**
> - * intel_svc_done() - complete service request
> + * stratix10_svc_done() - complete service request
>    * @chan: service channel assigned to the client
>    *
>    * This function is used by service client to inform service layer that
> 
