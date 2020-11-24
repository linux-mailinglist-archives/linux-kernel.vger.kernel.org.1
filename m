Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D522C2C22A6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbgKXKS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbgKXKS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:18:29 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B6CC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:18:28 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id l1so2215398pld.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jBs6szak71U1kYlF48R2uzvxU1ivk4Y6vDzm9BST0bg=;
        b=rL12uS7MAzPqf40BE8pmGuEbYzuUtSHtVdEjT8pvCryUjrDFCNJ2Se+gsjtqhluhCP
         tmaL2p7VLv/mpFsuwfsQgI2XO1ob1/FmyDaaxPx7EnHNMs+av0oIU7D7K9TWDgZncnC5
         9OlJeKW7iLSdsot1ZFWLlW9s8uOqCs3H99WfflvHCQati8f9237zg5zUZniJQikmN5FS
         exXTC0p/Ci4U6bTD2fKC9AjZz4kPMJGFJJ7HRRmHF2tXbXLjHyayS+PwSvMvyrfvh5za
         dcix4ZCPGsTxTPfLUj38yZD4ps/lDoHct/OwNTdJyIAc+OiReXPf8XlpI2GPiM33Vj5j
         smgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jBs6szak71U1kYlF48R2uzvxU1ivk4Y6vDzm9BST0bg=;
        b=qnHXxh2IdGay+r76pW/8Zh+TmDmIxHDAiRDNkrrKZYq/kzPCdSzlW2HuzR0k4SLXO4
         YP29gm+l3Iq2Kb7cVnZ8Xm/8tpJOy5wIJ4bpWk9O8SGw2CVdKGLRg2m1TENwWlogG09C
         +UvDf1sOQXUFEG/S5NghX9cc5tJRqZXLVmrTasaeVm7qDk43bFwTWL6CdBHislObo2Y+
         G1+4OvFXqDp5CJsiggx6v1wyGZvRaMNtq0VhyMqxEno4z8NfpnQNzM2dlAHJAGA5onLr
         rrJENkh5SXcKQZvBkPkqJYba8RZofHuyopIO3kz+m/jbj4gzYI/CHE+AVHyOb3x5W+eY
         WdaQ==
X-Gm-Message-State: AOAM533XI7PU8aGqr/iCIo74BVFrf8PlmcB5RV+zp29XYVPMu0OPfSBO
        +LvoikV6wsV8cUqd1ssXnKS4tux3lTIk9MjQADaUdw==
X-Google-Smtp-Source: ABdhPJwGx/meVclo0nkuNMkwc1P+7kvuyhTUi/wbchqwPOh9eLDSa1ljk+UOFGa/tXJotsm+jGDrqNny6wuqwGFLIgI=
X-Received: by 2002:a17:902:7d94:b029:da:53c:f7cb with SMTP id
 a20-20020a1709027d94b02900da053cf7cbmr3386269plm.69.1606213108539; Tue, 24
 Nov 2020 02:18:28 -0800 (PST)
MIME-Version: 1.0
References: <20201116155008.118124-1-robert.foss@linaro.org>
 <1606203651.4733.134.camel@mhfsdcap03> <20201124084343.GD3940@paasikivi.fi.intel.com>
 <CAG3jFytX_=RcKyLkNOSCEmNHnruxSP_=PNFuGRdrevJ17x4ndQ@mail.gmail.com> <961bb1b9384a4261949e9afd1e37d43e@MTKMBS31N1.mediatek.inc>
In-Reply-To: <961bb1b9384a4261949e9afd1e37d43e@MTKMBS31N1.mediatek.inc>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 24 Nov 2020 11:18:17 +0100
Message-ID: <CAG3jFyvvf4qbG18KPUNjnA6pyNU0Lz3Wpmjia5+23eGo9z7+5w@mail.gmail.com>
Subject: Re: [PATCH] media: ov8856: Remove 3280x2464 mode
To:     =?UTF-8?B?RG9uZ2NodW4gWmh1ICjmnLHkuJzmmKUp?= 
        <Dongchun.Zhu@mediatek.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ben Kao <ben.kao@intel.com>, Tomasz Figa <tfiga@google.com>,
        =?UTF-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?= 
        <shengnan.wang@mediatek.com>,
        "bingbu.cao@linux.intel.com" <bingbu.cao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 at 11:17, Dongchun Zhu (=E6=9C=B1=E4=B8=9C=E6=98=A5)
<Dongchun.Zhu@mediatek.com> wrote:
>
> Hi Robert,
>
>
>
> Just updated the identification method of first pixel on list.
>
> The bayer order for the new setting (either FULL or BINNING mode) shall b=
e BG/GR.
>
> This has been proved both theoretically and experimentally.

Thank you for verifying that BGGR mode actually what is produced.
