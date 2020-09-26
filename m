Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D203F279B2F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgIZRLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIZRLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:11:38 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17887C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 10:11:38 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n13so5688717edo.10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 10:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4TNtZY7T1WFexHeXE2tjx8zSAuQoR2lBax7QorKn3Es=;
        b=i6XAQmiL/jaodeEz/PPMWiB4Sf6Ih5vRFdQ1uA7azEI4lDq6dXE+SebrRCcR+WKFtZ
         udOEXpyfEWHb5GTQzHGhhz5DaRsEZwcd2eqOZq+q8qDJBBWK4Hzz9oL2Cmeb6EpGVqi1
         15RxQitwJb9yOZSMik1dKnUDG7t7BLzx8CiOwhLEQukKSLB24scSpVm1EDtzihHeLHLz
         kQo+r1bzwaf1ul/8YPzk40zzCwp0JcJZQz3kyR3Dh0o04hif32qKosphD5S5DErjYR1s
         /MzSH/l8lbacf3ohZCFEH52eMuWy5RM/497loKa3sc4m7POWGdviXzH+Rk6R5zcn3gua
         lsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4TNtZY7T1WFexHeXE2tjx8zSAuQoR2lBax7QorKn3Es=;
        b=fK///Vt3xK3MBpiC6lkHtTEKG+9TWvSPvNOsxzZL60Hzui/cTa58EH5t1LElRtaKC6
         GoaZ5oBZAOyfXd0/kCZwIzlYwN7ZtBg+bN2uFgUtnd+yVfVhL11+JC24u/5Q9Pvb+8q0
         NeaYIBKZ4JYTxNNhSfF4IC4ssaw5/1yaGK2i8AloOOvx7+VEUXGPtp2BPG7Ap1oCPXXA
         V4kMyi/qIzgAApIckh9fbdvMp7ACRrnV88FmfFfbERs+iqd9XtSr+Tqd4PeongTRQDtx
         XuEnB1q7+DpJ55FKKNu8/LZ6wY4/ceAw3eSkmX1ljrJOV0zJX2J0wZe3khHuL3LwRuUZ
         /d3A==
X-Gm-Message-State: AOAM532/AhJbsGqkl8qE1GGl5rMP8eJ5zl85W6eT24BeTRpTfz3LqhJD
        3rGnUZncdodxZhe0R851qmdddwIgmEL2tSc35px5tg==
X-Google-Smtp-Source: ABdhPJzQlUjHYrni36vDDSqqsDKWKBvHTgeb8vpOyDGry0XykaPIbFi7g5zFVfK63riZ8cuVIG63qacggI4g0sBavz0=
X-Received: by 2002:aa7:d4d0:: with SMTP id t16mr7506374edr.83.1601140296368;
 Sat, 26 Sep 2020 10:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <1601103820-14002-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1601103820-14002-1-git-send-email-wangqing@vivo.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Sat, 26 Sep 2020 10:11:25 -0700
Message-ID: <CABXOdTcTBHhxDfnrAFMLZ7fVPq2p6rPMTFceAkRNN4SKvvC1FQ@mail.gmail.com>
Subject: Re: [PATCH] chrome: Use kobj_to_dev() instead
To:     Wang Qing <wangqing@vivo.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 12:03 AM Wang Qing <wangqing@vivo.com> wrote:
>
> Use kobj_to_dev() instead of container_of().
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_sysfs.c | 2 +-
>  drivers/platform/chrome/cros_ec_vbc.c   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> index d45ea5d..a643ea8
> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> @@ -326,7 +326,7 @@ static struct attribute *__ec_attrs[] = {
>  static umode_t cros_ec_ctrl_visible(struct kobject *kobj,
>                                     struct attribute *a, int n)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>
>         if (a == &dev_attr_kb_wake_angle.attr && !ec->has_kb_wake_angle)
> diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
> index 46482d1..f3a70a3
> --- a/drivers/platform/chrome/cros_ec_vbc.c
> +++ b/drivers/platform/chrome/cros_ec_vbc.c
> @@ -17,7 +17,7 @@ static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
>                                   struct bin_attribute *att, char *buf,
>                                   loff_t pos, size_t count)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>         struct cros_ec_device *ecdev = ec->ec_dev;
>         struct ec_params_vbnvcontext *params;
> @@ -57,7 +57,7 @@ static ssize_t vboot_context_write(struct file *filp, struct kobject *kobj,
>                                    struct bin_attribute *attr, char *buf,
>                                    loff_t pos, size_t count)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>         struct cros_ec_device *ecdev = ec->ec_dev;
>         struct ec_params_vbnvcontext *params;
> --
> 2.7.4
>
