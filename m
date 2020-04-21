Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE41B2FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 21:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDUTDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 15:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgDUTDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:03:30 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033F9C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:03:30 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f18so9133727lja.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypgvWSUE3Hp+aq8UwpRBxeqBs2PJ/juR1hUTdDpXVsM=;
        b=hRM+woRxkymnWjkfxYhVHZTtkc/aEqCtO4EREIGDhuTdhHR3znpp8TJJX4VklGajh3
         J0Avw3mQ7ZFZqf0cuwRsGIKeyTctPKl+Duk4GutpgC9tn32LwAJz2OeTNyzT3gY2x5Pt
         n6IySZdsqG/2hL2dZvJP3mgokqxOD+I+D2LRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypgvWSUE3Hp+aq8UwpRBxeqBs2PJ/juR1hUTdDpXVsM=;
        b=tPJrFrXWOjwrhajakPfIQDU+We/bwd9NlzoIC4GuP2Xoy3s6/oH288AcqMn9IpwUus
         p+tELnLrpj4s8tCb8D3/lUNqmfcWrY/tQWltS8NdKP74c2CsnVdqVYO4lKoPXpfUZIOc
         SGdJsPGZvhavFwaQoeoJ9UZI4m4C2Gws2X1FhDwKZ6TjgiKvRkavPaE/9SXYATz6ltwt
         ua6zyxevc00kscNIcKgCUzYTOzRhtKDmgGuR7wmQLJ5YhjCvghjQo3vpOYtmYbfJSvsM
         tUu+EEO/Sx6nPi3xPfzUsk9j7aoTaDXlHdqwq/pzTrEMSAxaV8+Gw0rZpnMl5rymClg/
         Lcdw==
X-Gm-Message-State: AGi0Pub5vK/jQkCxGgRbUpuZHUD+WGk/0AbkEXlpaZV1L5YBdQYRGM01
        xvaLhv6eIYw5W4Lx6/FRTxsqP1dATRQ=
X-Google-Smtp-Source: APiQypIIp5McOWTdYFJy+IcyeOwZJPWV0lPlguiBRfGHmNrwWVnVVChAT3IPexBNWg+yTJuoW3wFdw==
X-Received: by 2002:a2e:8645:: with SMTP id i5mr13068164ljj.56.1587495807692;
        Tue, 21 Apr 2020 12:03:27 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id w24sm2777211lfe.58.2020.04.21.12.03.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 12:03:27 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id l19so12627767lje.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:03:26 -0700 (PDT)
X-Received: by 2002:a2e:1418:: with SMTP id u24mr14588814ljd.265.1587495806435;
 Tue, 21 Apr 2020 12:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiQsJu-ZFjt7+c9FVD5R40khtZiihrT+7O3UaVvHYz=HQ@mail.gmail.com>
 <428bac87-b6dd-0867-c8f8-622cd606de3e@skogtun.org>
In-Reply-To: <428bac87-b6dd-0867-c8f8-622cd606de3e@skogtun.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Apr 2020 12:03:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com>
Message-ID: <CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com>
Subject: Re: [BISECTED]: Kernel panic (was: Linux 5.7-rc2)
To:     Harald Arnesen <harald@skogtun.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 1:52 AM Harald Arnesen <harald@skogtun.org> wrote:
>
> Neither rc1 nor rc2 will boot on my laptop. The attached picture is all
> I have been able to capture.

I know you saw the reply about this probably being fixed by

  https://lore.kernel.org/lkml/20200416054745.740-1-ggherdovich@suse.cz/

but it would be lovely if you could actually verify that that series
of four patches does indeed fix it for you.

Your oops is on that divide instruction:

        freq_scale = div64_u64(acnt, mcnt);

and while we had a check for mcnt not being zero earlier, we did

        mcnt *= arch_max_freq_ratio;

after that check. I could see it becoming zero either due to an
overflow, or due to arch_max_freq_ratio being 0.

I think the first commit in that series is supposed to fix that
arch_max_freq_ratio being 0 case, but it still feels like the code
that does the divide is checking for zero in the wrong place...

                  Linus
