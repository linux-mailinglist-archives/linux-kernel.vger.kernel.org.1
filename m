Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09382CAC7C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392417AbgLATgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392393AbgLATgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:36:41 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E39C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:36:01 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 79so2810832otc.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UKsu26Ei1Ztq2Et7FDKCZoO2+MwWkWzcYFWc7u1thjs=;
        b=TzYx/y8d9otKKUrRpEWdlv2NN/GJsX5LiAF2My919rOqrTKIQ0NpHOaJmGOsaXfwxr
         21QPFORVReSfhLYJ34UjXDDyTNwJygJCN6vNQ/oQ3fzlnsFWoocu/opUKbqFKh4qBx+5
         1wFcVhkMNCgz5KkFgH//GRe4faOH3Gw/ITBQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UKsu26Ei1Ztq2Et7FDKCZoO2+MwWkWzcYFWc7u1thjs=;
        b=prYCOQ6FBZvzH22kMhkdJzG6eBtWp5U5SRInFXuW0PQ4CTJJERvBpoJvFv0+0kDpza
         ZaDfjgYk6N1kFVr8n2uSMLLFGGzjGWt6I5WzfIYgSswI/5nsFQwr8ZgQAc/0Zo0UpREL
         sJq2oFPxEbR6qwlmU6v9ECbCDF2zDYNuS6gXRRQ970ZJ+5hwDRjzpnb/m5CFfZ30TAwz
         Gf4a5pDmjExJzy+1zBZsgsOD4DNEKFAHUCXb6pI4vwHg+zzCAfFBtPKyZgvIvmlJzJin
         N1RD6a61sXC0VdM7SqiTi23y2aFsl80aa5XjQqjL6L3eJb+nQltvP1GuoFATxBYsslIS
         TfPQ==
X-Gm-Message-State: AOAM5304OkNCMp4y5T012r62tNF8CM2K8WdU+/j7heei2BI0DYxf3axH
        JsdOgyNNbR77xr1NlLr192QQrWVbtW9eyg==
X-Google-Smtp-Source: ABdhPJyc4BQWrj70Cxb0soicHIsN8uS2jySZG7giGSnG+lFqeqhSRhBas/tINmd95GB1dKcJXJ0k7Q==
X-Received: by 2002:a9d:481a:: with SMTP id c26mr3193157otf.58.1606851358994;
        Tue, 01 Dec 2020 11:35:58 -0800 (PST)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id g6sm166530oov.19.2020.12.01.11.35.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 11:35:57 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id w9so677420ooh.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:35:57 -0800 (PST)
X-Received: by 2002:a4a:c884:: with SMTP id t4mr3058694ooq.52.1606851356706;
 Tue, 01 Dec 2020 11:35:56 -0800 (PST)
MIME-Version: 1.0
References: <20201126171553.2097-1-youghand@codeaurora.org>
In-Reply-To: <20201126171553.2097-1-youghand@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 1 Dec 2020 11:35:44 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOvnfETrKs2ZbayZsRkUEpUbaeMGRkZNRCXa=M28HHE-w@mail.gmail.com>
Message-ID: <CA+ASDXOvnfETrKs2ZbayZsRkUEpUbaeMGRkZNRCXa=M28HHE-w@mail.gmail.com>
Subject: Re: [PATCH v2] ath10k: skip the wait for completion to recovery in
 shutdown path
To:     Youghandhar Chintala <youghand@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>, kuabhs@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 9:16 AM Youghandhar Chintala
<youghand@codeaurora.org> wrote:
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -1790,9 +1790,6 @@ static int ath10k_snoc_remove(struct platform_device *pdev)
>
>         reinit_completion(&ar->driver_recovery);
>
> -       if (test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
> -               wait_for_completion_timeout(&ar->driver_recovery, 3 * HZ);

Hmm, this is the only instance of waiting for this completion, which
means that after this patch, 'ar->driver_recovery' is doing exactly
nothing. Should you instead just remove it completely?

Also, if your patch is correct, it seems like the completion was never
needed in the first place. You should probably address such a claim in
the commit message; is there truly no need to wait here? Or was there
some purpose here, but that purpose was accomplished some other way?
Or was there a purpose, and that purpose was misguided? It feels to me
like it is indeed correct to remove this (shutdown should be performed
promptly; we don't need to delay it just to try to "finish
recovering"), but it's your job to convince the reader.

Brian

> -
>         set_bit(ATH10K_SNOC_FLAG_UNREGISTERING, &ar_snoc->flags);
>
>         ath10k_core_unregister(ar);
