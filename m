Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463C32E0FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 22:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgLVVfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 16:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgLVVfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 16:35:06 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEBCC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 13:34:25 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o13so35334746lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 13:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xmy4SQdwbm2DHPXN83yCBh3DyLsFV3D3oMOlf06BH5A=;
        b=HQBULK6iPt8405aC1NTIJFAKBDXFRKgGWawI9VEEvYt91P7EOVV0IFrtryGEIZHCeM
         lPNnDa4XkWW+3QZvRe/JtARxqQZn2V3veFd6VVokMcy6Q+EcT9yjcch38xGSL3BqVpIT
         kvYdVnLyrlCpmpNyjMsPLGSCc4bSUOO1/AspM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xmy4SQdwbm2DHPXN83yCBh3DyLsFV3D3oMOlf06BH5A=;
        b=FBynSVuUsv6UPBJynU22vnRBddZNNPByuMteebukPvKxuPByh88fcYDek0bNcQO9nT
         vUUZSbjcIx9VcUMcmLLGKuJUx+Qix6OPkjNvE7sNcum//Pb3z8XZDjzuGJYQ7qDto8lz
         TfLgC5WeozFsAzB7TEenJAkBJOKFWzhYHiG8tXYcBTx4ERuxpsAs8LIBV+KsuqcEfUma
         WYPqL8rSRJo8Dn/QddLelB20U/SCaHrKFHLCE54ecUMnIPxhSqLycSdOoMDfowEJ3sAP
         ytBLL7y+d07CnfUj/oEm+kSW/A0eNxtWMHy4O7Ive27xGq4ba/QtU6utDWq6RwGEdZ1S
         aN8Q==
X-Gm-Message-State: AOAM530WlPdCWgqDUU9o3HIDh+Ey/OxuKZo09CIdZv6Jdx4dtVwzaiC7
        Za+RFXX8VV8dDzkWXI0RkkupHxi9K+QQ7g==
X-Google-Smtp-Source: ABdhPJyh/suGkaLnbRxVzZVeloAR4nwjCva3E2vvJQIjAT/MkATSYiTj0mWlRd8HH+5TmYTNxNiUgg==
X-Received: by 2002:a05:6512:33bc:: with SMTP id i28mr9145195lfg.33.1608672863882;
        Tue, 22 Dec 2020 13:34:23 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id n1sm2816002lfh.186.2020.12.22.13.34.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 13:34:22 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id o19so35400413lfo.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 13:34:22 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr10175875lji.251.1608672862232;
 Tue, 22 Dec 2020 13:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20201222163452.GA1524@www.linux-watchdog.org>
In-Reply-To: <20201222163452.GA1524@www.linux-watchdog.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Dec 2020 13:34:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjEHYdDMwUqy0LqWMvAOqkce6Dj6Q5dkUpJOdd01sVhdw@mail.gmail.com>
Message-ID: <CAHk-=wjEHYdDMwUqy0LqWMvAOqkce6Dj6Q5dkUpJOdd01sVhdw@mail.gmail.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v5.11 Merge window
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        EnricoWeigelt@www.linux-watchdog.org,
        metux IT consult <info@metux.net>,
        Etienne Carriere <etienne.carriere@st.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Lingling Xu <ling_ling.xu@unisoc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Tom Rix <trix@redhat.com>,
        Wang Wensheng <wangwensheng4@huawei.com>,
        Wong Vee Khee <vee.khee.wong@intel.com>,
        Yangtao Li <frank@allwinnertech.com>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Zhao Qiang <qiang.zhao@nxp.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 9:42 AM Wim Van Sebroeck <wim@linux-watchdog.org> wrote:
>
>   git://www.linux-watchdog.org/linux-watchdog.git linux-watchdog-5.11-rc1

There's no such tag there. Forgot to push out?

I can see the the top-of-tree has the SHA1 that you mention:

> for you to fetch changes up to 0b9491b621196a5d7f163dde81d98e0687bdba97:

but the tag itself is missing. And outside of kernel.org, I do require
signed tags (and even on kernel.org I very strongly prefer them), so I
won't just pull that HEAD branch.

             Linus
