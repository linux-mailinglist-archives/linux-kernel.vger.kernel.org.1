Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE382F1225
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbhAKMKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbhAKMKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:10:05 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5F7C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 04:09:24 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id e25so14876272wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 04:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qAfBPpGti4IJb/cZMqnoVtqAcc2r4v07Ip2T/G5Ovz4=;
        b=uhMWbETIOgCPmlXFR2NKajl5ifHGLOYARBG1WPZ8kSXAvb5hSGYLFYetzZdbqRoUXw
         xyoBqCRr7vFo267aAYXOqWj3rTMXUbjHBghJ73ThVlXv3QXTjOVXJNI081o+qc8BihBG
         mqA8IW2z2GvDodU1XdOMOVukxzYjnJtfjTSp2LYXXmSxkPUWuGSjRPQTkZ1Lp87EEAYG
         7oLO9EgDedzdO1fBq/KET0Rxo23I+mWfD5OsJ4C72D0JOLcDLkaKuPgFTXxo394F7/Wz
         5WRpwOeU4zxwdsFyKXWPgwHVd4GW6rDPEbyuDothVcY1nfCiTuERlF9Z941tsp9zf/yd
         kygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qAfBPpGti4IJb/cZMqnoVtqAcc2r4v07Ip2T/G5Ovz4=;
        b=Qy3ejeFNd9p1tKGUJLFhKpGQRLi2gJjGq/FsHGiA8U4cMC5G2aQJUpwCMkwu7VSj7J
         PUdl08YvioeTVaRmqiEIJ8eR/sc0GdaZlLpYkYStwIdKV0ZeKjTTAiGF7V/k99WWjzd+
         X5JUxA+T/wGsgci5s73+8Dt5iSEtpGdgpViwsUltKiEVYyE4u+XjRgKJBn9WElFqf9W2
         y7gTKTNWx1+rFBibDuUtK1nI17NbGuZGh4fyyJWlpUzbo+4AN3564ds1czIyUq5Zco3o
         2z3X1+rS9lZgodZQkBSWMqDk1dn0xTp8NFT+buFFiZ4tcvHFEXRsU7i2YDs/Ud2moRHe
         hHhA==
X-Gm-Message-State: AOAM5304FFi3KwXXOr3waUeQLbl+DgPc+X8Fkk8IUXefhYP/hDSBP0Xx
        iEGxy6+svAbsMlsKRcMDaoW4no+R9c8G9SiZBbXyqQ==
X-Google-Smtp-Source: ABdhPJzDeFk/mOQloneLtj4kfha+Qnij5WrMFQUSxRNUrw8SRxCA+cQtKp2UGtisY7+fW/cX3oO00jllzN2ejjxl2AI=
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr14624684wmk.31.1610366963630;
 Mon, 11 Jan 2021 04:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20210109074435.626855-1-leo.yan@linaro.org> <20210109074435.626855-4-leo.yan@linaro.org>
 <96ec434e-4103-02ac-a05a-761a9ca8cb0d@arm.com>
In-Reply-To: <96ec434e-4103-02ac-a05a-761a9ca8cb0d@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 11 Jan 2021 12:09:12 +0000
Message-ID: <CAJ9a7VjtUuRRYBBu63kSXKwrGdB8ZoWJz-bE1g9tMLSbkFVDGg@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] perf cs-etm: Calculate per CPU metadata array size
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

I think there is an issue here in that your modification assumes that
all cpus in the system are of the same ETM type. The original routine
allowed for differing ETM types, thus differing cpu ETM field lengths
between ETMv4 / ETMv3, the field size was used after the relevant
magic number for the cpu ETM was read.

You have replaced two different sizes - with a single calculated size.

Moving forwards we are seeing the newer FEAT_ETE protocol drivers
appearing on the list, which will ultimately need a new metadata
structure.

We have had discussions within ARM regarding the changing of the
format to be more self describing - which should probably be opened
out to the CS mailing list.

Regards

Mike


On Mon, 11 Jan 2021 at 07:29, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 1/9/21 7:44 AM, Leo Yan wrote:
> > The metadata array can be extended over time and the tool, if using the
> > predefined macro (like CS_ETMV4_PRIV_MAX for ETMv4) as metadata array
> > size to copy data, it can cause compatible issue within different
> > versions of perf tool.
> >
> > E.g. we recorded a data file with an old version tool, afterwards if
> > use the new version perf tool to parse the file, since the metadata
> > array has been extended and the macro CS_ETMV4_PRIV_MAX has been
> > altered, if use it to parse the perf data with old format, this will
> > lead to mismatch.
> >
> > To maintain backward compatibility, this patch calculates per CPU
> > metadata array size on the runtime, the calculation is based on the
> > info stored in the data file so that it's reliable.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
>
> Looks good to me.
>
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
