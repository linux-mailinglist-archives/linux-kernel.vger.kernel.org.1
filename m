Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE202A9E26
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 20:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgKFThj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 14:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgKFThj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:37:39 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EBBC0613D3
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 11:37:38 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id t143so2490279oif.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 11:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mP1FNfhSXY5n5cuTFQ/M/4yPG4XlmpEFYtLq6GDkKUE=;
        b=gNu7ut0U3clqE69rnhvzIiZ3OwEi3TwtXhAk+ORMHzmp+mUaN//pGv8x5n81jS/WTF
         X1xpRtZ3V4YUrpu+d9nEjd7tGDf2u+THCYyaAScnvt8xQv5fEqMTZpp6Reg1IaPKU55Q
         DEYqXfOdwV6Om8D0YqSAPniZro7lAkm3CZHvTBOxaI/r07dGtacIrkrEgo6HCC2suUys
         lKGsbKn9AZS9oKXN3my1JG+d4UBUwtR6AKHGfw2zsLhIvATpl261KCKxXeuGxoplafZe
         X/JeWyHmYkeDTbWba2gWJdGDABaBSI+pw6MHNDshMDjf2Mj5ez6674PBCXhdwjOtnBeZ
         DL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mP1FNfhSXY5n5cuTFQ/M/4yPG4XlmpEFYtLq6GDkKUE=;
        b=eivdhagbwvtZ0+4Z+WiU1OVi2KVf+EKxQcx4oTg0UDsRHqoBTLwV5/77Ol+AjaI5+f
         I5Rrc0xpNMWOIWzIY9JekCfcj7fpn9sB6wy9zcKuaLw5NF9EsDNPcsUY4hvaJ8jXc5DD
         GphBH7BYTuhCzDmoVS0VXFuA+ykdTgC7rXtBuax4zhw08SIE0499L8Qq+wYNRlIayI2P
         t/5Pa9ZyFFbRywE8OynCENXbAutIrmL/eA4E/B8pSsLeE8D2f4/i9gU4hZ/FoYlKx+Fu
         SR3AvEpY4U3BLQSOvxKD9C4bAD2+7uTKk1ENNVyK+HEwksuDYkjw5qmh5V+TbspB+Z5A
         /7DA==
X-Gm-Message-State: AOAM532iR29iRg8+RH8i/XVbBGC/XlcnsH4Z7d48Nay1v07FckuSFT0S
        g5sDFhS7l2/qhlXx42/MFp348vG5Yhna47qqqTBBxg==
X-Google-Smtp-Source: ABdhPJydJRE9oDMRNEsREh7ZPKeGFWX+yL0ZSvAAmgnD57EBdmSwWm2xusshWTHj2B1LZFSsf7tK4a9GHtNmM+nIYUQ=
X-Received: by 2002:a54:4812:: with SMTP id j18mr2150352oij.70.1604691458091;
 Fri, 06 Nov 2020 11:37:38 -0800 (PST)
MIME-Version: 1.0
References: <20201106192154.51514-1-98.arpi@gmail.com>
In-Reply-To: <20201106192154.51514-1-98.arpi@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 6 Nov 2020 20:37:26 +0100
Message-ID: <CANpmjNNj=ub1TLEOxtjajVsm0Fw9fJnFAZOhiYewiBzVFgFVew@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 at 20:22, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> Implementation of support for parameterized testing in KUnit.
> This approach requires the creation of a test case using the
> KUNIT_CASE_PARAM macro that accepts a generator function as input.
> This generator function should return the next parameter given the
> previous parameter in parameterized tests. It also provides
> a macro to generate common-case generators.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
[...]
>
>  include/kunit/test.h | 36 ++++++++++++++++++++++++++++++++++
>  lib/kunit/test.c     | 46 +++++++++++++++++++++++++++++++-------------
>  2 files changed, 69 insertions(+), 13 deletions(-)

Looks good, thank you!

Others: Please take another look.

Thanks,
-- Marco
