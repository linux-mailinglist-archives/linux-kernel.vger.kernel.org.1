Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9F4255107
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 00:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgH0W0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 18:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgH0W0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:26:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1567CC06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:26:14 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i13so3388013pjv.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oiRYPTV9Xp4hDmIJl3FIgZQBNMfOgdOX8kJLpd9LdbA=;
        b=K/syNsggEMRL31WNQmgeGoNMQ/ehQnSpbyNXTjVkpgc+66YGK2IfWbpNNhuuLcOjgU
         S+FSsY+M1DHqAVEzjeOJ18Gp+tWus2d9m98Y/uDDwORzyIO48JoP1+9BOG2S2x3cl0Bb
         ilXVhL9PIdDhs3FFbbAu3iwYjyIdlqBMEhhSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oiRYPTV9Xp4hDmIJl3FIgZQBNMfOgdOX8kJLpd9LdbA=;
        b=ixrLruMePZVzpHeck1JZRhx8OUeXFxRDAnPigS/9QG/RnyoGfetwrZthfUIbLeGv69
         GKaHVc8+JppaMfVU1oAOfp4E1dWHXQqtfAlMz0/Jun+G0ny5bdakd5Zg6SsbgLZIAVnl
         cSEgs5W08k1AXaPtIPJR3CjTD3+4ojxULKZP4qjt/OG/d0FQD0ewMEnTCWF7BjK/GxPP
         dP2Mtom3xswExEK9sifneLm8qOd1GQ95CQngaeGQhVu0Qy6ZJ1BxTGH5kLm+0zxuQeMD
         BWK0f3ZHKQfTUKKbiAnniPLhhO6jJwfKUivu2pafAgEqQ/jgCO8aZG9jniKEyGBX8NeX
         Mu4g==
X-Gm-Message-State: AOAM533ixq6hWw/+0csNgNTz7yRdHNjb1Nr/etqby6KA3J5zlkeUHGhL
        OD+GGeO38cciToaTACzbsG8ZKw==
X-Google-Smtp-Source: ABdhPJxONp4RrvitcYcVF82oYuZdrsKx6Ay/xu8opcvalfLsdDHC05RMM7SmB4tIPVDlVRRlXcMRHg==
X-Received: by 2002:a17:90a:6b07:: with SMTP id v7mr910704pjj.138.1598567173631;
        Thu, 27 Aug 2020 15:26:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y1sm3960582pfp.95.2020.08.27.15.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 15:26:12 -0700 (PDT)
Date:   Thu, 27 Aug 2020 15:26:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        stable <stable@vger.kernel.org>, Andy Lavr <andy.lavr@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] lib/string.c: implement stpcpy
Message-ID: <202008271523.88796F201F@keescook>
References: <20200825135838.2938771-1-ndesaulniers@google.com>
 <CAK7LNAQXo5-5W6hvNMEVPBPf3tRWaf-pQdSR-0OHyi4RCGhjsQ@mail.gmail.com>
 <d56bf7b93f7a28c4a90e4e16fd412e6934704346.camel@perches.com>
 <CAKwvOd=YrVtPsB7HYPO0N=K7QJm9KstayqqeYQERSaGtGy2Bjg@mail.gmail.com>
 <CAK7LNAQKwOo=Oas+7Du9+neSm=Ev6pxdPV7ges7eEEpW+jh8Ug@mail.gmail.com>
 <202008261627.7B2B02A@keescook>
 <CAHp75VfniSw3AFTyyDk2OoAChGx7S6wF7sZKpJXNHmk97BoRXA@mail.gmail.com>
 <202008271126.2C397BF6D@keescook>
 <CAHp75VeA6asim81CwxPD7LKc--DEvOWH9fwgQ9Bbb1Xf55OYKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeA6asim81CwxPD7LKc--DEvOWH9fwgQ9Bbb1Xf55OYKw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 11:05:42PM +0300, Andy Shevchenko wrote:
> In general it's better to have a robust API, but what may go wrong
> with the interface where we have no length of  the buffer passed, but
> we all know that it's PAGE_SIZE?
> So, what's wrong with doing something like
> strcpy(buf, "Yes, we know we won't overflow here\n");

(There's a whole thread[1] about this right now, actually.)

The problem isn't the uses where it's safe (obviously), it's about the
uses where it is NOT safe. (Or _looks_ safe but isn't.) In order to
eliminate bug classes, we need remove the APIs that are foot-guns. Even
if one developer never gets it wrong, others might.

[1] https://lore.kernel.org/lkml/c256eba42a564c01a8e470320475d46f@AcuMS.aculab.com/T/#mac95487d7ae427de03251b49b75dd4de40c2462d

-- 
Kees Cook
