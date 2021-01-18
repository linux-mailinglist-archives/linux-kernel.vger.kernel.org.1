Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D20D2F9AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbhARHku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732747AbhARHkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:40:46 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5C2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 23:40:05 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id q1so31019156ion.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 23:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lp1dLvmDKcZnq78QX2LN/+VB/27h9qkstT6wTs9Co/M=;
        b=AXZ+UDlpcUVEsr1TOs1+Iqx0klX2cAdzpP3vuabxAlMHqkNou+ncYiWVRL/qWHYdkS
         D540/f7A+/gEYYvK02O3creHTr8mi6VR+SEDwnS+77ry6iuFSYh5L+bgH7FRovbYoxV1
         Mj03oiMGy8ffCZymWsQZMeZ7jdIElyw/fb18Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lp1dLvmDKcZnq78QX2LN/+VB/27h9qkstT6wTs9Co/M=;
        b=trz08Pu6VJCE2RMyoUP96r8eKAjk4zpzdc6WzgbFoTKMumMJcXVQ/Jg/ji4JSMcLy5
         jjNiJyPL1EHY0E2497cB3gTzKOqIx2jT3vVJLhwlsVg2zfnI43G9sj84QvvzGEXC2Ztr
         btoZB9xZ+c3+1FWYhkMEAiwPGGlpEbYU/p18mN+O6m5ZYi+7SLAmowIEe7Bo3Udz3Td6
         dTcz+ospUyK+GdtXUioYlT1iZFQ/lhw36gwPpVvJtVus/TxLyoKLBynyWo1XqT4DjMnS
         R0lp/N59xxGjELEvqZG2M1naLuR2hhSPKUob/ZXoIkPn4SZ39EvnvNQcQ92esreoT7z5
         yL2w==
X-Gm-Message-State: AOAM53011854eNa8o74WeHzX6jaGUsLTA9F5MQ/HA1fTe7WqxCbdnS1M
        o8+FT+b1nAiIfbq9QXY89RGZyeKIv6pRe4QMeKe71A==
X-Google-Smtp-Source: ABdhPJzS19TeWXKY5zhmREk0OObzaydz6aI7NnZ95qAIssnLYXDmmu/hZNZDSxJISl7U9K9UQ59iqZCwFp6plnX6UoA=
X-Received: by 2002:a05:6e02:1a8e:: with SMTP id k14mr20187777ilv.308.1610955605358;
 Sun, 17 Jan 2021 23:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-4-saravanak@google.com>
 <20191125112812.26jk5hsdwqfnofc2@vireshk-i7> <20200127061118.5bxei6nghowlmf53@vireshk-i7>
 <b0be1275-c5cb-8171-58fa-64d65f60eaf8@codeaurora.org> <20200130042126.ahkik6ffb5vnzdim@vireshk-i7>
 <CAJMQK-gmO-tLZkRRxRdgU9eyfo95omw_RnffFVdhv2A6_9T-nQ@mail.gmail.com> <20210118073430.a6lr3ynkd2duv34l@vireshk-i7>
In-Reply-To: <20210118073430.a6lr3ynkd2duv34l@vireshk-i7>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 18 Jan 2021 15:39:39 +0800
Message-ID: <CAJMQK-j6EYjU1z_SUY4MFEJO6qTtOH7mQ_QWj2iUMewBKAghng@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 3:34 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-01-21, 15:21, Hsin-Yi Wang wrote:
> > Do you still have plans to push this? I've tested on mt8183 cci with:
>
> I was never able to get Saravana to test this, if you are interested
> in this stuff then I can rebase this and resend and we can see if it
> works.
>

Thanks. I can test this with the mt8183-cci series.

> --
> viresh
