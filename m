Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E2E2D64AE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404141AbgLJSPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403968AbgLJSOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:14:41 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE32C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:14:01 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id h18so5751280otq.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYa3QwHjcr9KvgYh2cWR2ObRxXNVCxcMJKU5e9f8sD8=;
        b=numcK5p0fC6i0qHz1HrhREaD7+WeZR49j5Ld8oazdIWYJjGMor8RpCWz6WEkvH0SS+
         UlJYu/zIOO+mGE3A2M3CsowAbX/TuO3db5uEQkhqW1AIzEQlhcn0NLDHs0f1QYGqjWO6
         s4pU9wOxBze02RZqscoOgYQ1YRCTvJMyALiqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYa3QwHjcr9KvgYh2cWR2ObRxXNVCxcMJKU5e9f8sD8=;
        b=TRCm3jQQUARG/Ptj2k1uycuD4kzhUKXLu1xIHoDZ5e3W4iPeaHTmX+tfKo62YXPx0a
         0AIKJtanL9xfv/X/2W+jBrx5F8m9PaJGoxd0XofvJTArv/4RZvEewr58rB1xNIocJWR6
         HoOggPzWa7HNIAamsq2DK+kW/ORhhtp5rbHKEyftTo5rovDpbY8CAHktplRwdIxT0A/5
         aQzd5WCvM6lfdVfJ3yG5k0SvxTtyr+kRKFbj88OXKjyFyuPEz0R2McGQiszA5+xej0FY
         6isKsv2S+58FXnlGxEzuXas4T2EfKJlaycsg8bdvMBkvmqvH5TFnJ40/wjxVTFSPGXb9
         +6Pg==
X-Gm-Message-State: AOAM532tyc9NM2x+5Bd5yuEcb50bpJMkQOb1uzgVXzLgT+tFdmMEbqeB
        H6tFwOPbFMxHwH7SfHGcz7DXrB9VLQdhVQ==
X-Google-Smtp-Source: ABdhPJzUlkUG/BITLXb5RRxyxqOPgoOt73F/PAgXXw8es1xb68twKcc8cvL1XCKIGzp8SKt1KLyfmA==
X-Received: by 2002:a9d:12c:: with SMTP id 41mr6766588otu.77.1607624040467;
        Thu, 10 Dec 2020 10:14:00 -0800 (PST)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id e81sm1158596oia.30.2020.12.10.10.13.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 10:13:58 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id l200so6718099oig.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:13:58 -0800 (PST)
X-Received: by 2002:aca:6502:: with SMTP id m2mr6058702oim.105.1607624038142;
 Thu, 10 Dec 2020 10:13:58 -0800 (PST)
MIME-Version: 1.0
References: <1607612975-5756-1-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1607612975-5756-1-git-send-email-pillair@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 10 Dec 2020 10:13:46 -0800
X-Gmail-Original-Message-ID: <CA+ASDXN4uLsbo7uuO7WPaUBY+mqHQRfdMHJ4R9KBqqmiVQJUcA@mail.gmail.com>
Message-ID: <CA+ASDXN4uLsbo7uuO7WPaUBY+mqHQRfdMHJ4R9KBqqmiVQJUcA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Remove voltage regulator votes during wifi disable
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>, kuabhs@chromium.org,
        Youghandhar Chintala <youghand@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 7:09 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -1045,14 +1085,18 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
>         ret = ath10k_snoc_init_pipes(ar);
>         if (ret) {
>                 ath10k_err(ar, "failed to initialize CE: %d\n", ret);
> -               goto err_wlan_enable;
> +               goto err_free_rri;
>         }
>
>         return 0;
>
> -err_wlan_enable:
> +err_free_rri:
> +       ath10k_ce_free_rri(ar);

This change in the error path seems to be an unrelated (but correct)
fix. It deserves its own patch, I think.

Brian

>         ath10k_snoc_wlan_disable(ar);
>
> +err_hw_power_off:
> +       ath10k_hw_power_off(ar);
> +
>         return ret;
>  }
>
