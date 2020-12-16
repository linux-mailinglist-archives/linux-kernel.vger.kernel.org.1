Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775652DBAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 06:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgLPFct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 00:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPFct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 00:32:49 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F10C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 21:32:09 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id y19so45235236lfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 21:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mlVLjTH9AOgJknupcrVpMVLnutgzPOfSo360c08jI34=;
        b=HZjv4+pbrCO0fsRovVGZolbJ+O0SKz0aJ1PmlKs8Bn7+hjkeismNI0H1Bpc92aE2B5
         lYwAGAsDs/BoaNTEV86IXWlcMZbBawrtfbCQjt3nB8JN7uAjo0dW3FhdS8KxPh+46sHd
         RyOdnlE2y5Dr8NV3Ur9vWGQ71tEtQ/AHZYj5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mlVLjTH9AOgJknupcrVpMVLnutgzPOfSo360c08jI34=;
        b=Q0YjUkyVbBGy+UHVtpKP33J6XtQLEaw9KL6Nz9ui/J51sPiGEFeDYPvdBxDTzRbkUi
         3DY6PtW6PgxFK4BN2RhSKq0qOt2xVoBpoOBFKbtWfxuw7gpzJqczjfdTeXj06in/e2CD
         mnec16GZ/SyuDNne9zkVzBRu+EhVLVz4Nns1ecoDKwZsgs5ekaB/sfe5GVkzKlHaoP/t
         Lt6pjzpIJijcI/SSNsNTDp9PH3dlvcVfqhSUvXcBJTVzmwwcZT/zzWpYvl1riPAmDvY4
         fnCyphFPiUH18Ni2Vi3eRP5W6UI6u5GAaUcen1OPomqSSSC5/O9uL8Y1tU+HkPEfiTTQ
         U/3g==
X-Gm-Message-State: AOAM533tojQHXImMFdyrbf11/cCTt4tjXqguqy8LRljICP/xwWuPAVbR
        MbZmdBjbsxcteR8B2qUshwaPXN/IzQC+eg==
X-Google-Smtp-Source: ABdhPJzPbWuxsUwjj963K5xwRnRDC/B1IPwsatw4tTexIe5dMmmAMMD5o6hdpkhKaAT3yE67yHTG4w==
X-Received: by 2002:a05:6512:247:: with SMTP id b7mr5871674lfo.171.1608096727242;
        Tue, 15 Dec 2020 21:32:07 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id y3sm140350ljc.131.2020.12.15.21.32.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 21:32:06 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id s26so10636666lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 21:32:06 -0800 (PST)
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr12915520lfb.421.1608096726101;
 Tue, 15 Dec 2020 21:32:06 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wiXtdHJBXw+=0so3ZV8mvG0xEykxUta2sUWPB=hUWHmtQ@mail.gmail.com>
 <20201216044918.jdmi32dz75uboybv@treble>
In-Reply-To: <20201216044918.jdmi32dz75uboybv@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Dec 2020 21:31:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGq=ZfYN1VOrFpX=2JzfPkB34HfxeXV0K8FJbMz-iY3Q@mail.gmail.com>
Message-ID: <CAHk-=wiGq=ZfYN1VOrFpX=2JzfPkB34HfxeXV0K8FJbMz-iY3Q@mail.gmail.com>
Subject: Re: New objtool warning..
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 8:49 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> But yeah, it _might_ be possible to make objtool a little smarter here.
> Gimme the .o file and I can take a look tomorrow.

Hmm. I tried to send it to you, but then I get a bounce with

  554 Email rejected due to security policies

because apparently your redhat address doesn't allow object files.

Annoying.

I'll try sending it as a tar-file instead ;)

            Linus
