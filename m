Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207C928A970
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 20:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgJKSmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 14:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgJKSmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 14:42:38 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ABDC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 11:42:37 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 184so16089518lfd.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 11:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bv4yr1zd3oAgKGx/Y9Gfo9WCWv5ck5Zpi/t3B3m+xNI=;
        b=b+ZQBWCms04b5LpZCD5ErQiNvoQjpsnhRSNoVzN8K3oQ8LE2/9vVkkglylj9w+cXy6
         JLaATxwhlXSJKvnsuNMM574Dl2ErqnrMAgVw8ChUWI1RUl27CzMiBciFRk82jSJKNTNh
         3K2xy41zC02voPckdoU/HIltfJ5ZUNv3p1qLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bv4yr1zd3oAgKGx/Y9Gfo9WCWv5ck5Zpi/t3B3m+xNI=;
        b=RQmuvVRfLgAablnkrdf1u1VUyV6rSkLtx+6v8I28sYxigXweI9qzcBsrxSP9UODTnv
         VrTc8UZFuEUfMen0pe6jRHD0E8RagIOAkRI9bZVZ22gYA2x+YpKaQllzT8/P0YQ4MBYI
         1jRQTAMBYV0JQmcUKXYglz0c/0RKhMQZ4ZPrYUlnQ6cWp/4O+7TR32D4BY0err3dmvKT
         vmsAnOW2LH58i1wKWtDx3SDxBcOdqCI6O080wNr59tN8U3F5BAMhuZrsduriDTJ+WbRL
         FeqD/daW4WoyegdMBm3HyWarrJGCjFYLdlW4Ar6qLVjwCxh307ShgZtyrnMT0Nh5g5fU
         J5sA==
X-Gm-Message-State: AOAM533Kvvcte4Y3hbHVmOrjxHWSIGrDwlPIrDe5x1Ew47PUi7380hzO
        lR1qGCCvgFcRWVvSDsDTUIrCivga6/i4sQ==
X-Google-Smtp-Source: ABdhPJytTCqqxESyUI10EipOfB1YBLSwC76qSsQ4ELUQs21QJLRLS4zGj2kuOx2WcWb5452SO2s86Q==
X-Received: by 2002:a19:ece:: with SMTP id 197mr387445lfo.474.1602441755981;
        Sun, 11 Oct 2020 11:42:35 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id x4sm2666383lfn.280.2020.10.11.11.42.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2020 11:42:34 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id f29so859853ljo.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 11:42:34 -0700 (PDT)
X-Received: by 2002:a2e:8092:: with SMTP id i18mr8544266ljg.314.1602441754158;
 Sun, 11 Oct 2020 11:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <307a7581abe24135ac243c3080d4ab9e7c044cbf.camel@perches.com>
In-Reply-To: <307a7581abe24135ac243c3080d4ab9e7c044cbf.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 11 Oct 2020 11:42:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKT9j821qfbb7cs10RPcoaWTtHCjuQzgmaMLk+zZeOOA@mail.gmail.com>
Message-ID: <CAHk-=wiKT9j821qfbb7cs10RPcoaWTtHCjuQzgmaMLk+zZeOOA@mail.gmail.com>
Subject: Re: git grep/sed to standardize "/* SPDX-License-Identifier: <license>"
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 4:13 PM Joe Perches <joe@perches.com> wrote:
>
> Almost all source files in the kernel use a standardized SPDX header
> at line 1 with a comment /* initiator and terminator */:
>
> /* SPDX-License-Identifier: <license> */
>
> $ git grep -PHn '^/\* SPDX-License-Identifier:.*\*/\s*$' | \
>   wc -l
> 17847

That grep pattern makes zero sense.

Why would */ be special at all? It isn't.

  $ git grep SPDX-License-Identifier: | wc -l
  52418

and a *LOT* of those are shell scripts and use "#", or are C sources
and use "//" etc.

So your "standardization" is completely pointless. Anybody who expects
that pattern just doing something fundamentally wrong, because the
pattern you want to standardize around is simply not valid.

             Linus
