Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF94428F950
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 21:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbgJOTNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 15:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgJOTNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 15:13:53 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F67EC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 12:13:52 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p5so5231386ejj.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 12:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpNta3oGXOGMfw8lC8Ia8pIVoil33uOCCB/uiUIy1Ys=;
        b=nqtzQCD4UJ5TOOSNwTeAs18WkAHE9maC+RCNSoZ+tJjBTp3MGukv9rYj6uVO/w6hHl
         NL7UQGN3gKEtH0cVGN1rFfFQsayrZTyxSIcPBQC28ot902mb8iq+tSdC+bh21fCQxFo5
         8m+/7U/G5Ma1oEhQDsq3AuzTPhawD4Dt56XQKl3O+8fWunhBQN/4wEsa9twMNsL0cwSy
         ugCOlj2jgfN9f1YWDCMVahlaqvk49ZqsuL2yG/rlanqbE/ABH79jnuZMing7xDVZIhy+
         r3OF4/gxitTiZJSTG8p4MhlmsxecXpo+LCQCfU/Bhg7hAD23NuHPl+PTeY0L/6AKFQuc
         9T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpNta3oGXOGMfw8lC8Ia8pIVoil33uOCCB/uiUIy1Ys=;
        b=MsDHxc69k8fosJPKnQwceLRQdlrvzs5NsUpOSs3UvW6/4nZnKQWEoCAfun/aaFn78G
         iZ7jweSnum4lkoKDMBFerYD5tre5DnU1ip8xMspfDTORZFVQ1uuqhjWBr36PRZpVKGuQ
         +h/OshBzA2Y5KbTczMEjkccvZLPBFWKE+GaMfFsXELC8LOJFCsbkOK+ePbl8d/x2C5sK
         cYyhM04vzkH8TJcuT8vScRtadM6y4Q/3HueToKF34MC9YwKguFxnFlj/fwuuVHSiZ1KE
         d/vnoUveo3JhFpq1JjNt/m3AVwIOn1JhI+EzmiCyLTS5FZg3RonenzOmC7yZMmFTnQZ9
         q7oA==
X-Gm-Message-State: AOAM5325iZ3mqc5BwK8ROVWjodFgFAHVa6HPfUprMMDpUHDTrHL3itgD
        8yxMJMTaL6zSllbR089ZmJDDxqVsRPWxmUi3QjsVzzn1
X-Google-Smtp-Source: ABdhPJwMRHN2r+nEbe4Pcq5RIxrw+0qxNWTP6glIsrkOwjYteM0Gts+BCIAEOoZaHkKKxz5QFXbfG9nWrRaWavW+qWE=
X-Received: by 2002:a17:906:2b83:: with SMTP id m3mr6007641ejg.456.1602789230712;
 Thu, 15 Oct 2020 12:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
 <CAHk-=wiP+S4K3yU+FqgGmF+EgcSgk04Eerf3gE-6qObicy346w@mail.gmail.com> <CAHk-=wgYNzhoYuUBsBcFq1TFA5C+Bie-2uzZkF2McO9joXxW0A@mail.gmail.com>
In-Reply-To: <CAHk-=wgYNzhoYuUBsBcFq1TFA5C+Bie-2uzZkF2McO9joXxW0A@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 16 Oct 2020 05:13:38 +1000
Message-ID: <CAPM=9tzwRb13Umsgq+aqo2ZDqjEc9578tS7_ydxkYPYArmSong@mail.gmail.com>
Subject: Re: [git pull] drm next pull for 5.10-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eryk Brol <eryk.brol@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 at 04:42, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Oct 15, 2020 at 10:51 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Thanks, looks good to me [..]
>
> Uhhuh. I already pushed things out, but my clang build (which I don't
> do between each merge) shows a problem:
>
>   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:650:8:
>   warning: logical not is only applied to the left hand side of this
> comparison [-Wlogical-not-parentheses]
>                 && !params[i].clock_force_enable == DSC_CLK_FORCE_DEFAULT) {
>                    ^                             ~~
>
> and I think clang is entirely right to complain about that code.
>
> Yes, the code may be correct, but even if it's correct, that's a
> really odd way to write things.
>
> Anyway, what it does is:
>
>    !params[i].clock_force_enable
>
> turns 0 into 1, and anything that isn't 0 into 0.
>
> And DSC_CLK_FORCE_DEFAULT has a value of 0, so what that line actually means is
>
>   (params[i].clock_force_enable == 0) == 0
>
> which obviously is
>
>   params[i].clock_force_enable != 0
>
> which in this case is the same as
>
>   params[i].clock_force_enable != DSC_CLK_FORCE_DEFAULT
>
> which may be what the code actually meant to do.
>
> So I suspect it does what it meant to do, but only because
> DSC_CLK_FORCE_DEFAULT also happens to be 0, which also acts as a
> boolean 'false'.
>
> But it's also possible that the '!' is a left-over, and the code
> actually _meant_ to do the exact reverse of that. I have no idea.
>
> This odd code was introduced by commit 0749ddeb7d6c ("drm/amd/display:
> Add DSC force disable to dsc_clock_en debugfs entry"), and can we
> please agree to not write this kind of obfuscated C code?

I've asked Alex to direct send you any fix for you to apply once he's
had a chance to validate it,

Dave.
