Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902D92953F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505943AbgJUVPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505935AbgJUVPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:15:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB36C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:15:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v22so1860061ply.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZW4H+HkSax4dfTCQ1O9mSWMOeNGYTGZ0c8Mu7npYyhs=;
        b=HUZ6cRVo9d0RsVGYnGFg89JSJPcVvYT3PMRLwXbw5iWTQay9ot8awNMm7nKLu1LuTV
         c+cx9K/OprNoV0GA2CqSUfa/AspC8VBIFx+SldLz9nnTBBpnc537eaE4v3hwe42wuXRc
         FRWK0AF25WqxLdVeDBzlNXk5N6frWsw1iHdiYUcyldo511mwQVnf2g+uu+hywyFyC/66
         LD0xml/QOgc5TTG+cnprqdLUa1BXO+u20TQQy3jbTmbwQc7hsPurQyad60Yqj/TPgymE
         DxVxKTdhxm+qI72kjl+2YXoRjVoiqxHtqyb+c6cBQNR2yL8O1Aoo/bIfzjKF0vyrHo6r
         DTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZW4H+HkSax4dfTCQ1O9mSWMOeNGYTGZ0c8Mu7npYyhs=;
        b=rZPDaNvTUuv7tKToIsEq2minVAQYUJ5KRgT10MFiNBOJ8yz8MzWK567P3LMmFA0YRP
         u+LO/cNhJYxy+be7tLOtFtIn+9y7/n7J6gJVsmlUfCIiApXfqope1GcSLzTImy+Ztzw4
         BkIt2/hgIDcUJRQzCSxuzAg39N+5mqgg8y20Ugz4ZlGShiG1AfJM+qctjzPJKmhEXmRZ
         t8bD4LbDuCTvBiGXY9GLg9d+ZzI8bsWgcZyi89+inn+zdIvFHunChkgTtX7btHEEGTlO
         7FnuVRwbHFab/0VJFn3BazDiXnTLJ/EYw5qyth5KT1MVpF3QQ+chT6gMDs7qQtULrTBR
         RcFA==
X-Gm-Message-State: AOAM530pZq5LFJ0ni2oq6eJajZyLtNMgCdZNpvcuku1FZfpIGKzPM4+D
        wF1xAbZPpM21Kp2+M3f9Q8jUnBH27z86zGLCUkEaZg==
X-Google-Smtp-Source: ABdhPJyHzdUuY/qEGoP+823gx7/+DiP+C7sHXVbsIemUhDFho7iS0vIenEO5E+i/+epQw1ICFAS4493V4uNXaAJUgig=
X-Received: by 2002:a17:902:7003:b029:d4:e2c6:948f with SMTP id
 y3-20020a1709027003b02900d4e2c6948fmr141621plk.65.1603314943760; Wed, 21 Oct
 2020 14:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201020073740.29081-1-geert@linux-m68k.org>
In-Reply-To: <20201020073740.29081-1-geert@linux-m68k.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 21 Oct 2020 14:15:32 -0700
Message-ID: <CAFd5g44dGaKyDQGPeanE1G8MPzVdVkqbWjJhj+nQJGUgkezz9g@mail.gmail.com>
Subject: Re: [PATCH] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS instead of
 selecting it
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 12:37 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> EXT4_KUNIT_TESTS selects EXT4_FS, thus enabling an optional feature the
> user may not want to enable.  Fix this by making the test depend on
> EXT4_FS instead.
>
> Fixes: 1cbeab1b242d16fd ("ext4: add kunit test for decoding extended timestamps")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

If I remember correctly, having EXT4_KUNIT_TESTS select EXT4_FS was
something that Ted specifically requested, but I don't have any strong
feelings on it either way.
