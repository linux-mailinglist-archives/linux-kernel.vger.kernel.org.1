Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A28A2B4274
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgKPLSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgKPLSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:18:51 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EF4C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:18:50 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id s8so15272442yba.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MD9xHbpoBxI28g0y3d7aQhsOLegTugTpd8AuiJspFNs=;
        b=hmuBOgJMpbiQxGBqnGrXSn0SRmC2e/BrQz+KtWufgEXRLOpLsa1gEzPF3ryhKN3DFx
         OLb/bG4g63OMg5Z+G1vFMNjqsjuTvWF1v5n3OZ+TVC9b2R9W+ZvjzLY4nt0GD2fJRc8Q
         XMj3vIjuYhu77GI2PDZXJVmO3okeiRm+zBjp60MRe7Q86qDO6sMflPnA9wZ4nW+3ew1N
         5RuJzfHJ7SeCliEWT+dPFVqMWejHZ7DEHBtVMLtfHwEfSS71gOno3GE4zrjAzcnmWm8t
         n7U/u+EcrrANh36tYYcfQYHY84YmL1Vgx8QrVXOwE808k9O62urPXN4RjPtrBIwxSBHg
         lh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MD9xHbpoBxI28g0y3d7aQhsOLegTugTpd8AuiJspFNs=;
        b=NYF3ilTDFHfox2eLxDtOld5DNqyBqj9WLo81yb2UxZuLYrMV3DiYp3z5w43//6CLK1
         DgyXQMlxWD04HZ1n8PF67J/yXXFeQZh/UdOMQYdf8evnVr//dzteTCIdc+lCOjDIEnH9
         8BOxG+xIzdKMVXNm2b16zzoZvPJ9ySrvRE3Rlf/e0DpgiVcIw7/V1EX1Fuq5vxEhmVS8
         A+oGgEeXyK0LBe5GZJYj/85SkqrQrHOpS7Y8PljXn2Z+0SdcKaAnJWtCx3tayA5tXDM7
         zJ0XwtKi+WWIp61d5TyvMYF9jDTZSQbTDme025D2CHCZSzyzqyHWWNuoobYghJDRUZOy
         165w==
X-Gm-Message-State: AOAM5308xkQFmGIA044G4teT3r3xblkJ7BzqW/GxCcFZ7BEPNMlLQeWc
        CaLkuMwqMX7N0Amoa44IdMT89gfU7RAv/19hX4E=
X-Google-Smtp-Source: ABdhPJzuUvalT4x4fTA5gvfWQI1Nk/liV9/MbNuQHoZJj5e5bfz8uHuoywkSfsj71fb1fzdtohQMNxW0KOe/fNhPR/0=
X-Received: by 2002:a25:5f0f:: with SMTP id t15mr16854532ybb.26.1605525529784;
 Mon, 16 Nov 2020 03:18:49 -0800 (PST)
MIME-Version: 1.0
References: <20201116043532.4032932-1-ndesaulniers@google.com>
 <20201116043532.4032932-3-ndesaulniers@google.com> <20201116062639.GB7265@embeddedor>
In-Reply-To: <20201116062639.GB7265@embeddedor>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 16 Nov 2020 12:18:38 +0100
Message-ID: <CANiq72k=m1=vVaO4bfqGoLReQzQ9ywpyXF=-M6vbw3XzRe_0fQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Revert "lib: Revert use of fallthrough pseudo-keyword
 in lib/"
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 7:26 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.com>

.org :-)

Cheers,
Miguel
