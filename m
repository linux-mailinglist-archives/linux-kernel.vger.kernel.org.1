Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E242A5C05
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 02:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgKDBhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 20:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgKDBhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 20:37:06 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A61AC061A4D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 17:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7GsqZwUgVQA/3Vyt9cB1qKmbwdd4Y/il+cY0XAsw4fY=; b=BFHBR1z3EHEixqfVv88X3Unfe1
        3XKEAU6h8UmrSL0WGvqhoeU1bDDDCbg4R2s1M1KhIOSc+cX8q0jE6+uKe0ethBX1IiYNuk+29SvAp
        tBJOSwP6+37J3766+KcRySpjLUigXkC5rvhLm/iKL4fONSJh1oRLckDnPgEnUvLN2111GXzzvM3oz
        Dfa0eDZWwYVHKsk/hG3Q7F2WamZHVgsn8t2zDpxhpfykRsC5q9BMlKUN7SiqpzOiu3VVeNGdeoPZN
        JO5ym2i3akJ+EIGwJ54/yoay6Su3K20CHDc0xhABWvQPr/t2+ym+oJIgnZzZ0Z2bm0ZEKNDOBBcbE
        XCiN/F5Q==;
Received: from 83-245-197-237.elisa-laajakaista.fi ([83.245.197.237] helo=kapsi.fi)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jarkko.sakkinen@iki.fi>)
        id 1ka7jN-0006rV-JA; Wed, 04 Nov 2020 03:36:57 +0200
Date:   Wed, 4 Nov 2020 03:36:56 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] compiler-clang: add build check for clang 10.0.1
Message-ID: <20201104013656.GB21728@kapsi.fi>
References: <20200902225911.209899-1-ndesaulniers@google.com>
 <20200902225911.209899-2-ndesaulniers@google.com>
 <20201103045521.GA58906@kernel.org>
 <CAKwvOdk-bMx3Jt6=oN=PHqRv_tx5cF=9cVmumazb4vMNHdj5Ag@mail.gmail.com>
 <20201104003826.GB19460@kernel.org>
 <CAKwvOdnZSLP_YF3iFDLTHFE=ORxsrCR06s-B2Hk7khSxdC0+5A@mail.gmail.com>
 <20201104013447.GA21728@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104013447.GA21728@kapsi.fi>
X-SA-Exim-Connect-IP: 83.245.197.237
X-SA-Exim-Mail-From: jarkko.sakkinen@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 03:34:49AM +0200, Jarkko Sakkinen wrote:
> Shouldn't "#ifndef" be before the whole version check? Otherwise,
> LGTM. Please CC me once there is a properly formed patch to try out.

(to my kernel org address).

/Jarkko
