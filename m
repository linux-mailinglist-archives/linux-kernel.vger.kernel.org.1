Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7953C2A6E56
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgKDTyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbgKDTyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:54:46 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40129C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:54:46 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id i7so15532589pgh.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lH1r8oYHPf/SLkAdUec1wsVY4Z4avP7pYIBJELMlRNs=;
        b=s80e2IW5lbn2vFg3DpNgluZpfDwN3zlr+ZmzjHWEhI81R1nDlbLl0DM6S6o+T/+e7K
         y115+5JZH0VrGnI8rOunLMLHpFxSBLA/YU0jfEjl/IU7hJlZOem6uV3UbvC9H8LckeUC
         SfD4NGveBFuzVhyj6rlBdYH0kYlwawz0jqqxPmatwe3Qs9jSzMaJwCi8o5rgUviuxBzo
         iEUJkGYwJIsJLHs8pAyPbtpTCM4UIjeecoo86kakBTCkwV2a3Vn6/4YKo5ZdoOq9sZ0l
         e8Y4v+D0jCQIxiqc7ImC1mj8Hz1asVkHCIBr/hWSUJ8bUWaG5LgmUxbnYosEx31Gxz5J
         /d/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lH1r8oYHPf/SLkAdUec1wsVY4Z4avP7pYIBJELMlRNs=;
        b=cfHJNLMsxGxrtoWGEbeuDnRFd2Ds0jTV016z+4KMayPewxx3ptOvgDSyt85CNolTI3
         y2CgqtCOGPietzsIPD5b8BfJjL9KtgiMYJ3Gwt7I8GeuQgx1jPGozk3L0pIAIjNaX9y3
         wbuGR/43DJMlcfBsrUQh/+j8QJwX2EQQ6Pkt34Ksy4q6XSFY2xVXqqi1jvA9Bj4AF2r5
         XbCd5il7he0oHCMjY9vVeSKh2dOf1B9ojt4XzzXKu5IzXeKuUXu+qK4HI1HA7LICwhMM
         /9fqt+s3dEe6JINJUtuXp8/qIqGuV0eTpj4ytsKxYZhpns3zjgizKcKEnNfRXGUvRPXJ
         aAgw==
X-Gm-Message-State: AOAM533hYe9aBlStJIU5Gvv+CvV8MK/x61cN2fnbqi8w9lsRF7CsmSDD
        sczMiAcG6NAASzXeNclrvILxsl1EzOWGDAlPHsLBqw==
X-Google-Smtp-Source: ABdhPJxqJhBIbBXWB6/VmfmZVsLpzR/puvemSZga5m42q53kjlpVGuN14TcV/cfWYNIPF59CqBO0eWmVgH04FCwJq8A=
X-Received: by 2002:a63:b55e:: with SMTP id u30mr9421507pgo.381.1604519685500;
 Wed, 04 Nov 2020 11:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20201104191334.393972-1-ndesaulniers@google.com> <CAK8P3a3wAikP-KkGUiznqnc5f7Uja_UaYxvkCLVtcHDu1tYuGA@mail.gmail.com>
In-Reply-To: <CAK8P3a3wAikP-KkGUiznqnc5f7Uja_UaYxvkCLVtcHDu1tYuGA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Nov 2020 11:54:33 -0800
Message-ID: <CAKwvOdn77f-v4wj78YVxKhM4mgtuE++JtmORXAmfzK+xs7voJw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mark LLVM as maintained rather than supported
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 11:36 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Wed, Nov 4, 2020 at 8:13 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > Funding secured.
> >
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Did you mix up the two? "Supported" is defined as "Someone is actually
> paid to look after this.", and it sounds like you are saying that this is now
> the case but wasn't earlier.

Ah, sorry, then please disregard this patch.  I kept seeing
"supporter" listed via get_maintainer.pl, and thought that was a lower
tier than maintainer.  I should have rechecked `S:` in MAINTAINERS:87
-- 
Thanks,
~Nick Desaulniers
