Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A675229FC74
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 05:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgJ3ECn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 00:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgJ3ECl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 00:02:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC4CC0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 21:02:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n18so4966899wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 21:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vjWZgeQF3Hnb5tdCJ+i/96Sx1yBAjj2MSvrs4rWutEU=;
        b=Ngf/V7zTThX+UgeXi04wCUgJCG0ZAyJg9G9QXgvzJf5p/FZE7hbd1Trf5bGDHxUTgt
         Pe8kwXT9+ZfxjMz/pJxkIwAAgL+CPLMsq8hmmB1G74V8pBdA4M2LdhoqUGqCUfze+nun
         7KKuvg0zXbDarpUr1rOvN30GVcrBjISGDh0isy0Y/zBx8vjMDBY+UDalV1A5Vlu+O6el
         brGAYvhMU4kEuvurzdeIeR+Ng6az49T0g+FcW2tyfva4Wo/eBpzFciglzTh767yhzOj/
         FSVK8rg3Nc7rYjSm0WYnd3J/pSg3gfrN3fBp1FLhq3aTxNuKSc8vqu7FDO7dfphOKoWM
         2gJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vjWZgeQF3Hnb5tdCJ+i/96Sx1yBAjj2MSvrs4rWutEU=;
        b=jR+wtaxkktMkakd17aGp7UI6et1pfCAS44nKbgBRTgaAMpJRchOkfe13N51lrRvQIm
         XENM0EFqkbYd+IkOpXesr+TlB43yNpKg2SgvFkPJvo5WQbnFf4dbWH0ApMuucKUHeweI
         QZfDuVQryMAwH4cVjA7swJ36k5nlVQtUzz7wDBajD86L5AK5+3yOJ/semLvkWoAc6lz6
         UhA8Xj5tP0CVRmjUYWSB81j8GMIk0nvZ8RTeVwXeHX0B4biOolDef7/TguCaTZPPxJiy
         hWootocQhefpTztFomAEFdBCF/EmwiBoYAilxL6JmpYT6tdLFzcWZzfkx5QykjurntzR
         kQYg==
X-Gm-Message-State: AOAM531i5pGLQzt7ohAgxCfdyS9vhJnNyuAh5OvGOmsEsMXgUoe2hP4D
        opKkF/nWkWGTgLV0nqkkyvdRf54TqcupY/aK+pE=
X-Google-Smtp-Source: ABdhPJz6VrLiMSegTurNvXqSrj8b9Jp2ijo81GDANxFAWohbS/UL6YDBlH7xbDgi7DHPWVLunUxhQDQs2f73E7Nd9YI=
X-Received: by 2002:adf:ef92:: with SMTP id d18mr416245wro.420.1604030559857;
 Thu, 29 Oct 2020 21:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201029100647.233361-1-coiby.xu@gmail.com> <20201029100647.233361-9-coiby.xu@gmail.com>
In-Reply-To: <20201029100647.233361-9-coiby.xu@gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 30 Oct 2020 12:02:03 +0800
Message-ID: <CAAfSe-vv=EXzC4xjnF6RNO+ifoodYCui4cgdodNisQio0TLHtg@mail.gmail.com>
Subject: Re: [PATCH 9/9] mfd: sprd-sc27xx-spi: remove unnecessary CONFIG_PM_SLEEP
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Coiby,

After removing CONFIG_PM_SLEEP, sprd_pmic_suspend/resume() would not
be built into symbol table with clang compiler though, that would
cause clang compiler report warnings of "unused function" if
CONFIG_PM_SLEEP is not set. So I also prefer to add a __maybe_unused
instead as other people suggested in the mail list.

Thanks,
Chunyan


On Thu, 29 Oct 2020 at 18:07, Coiby Xu <coiby.xu@gmail.com> wrote:
>
> SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG. Signed-=
off-by: Coiby Xu <coiby.xu@gmail.com>  drivers/mfd/sprd-sc27xx-spi.c | 2 --=
  1 file changed, 2 deletions(-) diff --git a/drivers/mfd/sprd-sc27xx-spi.c=
 b/drivers/mfd/sprd-sc27xx-spi.c index 6b7956604a0f..4db2ec9ef2ff 100644 --=
- a/drivers/mfd/sprd-sc27xx-spi.c +++ b/drivers/mfd/sprd-sc27xx-spi.c @@ -2=
06,7 +206,6 @@ static int sprd_pmic_probe(struct spi_device *spi) return 0;=
 -#ifdef CONFIG_PM_SLEEP  static int sprd_pmic_suspend(struct device *dev) =
struct sprd_pmic *ddata =3D dev_get_drvdata(dev); @@ -226,7 +225,6 @@ stati=
c int sprd_pmic_resume(struct device *dev) return 0; -#endif  static SIMPLE=
_DEV_PM_OPS(sprd_pmic_pm_ops, sprd_pmic_suspend, sprd_pmic_resume); 2.28.0
