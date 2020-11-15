Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E532B392C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 21:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgKOUfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 15:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKOUfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 15:35:36 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDF2C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 12:35:36 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id dk16so21502045ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 12:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ijg9lN4q+y1lKWWb0I210T2G+LZI/xVs/0TId95I5ng=;
        b=W4RjtnWI+BKHWNFpCfOvPpta63nqCPhbZ7c0m6ZzGyaCq9QyMuC/YqekjnwfgIdThW
         5HSVWNfrroeWYcXASxPhMJNLVINwYYJ8JvFdsUPYpspSkVDZR8IIjsrPZKy0WElubF6S
         qyXsNa4mCurwFnpdeeYUGlI4aAgras0OiNeQx9rnwbWXhYK1DPdwXigkJTplPkKXBvPw
         4WVIk+8DZq5ekCeaiXctRAEu04RY6xIDpjw66RBCcvmgx326LIffJW+aUkNT+LTyzNZp
         0ZgVkS+a+7mdIa4eCzlDQ6VcacMEkNKRncn2/W747wEx/TkpEEt5GbCyQS5foUrourJR
         qyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijg9lN4q+y1lKWWb0I210T2G+LZI/xVs/0TId95I5ng=;
        b=oMYQD1rcVbiGEKFaJrsk0bTNcwVTx4Nc3QnfT3ClK8EQThmLXmcqeSBSccpNGeV2Bc
         d0ZUEbyfAJYl6DV2F5XldXpK8wemFnM8VTz/UPdPOm2UcrnFZTaGXqpMxMwJV3+yzO/l
         TVqCmKmJgcMQw+PMa30X6cTkGrFd8yvHLJOhUXI6sJEbH8/wYPNQUjUtTNAssLuJjnPB
         mcIPQmTlnGkQ02l616qm5mp3F8bA0rLWNbrxBKVFe4uimf4yqSWmhOj9rCAg4OwZuzQD
         pgnbilYugVjVV1pCTlhs6GXsaxgHj2iPim9rnzaOfdvxhuq988ijC0ovl1cfYBAfHABA
         5Ggw==
X-Gm-Message-State: AOAM532hE+pFLF3njev7ihzAI9FcUGVr86aEjh2ymKX/qQ6qXVjK4UjN
        7tO28ADByitlu53GOkIun1ME/w6fOA2XlzbOCRYO0O5td0A=
X-Google-Smtp-Source: ABdhPJxHshwuqi/yaOW02cHa96cuk2s8w5tE5RdJPO2rcxGDrZpH6KdRqzYXTPZvr5A21b7vculdOK9IfW5KLpF9uCQ=
X-Received: by 2002:a17:906:82d9:: with SMTP id a25mr11612572ejy.101.1605472534755;
 Sun, 15 Nov 2020 12:35:34 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
 <20201103222013.hypmzlq7uuqufe76@box> <CAHk-=whPqB1PUVCCcQMjm-YTBnTP7UD_ey2rbXzcJhQufJwcUQ@mail.gmail.com>
In-Reply-To: <CAHk-=whPqB1PUVCCcQMjm-YTBnTP7UD_ey2rbXzcJhQufJwcUQ@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 16 Nov 2020 06:35:22 +1000
Message-ID: <CAPM=9tySfv3vueCjR84MTzxiZdKZZwVuddb-GuuPyoVncoSPyg@mail.gmail.com>
Subject: Re: [git pull] drm next pull for 5.10-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 at 03:57, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Nov 3, 2020 at 2:20 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Thu, Oct 15, 2020 at 11:33:08AM +1000, Dave Airlie wrote:
> > >       drm/nouveau/kms: Search for encoders' connectors properly
> >
> > This commit (09838c4efe9a) broke boot for me. These two hunks in
> > particular:
>
> Christ. It's been two weeks. I'm doing -rc4 today, and I still don't
> have the fix.
>
> The problem seems entirely obvious, as reported by Kirill: the nv50
> code unconditionally calls the "atomic_{dis,en}able()" functions, even
> when not everybody was converted.
>
> The fix seems to be to either just do the conversion of the remaining
> cases (which looks like just adding an argument to the remaining
> functions, and using that for the "atomic" callback), or the trivial
> suggestion by Kirill from two weeks ago:
>
> > I hacked up patch to use help->disable/help->enable if atomic_ versions
> > are NULL. It worked.
>
> Kirill, since the nouveau people aren't fixing this, can you just send
> me your tested patch?
>
> Lyude/Ben - let me just say that I think this is all a huge disgrace.
>
> You had a problem report with a bisected commit, a suggested fix, and
> two weeks later there's absolutely _nothing_.

I do have a fixes pull from Ben from Saturday in my inbox, I can send
it on this morning.

Dave.
