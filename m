Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FC92CEA0A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbgLDIkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:40:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44394 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbgLDIku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:40:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id s9so5643345ljo.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:40:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yiu8+tXTBsSe5C/YobYcYIjj+kze1oiRLa7kn7MZ3yI=;
        b=oXnXzfea/JkvVBE2jIL8eqUgW0HkMM645jkkSSR+acMmI2Zezp+GZKHM3an0PCSaqs
         f/AaUb9AMJeB7dIa5SHEtwbt/Y/82SXOk5rJ3ixbOOWR1LwYU43b+x9Hyv7DHotWxldj
         Q17tH/1ptjNUUgtpFyMnqSnMyqht153/RiwhhHTkF6XD/IGUD5GyCNfW3PBPGppQCFfA
         jaN7c8DMiqit8E0rrAHKaAr34lqWovCerJH8frrk3fotu0f8OJgBzOCKKOXbrRNV2O/F
         VVANB0RJ9P4CyUZBW38URfwne/rl3uwNeu+k1hdyePnZMfl+9pcbaYS6cVPZXvTVe6m7
         tSOQ==
X-Gm-Message-State: AOAM532pV0TaTV+5dYOEQnVC+ZIOdkes7wF2b1QFrBkr9fJqv4nhe0k6
        z/EkauKxOtY+1Fui1p9ddnc=
X-Google-Smtp-Source: ABdhPJwS5qFQ/psaUnmGAsXqz3qI0zifCh+9HilqTaB7ZSeLltQnMtnjfev1SDanVLsQifCMjicNgA==
X-Received: by 2002:a2e:97c1:: with SMTP id m1mr3095064ljj.278.1607071208414;
        Fri, 04 Dec 2020 00:40:08 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id q26sm1444609lfd.260.2020.12.04.00.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 00:40:07 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl6ds-0001aJ-JQ; Fri, 04 Dec 2020 09:40:41 +0100
Date:   Fri, 4 Dec 2020 09:40:40 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Wang Hai <wanghai38@huawei.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com, aibhav.sr@gmail.com,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: audio: Add missing unlock in
 gbaudio_dapm_free_controls()
Message-ID: <X8n2CL58pQ/077rQ@localhost>
References: <20201204021350.28182-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204021350.28182-1-wanghai38@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 10:13:50AM +0800, Wang Hai wrote:
> Add the missing unlock before return from function
> gbaudio_dapm_free_controls() in the error handling case.
> 
> Fixes: 510e340efe0c ("staging: greybus: audio: Add helper APIs for dynamic audio module")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  drivers/staging/greybus/audio_helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
> index 237531ba60f3..293675dbea10 100644
> --- a/drivers/staging/greybus/audio_helper.c
> +++ b/drivers/staging/greybus/audio_helper.c
> @@ -135,6 +135,7 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
>  		if (!w) {
>  			dev_err(dapm->dev, "%s: widget not found\n",
>  				widget->name);
> +			mutex_unlock(&dapm->card->dapm_mutex);
>  			return -EINVAL;
>  		}
>  		widget++;

This superficially looks correct, but there seems to be another bug in
this function. It can be used free an array of widgets, but if one of
them isn't found we just leak the rest. Perhaps that return should
rather be "widget++; continue;".

Vaibhav?

Johan
