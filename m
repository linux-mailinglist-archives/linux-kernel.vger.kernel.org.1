Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2259627760E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgIXP6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgIXP6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:58:37 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7117CC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:58:37 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id k25so3235825ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDlImHQG+WyGWW1Zw8OrcVApf/zvofomVSpORgyBHR8=;
        b=gU9H8quw0ODZD5j2ATVueoHOBIrQbytcaQkpJ4BOa0yac1xXfdXp3nabz+lI1bwWGC
         dGGlkRyJzpHFaqqmFSeoFPcO0NA7OALEi8rZ6V8mcAPas1TR0JLDs82By7cToOhXI/vl
         5NkyAJespvEzlUiX6038sU2DCsPIsey/ykeCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDlImHQG+WyGWW1Zw8OrcVApf/zvofomVSpORgyBHR8=;
        b=MT44turq0xHT7bk0M3LxMUJF5MHL8GT2H0bd6NLGlnlIRHe9koScvNkWr4hmRTPvmR
         XbIQ2DytPOs7qcwomURQs+DB58nBDdKKhmYRTnm97LZsJ+lNreTPSd64VqLsNkZ2lZEc
         hBcPPw78NojCzQt/Nxdnf5FzMjoft8e2QxcEO+sc4Njxgpoe+C7yOL4UeEs/UMsnC83l
         yh3bPkcWI/8LaI+Wr8/b8BEw7Veay6IIP+y3bVFhVmCSVZ0NWDPvYKPD4bB0gwg+KCNW
         7UUJSjWM1qkSoda2S6oQ2i7iUoHH9jODawLDNTOPGmk9NtzYv2YNyU2XAIrN4TZ48vli
         KnZw==
X-Gm-Message-State: AOAM532Gm82VCeHLd+gwutApTn6Dt6vMTfIXZZWMbVF+wxhZfM9BFT/3
        lEkxJyHqn0PYrro8wP2pg661Xu9qObsGaQ==
X-Google-Smtp-Source: ABdhPJwCztssYuIbseGcBhTx55UEUTo86IEQ3E6ppZzRmXBAGoFpnlGJohhwfwA0Xl0yi5U8RMCwJw==
X-Received: by 2002:a2e:b8c8:: with SMTP id s8mr155005ljp.127.1600963115513;
        Thu, 24 Sep 2020 08:58:35 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id v196sm2386945lfa.96.2020.09.24.08.58.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 08:58:33 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id d15so4463705lfq.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 08:58:33 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr47607lfg.344.1600963112812;
 Thu, 24 Sep 2020 08:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com>
 <20200916142806.GD7076@osiris> <20200922190350.7a0e0ca5@thinkpad>
 <20200923153938.5be5dd2c@thinkpad> <CAHk-=wiMJu0_sLO78+nLoe=pxC-p=sSpC3moq0p5RyJc9KXC4Q@mail.gmail.com>
 <20200923233306.7c5666de@thinkpad> <CAHk-=wgbfGCKKn=RTX9gF9Q+FYOGn2kD1OLnQuJSD+A0Rvg9Pw@mail.gmail.com>
 <20200924000226.06298978@thinkpad> <20200924140638.7bcb7765@thinkpad>
In-Reply-To: <20200924140638.7bcb7765@thinkpad>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Sep 2020 08:58:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTKXJH1teKV3-tu1+qABMq0_tpdM9K4hYwbGCt7vwx7Q@mail.gmail.com>
Message-ID: <CAHk-=wjTKXJH1teKV3-tu1+qABMq0_tpdM9K4hYwbGCt7vwx7Q@mail.gmail.com>
Subject: Re: BUG: Bad page state in process dirtyc0w_child
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Peter Xu <peterx@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
        Qian Cai <cai@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 5:06 AM Gerald Schaefer
<gerald.schaefer@linux.ibm.com> wrote:
>
> It's all good now, no more occurrences with unlock_page() before
> wp_page_reuse().

Thanks for the confirmation. When you pointed at that unlock_page()
change, I was pretty sure that was it ("D'oh!"), but it's always good
to have that verification.

Committed,

              Linus
