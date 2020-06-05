Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAC51F0388
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 01:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgFEXd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 19:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgFEXd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 19:33:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3915DC08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 16:33:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b6so13784212ljj.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 16:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ClAVloF54JIqrc+m+0ATOT37Q30+IcoX9urgdaodTTM=;
        b=HenIB/3KEnX6g7OVHqu+kSDDosed1DGCBW9BlMitBhtXu1qUftlTh0ByQYgIxxzPaJ
         v1BjKRoudpt4MRAW4isZGAyfXDO8MooDq35/5ak4ac6HzntoEvXpzd5SVBQKA2dAjkgz
         VEzncixfstBUoWrWg53pxL1hUYFIG0E2zxjFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ClAVloF54JIqrc+m+0ATOT37Q30+IcoX9urgdaodTTM=;
        b=obz0XpL57QAV9akfnUe1k9Mr8TXbWJpR8UvrXQl6iubTpzPpJL6a9DS543byFLPODi
         yyUx1dQxjgL0cTO0b2bIZvsrUJD9hrIfWXsV55Ld1IhAttzGyuCu3yFz2WOx1ZZnFGE/
         24Bo9l3D25l7d9M0nP+WYnsIn1m+XNmH372rS37t3RAg9r6EB4zMhvmn1W2SOeVZMVcW
         v2NGOuzeDJ+oaaxW1kjnnmg/Wkt3o1vTJytDId2s2dQ3m14U+ri7Op7zKBEsKQySLfO+
         MX+0upJWNuGxfoZXOdNWak6TZWGDOKjuRJP6T6A9myAi6HU0u6vGH2K4wUDM/ZVV1Nfg
         NFyQ==
X-Gm-Message-State: AOAM530UrLelpHaqTRSyxWxqlkBPPhkPqD8Vhpp9e99pEhbahFLRp1sJ
        Sm3GX1MGSI/MIamBieVZBaeG0hB/zvI=
X-Google-Smtp-Source: ABdhPJxwAZn8pejrqIJX36pC2/e3/SUWmdpAe1bVvyanS+9qI3soZ+24pb4iBDRDAOHeLaigO8x3qQ==
X-Received: by 2002:a2e:97c3:: with SMTP id m3mr5861578ljj.312.1591400033960;
        Fri, 05 Jun 2020 16:33:53 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id p1sm1487563lfo.66.2020.06.05.16.33.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 16:33:52 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 9so4097740ljv.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 16:33:52 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr5449089ljn.70.1591400031826;
 Fri, 05 Jun 2020 16:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <2240660.1591289899@warthog.procyon.org.uk>
In-Reply-To: <2240660.1591289899@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Jun 2020 16:33:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsxbn2QamOL_xu0F8srnpmsAZ-k6eJMCFazAKOcJ4t9w@mail.gmail.com>
Message-ID: <CAHk-=wgsxbn2QamOL_xu0F8srnpmsAZ-k6eJMCFazAKOcJ4t9w@mail.gmail.com>
Subject: Re: [GIT PULL] afs: Improvements for v5.8
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-afs@lists.infradead.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 9:58 AM David Howells <dhowells@redhat.com> wrote:
>
>  (4) Improve Ext4's time updating.  Konstantin Khlebnikov said "For now,
>      I've plugged this issue with try-lock in ext4 lazy time update.  This
>      solution is much better."

It would have been good to get acks on this from the ext4 people, but
I've merged this as-is (but it's still going through my sanity tests,
so if that triggers something it might get unpulled again).

                  Linus
