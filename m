Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F76E2FE82D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbhAUK4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:56:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729948AbhAUKxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:53:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE79B2388E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 10:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611226350;
        bh=joXsWySRbCpeXgJGWvfjkk3B0A5HawAKQzOPNL63CWI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZgToFo4Z6b3rZGEfKnksUIMOEMU896mS5dkbtosDale+jNDOa4zSMZ0ZTSNiSJVw7
         1TkS9aYFpwlpoQJ07MkLeeYPEjIqoLLzcfJ3vsyeOFskCKErUOXvjCUOvFqVznHUdM
         RJhlYdEAnhf/AoZ9xEAs8a1gy/Ibw6lCRvASJMIUzSCMbbwSJSa/c/jClR4ZrkURjE
         P+5SgF2QP4anEhglLAxhnGtG0CtvZH9CQIBjN5GVmJs7Fame+e3194mAMZPJ/BbLSz
         7GeCgOseuJUBCOJChbLEyV+33vS+eFrfsdEf7c13+HmV8yqD5Km+0ZWDvE0eBuf05y
         dK4geQLiKIgjw==
Received: by mail-ot1-f47.google.com with SMTP id f6so1172180ots.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:52:30 -0800 (PST)
X-Gm-Message-State: AOAM5300A1tPw45p2CWGgq+BFQiRTbJ4nvU25GAag9NWoDSR/Vv2ok2F
        Zwqnzh6+gvuQ9W1cboN3ER6Upryp8NI6Y6D4J4M=
X-Google-Smtp-Source: ABdhPJwaHE5gSoHcTUdZ3ZuMwiZ7NxU8/eegCE5gziTqwjhe6YZnkMo10U6Zy2pwRh0EBA+I9+S80KTz3j0JOtmlzQI=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr9994046otq.305.1611226350006;
 Thu, 21 Jan 2021 02:52:30 -0800 (PST)
MIME-Version: 1.0
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com> <20210120132717.395873-3-mohamed.mediouni@caramail.com>
In-Reply-To: <20210120132717.395873-3-mohamed.mediouni@caramail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Jan 2021 11:52:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a20XRHaErO5445ds6tf0omSKLMZ_NAWdS=9nBbLb7rdvg@mail.gmail.com>
Message-ID: <CAK8P3a20XRHaErO5445ds6tf0omSKLMZ_NAWdS=9nBbLb7rdvg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] arm64: kernel: Add a WFI hook.
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 2:27 PM Mohamed Mediouni
<mohamed.mediouni@caramail.com> wrote:
> --- a/arch/arm64/kernel/cpu_ops.c
> +++ b/arch/arm64/kernel/cpu_ops.c

>  #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
>  #include <linux/stackprotector.h>
> @@ -74,8 +75,14 @@ void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
>
>  static void noinstr __cpu_do_idle(void)
>  {
> -       dsb(sy);
> -       wfi();
> +       const struct cpu_operations *ops = get_cpu_ops(task_cpu(current));
> +
> +       if (ops->cpu_wfi) {
> +               ops->cpu_wfi();
> +       } else {
> +               dsb(sy);
> +               wfi();
> +       }
>  }

I think the correct place to put this would be a platform specific driver
in drivers/cpuidle/ instead of an added low-level callback in the
default idle function and a custom cpu_operations structure.

       Arnd
