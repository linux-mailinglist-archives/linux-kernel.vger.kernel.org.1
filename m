Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA782DA36A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408793AbgLNWaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390134AbgLNW3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:29:39 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BCDC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:28:59 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id w3so17412838otp.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQJ31nxgRFNp8EZMZx7FpPO6Zey0SIdb/j3Aj9RQw50=;
        b=k5EFIvrMkJbEa+nK4q3JlJtULb4oIuWXZdnkEt4LnpFVI+TxG2Jnfz0fPBbLKC5eu9
         6RbYVvc6lMGoLbEJi9s8qKo+dXDFtWvsS/B25mqkuJC9hvnLqxZZbjirD+PJznv/f9Ve
         GIlFqFYORvcO4RSSbWHaHryZm/j4P+dYbBzeB8D7rvtGAV2pEWnrKVwG4gAwbPR9cahs
         54Jw5pZi/XPWQH/nbj9N5wVXCOk0mdQLMtPP/vc93QpVAZS+bM3lisrJrD/RukYnhOyJ
         yFR6Ms38ryp/uevoKuiskLbkORJZfXnHCSyFGuoc21ippsVhFurKa0cE3IBd7HaiPMBP
         zSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQJ31nxgRFNp8EZMZx7FpPO6Zey0SIdb/j3Aj9RQw50=;
        b=pI3G3+eFGttUQH7DEer7wPUVTiJaPonI1sXp3e1D3x4xo2c6HMT7qhyOEP1oGCP8no
         8dt8ycCROJhsVnVg6d2Xqgap7CQWeXECA/JZ+V+tRb3zkkI5I9ZsY/1zQ8cm5lU2LHsb
         2vSnwEdcIsPzvI8SE+WNmJzEK2upjQkBmM9OW6nmxo8AenhLHk2wse7uQsa/j/LJtIQX
         kn21xB4FN//GIjtUOYHkAiOGADyOBd1mu/QwjU8tWWL+AwISHCicR8JXlM52d82vfkaQ
         4ERaGgMuc8GLSjsvhHtQ3R+Gp8THrgh3wyGd880SP1IjZJKMZVfp91b73bRLuz4QDAZf
         NyKg==
X-Gm-Message-State: AOAM5324PTjUB2aYYEobtVcoCT9iB+rWT2JEIeO6QBkHheL0d/NWN3Tp
        ZYKRlQVJuJeR2A4FYvAwrgdPoZ0/DicH0ga4HSA=
X-Google-Smtp-Source: ABdhPJz4xCYDEx6ZevgUKDDg/umaaRlXBpiemsW3Y0HOAK/v6cPBraxTcPoES/oo9oSLJyGxEDM5dvWueoFZRAehe8I=
X-Received: by 2002:a05:6830:1d66:: with SMTP id l6mr4788158oti.23.1607984939076;
 Mon, 14 Dec 2020 14:28:59 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tyNrbap4FG6qstkC5YTznqVebD=ye+4+Z+t42yQnL325A@mail.gmail.com>
 <CAHk-=wjue4aOyQQq+C6SEurwe6XABhMyNtsfn1goU==Hf_QUqA@mail.gmail.com>
In-Reply-To: <CAHk-=wjue4aOyQQq+C6SEurwe6XABhMyNtsfn1goU==Hf_QUqA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 14 Dec 2020 17:28:48 -0500
Message-ID: <CADnq5_MyMm+FmmbKHccDDOBryEdgbQHdw3rtuhUv=cvJrirHFg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.11-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 5:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Dec 10, 2020 at 7:52 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > This is an early pull request for drm for 5.11 merge window. I'm going
> > to be out for most of the first week of the merge window so thought
> > I'd just preempt things and send this early.
>
> Ok, I've merged this, and Dave is likely gone already, but it _looks_
> like there's a problem with the drm tree on my Radeon workstation.
>
> It works fine on my i915 laptop.
>
> The symptoms are that the boot just hangs after
>
>    fb0: switching to amdgpudrmfb from EFI VGA
>
> when on a working kernel the next lines are
>
>   amdgpu 0000:49:00.0: vgaarb: deactivate vga console
>   [drm] initializing kernel modesetting (POLARIS10 0x1002:0x67DF
> 0x1DA2:0xE353 0xE7).
>   amdgpu 0000:49:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
>   [drm] register mmio base: 0xE1C00000
>   [drm] register mmio size: 262144
>
> I'm bisecting for more details, but it might take a while, and I
> thought I'd start the ball rolling with this initial report in case
> somebody goes "Aahh.., we know about that case already, the fix is
> XYZ"...
>

The relevant fixes are:
https://cgit.freedesktop.org/drm/drm-misc/commit/?h=drm-misc-next-fixes&id=aefec40938e4a0e1214f9121520aba4d51697cd9
https://cgit.freedesktop.org/drm/drm-misc/commit/?h=drm-misc-next-fixes&id=95e3d610d35c9c5b51e12c5c8ac18061ae08cf97

Alex



>               Linus
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
