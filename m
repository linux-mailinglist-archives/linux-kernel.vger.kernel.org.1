Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48978233270
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 14:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgG3Mxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 08:53:47 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.35]:32233 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726535AbgG3Mxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:53:45 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 5289A5DD9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 07:53:26 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 183qk8YXrQyTQ183qki6ZO; Thu, 30 Jul 2020 07:53:26 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QZ4BKgZJSRvqd0E7KvYS/q4D5CC5tTLJdNa/HA/1yUw=; b=Kd2jLlaIwm4GBvdFd+3XwS9oKM
        fikK0PhLX1bA597iTNZkJXG5KzRbDeJWWW+WTE7Rtg9THYSwUsl6DMj1n1RRC4/4cYfgm9YCVzNDM
        Ib+lcCuBnudvUfG80vp75QhVrBqUmWLLQsuenLOSDv6UvoSBXw24pZNA9PxDMBTaLl1xNnJYKNwus
        iImIZNBBcS11ueRTf8/aFLotq3HL/e61sOcWKeo0jZz7FPFlF4S63D0Z9tdY7qq1etJ04tfH+pIkC
        F2X/iN88tC+ObI5xe9f14ZaEuA/2CBbla5MKffxR225vPEXD77KLLqYIaHxDzfrM/Utm6G8KHqJa7
        VyUC9vMQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:33550 helo=[192.168.15.3])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1k183p-003ExR-VD; Thu, 30 Jul 2020 07:53:26 -0500
Subject: Re: [char-misc-next V2] mei: hdcp: fix mei_hdcp_verify_mprime() input
 paramter
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Ramalingam C <ramalingam.c@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
References: <20200730070258.3361503-1-tomas.winkler@intel.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 AP7RWS474w==
Message-ID: <787ef32c-b10d-5fb7-786f-2825180e1b88@embeddedor.com>
Date:   Thu, 30 Jul 2020 07:59:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200730070258.3361503-1-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1k183p-003ExR-VD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.3]) [187.162.31.110]:33550
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

On 7/30/20 02:02, Tomas Winkler wrote:
> wired_cmd_repeater_auth_stream_req_in has a variable
> length array at the end. we use struct_size() overflow
> macro to determine the size for the allocation and sending
> size.
> 

My comments here:
https://lore.kernel.org/lkml/66c9950c-ef54-423e-467f-38a9f7afb384@embeddedor.com/

still stand...

> Fixes: c56967d674e3 (mei: hdcp: Replace one-element array with flexible-array member)
> Fixes: c56967d674e3 (mei: hdcp: Replace one-element array with flexible-array member)

You have repeated the same commit twice, above. Also, a Fixes tag for the commit from
Feb 2019 that I talk about here:
https://lore.kernel.org/lkml/66c9950c-ef54-423e-467f-38a9f7afb384@embeddedor.com/

should be included in this changelog text.

--
Gustavo

> Cc: Ramalingam C <ramalingam.c@intel.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V2: Check for allocation failure.
>  drivers/misc/mei/hdcp/mei_hdcp.c | 40 +++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
> index d1d3e025ca0e..f1205e0060db 100644
> --- a/drivers/misc/mei/hdcp/mei_hdcp.c
> +++ b/drivers/misc/mei/hdcp/mei_hdcp.c
> @@ -546,38 +546,46 @@ static int mei_hdcp_verify_mprime(struct device *dev,
>  				  struct hdcp_port_data *data,
>  				  struct hdcp2_rep_stream_ready *stream_ready)
>  {
> -	struct wired_cmd_repeater_auth_stream_req_in
> -					verify_mprime_in = { { 0 } };
> +	struct wired_cmd_repeater_auth_stream_req_in *verify_mprime_in;
>  	struct wired_cmd_repeater_auth_stream_req_out
>  					verify_mprime_out = { { 0 } };
>  	struct mei_cl_device *cldev;
>  	ssize_t byte;
> +	size_t cmd_size;
>  
>  	if (!dev || !stream_ready || !data)
>  		return -EINVAL;
>  
>  	cldev = to_mei_cl_device(dev);
>  
> -	verify_mprime_in.header.api_version = HDCP_API_VERSION;
> -	verify_mprime_in.header.command_id = WIRED_REPEATER_AUTH_STREAM_REQ;
> -	verify_mprime_in.header.status = ME_HDCP_STATUS_SUCCESS;
> -	verify_mprime_in.header.buffer_len =
> +	cmd_size = struct_size(verify_mprime_in, streams, data->k);
> +	if (cmd_size == SIZE_MAX)
> +		return -EINVAL;
> +
> +	verify_mprime_in = kzalloc(cmd_size, GFP_KERNEL);
> +	if (!verify_mprime_in)
> +		return -ENOMEM;
> +
> +	verify_mprime_in->header.api_version = HDCP_API_VERSION;
> +	verify_mprime_in->header.command_id = WIRED_REPEATER_AUTH_STREAM_REQ;
> +	verify_mprime_in->header.status = ME_HDCP_STATUS_SUCCESS;
> +	verify_mprime_in->header.buffer_len =
>  			WIRED_CMD_BUF_LEN_REPEATER_AUTH_STREAM_REQ_MIN_IN;
>  
> -	verify_mprime_in.port.integrated_port_type = data->port_type;
> -	verify_mprime_in.port.physical_port = (u8)data->fw_ddi;
> -	verify_mprime_in.port.attached_transcoder = (u8)data->fw_tc;
> +	verify_mprime_in->port.integrated_port_type = data->port_type;
> +	verify_mprime_in->port.physical_port = (u8)data->fw_ddi;
> +	verify_mprime_in->port.attached_transcoder = (u8)data->fw_tc;
> +
> +	memcpy(verify_mprime_in->m_prime, stream_ready->m_prime, HDCP_2_2_MPRIME_LEN);
> +	drm_hdcp_cpu_to_be24(verify_mprime_in->seq_num_m, data->seq_num_m);
>  
> -	memcpy(verify_mprime_in.m_prime, stream_ready->m_prime,
> -	       HDCP_2_2_MPRIME_LEN);
> -	drm_hdcp_cpu_to_be24(verify_mprime_in.seq_num_m, data->seq_num_m);
> -	memcpy(verify_mprime_in.streams, data->streams,
> +	memcpy(verify_mprime_in->streams, data->streams,
>  	       array_size(data->k, sizeof(*data->streams)));
>  
> -	verify_mprime_in.k = cpu_to_be16(data->k);
> +	verify_mprime_in->k = cpu_to_be16(data->k);
>  
> -	byte = mei_cldev_send(cldev, (u8 *)&verify_mprime_in,
> -			      sizeof(verify_mprime_in));
> +	byte = mei_cldev_send(cldev, (u8 *)&verify_mprime_in, cmd_size);
> +	kfree(verify_mprime_in);
>  	if (byte < 0) {
>  		dev_dbg(dev, "mei_cldev_send failed. %zd\n", byte);
>  		return byte;
> 
