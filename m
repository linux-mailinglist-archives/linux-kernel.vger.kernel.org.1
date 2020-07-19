Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF572251D5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 14:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgGSMW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 08:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSMW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 08:22:58 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB58C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 05:22:58 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k15so8333179lfc.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 05:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WujZ/7jho1fGoHN1cxPxG4EtZF1JYD29nSTtD3mfiTI=;
        b=Z3NKGYHbByVNND6TEr1PvZw2+i2FuU6IdWaDdBS6ScSxzk5cjT//fNt1hUxNDPkSw0
         FXuLvFP9PwMdml6Sxti2Ms5+ap+rwrp95GzzTfaUN3h7s4l7PLxO22xQI24VdT9fJp/2
         P1jp4fIfcrdi0oVjI4lt45ERxxj/h0G77Mq5bz6/lZ4hZ1mgUHbafiwHqCgwIEU1g+uK
         Cmv02LKa+rghpupsCicTz3ERrUIAWPN7o4y9twvr7m7fGqOvcN9KAkpYp3UsgdhXqb5I
         u6maFfi/l0T7pjjrEDcxAzOTdEZ8Pv8HMOVAikbQ1XukhxEataY0hsp0F3yzX1pu2Zrc
         9wnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WujZ/7jho1fGoHN1cxPxG4EtZF1JYD29nSTtD3mfiTI=;
        b=EsiN9FXFrkFkNUoyU42CKxuroMLQXarpZb1c2KmjG/ogIRKbjddoKZg1+428EF4+2x
         dz2fqy7xo/HWD1NabBMed1l1lWR/52gda6WwhqG4dCD80Tnfqn7dAl974Lt9IouFNUnL
         jycIcj55UCQcw/UJGK+Tw9bc+9p/N5d64l+2eZTI/fQDpz0IeZpl2o8N3rgGDVrnkgQB
         CL31gueejV89kBVEp3c2GCYHypcPzCUNGiZrJJu8NhWIKy2g58i41WS0SPUJCKy4aOew
         HnXkgXg0zsThdkNPLOH5QWEjYlV2SCwqn6X8UxFPW/JIvO7AvnvIU6v4gDdBIwPU53G6
         QGuQ==
X-Gm-Message-State: AOAM530yPoViwd2OEe3u29qPGnBHBQnGuuaKqeY0ML05tin4uGE918wS
        ydiVIVuDhp9uJZuvlerlz5exKzD40VMumCi43myJ1Q==
X-Google-Smtp-Source: ABdhPJy6emGfmf/9lRBLLDOFNbaaEr1iR97/eYQylRnx0qjqmuhyKlX/PtXMK8DwtCQ71KPW+GxR2WtI7IlzFc5AD9Y=
X-Received: by 2002:a19:e45:: with SMTP id 66mr5284234lfo.82.1595161376814;
 Sun, 19 Jul 2020 05:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200712131003.23271-1-madhuparnabhowmik10@gmail.com>
 <20200712131003.23271-2-madhuparnabhowmik10@gmail.com> <20200712160856.GW9247@paulmck-ThinkPad-P72>
 <CA+G9fYuVmTcttBpVtegwPbKxufupPOtk_WqEtOdS+HDQi7WS9Q@mail.gmail.com>
 <CAA42JLY2L6xFju_qZsVguGtXvDMqfCKbO_h1K9NJPjmqJEav=Q@mail.gmail.com>
 <20200717170747.GW9247@paulmck-ThinkPad-P72> <CA+G9fYvtYr0ri6j-auNOTs98xVj-a1AoZtUfwokwnvuFFWtFdQ@mail.gmail.com>
 <20200718001259.GY9247@paulmck-ThinkPad-P72>
In-Reply-To: <20200718001259.GY9247@paulmck-ThinkPad-P72>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 19 Jul 2020 17:52:44 +0530
Message-ID: <CA+G9fYs7s34mmtard-ETjH2r94psgQFLDJWayznvN6UTvMYh5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] kvm: mmu: page_track: Fix RCU list API usage
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     madhuparnabhowmik10@gmail.com,
        Dexuan-Linux Cui <dexuan.linux@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Paolo Bonzini <pbonzini@redhat.com>, rcu@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        frextrite@gmail.com, lkft-triage@lists.linaro.org,
        Dexuan Cui <decui@microsoft.com>, juhlee@microsoft.com,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 at 05:43, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sat, Jul 18, 2020 at 12:35:12AM +0530, Naresh Kamboju wrote:
> > Hi Paul,
> >
> > > I am not seeing this here.
> >
> > Do you notice any warnings while building linux next master
> > for x86_64 architecture ?
>
> Idiot here was failing to enable building of KVM.  With that, I do see
> the error.  The patch resolves it for me.  Does it help for you?

yes.
The below patch applied on top of linux -next 20200717 tag
and build pass.

>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index de9385b..f8633d3 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -73,7 +73,7 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
>  #define __list_check_rcu(dummy, cond, extra...)                                \
>         ({ check_arg_count_one(extra); })
>
> -#define __list_check_srcu(cond) true
> +#define __list_check_srcu(cond) ({ })
>  #endif
>
>  /*

- Naresh
