Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B142B7193
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgKQW2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgKQW2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:28:54 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6BEC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:28:54 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id u2so11062982pls.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+l6bPNdAyGzxXdbN4WyqDuDuPAZPzRdy+08/xBki4g=;
        b=oxyyGnn2pbqzNcAh7Ro5v/5q+r5L0/p8tgKM5bY5Amc103WXnHI72zTmNIl9EKzGUP
         hx+MTwWTcvuW+rL3rnEp3nVYrbexUS+150D5tGwQ7D80hcO9gUlWErWSaBGVadR7zLv7
         WEN+YlkXUTrpAr8XzzyDVMXB68lyehw2wG25TORvlwowlCEIbqmEalhfueDvU6V4t8xQ
         3F0PhD/cM5Y2wpMOOwp68iwtNEfMy7WD8y3fh9XUK9zFP1R82KM7z8aRDE/zDmieqzLF
         2CR9WVPP7zoYKtH/jT86zIJKogoA6Y755rDX953a0ITuhls5qVkiVB7fPVgjYXcvmrn+
         k2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+l6bPNdAyGzxXdbN4WyqDuDuPAZPzRdy+08/xBki4g=;
        b=jRV0O/Pv4f7W6Jlcu0xtYfibttroQLB0mwgbnktnhT0o2Rce5CJu4nXim/+/HpvAkM
         ZaCDIB+YqQex7wq6oyyM8VekxAlHzyUdn6+GqHT8ULPTXBE6bDkDMk7ym//scPw1BCtY
         +E4zxIhOf1yMB994y/Qe3tTva6/IcII3n2lPji+u0cUxEzDybycpCoCSnPBRNQNTojWk
         XsbSvribyimbLnq/t+couf72a6NVymKr67dGer7MTI0X4YUYQsV/qwJSQ6ALh2TdGxrB
         H1OVWwqrxuyQtn2kklYaWjRznlxP+8Gvf3xAMGkmSgLYB9tyzLkwNz0hMivzy+QWFDH0
         j2wQ==
X-Gm-Message-State: AOAM531WUIbpWuBetVnyCn9Ym2T23Sawd/uKIbC3cg2Ue5NG0CCqwMQd
        6C1fD8IeHpEykt7liuXHKbxSfanirTUQ8jsyaUh/2Q==
X-Google-Smtp-Source: ABdhPJxWXioFAPozNpXYIDJ3H6sf8MNf9Tby1TCVJwkV7fzb9RpugKiB0p81VLrblJcCJB4KyhP3+HCdilQdR+vYEIM=
X-Received: by 2002:a17:902:e901:b029:d8:e727:2595 with SMTP id
 k1-20020a170902e901b02900d8e7272595mr1537952pld.56.1605652134074; Tue, 17 Nov
 2020 14:28:54 -0800 (PST)
MIME-Version: 1.0
References: <20201116043532.4032932-1-ndesaulniers@google.com>
 <20201116043532.4032932-3-ndesaulniers@google.com> <20201117030214.GB1340689@ubuntu-m3-large-x86>
 <CAKwvOdk_sphJGQarEWJLzGZWkdzO9dqmcRmys3Retw3vn2Fwag@mail.gmail.com> <20201117221629.GA4679@embeddedor>
In-Reply-To: <20201117221629.GA4679@embeddedor>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Nov 2020 14:28:43 -0800
Message-ID: <CAKwvOdmNW3iynqi_+2c1P-6Prq1a8iVufoaZh2NAbsaBLeZZ4Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] Revert "lib: Revert use of fallthrough pseudo-keyword
 in lib/"
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 2:16 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> I'm happy to take this series in my tree.  I'm planing to send a
> pull-request for -rc5 with more related changes. So, I can include
> this in the same PR.
>
> In the meantime I'll add this to my testing tree, so it can be
> build-tested by the 0-day folks. :)

SGTM, and thank you.  I'm sure you saw the existing warning about
indentation.  Do we want to modify the revert patch, or put another
patch on top?

-- 
Thanks,
~Nick Desaulniers
