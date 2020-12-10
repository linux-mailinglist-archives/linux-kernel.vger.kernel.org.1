Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFF12D5878
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgLJKok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730351AbgLJKoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:44:10 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B1DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:43:29 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id j26so3135261qtq.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HCXHdtmiujJrojUr10RP4Pb9dzIfVOToeT49LuGH/ks=;
        b=UGZc44LK50KqhqXQsFjm39B+rL98RRFWKa2cAbYIxUjv+cwLVW+6/kPmHLuJqecyGT
         Km5ihpsn9RqSobMcFcxoeYnWXsp+TZdsak67o5aEg5UJloaadciAVB1Az6Km88QiBU6o
         g1D0+qcgHgQL3qXSViLTBj5jHFPcIaVQDiyTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCXHdtmiujJrojUr10RP4Pb9dzIfVOToeT49LuGH/ks=;
        b=aD4TUYK7Hzdr/0KSX72I3Gwm5GE7YgYvSTDXX6aVqL67//sGzuZqUsG9yfRIjR7BBE
         jizTzqUdcjVLT8ONQGn2Ko89di6ARswslFbL+5oGwOvxY0P41qNQgeFlmevCXKn7zmqM
         wRQj3IDchW9ljWy/imMuqwkg1tJ/HPALcDtH25AHi6IKvX2Qr+6hhMyxkOIawIHHmkvA
         v1X2buOfdI9Ae5M+RHiPzBVmh04y6aYRhCvFt6/MexLELSGeRCRSZpE5prrj9yqCDOTa
         1/9QvyYV5bduH1JJHFCglesQDBMV7hOqBUPeEWxRAEe0Ri4/kVCQaeSirHCqinHffDWC
         KPTg==
X-Gm-Message-State: AOAM5326UGYgffE6kfJKTHndrt+MQrcJQlyujVOcc3W0e8YpuSOWRC29
        IkCZZwTUL3ZKk7cehHEXj5RKKMM20+vzZQgs65zUsA==
X-Google-Smtp-Source: ABdhPJy3bPoQAsDQ5caqqcvDV2zL3T+aJ9ttI6e7E0xNhqz+94xh6Lw9p9EWpi/WKJqy3Oa8sA1obBIg2dhDfLw+LY0=
X-Received: by 2002:ac8:590f:: with SMTP id 15mr8286163qty.249.1607597009028;
 Thu, 10 Dec 2020 02:43:29 -0800 (PST)
MIME-Version: 1.0
References: <20201201134330.3037007-1-daniel@0x0f.com> <20201201134330.3037007-2-daniel@0x0f.com>
 <20201209163536.GB566058@robh.at.kernel.org> <CAK8P3a0D+XQREm7Gw5-7-byiz7eufYGT_r-XC3H6_whdOB0a1w@mail.gmail.com>
In-Reply-To: <CAK8P3a0D+XQREm7Gw5-7-byiz7eufYGT_r-XC3H6_whdOB0a1w@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 10 Dec 2020 19:43:18 +0900
Message-ID: <CAFr9PXmqS-CX2zrrKVy4FAF7X6J-CrDBe-NMBNXjf7S5oMo5dw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: mstar: Add binding details for mstar,smpctrl
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, DTML <devicetree@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, 10 Dec 2020 at 02:45, Arnd Bergmann <arnd@kernel.org> wrote:
> Daniel, please send patches on top of this series to address Rob's
> comments.

Will do. On the enabled method one I had a question for Rob so I'll
wait for a reply to that and then send the fixes.
Sorry about the trouble caused.

Thanks,

Daniel
