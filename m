Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3372A0884
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgJ3OyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgJ3OyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:54:00 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D588FC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:53:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x23so3073320plr.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CkQFDq2V3fTRnTqwrpougjs6hrzT2Mg5FLap+tCFeI0=;
        b=G9li2Tvz7YB3v7bQVSR3T+G91Gn4Q1O/LxAV2YyfxdIcTWerCiyFiIVBFA/l2Kts6+
         iO363f1lgr5WtxxvPlDzy9sNMRswErv+Ay3jyuSByl2mPqHG1ByPQ8WdZB0Z5qeMMdDC
         O0tFO9VVUyKNyK8fAC9/VLINWtqhE76QJFqnZwm+ZuVPN3beg+3jf5mQ9OD0CPkuLtdn
         b2YVS7FMoX7EYNOtz/W18Z7UNGP+lFFCMHO+bOu78Si3q660H/mjD+wLbY7VO2bFHVYL
         39ylpHs/5qWJ5MuAtCuAioXn7p6AXDgYqNWGtv5dAR1PH4OnB5yXz/eSKXJxSIdoOEJ5
         2hFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CkQFDq2V3fTRnTqwrpougjs6hrzT2Mg5FLap+tCFeI0=;
        b=ZhdAnGshqDpRzkrEeS/w4ttbahs+y5SbtCogZF3S3dmqovkGeXh+4BwtvBPiq8OOCs
         YwJQ/tMjIwsT/T2pn0sjKuq0ohEWGiO4ZlPHatPygg8E8MsMXOGoZYa7QoEVLlwstfK9
         gIcBbO8BUOzh84SSYfGoNz25JxAex0BERLj+YhrB/uHATuk2m70M07KQWDXWK/6Q/CgY
         wytL1bUsH+SA6SCLHFYm4RQ9MYBqHcN7011jKcIBZT8wXKBhe+oniWNZeIsY8Z0PvWTR
         93viqdlIqtTkKNTuEPntRUZd43ON7artAAyYfqEFpuscyJ4v2ai+BrerSnzLtgUQ0+mZ
         RvJA==
X-Gm-Message-State: AOAM533Pjw9DONahQQTaQ+QqIuTM8jaaqp1b/dUo87yCZsIMsfa39KgA
        vfhnnBtPU8yXSI7BEVTL7cY=
X-Google-Smtp-Source: ABdhPJyvA4VrWnyjoOxNgcBLcrNyRQ8yIc1KHqAj6mmJQxnD7c8Pj7HTBZSnzbcoRfNfc1d2agC2gg==
X-Received: by 2002:a17:902:b688:b029:d6:ad52:ffab with SMTP id c8-20020a170902b688b02900d6ad52ffabmr950049pls.61.1604069638420;
        Fri, 30 Oct 2020 07:53:58 -0700 (PDT)
Received: from localhost ([240e:472:3d00:779:b01a:f9a7:6a68:30ac])
        by smtp.gmail.com with ESMTPSA id u14sm4039534pjf.53.2020.10.30.07.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:53:58 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Fri, 30 Oct 2020 22:53:22 +0800
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 9/9] mfd: sprd-sc27xx-spi: remove unnecessary
 CONFIG_PM_SLEEP
Message-ID: <20201030145322.agt774ib5jgin7du@Rk>
References: <20201029100647.233361-1-coiby.xu@gmail.com>
 <20201029100647.233361-9-coiby.xu@gmail.com>
 <CAAfSe-vv=EXzC4xjnF6RNO+ifoodYCui4cgdodNisQio0TLHtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAAfSe-vv=EXzC4xjnF6RNO+ifoodYCui4cgdodNisQio0TLHtg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunyan,

On Fri, Oct 30, 2020 at 12:02:03PM +0800, Chunyan Zhang wrote:
>Hi Coiby,
>
>After removing CONFIG_PM_SLEEP, sprd_pmic_suspend/resume() would not
>be built into symbol table with clang compiler though, that would
>cause clang compiler report warnings of "unused function" if
>CONFIG_PM_SLEEP is not set. So I also prefer to add a __maybe_unused
>instead as other people suggested in the mail list.
>
Thank you for the suggestion! At least Lee prefers to CONFIG_PM_SLEEP
thus to keep the status quo. I'll see he'll change his mind with the
ongoing discussion [1]:)

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2361371.html

>Thanks,
>Chunyan
>
>
>On Thu, 29 Oct 2020 at 18:07, Coiby Xu <coiby.xu@gmail.com> wrote:
>>
>> SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG. Signed-off-by: Coiby Xu <coiby.xu@gmail.com>  drivers/mfd/sprd-sc27xx-spi.c | 2 --  1 file changed, 2 deletions(-) diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c index 6b7956604a0f..4db2ec9ef2ff 100644 --- a/drivers/mfd/sprd-sc27xx-spi.c +++ b/drivers/mfd/sprd-sc27xx-spi.c @@ -206,7 +206,6 @@ static int sprd_pmic_probe(struct spi_device *spi) return 0; -#ifdef CONFIG_PM_SLEEP  static int sprd_pmic_suspend(struct device *dev) struct sprd_pmic *ddata = dev_get_drvdata(dev); @@ -226,7 +225,6 @@ static int sprd_pmic_resume(struct device *dev) return 0; -#endif  static SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops, sprd_pmic_suspend, sprd_pmic_resume); 2.28.0

--
Best regards,
Coiby
