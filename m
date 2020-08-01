Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060F12354A5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 01:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgHAXqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 19:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgHAXqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 19:46:10 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434F0C061756
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 16:46:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i80so18669982lfi.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 16:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZMOGkwyk+2uEnUplsOHluFyRACy5ZEHgGFqZFevp/I=;
        b=ELVOJ1KLBrj+PsJAkUsND/KaMhcdbWYA2ubAmUPGagezmMEKvCPdO+jw3XIidJp5LB
         nKykDgvzoEo2v/DoR5fNqAvq2ENIMiAm/XEqfdIOzM92UHS6R8y6Fx21LKGDobCVNT9t
         ofUTocgD7MIBWDf/AFebKW9iYUhjbcX3++8dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZMOGkwyk+2uEnUplsOHluFyRACy5ZEHgGFqZFevp/I=;
        b=sa0V82KERGPDDjohD+wJPQjN+OwY0gyN+TEJ1llihSqcEhSuKbxdZMbesqa4r5w63L
         K3p1j0d8FGLwh3XxWwfgDsq3vmrwx5hI4DVYd6XLpREhZqhrKkVeiThz70xApxUwmMma
         3QRYdYiYYwuvC/FcHMLDL6NApGlkUx66a0ixReWvqeMc9necC+tEGwIRDqBX163rhQsn
         ABzUQCOiL96v49mSfP4L/M8pn3NNUbBQG7ArIEb5/PkzVK9jIqxKUc2bJYhaTtNMVYCs
         tgwM/W04/GUpDptJXypDwos2z/gQwwxboU2/3K5iaY30WZ7uoNQ82JEbU5o/1D4AKxcp
         S7+Q==
X-Gm-Message-State: AOAM532z6kkySgQcBCL29FWoXlBQU4KIXhCsUq1dTGnD9pmdA9+jDcKr
        nMJN8yCROotdNfOqn5GRpnyWmoiNgV8=
X-Google-Smtp-Source: ABdhPJz41HnFrd3gFV6HiO4sJhNRIS9JypDXKLqst1/CU5/llAaHvDvd/oLXJ7roQ6k25a4cyDyX2A==
X-Received: by 2002:a19:7f94:: with SMTP id a142mr5078007lfd.43.1596325567985;
        Sat, 01 Aug 2020 16:46:07 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id i3sm2674891ljj.64.2020.08.01.16.46.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2020 16:46:05 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id g6so23410618ljn.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 16:46:05 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr313806lju.102.1596325565372;
 Sat, 01 Aug 2020 16:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200801.143631.1794965770015082550.davem@davemloft.net>
In-Reply-To: <20200801.143631.1794965770015082550.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Aug 2020 16:45:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiwBCM-a=k8bd4_umR2Od6gf7d8Do3ryGAaFneNRGFng@mail.gmail.com>
Message-ID: <CAHk-=whiwBCM-a=k8bd4_umR2Od6gf7d8Do3ryGAaFneNRGFng@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 1, 2020 at 2:36 PM David Miller <davem@davemloft.net> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git

How is this wrt an rc8 or a final?

I have another possible small reason to do an rc8 right now. And this
roughly doubles my current diff.

On a very much related note, I really wish you didn't send the
networking fixes the day before a release is scheduled.

If it's really quiet., send them on (say) Wed/Thu. And then on
Saturday, send a note saying "no, important stuff", hold on. Or say
"nothing new".

Because right now the "last-minute network pull request" has become a
pattern, and I have a very hard time judging whether I should delay a
release for it.

                 Linus
