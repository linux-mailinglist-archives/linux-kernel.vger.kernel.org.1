Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACECE276B3B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgIXHxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgIXHxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:53:05 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504BDC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:53:05 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l126so1395466pfd.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Yv4LWoL/EotEUZL/RKuRP4UD2KLvMLmgrQWE3rymaHQ=;
        b=QTSYS9zsVnUIG2lRDVPd1H7PTGeRYkgK0TTJ176QNoMq0iZgGnPV0B6VbX8/F3Q8TZ
         GtJQ2xke2oUW7DklAhqKjnXfMdRmifsTnLvH8qt6MXM8ndMWk53zYrRUIYrAAm6Uu8jr
         jUrFxJWpk+ngtNg7ganJMqQ6eHYSldUQK69zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Yv4LWoL/EotEUZL/RKuRP4UD2KLvMLmgrQWE3rymaHQ=;
        b=Bi92INrwRvBfuqqF+8Y2hy/aLSSCRe0tjllG7/uPjcfObpC1G8Waxp9TfOOu4f4eeu
         5tTtuES1QySzmkUl3C+6IFMZGZhTiy3ZzFBNG4IQjL4+AEeZoCZPlVinfktWKidDCipw
         4zJvimOtmDPTEfQnSRF0zssVR8t/YCQB30+TRjPPk6IVRqjAuqwX65uquRVdPhjDvY6S
         HQ0lrD8doOqZkJjPy3vCkiL7kRySSxSmAntPy5PaStWT9JekHRc9w0+xhqnJReIIEgDD
         7Cmsaa5PGBtlqY50ohtSaN6zPLkH8U6Ctv0eZ0TeWlBnwVdnvjJtrsbacGytwGBpSUaC
         vJhw==
X-Gm-Message-State: AOAM530nIt6/hAQmI1j29fzzPM3zd0JydergC+3Ax4/n2Q3jmpNc+cyP
        sjrqgszv3dWm8tx9aXapoNjvSP7/Oeu20A==
X-Google-Smtp-Source: ABdhPJw652M7uF3+ebs+rkXd6pvMrBXf3A7VMNdX8YdqKk5C2W3BugAS7vCpPyr/4pu/r6g/JE6bUg==
X-Received: by 2002:a63:3047:: with SMTP id w68mr2863262pgw.341.1600933984623;
        Thu, 24 Sep 2020 00:53:04 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id i25sm2100379pgi.9.2020.09.24.00.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:53:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1600930266-9668-4-git-send-email-mansur@codeaurora.org>
References: <1600930266-9668-1-git-send-email-mansur@codeaurora.org> <1600930266-9668-4-git-send-email-mansur@codeaurora.org>
Subject: Re: [PATCH v3 3/4] venus: core: vote with average bandwidth and peak bandwidth as zero
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org,
        Mansur Alisha Shaik <mansur@codeaurora.org>
To:     Mansur Alisha Shaik <mansur@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Date:   Thu, 24 Sep 2020 00:53:02 -0700
Message-ID: <160093398246.310579.10928011770055575848@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mansur Alisha Shaik (2020-09-23 23:51:05)
> As per bandwidth table video driver is voting with average bandwidth
> for "video-mem" and "cpu-cfg" paths as peak bandwidth is zero
> in bandwidth table.
>=20
> Fixes: 7482a983d ("media: venus: redesign clocks and pm domains control")
> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> ---
> Changes in v3:
> - Added fixes tag
>=20
>  drivers/media/platform/qcom/venus/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/pla=
tform/qcom/venus/core.c
> index fa363b8..d5bfd6f 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -385,11 +385,11 @@ static __maybe_unused int venus_runtime_resume(stru=
ct device *dev)
>         const struct venus_pm_ops *pm_ops =3D core->pm_ops;
>         int ret;
> =20
> -       ret =3D icc_set_bw(core->video_path, 0, kbps_to_icc(1000));
> +       ret =3D icc_set_bw(core->video_path, kbps_to_icc(20000), 0);

This gets added in the previous patch. Why not put this patch before
that one?

Anyway..

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
