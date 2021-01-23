Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C761E3017C2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 19:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbhAWSvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 13:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbhAWSvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 13:51:40 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8421C0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 10:50:59 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q129so18305408iod.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 10:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+w2L7sIwOft/kpC6AV4o3i6vRyAbuDXd8tlN+nR2to=;
        b=ZiKN+MqnM5JH2l0renrgZkVnqGw729VFyyERNeqZAU9mEfRz1EMx2fI90HqAxLsvhk
         wljCetWri+jJeDDhbTjWdVQ9KK+zOlLq9hrzdTsPGktqjmbheyZhXZ4aejycKdROmnzE
         QEsUiBKgkGH289eoPlvcEbUauLVHFwQPgWxhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+w2L7sIwOft/kpC6AV4o3i6vRyAbuDXd8tlN+nR2to=;
        b=a4A3WYFhf2MT/faK8uT6pRGbfX477I6z60ob/IaSH/n3/0160DIqdlNwHQsH+43NsG
         VGlo31zm6ACHg1maSJpGJHajoKc/122E1iTHUoQeMxXQ0zQKw+gqrsBIqMWuP1cCar/K
         OFTBbFhwDWKRJtFZhyOyj+2+0+yzBKOHDSPk0NUqXrzeYcXK9kg3tUUmZ2Ql44j1pUUn
         2uXLRQZCooaDgd1+mV2Ybc2OBVc7tVhxjyPqzgMyqErbmYhjJnXtZb0j7N6KgvFPiuu9
         t47lVHl/fxwTryQZL3NcIb5XxNAfJFojahqi/BEHylpSWbfRD21yLzxYFx0pMk/zswhm
         Gvmw==
X-Gm-Message-State: AOAM530eFhzTRU+OZo2FaDorz1nvrpZxo8dTD7KZqiAEooqpVgfYHuOp
        C1GqxpKMltRlqNK2hF1hkcS+tHfgY1ANH5ClmBPf2qtmyGJ+Hw==
X-Google-Smtp-Source: ABdhPJzCaU2/nupwwEHfJeLInWkUbje3f1zj+tZd56tc+2WooqYNK7AeK3AQtG/zdKeyJOs2fzyE+drtUpegtCiXrho=
X-Received: by 2002:a05:6e02:6ce:: with SMTP id p14mr629823ils.50.1611427859012;
 Sat, 23 Jan 2021 10:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20210123154922.1309290-1-dnojiri@chromium.org> <20210123154922.1309290-2-dnojiri@chromium.org>
In-Reply-To: <20210123154922.1309290-2-dnojiri@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sat, 23 Jan 2021 10:50:47 -0800
Message-ID: <CAPUE2uteRNWVYDSeDnadsgXPdsLMMOZTGbJvtzeudC3SP7uMtQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mfd: cros_ec: Add peripheral device charger
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     Vincent Palatin <vpalatin@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Alex Levin <levinale@google.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Ching-Kang Yen <chingkang@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 7:54 AM Daisuke Nojiri <dnojiri@chromium.org> wrote:
>
> This patch adds a cell entry for PCHG (Peripheral CHarGer). PCHG is a
> framework managing power supplies for peripheral devices.
>
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> v1->v2
> * None
> v2->v3
> * None
> v3->v4
> * None
> ---
>  drivers/mfd/cros_ec_dev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 6135321592b76c..f3bc1cb6891ba5 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -116,6 +116,7 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
>         { .name = "cros-ec-pd-sysfs" },
>         { .name = "cros-ec-sysfs", },
>         { .name = "cros-ec-pd-update", },
Will not merge upstream, "cros-ec-pd-update" has not been upstreamed yet.
> +       { .name = "cros-ec-pchg", },
In the other patch, you said the driver probe routine will be called
when the feature is supported. For every EC, even older one, these
drivers are always called. If there is a feature flag in the EC (see
ec_feature_code), you can use cros_subdevices instead.
>  };
>
>  static const struct mfd_cell cros_ec_vbc_cells[] = {
> --
> 2.30.0.280.ga3ce27912f-goog
>

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
