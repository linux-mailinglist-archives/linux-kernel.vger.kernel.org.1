Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259D329775F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbgJWS4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465765AbgJWS4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:56:33 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFB9C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 11:56:33 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k3so1717610otp.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EoT3yWOrSBsazr0sI34MLouxI66P/1yaiC+BUbvBhVc=;
        b=EJJbzOU5YcXKkZkJyjL044nb3GvCvkwsMdiMk8c6ng9UPQusWKKAKoYX1hw1D3P0+0
         XVpiXrnDohOvhglPaqqPDAf79YnzuWImu40KRK7Gxr8SIVczB6bo/S3Tg2+ubugJAc04
         BIuaRzNEU/5rrO3ph+ep/ia/bOck5Hth07qBG5GVBDWX5cmBO2H9cD/pt+4ZYT2ygyY0
         1ash+G4niL3BBnn5ekGYwJKc8HunAjw3UsdpiNHcgfW7T/9f+P4DUB5yNEqtZt3Ik53t
         zAN2Hhf3YhU0S1HAGyXw/4pz+UCDUHz3wbf65y+SwiujWN7058OFstD+XJs4AOk6s7sv
         YFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EoT3yWOrSBsazr0sI34MLouxI66P/1yaiC+BUbvBhVc=;
        b=r5kTVPw9FVASseCrKBND0BK5PDj/CVqWIKhCP5htKXUdd7sEEY2Da1nPV4m0Fv0xPx
         QbizeUiGMoQ5Pt89nVcMtcUdOE8UnLi6D82EwvJT9DTgE+eUzualHj9VqZkNeQmgLWvt
         NCBAD5LGZ1VClTEv+LTHq0pV/N89HQWJuI+fjbnSoD3to5GJw2WkrXpItxWXIYE+67zd
         a+hzeS6RuapmQHjwBdP4uHJ6FQ9en5j1BdqwCOxdYkM/DLylrpjHiLLHrRxg/3ZZ6+Ym
         jG1W2aQe51Amovm3zn83Trcielj+SVQWYuAfO66Y/lZP3Pt3Jk6yFYbn66Kf8osE6jmH
         HUgw==
X-Gm-Message-State: AOAM532E2H4QgjcgBFz+fcBJdBfn91zDoqtp47Rv8t14KJVkzAPlQgJw
        HbuIjGmTJpH/lhP2CCzoKiD8xcw5+2u52HaMcFL4ZA==
X-Google-Smtp-Source: ABdhPJzFo5v/hylmtjASbZpKKqG6nIfUwnRCajjhbZC/oESvTnYj2dsxSOQTw28NTqX+RyCiwVUyxDujQaimXgp7b9U=
X-Received: by 2002:a9d:34d:: with SMTP id 71mr2539238otv.251.1603479392382;
 Fri, 23 Oct 2020 11:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201023150536.282568-1-98.arpi@gmail.com> <20201023184803.GA3922681@elver.google.com>
In-Reply-To: <20201023184803.GA3922681@elver.google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 23 Oct 2020 20:56:20 +0200
Message-ID: <CANpmjNNdh=FmbC5ML7=gDOcdUsfUdsg6hgXeva4emdFKGPyjog@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: Support for Parameterized Testing
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

On Fri, 23 Oct 2020 at 20:48, Marco Elver <elver@google.com> wrote:
[...]
> > + */
> > +static inline void *kunit_param_generator_helper(struct kunit *test,
>
> I don't think this needs to be inline, but see my other suggestion
> below, which might make this function obsolete.

Ah sorry, it's in a header so we might get complaints if it's not
inline. But in any case, if you use the KUNIT_ARRAY_PARAM() macro I
proposed, this function will become obsolete.

Thanks,
-- Marco
