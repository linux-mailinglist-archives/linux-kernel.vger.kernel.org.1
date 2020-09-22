Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08F1273D15
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgIVIQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:16:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59315 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgIVIQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:16:51 -0400
Received: from cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net ([80.193.200.194] helo=[192.168.0.210])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kKdTm-0008TT-7b; Tue, 22 Sep 2020 08:16:50 +0000
Subject: Re: [PATCH 1/3] stress-shm-sysv: exercise shmat with invalid flags
To:     Piyush Goyal <piyushgoyaliit@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20200922072730.68911-1-piyushgoyaliit@gmail.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <c867a2f8-5046-ce14-e36a-3d48780c317a@canonical.com>
Date:   Tue, 22 Sep 2020 09:16:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200922072730.68911-1-piyushgoyaliit@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believe these patches should have gone directly to me and not various
other folk.

Colin

On 22/09/2020 08:27, Piyush Goyal wrote:
> Exercise shmat syscall with invalid flags resulting in more kernel
> coverage.
> 
> Signed-off-by: Piyush Goyal <piyushgoyaliit@gmail.com>
> ---
>  stress-shm-sysv.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/stress-shm-sysv.c b/stress-shm-sysv.c
> index aa03d718..5a3e0cc1 100644
> --- a/stress-shm-sysv.c
> +++ b/stress-shm-sysv.c
> @@ -128,6 +128,19 @@ static int stress_shm_sysv_check(
>  	return 0;
>  }
>  
> +/*
> + *  exercise_shmat()
> + *	exercise shmat syscall with all possible values of arguments
> + */
> +static void exercise_shmat(int shm_id)
> +{
> +	void *addr;
> +
> +	/* Exercise shmat syscall with invalid flags */
> +	addr = shmat(shm_id, NULL, ~0);
> +	(void)addr;
> +}
> +
>  #if defined(__linux__)
>  /*
>   *  stress_shm_get_procinfo()
> @@ -337,6 +350,7 @@ static int stress_shm_sysv_child(
>  				goto reap;
>  			}
>  
> +			exercise_shmat(shm_id);
>  			addr = shmat(shm_id, NULL, 0);
>  			if (addr == (char *) -1) {
>  				ok = false;
> 

