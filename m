Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231D62A34D2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgKBUCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgKBUCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:02:18 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C950C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 12:02:18 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id x7so16058887wrl.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 12:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+LHkPNNHGbEfsJSQWciAnfkrQlxui91397IyZ7j51r4=;
        b=s/XXlneVIJlCJqA+P3wqUaXYCK2ybHjf+F+WnpOSHIIg3kHtEB1z3Gc/pgUKvHF4He
         vsv1iWVlFT8uZPEEg5jF/+zW2PGq8gW1DKDdmO8X0S6euvf3NJ8meCddkGp3sje+58MS
         5CUJqqeG0HeGZ1EiMe2HPXlMejTWo5lCw6iYAk3ClO89NIxF0S8Lcs5xupGvEpHWedKW
         kssWl8UnN5T2ejXz+WhH8xcuaJAVWLZ1xLV9LllODxi3sJ577JUNsa78V4uB/mjswCSD
         ozf9/apVVI6gXkiGQPVfMdQavzNxCI6T93iHkHFStVD+zfTZNlFp6Li3SjuHcUDVZHFd
         D8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=+LHkPNNHGbEfsJSQWciAnfkrQlxui91397IyZ7j51r4=;
        b=OPL37cQO2yKhKm+1HG2uIFZOd3gASTCiD7kUaxTe3lxwn05NDz006sJrVaE1OCVvBv
         VpYIU5Nc0aSiP4z6ulUMfUod2KPNZFqZ2pnDR/i1v4m0BVvPNpXw6J5D+SL47VisbS9i
         tbc7cl8ZTajXZCDh+hEzpgNQiuh9NtKbSerX3woB1ZLeh5993jMJVQsl9Jl3GOb7B4oL
         /T7q4zwRNV29GmV5fHJ1emswhlbt/Ezqb0KIUDSd61eBr6N42zb+4M2CtrkbvOEUnRum
         6zrmiLQBsfzV0PBxt7IeKb6napuWly1CeoVA1jgd2WmVGmakMDQqpPbPYRU4twuv3Bxi
         13ig==
X-Gm-Message-State: AOAM5333czOKLAuEzQMB+pZiLfxqdrwrXUwgFNPfwdAm2WwzjfaiwHWt
        0El8/CkMfA1Y9KW/UKaOfwc=
X-Google-Smtp-Source: ABdhPJx/kNoq2YtHLfUwD/tFAfh/4biaXbd6hWObircRavhW5qvCIADgoqAOup5/kF5517/O/JPOhg==
X-Received: by 2002:adf:c847:: with SMTP id e7mr15411821wrh.346.1604347336925;
        Mon, 02 Nov 2020 12:02:16 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id b4sm15426048wro.57.2020.11.02.12.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 12:02:16 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] drm/amd: fix typoes
To:     Bernard Zhao <bernard@vivo.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Colin Ian King <colin.king@canonical.com>,
        zhengbin <zhengbin13@huawei.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20201102125747.6420-1-bernard@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <654ce843-8b12-7ba2-9225-3c724afa3cdf@gmail.com>
Date:   Mon, 2 Nov 2020 21:02:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102125747.6420-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.11.20 um 13:57 schrieb Bernard Zhao:
> Fix typoes.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> index 2c6db379afae..e994d233aa21 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> @@ -1980,7 +1980,7 @@ static void calculate_bandwidth(
>   	else {
>   		data->latency_for_non_mcifwr_clients = bw_int_to_fixed(0);
>   	}
> -	/*dmif mc urgent latency suppported in high sclk and yclk*/
> +	/*dmif mc urgent latency supported in high sclk and yclk*/
>   	data->dmifmc_urgent_latency_supported_in_high_sclk_and_yclk = bw_div((bw_sub(data->min_read_buffer_size_in_time, data->dmif_burst_time[high][s_high])), data->total_dmifmc_urgent_trips);
>   	/*dram speed/p-state change margin*/
>   	/*in the multi-display case the nb p-state change watermark cannot exceed the average lb size plus the dmif size or the cursor dcp buffer size*/

