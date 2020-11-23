Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E162C1833
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 23:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbgKWWHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 17:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731969AbgKWWHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:07:24 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F02AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:07:22 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id 18so9545447pli.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=TaKNq0Vmt1rCpBMLeTVqxMuut2Wh1ngLnfCI1bJ3IR0=;
        b=UWRBjBZ328jeioGi/8zb/XNVOPRVtXOq4eSr05KKEmh45kgcNdehmBG7Xcyql5ZYxb
         b3gdN+aUQuMwBnWI69113OJ+iSZhdIXYX8MyeGXLEtvhQcXSborXDZ7/0F71VkDrLuf8
         oxetw+WK3/SrApV+/4w9ciZwqV+rhaNnONs/pUrY3WSiP6F26RmyspnNMZ35s+cmQyUw
         G1+PupXwLYWfAg/ijxK5Haz57bxjs1uELcFyieVhaR5YK59ekaPNl7yrXsbkBGUgIdZw
         4l08jmfZf0VGvwZGrjg2paKMiCzt1CVpEX2xzgi5IrRHrL2aPq2h1Sx7kalW5V7O72tM
         RPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=TaKNq0Vmt1rCpBMLeTVqxMuut2Wh1ngLnfCI1bJ3IR0=;
        b=FNBvFd9XOnCXY2uCTBCI3C6zb7KGRlAB6igecsis1zQ7hICcJ9fStuOQe41+5GQpsa
         VFT7CTxNG784pPssZKtkWyU7FV04zw0yj0kPIlmokesOErKyJEEQe7YmV2qcrvvf63u/
         PAZ6asOIjJoMvFmXZLz7YOKzGf/RJmocb7/6uNErhBZXDM/cwMN+D0xiooNreaGplZzS
         BXh5UL9mZaUJe3nx4XcHVo2mcXll0Rv0Zi/Dao9FQ+3SChDPxhW4CJP8GaTU/N4uI0cJ
         Up4e0IbpEiQ9MMsInGppGZ8YLiiPyzeqeKZoHXZKGGbVo9zJYjiQ5FYGvhArz3XptLql
         cVXQ==
X-Gm-Message-State: AOAM532/codDlK/DDULf7GAlGJGlKHdiMJCBZCIV4y3OfCXvveMwwGSo
        BGxthC9dBi9X3BL6yMAKRdKtiw==
X-Google-Smtp-Source: ABdhPJxjtuWxeucBrB4XThYnYHY4MAmEBqJLJaFJHccOIycvvNEk0Nqp4X1SBZv1QMqZ/gdvxeonKQ==
X-Received: by 2002:a17:902:c3d4:b029:d9:ddb4:5146 with SMTP id j20-20020a170902c3d4b02900d9ddb45146mr1362887plj.73.1606169242061;
        Mon, 23 Nov 2020 14:07:22 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:5066:c8ba:b185:db28? ([2601:646:c200:1ef2:5066:c8ba:b185:db28])
        by smtp.gmail.com with ESMTPSA id m8sm11328937pgg.1.2020.11.23.14.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 14:07:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch V4 4/8] sched: Make migrate_disable/enable() independent of RT
Date:   Mon, 23 Nov 2020 14:07:19 -0800
Message-Id: <9BAD6F21-4DB5-4277-A38D-BB1FA038F2D7@amacapital.net>
References: <87h7pfn4u3.fsf@nanos.tec.linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <87h7pfn4u3.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (18B92)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 23, 2020, at 1:25 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFOn Mon, Nov 23 2020 at 22:15, Thomas Gleixner wrote:
>>> On Sun, Nov 22 2020 at 15:16, Andy Lutomirski wrote:
>>>> On Fri, Nov 20, 2020 at 1:29 AM Peter Zijlstra <peterz@infradead.org> w=
rote:
>>> The common case of a CPU switching back and forth between a small
>>> number of mms would have no significant overhead.
>>=20
>> For CPUs which do not support PCID this sucks, which is everything pre
>> Westmere and all of 32bit. Yes, 32bit. If we go there then 32bit has to
>> bite the bullet and use the very same mechanism. Not that I care much
>> TBH.
>=20
> Bah, I completely forgot that AMD does not support PCID before Zen3
> which is a major showstopper.

Why?  Couldn=E2=80=99t we rig up the code so we still track all the ASIDs ev=
en if there is no CPU support?  We would take the TLB flush hit on every con=
text switch, but we pay that cost anyway. We would avoid the extra copy in t=
he same cases in which we would avoid it if we had PCID.

>=20
> Thanks,
>=20
>        tglx
