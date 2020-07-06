Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A912159E2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 16:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgGFOtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 10:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgGFOtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:49:23 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB496C08C5DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 07:49:22 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id f24so20723322vsg.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 07:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZIQaWy28Q6coyzuG1qY9Ngjw6X3bVPdqiUrvraZzL8=;
        b=BHcUImo9qjgsxq1gkudZzN+sUyQjlxmS0N5bIQ563ciUaLXhlmI7ZDZ0IrxUT5/a0m
         yWovBEnPgSl0IcA7IeVOGajYo3HaEZv6ptXCcQVT3tek4JZh5mwYeyQdbz5z5TVhKTxJ
         4nstAMyqU2uM4IFZmfgnhFhpo0NcMcBN8N93zEiKkel6KIzRLKDYqeAETlD04LAt3HoS
         ps3R4/w9qJsRr8IvCVB3yB1IGV99H7aHa9wlXzguSrO39T+jzuQ9hFY+RmCWv3jYKl9N
         U+CWgjku012MN+Ixs3l41xbCV5AnF7NMNDII/HO/ekyFsbHVRMSEfv/ABaf/szaWblHZ
         DA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZIQaWy28Q6coyzuG1qY9Ngjw6X3bVPdqiUrvraZzL8=;
        b=FUM8SpHC+Ct8niFSzQ3CYHYnbPpEfd4HXM49LSuCIw9MaDI3Yn57TuHBXScBBuMrpG
         L8oK/+OpS/8khfsuscrzTt59VpjJemfxXvgihJ7RHYxchk2CdsrU5VWPpstWORvxvHpJ
         nw6QhZlAeTooElwuQsVED/np1lvP1AOOJXiHTRAhb7MB+wm0ICeIeb3ZQ7JazQ6Sw8Ml
         S5pw7qIfIXIuLSPXpCFV3Kp+i2+GLJFBTNPf63Karida1HY76NSnaUmFx2R+pd9tuXYR
         gs9Ogy1Adf3+oPKaLoLqXUsYoPWTv7eO2m4DCappcqUJTtX2NpXxiIfNAmfnbl4FMIlO
         iifw==
X-Gm-Message-State: AOAM531JLSB8gSpKUfDzCJFByohDsbtNHmw+J1N5xjibzVevFyRcRoge
        8xdN+PaRtKBM78fXUvbqMIxfFh7BZwdFCU2XtWqH6g==
X-Google-Smtp-Source: ABdhPJzreBcmhG0nNZnUN3x7kDHnm9UhyLfQkeMxDdbCqtFpnCAQ9ED2mzmSMvCoAvNAtHuSQQINFhWiU051rfNcev4=
X-Received: by 2002:a67:f888:: with SMTP id h8mr15841955vso.165.1594046962120;
 Mon, 06 Jul 2020 07:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200617151938.30217-1-f.suligoi@asem.it>
In-Reply-To: <20200617151938.30217-1-f.suligoi@asem.it>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Jul 2020 16:48:45 +0200
Message-ID: <CAPDyKFqXHwi++FuiNtpw3Jmg2-VtAwQ0-AzQBPPTqLZwhtPNsA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: host: sdhci-msm: fix spelling mistake
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 at 17:19, Flavio Suligoi <f.suligoi@asem.it> wrote:
>
> Fix typo: "trigered" --> "triggered"
>
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index b277dd7fbdb5..3f615d0ccb61 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1362,7 +1362,7 @@ static inline void sdhci_msm_complete_pwr_irq_wait(
>   * To what state the register writes will change the IO lines should be passed
>   * as the argument req_type. This API will check whether the IO line's state
>   * is already the expected state and will wait for power irq only if
> - * power irq is expected to be trigerred based on the current IO line state
> + * power irq is expected to be triggered based on the current IO line state
>   * and expected IO line state.
>   */
>  static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
> --
> 2.17.1
>
