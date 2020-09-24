Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24393277189
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgIXMuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgIXMuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:50:21 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724D1C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:50:21 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id z1so951194uaa.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N2mPAW56fKadViU5wZniYvwkuM/5bXXPrgkxeimyQo8=;
        b=CW+OlnYYf1kDTWmN3zq4fe88Ck689LBrfQqha85IBla3o7yw9aMI0PBxYqLuhTfaM5
         TlKOTSvAbNcklOMLvTZUDmb3sAth/Kov9hblt/mS4J73XZgHwVGBdUOy6YGLtTfFQilx
         wDYx5E5CWpAMLoRxZU/OUhpBco3NEDdrEg/gXTFn6OSEgIisHYQ4+OGWUmhmogqFLRxq
         8pofKiKCkn3g/2YdvDPLNqOciZLKxplwqe+o289w8E0uPeyxKNpULtdS2ayayC3CKUma
         /hZKR0jYzVENoLMuaiDIXzte7osGDDUgxl/kjgPiDWT9qUYfWGDXFjMVDpwnTDFmBK+5
         xBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2mPAW56fKadViU5wZniYvwkuM/5bXXPrgkxeimyQo8=;
        b=YsoQU5Du34fZC8fKQPGq5awDH4GKlekPEEByPRslTPEYB/kQizf+IVHTkuqZBL5N3o
         uKSNX8g1APGtg5AgaqrZ0EHke3/HIkGiz6qZ65cxtdWzdfqnUOnL39c8UYX0sW0WHPsz
         UpOsnU9wM3iYp9D+Q3I3ot7waHCxWRYtqkSmsZLz7SIjiQeNcw8MjIuJq5W08lChmhzl
         5Wv/j/DSGuWbDvjBvkeWKS6w2NrPFoFUQaxd1AmxwLDnYH3sxglVBnwsQ4LNyPwdT5IX
         Qwav+zFEREv13rHsDCzoBoaVOJ+moVClW/xlQ7ezaMD9tYBn1OfPbR+dleXdQnscewHG
         ufBg==
X-Gm-Message-State: AOAM531N9FC98mAS8aIEMfBKqMFtaAlLEsUp/IDWOkCZ6QSi7BBREzAq
        IAiBFHRNhbHr5Sc3sBLygK48D9UycLpk3q/GCxPe5Q==
X-Google-Smtp-Source: ABdhPJx7NfTkgqcsTMA8f0/VYZPA8fCdY2JFFwb90om5xipv+nvJ0DDwQJZTAnPOiNegCeLMOG6nAYrdXmKhjgWAIoI=
X-Received: by 2002:ab0:4425:: with SMTP id m34mr2415949uam.19.1600951820686;
 Thu, 24 Sep 2020 05:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200921131042.92340-1-miaoqinglang@huawei.com>
In-Reply-To: <20200921131042.92340-1-miaoqinglang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Sep 2020 14:49:41 +0200
Message-ID: <CAPDyKFpF3+Dr3iJq1Yn2OSnpV4OZ9oVig3g3GzROiiPiiwJyrw@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: rtsx_usb_sdmmc: simplify the return expression
 of sd_change_phase()
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 at 15:10, Qinglang Miao <miaoqinglang@huawei.com> wrote:
>
> Simplify the return expression.
>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index 598f49573..5fe4528e2 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -579,7 +579,6 @@ static void sd_normal_rw(struct rtsx_usb_sdmmc *host,
>  static int sd_change_phase(struct rtsx_usb_sdmmc *host, u8 sample_point, int tx)
>  {
>         struct rtsx_ucr *ucr = host->ucr;
> -       int err;
>
>         dev_dbg(sdmmc_dev(host), "%s: %s sample_point = %d\n",
>                         __func__, tx ? "TX" : "RX", sample_point);
> @@ -601,11 +600,7 @@ static int sd_change_phase(struct rtsx_usb_sdmmc *host, u8 sample_point, int tx)
>         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CLK_DIV, CLK_CHANGE, 0);
>         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_CFG1, SD_ASYNC_FIFO_RST, 0);
>
> -       err = rtsx_usb_send_cmd(ucr, MODE_C, 100);
> -       if (err)
> -               return err;
> -
> -       return 0;
> +       return rtsx_usb_send_cmd(ucr, MODE_C, 100);
>  }
>
>  static inline u32 get_phase_point(u32 phase_map, unsigned int idx)
> --
> 2.23.0
>
