Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D5427DDCF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 03:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgI3Bfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 21:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgI3Bfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 21:35:42 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0992C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 18:35:41 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id h26so434525ejq.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 18:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZtFBpYGVBWcjph4+4nRslST7ms1gG/x8RojOlPP7OMI=;
        b=mMaVeS2APZBDIkB70hEoyZsmnOJIMwL4dMiwBOlw2Wcqx+bIM2L3UFWbnblFrcDMMf
         tGDh4GAOiOS4TTUizsZKZm2wLJigNPuFTg0j5MWzRoOVm5SbwhoZiXamc/zsvEHcMMks
         Vjtcc9tyy1bptHezM8TH7zV0IoH+ujpswDfG3sDItcxD/CydRfOaKkjF8iyA5E+J4R0/
         rKw7jnQ8jBiZ1EOWNceGU/p5i/Z8BZz4at0Gm3Qo1lTLo/2+4/e0UYm3RhSIlmPA1QwQ
         SLhDisyxG9Ilf1FtjF3sJtEh6mMGNTll3AL4/+Z+zQ7pdvLGiectYexUxB6r2xiBaRoI
         uBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZtFBpYGVBWcjph4+4nRslST7ms1gG/x8RojOlPP7OMI=;
        b=pkQbHrLxWR26nfOnqL5mJpDyauH566zRp0z9MciGjfVc+tu/SE1CjJ+n5wSSCDrR3b
         u0rhU5Ci8esd/+X0k9PVUcvyCqfnqzbpK+/DSoE/qbeTvBUQiJim7fOi1qkPKZ6iN/qb
         Qj2peo9cRTqHQ/02MqUO8D+v61lchDtSMNZ+20gM/9xZoyrZrrPjw9B7OhgISj/u/NMA
         xY4ENfdUb9OVt9dyk8j+k2i2La7prAs+5Lytk6tBinfeDp1LQCpPr87KB+nlIa812oRi
         3BYGZhu7BtlkOdJR5O4mLEzNyiKT3WYdgkGX2Jjg4K7NIY7+z+V7YJjBqa7FwCSHv4oj
         qe5Q==
X-Gm-Message-State: AOAM531x7OydaSkV8JIlUL/AwYDyAiySCWa6iWsM+KgZNIBcnSPgdiXP
        pmRgqgWasKbQGOzqBdrcm4BLBI+qu+rYtF+S8i/FkJFRO0QD5Q==
X-Google-Smtp-Source: ABdhPJy5QlofMjhpYHwlTw22TgmBje1ZtY35FcmpCbfAMqa0DdHPS1et9APkFZ3LhmhOZLlHf9Bp+ShKwnKbbO9o3gQ=
X-Received: by 2002:a17:906:c447:: with SMTP id ck7mr460541ejb.358.1601429740533;
 Tue, 29 Sep 2020 18:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez3SG6ngZLtasxJ6LABpOnqCz5-QHqb0B4k44TQ8F9n6+w@mail.gmail.com>
In-Reply-To: <CAG48ez3SG6ngZLtasxJ6LABpOnqCz5-QHqb0B4k44TQ8F9n6+w@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 30 Sep 2020 03:35:14 +0200
Message-ID: <CAG48ez1b7_tSyFndMOefGECog4Dde5XmRHCtWen9=CdJkho+HA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/gup_benchmark: Take the mmap lock around GUP
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 3:19 AM Jann Horn <jannh@google.com> wrote:
> To be safe against concurrent changes to the VMA tree, we must take the
> mmap lock around GUP operations (excluding the GUP-fast family of
> operations, which will take the mmap lock by themselves if necessary).

(Sorry, my mail setup messed up the In-Reply-To headers, so you may
not see the patches threaded properly... let me know if you want me to
resend.)
