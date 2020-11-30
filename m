Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAB02C8646
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgK3OMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgK3OMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:12:09 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAECC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:11:19 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id p12so8156217qtp.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NgaLJ0QO9EJtE6uiL7yCQcVN+ABRxsy8u6JjcXDtCo=;
        b=uwTB1HIu4qLxrfXqctZyv9GreSirwpQFMCG/zP5/sGGl6tmjsIkiGPBVkW8YfC3BdD
         hMci1us9GEJRrZHDi2M8HlQAkTWlsG03jP9H5ecIxKaGhkdSwd06QK3oSDNC3ULHcZDj
         GO5XKYaGc6MUAsQpcna8VQEVRKgnBZw6C3LaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NgaLJ0QO9EJtE6uiL7yCQcVN+ABRxsy8u6JjcXDtCo=;
        b=SERIczOuwRP3LvfcewIXcPfqnD+YUDZ/hhCk7hBc4CAcWPrVSF3A+tBYbjB+VwCRsN
         oLpdjXqbdY4IBz1lNxBZwmURb0WQu5PayluesXLxiL3WGHtDL74Q4hJgP+pjZ84FAU9G
         8gqZHSTH+2nYxl7VPhPkVwEuW+ZpvuObKMZIsKPANtZrMiHk+bEbVnwJonOW3RUq5Rds
         8TcPtYMpnam1bbF9fAppq3jmT2vP0xPU8SRTeOS//9EU5JeJY57GOBGP+gWsBVHWY9Ih
         86/7VrNWpuI1At1Pv1Y6nTPrsFJktjmHqEvjm4xqfHlorVpvnTM4QgOGWDuBfIfC9PpZ
         xKUA==
X-Gm-Message-State: AOAM531Ihfge58E4lcVPanyW9OAars8ObWGLGzjdnLVtXESxAAOfk+tE
        VlVmu+5am4YIu/BpnkRUECaqd+eWN4XRq0Ca/voZKA==
X-Google-Smtp-Source: ABdhPJxuOk4lt6aRnHtzdp4qErPriGzwnXYHpe/+O8jJe8J5DIxrFCbxqkv66JGvgIwypVPsBwCGC1gUD5EFpPC3Kdw=
X-Received: by 2002:ac8:590f:: with SMTP id 15mr22272575qty.249.1606745479012;
 Mon, 30 Nov 2020 06:11:19 -0800 (PST)
MIME-Version: 1.0
References: <20201130131047.2648960-1-daniel@0x0f.com> <20201130131047.2648960-9-daniel@0x0f.com>
 <CAK8P3a2oqc51Aw7fyjW7t_zzRYX4Xxa7SS72faj7zvcZfyuaFg@mail.gmail.com>
In-Reply-To: <CAK8P3a2oqc51Aw7fyjW7t_zzRYX4Xxa7SS72faj7zvcZfyuaFg@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 30 Nov 2020 23:11:58 +0900
Message-ID: <CAFr9PXnkxBeujWFqVWfonEKEJ81ExnYcjr3jRMTBobGf9q2jsA@mail.gmail.com>
Subject: Re: [PATCH 8/9] ARM: mstar: Add smp ctrl registers to infinity2m dtsi
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, 30 Nov 2020 at 22:44, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Nov 30, 2020 at 2:10 PM Daniel Palmer <daniel@0x0f.com> wrote:
> >
> > +&riu {
> > +       smpctrl@204000 {
> > +               compatible = "mstar,smpctrl";
> > +               reg = <0x204000 0x200>;
> > +               status = "okay";
> > +       };
>
> You probably want some more specific compatible value, in case there are
> multiple SoCs from mstar that have an smpctrl block and they don't all use
> an exactly identical register layout.
>

From what I can tell these are in the same place for the infinity2m and
the other SMP chip in this series that are in the infinity6 series.

Would "mstar,i2m-smpctrl" make more sense?

Thanks,

Daniel
