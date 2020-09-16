Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3331A26C60B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgIPRat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgIPR2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:28:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C07C061355
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:17:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bd2so3544879plb.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=icqQdJptZU1+Cli7+KP35XPpco/lrViFrPCj4c4ItTU=;
        b=mNTDCrovWeR++HPoKJ5nc9Jd4bCTN0psmXsvkS5E3/I1fy+W6uAlWjYQsHgbHwIjZT
         7rW0VJ1LogMzOqE+y/JfsZJsMrGDIOaoBaWZZmqKsie1JUYETlh8qdq2SSI2nhoZ27I7
         FZQfkeVKS19jy6I03LnAS/dFZwDUNick/O9kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=icqQdJptZU1+Cli7+KP35XPpco/lrViFrPCj4c4ItTU=;
        b=nDfK234E44q8jN4lSS3Y/duG1QE0B+Si6XEq97WA8FD0R0zdl2Ru1O3yFcGV8xMYAH
         oev0Dj1yDD61kBMGQYCBEn8VSE+32EAgEMjlG31DT0je4jw5HNOf37+bFnlEQK3k+1wf
         yw1gZ713JoIJCJlotdpo+hYDJqzXq7CBhW2QpO6UsORkuFy2WjHRCR4mMowzpyx9YKa8
         Sqti+Csb70lstVFJFBTsJQhnWEJEgDZK68AYdijvPTW7XL3rv6dViDT5oh1C2GdZn09/
         arY0yFqh8pYMGfu3M44CT0XpFZFzEySRQg/LJD2c7c9RJdeWIGWY5M4UzE27sqq7psd4
         eNAA==
X-Gm-Message-State: AOAM531DD6NzPuZpKOwZryYYGkWu/fRkE441/Ozb/djBB5GkQLklLiE6
        MXnlHw5XZpV0TSc8k/qSj6UBKA==
X-Google-Smtp-Source: ABdhPJwls/xnxK0gmUalIkWlfpej7xUrnrowqMX77b9HSLjNZLh8iL4/eR5Em7wKVHXEpoKFK6BvkQ==
X-Received: by 2002:a17:902:8643:b029:d1:920c:c1db with SMTP id y3-20020a1709028643b02900d1920cc1dbmr25400194plt.42.1600276671136;
        Wed, 16 Sep 2020 10:17:51 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id x4sm17420010pff.57.2020.09.16.10.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 10:17:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200916145252.16024-1-sibis@codeaurora.org>
References: <20200916145252.16024-1-sibis@codeaurora.org>
Subject: Re: [PATCH v2] remoteproc: qcom_q6v5: Assign mpss region to Q6 before MBA boot
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, evgreen@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org
Date:   Wed, 16 Sep 2020 10:17:48 -0700
Message-ID: <160027666863.4188128.6191735162530147774@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2020-09-16 07:52:52)
> On secure devices which support warm reset, the MBA firmware requires
> access to the modem region to clear them out. Hence provide Q6 access
> to this region before MBA boot. This will be a nop during a modem SSR.
>=20

Does it need a Fixes: tag? Probably.

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>=20

Trivia time!

>=20
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom=
_q6v5_mss.c
> index c401bcc263fa..f989ca81d374 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -931,6 +931,16 @@ static int q6v5_mba_load(struct q6v5 *qproc)
>                 goto assert_reset;
>         }
> =20
> +       /* Some versions of the MBA firmware will upon boot wipe the MPSS=
 region as well, so provide

Should have /* on a line by itself.

> +        * the Q6 access to this region.
> +        */
> +       ret =3D q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, false, =
true,
> +                                     qproc->mpss_phys, qproc->mpss_size);
> +       if (ret) {
> +               dev_err(qproc->dev, "assigning Q6 access to mpss memory f=
ailed: %d\n", ret);
> +               goto disable_active_clks;
> +       }
> +
>         /* Assign MBA image access in DDR to q6 */
>         ret =3D q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, false, t=
rue,
>                                       qproc->mba_phys, qproc->mba_size);
> @@ -1137,8 +1147,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
> =20
>         /**

Should be /* instead of /**, the latter is for kernel-doc which this is
not.

>          * In case of a modem subsystem restart on secure devices, the mo=
dem
> -        * memory can be reclaimed only after MBA is loaded. For modem co=
ld
> -        * boot this will be a nop
> +        * memory can be reclaimed only after MBA is loaded.
>          */
>         q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, true, false,
>                                 qproc->mpss_phys, qproc->mpss_size);
