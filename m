Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6422CDB4A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbgLCQbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731334AbgLCQbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:31:42 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB5EC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:31:01 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id bj5so1434336plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 08:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUlsCpyemxPUGQpIBc3drhb3sc/Fkh4PtlzYbjVQNa8=;
        b=HZ6E/ni9UlGIxxR2BMbpyFFrvxiyLLK/RkdhroUMEVqnOWKmVXyd9TZmPMSfFUiNe2
         BCXQhAC+V52TJMomN/Y3bN74/vuS4dIRpmRLM5l0NrZmyhQFlUL6tpnRHXqGCeh5Htwu
         FSPGqArFMdbtiIMrB/2MxotpFJWUIfEFnsm6rtlkL2RisaEVCIMrwl6eeV8ex4CmavCb
         E1UbVC3eRxmq/0VcQHcrxfMnvmO8mitkiqwbiSmNwcT7BYmgzBWFyyA4AzvULuotN+XY
         W2JdAPYMGXHpnY6QS+75KG+QsnepLi8V6AUYw2qCGQ0lfVrI2G/MfrlyFcPfOWC1b6XY
         ceLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUlsCpyemxPUGQpIBc3drhb3sc/Fkh4PtlzYbjVQNa8=;
        b=HqwiGvbCYL9oKoj5Qrefo/wSFFkHueBNAdJd5NxFVjzH0Z4aqRl+539JVyexQWiQYD
         i74KryWRaLQrG9IXAdDwrWAfk6XnavIy4qyLT2osAi2dcizM8fwC/nSu9fX3wThivqwT
         ctxXjQobjrJACspE8rfG4X9NH0G+Z41Nc5vYkETnmV/ByQxPq+NhRA5ouxK4ctdjYmN6
         jiCYQ000ZjOuPj9/bhakhPwOLu804a8QbhxQOxBLGHLLQ9zQ/1kObdD1CFFws4L+EIY/
         OGFZ2LLf9lUxrdPyUZGmUhUVdJIji3J9Vy9OYGSInGJqi4nSoed89X55x/tInTJRJyFj
         obOg==
X-Gm-Message-State: AOAM5327xnOsYhRzhQwo20c+sGJLI9Btil5GRQfYL82kofnQZk+L+Qpc
        nVuyEnh5xPP3ls8So5r3D6Y8IkFWJYFPejietU8=
X-Google-Smtp-Source: ABdhPJyGpaBbPYigJz61z6dE/n5rsekW4wIydbSaYp/wf1bKc73V+I0B8uhEJRMvQA5TE3/pm31rBwrkVMh+3O6XPns=
X-Received: by 2002:a17:90a:34cb:: with SMTP id m11mr3783185pjf.181.1607013060896;
 Thu, 03 Dec 2020 08:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20201113235242.k6fzlwmwm2xqhqsi@tomti.i.net-space.pl>
In-Reply-To: <20201113235242.k6fzlwmwm2xqhqsi@tomti.i.net-space.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Dec 2020 18:31:49 +0200
Message-ID: <CAHp75Ve4jSBXfeyMQHn1=T21Dkf4q4DF7DWPTc2U_QO79Pn_TQ@mail.gmail.com>
Subject: Re: [SPECIFICATION RFC] The firmware and bootloader log specification
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     coreboot@coreboot.org, grub-devel@gnu.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        systemd-devel@lists.freedesktop.org,
        trenchboot-devel@googlegroups.com,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        xen-devel@lists.xenproject.org, alecb@umass.edu,
        alexander.burmashev@oracle.com, allen.cryptic@gmail.com,
        andrew.cooper3@citrix.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, btrotter@gmail.com,
        dpsmith@apertussolutions.com, eric.devolder@oracle.com,
        eric.snowberg@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
        hun@n-dimensional.de,
        Javier Martinez Canillas <javierm@redhat.com>,
        joao.m.martins@oracle.com, kanth.ghatraju@oracle.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        krystian.hebel@3mdeb.com, Leif Lindholm <leif@nuviainc.com>,
        lukasz.hawrylko@intel.com, Andy Lutomirski <luto@amacapital.net>,
        michal.zygowski@3mdeb.com, Matthew Garrett <mjg59@google.com>,
        mtottenh@akamai.com, phcoder@gmail.com, piotr.krol@3mdeb.com,
        Peter Jones <pjones@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>, roger.pau@citrix.com,
        ross.philipson@oracle.com, tyhicks@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 2:01 AM Daniel Kiper <daniel.kiper@oracle.com> wrote:

...

> The log specification should be as much as possible platform agnostic
> and self contained. The final version of this spec should be merged into
> existing specifications, e.g. UEFI, ACPI, Multiboot2, or be a standalone
> spec, e.g. as a part of OASIS Standards. The former seems better but is
> not perfect too...

With all respect... https://xkcd.com/927/


-- 
With Best Regards,
Andy Shevchenko
