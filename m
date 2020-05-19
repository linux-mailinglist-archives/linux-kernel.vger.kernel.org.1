Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E621D9CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 18:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgESQfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 12:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbgESQfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:35:10 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD02C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:35:10 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id k5so378277lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54tiBIP0EU7n2aZj7YIONdjaPqjtzHIpQK/HSrYUxTM=;
        b=BKlafAkH7UQm8tvxZZNMBXFgkeIFjR+sjrqKcA5zu8XfgLo2XsHzCIggLB+hau5PqY
         bXm4UtHx7/hgToK6wSRtXVRYfkosw2PzhwIv8qXaSb+oYyfc0spNrlQZmy04cFyxd8aX
         2/kuksBERD9XsYiDJcDnbRjB+/bFhGsJeMkcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54tiBIP0EU7n2aZj7YIONdjaPqjtzHIpQK/HSrYUxTM=;
        b=lAZziPI6nisHht5BPZEtTowyTCWS/fBFr6iSIx3on2Lmph69SI2v8tiuTp5j17740f
         aiF7Q/00el6ys2joJYdylIayygbPYdMLzrWqRj7cQ+PTPFSDVkbnZkYT8XPDJG4p8ZNt
         oe+aOQufCQ3pao6oH4uGuZpirzH2a8VsTptwQyGzO5If+NRkxjtSv+eglXJvRT4+ToZr
         RgcKNaAvrrdZi0NXUkBkxk+6PMyOczQ4HWI1bMPc6LjvU1nbjV3h5uopJ4nMBg3Oh7x/
         RhUw6EpPZVv+KqSZQ5PnN91lr+G7rXJ7FFeRHQNB86j8VKTZPrsqoUb67Bam4p6Npl/E
         wIyw==
X-Gm-Message-State: AOAM5302d028MLyUg/+mi7KIPlzrwT6lQmC08JSlXM9U2ySXqhCLYZLe
        AJZXEfJQL808po/gC1ECKJkdf4EffGA=
X-Google-Smtp-Source: ABdhPJwkI1tJuZWDjSPP751OftiR7F1nlNsk/6//Uaw8IamulF0jmCMryts8mp6IXYYTnTgR1cPDnQ==
X-Received: by 2002:a2e:d1a:: with SMTP id 26mr178170ljn.160.1589906107566;
        Tue, 19 May 2020 09:35:07 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id x10sm70347ljd.25.2020.05.19.09.35.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 09:35:06 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id h188so59941lfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:35:06 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr1549357lfn.10.1589906105818;
 Tue, 19 May 2020 09:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200519134449.1466624-1-hch@lst.de>
In-Reply-To: <20200519134449.1466624-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 09:34:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whj0zVP-ErHcqGNrM0-bZ+TvSFAwpEd+pKFadZeFXj5PA@mail.gmail.com>
Message-ID: <CAHk-=whj0zVP-ErHcqGNrM0-bZ+TvSFAwpEd+pKFadZeFXj5PA@mail.gmail.com>
Subject: Re: clean up and streamline probe_kernel_* and friends v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 6:44 AM Christoph Hellwig <hch@lst.de> wrote:
>
>  - rebased on 5.7-rc6 with the bpf trace format string changes

Other than the critique about illegible conditionals in the result
when doing that bpf/trace conversion, I like it.

                  Linus
