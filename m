Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4629A27A9C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgI1Ikc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1Ikc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:40:32 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1247EC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:40:32 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 16so242816qkf.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iqYQ5sz+ArIYSfmlt3OgrHWYttBziLhTw7xUILWTUa8=;
        b=LGz086CBKtcRDQrRiYcu4//fyA986gsqau4zivFr1ptMVYQF5+QawkhsBLRCr1jwQo
         XJ0KJb5ovlOROM04ruNuv67lpzJC+Jm/SRDp997Ze9jzV3MWRCEY0/2PA24FbQEztCIw
         kevYK0ZarE6OpE/Dw4gAGqSwTfW0ABzxeRgmgrVr1X10zD50wFeoH5eu6ccFcWv8Wx6T
         CJ9nXKBupql+cyahbZ0VKEF3Gu4YZNCv/P23AW0mVc2c5AMh76JtgDoTjTsXU5u5KKps
         Aumijl1MJXrQoHLqd1D8u7IsdjyfXX1AcWayUTZ/gWyT1Wgi6lhg+xDPgYuOeXgwl/dh
         1f1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iqYQ5sz+ArIYSfmlt3OgrHWYttBziLhTw7xUILWTUa8=;
        b=bMLFsFjDM0AzfjBWbrG+oRd0KnNlsAGgF9XJiuFsxp6HvnqfpEtwsWW36kZR2jQEFm
         WuHbSUt3oJVxyFZxFnXy4Thz1CC0xSWMG2B9hg4jJU4fTdvn7hfB0JSf52Bs+COAQf3q
         m0fUNJk0n1pbpcWs/Rz0ueattcm+2yKgBFq6AL1szV0KK0kVGlM+GLkZcC2l3lTfm0gE
         9nTsuirIx8uZK0q23or5e5yee2RKR65UKGjJ26pEsMYeoQN/nw3ob+NwL6/1o9qQcX9H
         KjXrpuUENW8CRkwfX0cCfI1pfc5OE/D1/ImpTlbWICS3vtsBM/9hKTreXWKUsZZhIsmh
         HS6Q==
X-Gm-Message-State: AOAM530iv5U0dLXXDswntwl8of2XQgm6yyALf3DcgA8CukNF0hjj+ijx
        Bmu/ayq3RVRpkFIERk2aUmxDZr014MKPBCY7YbgpxQ==
X-Google-Smtp-Source: ABdhPJwGA1T3uid5wMv1FTMnfX/Lrb+j9EQGvD/7of/YtLQ85Lxn96P234GJoGhpEpLE7ryT3c2lvnKB2vB4VDmwBOY=
X-Received: by 2002:a37:5684:: with SMTP id k126mr366051qkb.43.1601282431060;
 Mon, 28 Sep 2020 01:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200927145737.GA4746@zn.tnic>
 <CACT4Y+Zxt3-Dj6r53mEkwv24PazPzTxQ7usV1O+RB0bk2FzO8g@mail.gmail.com>
 <CACT4Y+ZZH76qg810RzGp6FDLTxJWVqZgkrXSxqgq7AjpPYG9XQ@mail.gmail.com> <20200928083819.GD1685@zn.tnic>
In-Reply-To: <20200928083819.GD1685@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 28 Sep 2020 10:40:19 +0200
Message-ID: <CACT4Y+bPFASnmFRKpQ=KY1z+RnTbGmkPU3aikzdXZpKkV03D9A@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:38 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Sep 28, 2020 at 08:06:19AM +0200, Dmitry Vyukov wrote:
> > Maybe it's just a random silent memory corruption in the end?...
>
> Oh, the rabbit hole goes deeper. But if it is corruption, what is the
> common element in all those? All those guests have run on the same
> physical machine?
>
> If so, you probably won't get any logs from it to search for MCEs or
> so...? Maybe the GCE people can do some grepping :)

I meant the kernel self-corrupts itself, that just wasn't detected by
KASAN, page protections, etc.
