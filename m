Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3617294CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440859AbgJUMqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437025AbgJUMqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:46:46 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3909223BF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603284405;
        bh=ttXp3ovL74pvsFHzn70xAtSuQ5PCnDzGKQbu4q5Oj+g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bWwHqUVe7SwWjbBhWQfnc1gNPHZxfTBeszYdkfWpiqaHp1Ub1JrfyZPkblZzAErMt
         8+FbAjYbP14i4MZiJxhgGe/KZE6xBWhqJAfMAcOA+LqCXNbYBDntywVRcfW8xjqbwg
         SFAAiAHU7qxorTJqRAASlmvTaBR4kuH7G7jTGaEc=
Received: by mail-qt1-f173.google.com with SMTP id m9so1884992qth.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 05:46:45 -0700 (PDT)
X-Gm-Message-State: AOAM533Gh8devLGAq/tNNrbrAccTvnAyjb0BD0406A+zh3zp6vkTjs7w
        xkEBDGDb3dzZc+3kqgw7Asnq/89stg/swdd3ftI=
X-Google-Smtp-Source: ABdhPJyAmqnWKXXVYMHBrBwQ8vRAy5SXr0Z8q5x0gqYcFsbtiIr0nZUN9iiiouSsLjFc5Rif7/kUhm+TwOPAM49mtw4=
X-Received: by 2002:ac8:1ba6:: with SMTP id z35mr2845432qtj.204.1603284404668;
 Wed, 21 Oct 2020 05:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20201008071628epcas5p24d196a6023a47a3b0bfa7b7f231ec811@epcas5p2.samsung.com>
 <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
 <20201008083015.GK1551@shell.armlinux.org.uk> <CAK8P3a0h=D8_Kn_fpHbsik_jf4to2jayxj7K7B7=HaNFzKqNnw@mail.gmail.com>
 <CAK8P3a2tmRo0voZJLqYbNQGG9FZCGuKzMj8Zo8f+WL+dvOourw@mail.gmail.com> <20201021123400.GK1551@shell.armlinux.org.uk>
In-Reply-To: <20201021123400.GK1551@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 21 Oct 2020 14:46:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1U9=4G-8CPQRsvVWXYX91hGUbos77amMR+FH_pq9OegQ@mail.gmail.com>
Message-ID: <CAK8P3a1U9=4G-8CPQRsvVWXYX91hGUbos77amMR+FH_pq9OegQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] IRQ stack support for ARM
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Maninder Singh <maninder1.s@samsung.com>, v.narang@samsung.com,
        a.sahrawat@samsung.com, Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Huckleberry <nhuck@google.com>,
        Will Deacon <will@kernel.org>, Jian Cai <caij2003@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 2:34 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> We don't do it because we don't have a separate register to be able
> to store the thread_info pointer, and copying that lump between the
> SVC and IRQ stack will add massively to IRQ latency, especially for
> older machines.

I forwarded my other reply as well, in which I suggested using
CONFIG_THREAD_INFO_IN_TASK, wouldn't that solve the problem?

      Arnd
