Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28831279C08
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 21:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIZTLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 15:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIZTLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 15:11:48 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2211C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 12:11:48 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id r8so5115128qtp.13
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=HXHwAmJqtzhy0GaltRSGEDCBQtRzzJDllTi8cJUt2Wo=;
        b=qvuhbvpu5AO68fMeveIuWfGTN+D0nmcZlJkX1mjHMmoXPPkHmZPS5g/D/RaJ3UJi1t
         9EyczrTwihu910bMwqhL94H4xZp9d//UhjyTRIFCMDEbx6vKWG2pg6CTW+r9DFOMfRFA
         JrI9tnamwDhUeSGwOIgIwmg2tK13YK2+lX8OcWcBLZVPDmgOX3HULpBK9ufXJQLNLWVA
         lOkHZuZvkIM7U5Z2RY3DKa6qZDfBtC+alVW5PlXgULgh+pSo5vkWeVupF9UPKtxmaGnh
         W7C+FP9o6fS4a8TGvzzgsI1siljTwM0CN5LokWDdHCVq597qzdlgE6zw1OMUfrEAlIzb
         qTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=HXHwAmJqtzhy0GaltRSGEDCBQtRzzJDllTi8cJUt2Wo=;
        b=bM20QeDmt337t03+RQuj8vQecx6OMLoYHmi9bMFWMnFirixGaXTU0QA6RqiC94zwMd
         G4amT8c6B5VvsnlMeMLYkaFAl0Lav0A4901F/G/+MdsImMKVF1HhAzrvsjDoS8Zqc04H
         1lcMwydvX1KrrNy7AjVHjVYuZneqmW7XxjgCEQ/5riReP3M6fKRAfIYHs31yI/uS3Nx9
         03EUKjNc+4OjzWkwDwTPrn0TtAATfnv5oVe11rcQ8+sQVq+oddxGBfWtZE8ZIauWlx7b
         tZUkSJOA6+rOmwNFCFVp0NygqubJcd62Zzlz6Oka8JCLtNBy0VeQo6OXPkg7N9kLXvqT
         JwVw==
X-Gm-Message-State: AOAM532cKpEKn0CkZRNVNDa+OLpTkRZPAT9o06N/towa8fMKf+HevAkN
        RdHBSsRRzGF0ZOUq0MgXt9VOjw==
X-Google-Smtp-Source: ABdhPJwR2g/ncpm2C/nXgazviM7lxAwgSV7qyq+RWN6LOPygiZjfv1mzPGO8S8L1GCjJk/lx6rhT2g==
X-Received: by 2002:ac8:6f3b:: with SMTP id i27mr5793438qtv.299.1601147507604;
        Sat, 26 Sep 2020 12:11:47 -0700 (PDT)
Received: from turing-police ([2601:5c0:c000:a8c1::359])
        by smtp.gmail.com with ESMTPSA id b13sm4477025qkl.46.2020.09.26.12.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 12:11:46 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Joe Perches <joe@perches.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cocci <cocci@systeme.lip6.fr>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@shadowen.org>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolons (was Re: [PATCH] checkpatch: Add test for comma use that should be semicolon)
In-Reply-To: <58673398c6b836ebd7509f787e6f0d10bfd751bc.camel@perches.com>
References: <87r1qqvo2d.fsf@nanos.tec.linutronix.de> <a53048f738dacc1c58654eb94e229de79d4f94c2.camel@perches.com> <alpine.DEB.2.22.394.2009251904540.2772@hadrien>
 <58673398c6b836ebd7509f787e6f0d10bfd751bc.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1601147504_3912P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 26 Sep 2020 15:11:44 -0400
Message-ID: <173999.1601147504@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1601147504_3912P
Content-Type: text/plain; charset=us-ascii

On Fri, 25 Sep 2020 10:26:27 -0700, Joe Perches said:
> And the generic individual maintainer apply rate for
> each specific patch is always less than 50%.
>
> For instance the patches that converted the comma uses
> in if/do/while statements to use braces and semicolons
> from a month ago:

> 29 patches, 13 applied.

To be fair, it's *always* been hard to get pure style patches applied, because
they usually hit one of two types of code, with different results:

Some of them hit code that's been stable for a long time - and those patches
don't get applied because of the (admittedly small) risk that a "style" patch
may actually break something - yes, that *does* happen often enough to worry a
risk-adverse subtree maintainer.

Some of them hit code that's actively being worked on - and those patches don't
get applied because they can cause merge conflicts.

This is a hard problem to fix, because it's difficult to say that either of
those viewpoints is *totally* wrong. At best, you can make the case that some
maintainers are a tad over-zealous on their attitude. And since its *hard* to
find good maintainers, it's not possible to fix the problem by just putting
somebody else in charge of a subtree. It's theoretically possible to bypass a
problematic maintainer by sending the patch to the person one level up, or
directly to Linus - but although that usually works if you have an urgent patch
and the maintainer is on vacation or stubborn or whatever, that's got
essentially zero chance of succeeding for a mere style patch.

Unfortunately, although I understand the problem, I don't have a solution. It's
easy to tactfully say "this code is wrong, and here is the fix".  It's a lot
harder to find a tactful way to say "This person is wrong and should do it this
way", because code doesn't fight back when you offer constructive criticism....



--==_Exmh_1601147504_3912P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBX2+ScAdmEQWDXROgAQI8Ag//YKel+oxk8JlWyUFEbQz41v44EhWHlykN
LLlOnRINghANJbunFpoUgD+KW9I9mPy8MmbdF+SeQq8fT+g5qfIwsYNsTeJI/Bu8
K3ksbdy6qcuqO5ZmfqS9d1VYykaAXbIi1OqTa6gkX60EU+c1zLuCo78gFyO0c27T
193bWbUG7iCkEXN3261e+a8p1XvQOUtRULuedBbyUQ9GmIEv8oLOMErq4YSBVx5t
k/FKSrRfu5ZesBbxOOzGpPQXMpq64vwatpcZlNs6fKZjnzgmCYtnSzMCZ13bhkGE
zPQQs1Ak0c1GmBVTlZVYHUNNLG4SKdHchF9yKZ5gooqLu1eWEg6O5WxeMWAjIQ1d
qbxKveWY0E8xj0PM//BgyZraCRrAT8KGcpXjFEWtsw07dKD3hnpdXg2PlrX972v2
BPk+M7pGEe/qZJPdGiptefli6zxtuv+hQI9sVif99+FRQ3RlKx4/xte1O7iKn3/N
wzXNZ7pFG0UPGIkM5pEzUWv1VmBXoZqDT9qqanHNZDkRjYuv0IouI0QWaZ5v363E
SOK0YBnHPUHA+bMOek59eof91yAwzgCqUrmAlZ3T/AKKHY1jUIujKbr/zVhAfa9b
x0mn/NSmOmLc86BSgNKrAhxkbfoOzPnwnMVx1AHMhzZ43mlsaNyDz09SomWDWkzX
GcnpFZnyRSo=
=Cdbo
-----END PGP SIGNATURE-----

--==_Exmh_1601147504_3912P--
