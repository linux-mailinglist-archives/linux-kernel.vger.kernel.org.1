Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26FA2DC5D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 19:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgLPSCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 13:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgLPSCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:02:02 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB10C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 10:01:22 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id o144so22763862ybc.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 10:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFOQJYvSJRifdqFPCviPjYdpzbh1IqtzJ4CNX1jyZLI=;
        b=Hj/GUH41mTJHNxqAeETQGhZSsXDas2vhqQGy5vEVE+8XPsyeZQXoTbiv6A1bOwFWwe
         xyC8RHG8tX+yWSeya5GYsDpESSvp4ubeJuE97dg93F+kNgOo5l3eEjWBOH4foLMhsiCY
         Bhb2czRuz3O+8AybDHUi3PWFmWVpYvCoj3IyGeQQhTLvRJWFhDCBd5pbFLcsM0LqkM38
         PyEOUF2lhkUneMzERDNZh4Wgq12uQ5r2BQh82fOmoU/FNqSfgjJWy0Az4mUKjYaazyoD
         OzhHuhw04vsaPxtvDmXPcUKQqqVmHDl51y+xsZkfuwbKomlX6IgVvaZtdOZCdtenyjcu
         Bv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFOQJYvSJRifdqFPCviPjYdpzbh1IqtzJ4CNX1jyZLI=;
        b=X39b8CTxrmUsotzuEdZnyOHtDXFUwJx+ubSg5MXMIkJ+CARjB5pc8G+P2kqmSSATuB
         Frg8RoFVYG1kJyvhbOUWyyk/E4CBeUlvnjsOaslvvRFMsRKeXKFQ0/oB50cEKaO+wmf1
         NWfitVwuhTiQr20PbZzXTL4KkOxTkCu8H76brvCVGH2zJim8MPTEBP6jNWISqGU3jN37
         O3AOFrUZdxBY6kPxKUq2E+d2QSmuIElZywyfWqxDLPnUx59dZzO8kx3cnZXs5XDbRrzi
         Zn9vlUCs1u03mV7D7J3Tid53gjwCvimvxdOCfSoOh0/gB2htDETyOKn0iU3lrDvXTyAY
         dY7A==
X-Gm-Message-State: AOAM533kvf/csCrPhB4v2sAsvDSs7FH66+tP3Wy0qAjab3cqnQEXhqJ9
        0Bk4VCJQ2C1UKTUYy31NZ4NzqJqrFjfkDdH3NUcruA==
X-Google-Smtp-Source: ABdhPJwmDODLaLqYbUxaJy1G1Zah31SwTkbkqXj6YB9o3+5QCGCr7BwzqWerCJnYse2Bcrarf+9RkIP5DPRevF1+zT8=
X-Received: by 2002:a25:15c8:: with SMTP id 191mr51030977ybv.256.1608141681760;
 Wed, 16 Dec 2020 10:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20201214173731.302520-1-suzuki.poulose@arm.com> <20201214173731.302520-19-suzuki.poulose@arm.com>
In-Reply-To: <20201214173731.302520-19-suzuki.poulose@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 16 Dec 2020 18:01:11 +0000
Message-ID: <CAJ9a7VjKBg4YTDfGDG0eeQ2jUjN1wid0YzHOS-t9GvEWqT0gtQ@mail.gmail.com>
Subject: Re: [PATCH v5 18/25] coresight: etm4x: Expose trcdevarch via trcidr
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Jonathan Zhou <jonathan.zhouwen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki

On Mon, 14 Dec 2020 at 17:38, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Expose the TRCDEVARCH register via the sysfs for component
> detection. Given that the TRCIDR1 may not completely identify
> the ETM component and instead need to use TRCDEVARCH, expose
> this via sysfs for tools to use it for identification.
>
> Cc: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 009818675928..277fd5bff811 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -2395,6 +2395,7 @@ coresight_etm4x_cross_read(trcidr10, TRCIDR10);
>  coresight_etm4x_cross_read(trcidr11, TRCIDR11);
>  coresight_etm4x_cross_read(trcidr12, TRCIDR12);
>  coresight_etm4x_cross_read(trcidr13, TRCIDR13);
> +coresight_etm4x_cross_read(trcdevarch, TRCDEVARCH);
>
>  static struct attribute *coresight_etmv4_trcidr_attrs[] = {
>         &dev_attr_trcidr0.attr,
> @@ -2410,6 +2411,7 @@ static struct attribute *coresight_etmv4_trcidr_attrs[] = {
>         &dev_attr_trcidr11.attr,
>         &dev_attr_trcidr12.attr,
>         &dev_attr_trcidr13.attr,
> +       &dev_attr_trcdevarch.attr,
>         NULL,
>  };
>

It makes far more sense for this to appear in the 'mgmt' group, per
the grouping in the Coresight spec. This would place it alongside the
other CoreSight management registers, including DEVID, and DEVTYPE
which is used with DEVARCH in the CoreSight UCI, . This is also
consistent with the CTI which places all three of these registers in
the 'mgmt' section.

Regards

Mike


> --
> 2.24.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
