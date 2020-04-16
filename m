Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DCB1AB617
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 05:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389682AbgDPDKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 23:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388679AbgDPDKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 23:10:32 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89CDC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 20:10:31 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id o25so15422316oic.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 20:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kvQz41+YJ6K8MZlwaic6g1JoTDzmLdupa02Hek26+Fw=;
        b=OiqRjo6FQ0/ABr0U7Pqk6ZHzf31I3Rnbctlzd4kIDtL1DK5iq3IWT/wqPpwH27Pp7e
         VlRyTRKgezkk8yFc0gP2eGd/Yiwa5aWyWYXd0+Kup/qUsMrBrl57Xc8kpo5e26+xr+BF
         bNwvP2u0qnt3Anad6hBZvjeDumm1uTtOGHgUscBQZ5a0HoTvTF7/1221uEcPayiwAhDM
         1M3tgJNQw0tcqoGgK2rpjZ+zcOLxoPr0fDvcvfAzLdndWhnglfvY1R/DJtcSjZA7sz5b
         KEybyy6Iz5rOgJu/jwBY/WaQM01Ss97RWhBsB919mkmJnnbj0WX0FkD+qCwTD3g1ESvx
         enFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=kvQz41+YJ6K8MZlwaic6g1JoTDzmLdupa02Hek26+Fw=;
        b=ehNwNAsos2W8o1EGAluVcZtyEgzUyfXqcWtqQ8he8JWJFft2s7fVvFYUmvZNZgTwAu
         +8s8X3kWb4WyeIciavUCksq2aqqF+1SdoilcT31Cz7xvYU7hyTvwch+E/Q7pX/Kf5QJo
         RqGIB/Ru+qOmgc18lEFIoZmi05GcG19vVg5itY9PAUkFom1mgHvWyLY484b2225Au6Mi
         xN+30D5GxZw9BVdMpt+dmmIIyEiMvQiT3rOJzVh9aj3eP3WKjr8Rm1FVUI8hoObNJxJz
         2Q6uhRMKzrsYjx3matHBrD505mV8nvXFb41ddfJd+xhWvy67qlziDZaf7ZayZ09FMf89
         hDXw==
X-Gm-Message-State: AGi0PuaEf9lcJ6tyO9YgV01tPrZ3f67onIYHum7HNLHg00C174suq25w
        XnPijnZSUMM3mY+XhibVfqvqsg==
X-Google-Smtp-Source: APiQypLFO4uL9+pzH+etEJWpQl3jtU8YKFFSYEa5MWZBXApcZsRP4AaEA3IJlovSs9JXuYFpHY3Wng==
X-Received: by 2002:aca:cd0e:: with SMTP id d14mr1528914oig.167.1587006631069;
        Wed, 15 Apr 2020 20:10:31 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j17sm6769815otp.58.2020.04.15.20.10.29
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 15 Apr 2020 20:10:30 -0700 (PDT)
Date:   Wed, 15 Apr 2020 20:10:15 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        syzbot <syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in shmem_mfill_atomic_pte
In-Reply-To: <CAHbLzkqESnh2JNe5CuiH8QjUOskDEihZUXumLAkpLXoa3uvdsg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2004152007370.13597@eggly.anvils>
References: <000000000000571acf05a229cb2f@google.com> <CAHbLzkoTC3WoNa-dLBBmi15oBRXNbJzJuS6-GPr8XPWiHrgO4A@mail.gmail.com> <alpine.LSU.2.11.2004151808370.12919@eggly.anvils> <CAHbLzkqESnh2JNe5CuiH8QjUOskDEihZUXumLAkpLXoa3uvdsg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020, Yang Shi wrote:
> 
> Thanks, Hugh. I believe this commit could fix the splat. I'm trying to
> push my test tree to github to let syzkaller test it. I will send the
> formal patch once I get it tested. It is just slow to push to github,
> less than 50KB/s...

Your diligence is admirable.  With straightforward ones like this,
I tend to just rely on syzbot to call me out later if I've bluffed.

Hugh
