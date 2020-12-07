Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08AE2D0B85
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 09:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgLGIMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 03:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLGIMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 03:12:36 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED67CC0613D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 00:11:55 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id u3so8788206pfm.22
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 00:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=T1/uCgriftupixNf+4mVw4z0PH6umYpnZIgShocsQIk=;
        b=UAXJQsVF7WxLlgecGX62CA35WR8iN7FqGfdf//tLlZ88Ts9GFkFSJUjt1IIr6cvg7X
         +TlJao254/Q5SVTEQiHH8hwIiGTriqErShnXfROmrQDB3GhuwKPLijlPglv2wx/Hrisd
         U2LrZ9fbc+QGvXZzTGifekbCV3qTig11TL4UhU1+43F8g3oXXvwkDQh0rrgj8VCQnY0x
         jDsddGkF021YisyxSXSt4s7qcIzp4hG+7Pt/2NnrDfmBIiMv1Z/G66UXllQoebfQFxZf
         PVx83lFAPOeSrE5rvImcNtW18rrDnPV0Ac3L2ju+1ktC9SojE2GxUcf8kTTsTgqh9Mp6
         43Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=T1/uCgriftupixNf+4mVw4z0PH6umYpnZIgShocsQIk=;
        b=SHo2QP2YHdEi7INyCL0rB2I5mI5gMsFf66EhsZ+T1xs/cvzwtUOoyzbausl4QOvMgU
         64vHEgKeIsUI+bVDAHenBSxP/GyYTeqR6y/PCE20/4kBsqHUQFX8KeBjRX8MVzmo8yHY
         NhY7ZcUfsY2sU+XEAk6/M8Ghcq4ZKyQPCGzFDidFoQ0Rg0hvYSD/90hbcEZoYIHpsuwA
         5yEEfnJckU0OxxVo5GWUoWcSpPZtUw4oPhSOkz3zhqwD7YdTVjL4+vjLTPQJp8mAwuVN
         EfTLzJw44E9Kjc5BsNPxRahXQM/tSsqcwTV8+zl+QavK+xnzNs4CfMqbdaQ2KK83tKP/
         VMig==
X-Gm-Message-State: AOAM530U4y0Y0zRUKRXb3f4r6YDY7YCl7PSyeDKDFF7CF2H6jsKn/8sn
        z8m7JspsiAvX8k4wzrWkr4Os5ef8Mneq
X-Google-Smtp-Source: ABdhPJz3E1GFLe55Fi0egX3lmJnzWNni4b6aOcWs9etu3jPoTp2aROgDYTu87iAkHdDUpvB2HaELS7EEU2Im
Sender: "gthelen via sendgmr" <gthelen@gthelen.svl.corp.google.com>
X-Received: from gthelen.svl.corp.google.com ([2620:15c:2cd:202:8edc:d4ff:fe33:9605])
 (user=gthelen job=sendgmr) by 2002:a63:c4c:: with SMTP id 12mr17405303pgm.428.1607328715294;
 Mon, 07 Dec 2020 00:11:55 -0800 (PST)
Date:   Mon, 07 Dec 2020 00:11:51 -0800
In-Reply-To: <ddca2a9e-ed89-5dec-b1af-4f2fd2c99b57@linux.alibaba.com>
Message-Id: <xr93r1o2jarc.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com>
 <CAFqt6zZU76NOF6uD_c1vRPmEHwOzLp9wEWAmSX2ficpQb0zf6g@mail.gmail.com>
 <20201110115037.f6a53faec8d65782ab65d8b4@linux-foundation.org> <ddca2a9e-ed89-5dec-b1af-4f2fd2c99b57@linux.alibaba.com>
Subject: Re: [PATCH] mm/filemap: add static for function __add_to_page_cache_locked
From:   Greg Thelen <gthelen@google.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Shi <alex.shi@linux.alibaba.com> wrote:

> =E5=9C=A8 2020/11/11 =E4=B8=8A=E5=8D=883:50, Andrew Morton =E5=86=99=E9=
=81=93:
>> On Tue, 10 Nov 2020 08:39:24 +0530 Souptick Joarder <jrdr.linux@gmail.co=
m> wrote:
>>=20
>>> On Fri, Nov 6, 2020 at 4:55 PM Alex Shi <alex.shi@linux.alibaba.com> wr=
ote:
>>>>
>>>> Otherwise it cause gcc warning:
>>>>           ^~~~~~~~~~~~~~~
>>>> ../mm/filemap.c:830:14: warning: no previous prototype for
>>>> =E2=80=98__add_to_page_cache_locked=E2=80=99 [-Wmissing-prototypes]
>>>>  noinline int __add_to_page_cache_locked(struct page *page,
>>>>               ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Is CONFIG_DEBUG_INFO_BTF enabled in your .config ?
>>=20
>> hm, yes.
>
> When the config enabled, compiling looks good untill pahole tool
> used to get BTF info, but I still failed on a right version pahole
>> 1.16. Sorry.

I'm seeing an issue with this patch.  My build system has pahole v1.17,
but I don't think the pahole version is key.

$ git checkout 3351b16af494  # recently added to linus/master
$ make defconfig
$ make menuconfig  # set CONFIG_BPF_SYSCALL and CONFIG_DEBUG_INFO_BTF
$ make V=3D1
+ ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
FAILED unresolved symbol __add_to_page_cache_locked

Reverting 3351b16af494 ("mm/filemap: add static for function
__add_to_page_cache_locked") fixes the issue.

I don't see the warning which motivated this patch, but maybe it
requires particular a .config or gcc version.  Perhaps adding a
__add_to_page_cache_locked() prototype would meet avoid it.  But I
haven't studied enough on BTF to know if there's a better answer.

>>>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: linux-mm@kvack.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> ---
>>>>  mm/filemap.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>> index d90614f501da..249cf489f5df 100644
>>>> --- a/mm/filemap.c
>>>> +++ b/mm/filemap.c
>>>> @@ -827,7 +827,7 @@ int replace_page_cache_page(struct page *old, stru=
ct page *new, gfp_t gfp_mask)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(replace_page_cache_page);
>>>>
>>>> -noinline int __add_to_page_cache_locked(struct page *page,
>>>> +static noinline int __add_to_page_cache_locked(struct page *page,
>>>>                                         struct address_space *mapping,
>>>>                                         pgoff_t offset, gfp_t gfp,
>>>>                                         void **shadowp)
>>=20
>> It's unclear to me whether BTF_ID() requires that the target symbol be
>> non-static.  It doesn't actually reference the symbol:
>>=20
>> #define BTF_ID(prefix, name) \
>>         __BTF_ID(__ID(__BTF_ID__##prefix##__##name##__))
>>=20
>
> The above usage make me thought BTF don't require the symbol, though
> the symbol still exist in vmlinux with 'static'.
>
> So any comments of this, Alexei?=20
>
>> Alexei, can you please comment?
>>=20
