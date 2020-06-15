Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0574D1F9687
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 14:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgFOMaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 08:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgFOMae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:30:34 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905CCC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 05:30:33 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c194so15710622oig.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 05:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tWSA5FVA8bXyBwXd6vhDmVX7eTx9jTJK5LgJxK7Wee0=;
        b=JPDq6iHlIfTHgfcHNpDQZ4UfTO9p3TJfgidxLHwezLec/fXvvr8IdHp2qAkLjWUHMP
         0F5gUcC6DrJAxt9prx3YsZA4gr2RWyWUGsqsm/0zBJWmtmpNphXrjvNKDe2QpvqbtDhG
         9faYity0ydP/4dDaDPUYyqruFpsyKprCY3mKanf3nQD8um3anQnhfg/MhdAdOxMEBCYa
         STAQ4vFKBEhSl99H7sIi26naWIIfsf7+8tm45KeF1I4lApcuVJeYSRuG0GFuQTXi9cKj
         MCsv2maRiLZXaooQX1xbqUtyShfCso4xLrQ79wsPDBHTXKczBTDiGH+Y/Kw+DCLRGY+5
         YY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tWSA5FVA8bXyBwXd6vhDmVX7eTx9jTJK5LgJxK7Wee0=;
        b=QRwME9welzxeCP2HBmSxnmNOJ++XS9PbJ1T6d/+hL8p96RPJ4qSz+G4Ff/qUTnQOXz
         WDXYT9Dxa0bgLsPF+gnYvLiYz2UwAUtW4VPOWQjINJ07dXZNkj6jUhqJwCHrtUzWzXpS
         6I2g0Ejc/92evuND3Jpa6Yt36QOixI8VpfTVy3RvD1fpP+AnvvXCy48ijc1vYSk7EWXf
         8GCseDAQRQcXdKTWog5+NSHFTRidqSs4N/tDyN3/EYC/01wM0rwRjGdYqOEcTJFZsLnc
         a6T3FMVf81edvdz7rzO3JEzobCdPRynb7qU8aGEIT1AHRbSQXyg+47kKDVbQ1uLTPQPB
         ySLg==
X-Gm-Message-State: AOAM533RuuqsUmGqTjrIZXZMhkMINAEKHppo/gy2KkUacxXmd4+wANE6
        DlBnCCy/nCt+sWL/jHYmMQgOExSlVur3sy8obPPRDQ==
X-Google-Smtp-Source: ABdhPJwQGg/4LetqJPkNs3aYq5vztJYNWyVHE9oV0AeFmcQtapjoRkr9R+iYHQEpbIX6+oni+7UqxIS0uaD1ytjaJXw=
X-Received: by 2002:a05:6808:34f:: with SMTP id j15mr8820767oie.121.1592224232767;
 Mon, 15 Jun 2020 05:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <000001d5824d$c8b2a060$5a17e120$@codeaurora.org>
 <CACT4Y+aAicvQ1FYyOVbhJy62F4U6R_PXr+myNghFh8PZixfYLQ@mail.gmail.com>
 <CANpmjNOx7fuLLBasdEgnOCJepeufY4zo_FijsoSg0hfVgN7Ong@mail.gmail.com>
 <002801d58271$f5d01db0$e1705910$@codeaurora.org> <CANpmjNPVK00wsrpcVPFjudpqE-4-AVnZY0Pk-WMXTtqZTMXoOw@mail.gmail.com>
In-Reply-To: <CANpmjNPVK00wsrpcVPFjudpqE-4-AVnZY0Pk-WMXTtqZTMXoOw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 15 Jun 2020 14:30:20 +0200
Message-ID: <CANpmjNM9RhZ_V7vPBLp146m_JRqajeHgRT3h3gSBz3OH4Ya_Yg@mail.gmail.com>
Subject: Re: KCSAN Support on ARM64 Kernel
To:     sgrover@codeaurora.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019 at 11:31, Marco Elver <elver@google.com> wrote:
> My plan was to send patches upstream within the month.
[...]
> On Mon, 14 Oct 2019 at 11:30, <sgrover@codeaurora.org> wrote:
[...]
> > When can we expect upstream of KCSAN on kernel mainline. Any timeline?
[...]
> > > > Can you please tell me if KCSAN is supported on ARM64 now? Can I ju=
st rebase the KCSAN branch on top of our let=E2=80=99s say android mainline=
 kernel, enable the config and run syzkaller on that for finding race condi=
tions?
[...]
> > KCSAN does not yet have ARM64 support. Once it's upstream, I would expe=
ct that Mark's patches (from repo linked in LKML thread) will just cleanly =
apply to enable ARM64 support.

Just FYI, KCSAN is in mainline now. I believe porting it to other
architectures has also become much simpler due to its reworked
ONCE/atomic support relying on proper compiler instrumentation instead
of other tricks.

Thanks,
-- Marco
