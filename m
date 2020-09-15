Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8416926AB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 19:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgIOR5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 13:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgIORlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:41:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D10C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:41:35 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so2344682pfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z1YjZCsp4omtvOs8Zgwj8r9+riXW9+60BrD6+tQYvl0=;
        b=VxVrm1ZlNEgDHjFoTQjcb8wBZsTP2AMGTFBYiEonhdpBs+qdY8flCLSmhVkSnJFeS6
         zFuF6BA7OajVnTBCJOH970BXWyojQ1Bjwe3LHXsqht0DmZu+y7oHdDBQgRYHjWlsCHfy
         PqD0MeO09BRgPRMpDclA1eglK/Jn7wk7hljJ3QTTsKz0NWkG4WqIY81FqexKKLHu5Vp7
         Hs8Phtdy9AqirSa2aCg4xlNf3o50BeBILWLvDwf7grvxFXc3wS0tzbqbW0Zn0SJOjKZ3
         6cBroJHjb6LL4CSirdFKNdhOdXWkI6c4pmPwEo5hmDnFBTQ2nvJKoPuVYicOAN4RaRoE
         Pt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z1YjZCsp4omtvOs8Zgwj8r9+riXW9+60BrD6+tQYvl0=;
        b=PPiCEaldzD1SDsxOTxCD3UyiB5p8jrJ0tFLuRIj7pTrcZVdZ3jGzFj8KEi5NzCI1yW
         eRhxu1choHRc9k1nqIIz75R1P+GUFsCVn7hAV+vzp5BC0+N+68cKvFJb6nSnOvqNIgJo
         sWmu53QguxCqz3RDyJQ29QJTLCUTNeUAdZUgtJrNe7fvFAqbdWyCwdTo4MDSW1yZA9ZY
         KLO4A/wB3x+66tDOt7T08EpxaOwqZ9n6NI4Mn1NXn+sUuCZo+oSPZfQk3CWDtW+fvmC2
         YJHwWi9eBlbxyfe0TiV8x0jbDfcqiUIREddoD7yHmnmQQVIJaFPZni2v/bqDpaoIRoYc
         NAuA==
X-Gm-Message-State: AOAM532c4XaAUIjLZfMirC8rSTwJM/nOM7cEL7i8RXwjt2M0TWKyB0R2
        jwZKOjwgMzArkJvRFQ0BUfwuWO1syd8KGh0fX5MMCQ==
X-Google-Smtp-Source: ABdhPJwmjnDgUJ3GpsyMpMDlACF72yh7O7IgOZKzCY9p6Q1/S7zc8eA7UoTICBeeVlm7z50c7YH95LJJT/37eCHtlEM=
X-Received: by 2002:a62:1c4a:0:b029:13e:d13d:a136 with SMTP id
 c71-20020a621c4a0000b029013ed13da136mr19038520pfc.30.1600191694743; Tue, 15
 Sep 2020 10:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com> <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian> <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble> <20200915172152.GR14436@zn.tnic> <20200915173430.GS14436@zn.tnic>
In-Reply-To: <20200915173430.GS14436@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 10:41:24 -0700
Message-ID: <CAKwvOdnqJJ8Ot6sRvVUTyuwA_zhRQXOnMU9KS6aVcTqRGb3JmA@mail.gmail.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING e6eb15c9ba3165698488ae5c34920eea20eaa38e
To:     Borislav Petkov <bp@alien8.de>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        "Li, Philip" <philip.li@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:34 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 15, 2020 at 07:21:52PM +0200, Borislav Petkov wrote:
> > I'm thinking clang12 is too unstable to take it seriously...
>
> Yeah, I'm being told v12 is not even close to getting released. So why
> are you 0day guys testing with it and reporting issues? Are you testing
> unreleased compilers and reporting bugs against the kernel?
>
> What's up?!

We want them finding bugs in unreleased versions of the compiler,
before those bugs in ship in release.  This is a good thing.

-- 
Thanks,
~Nick Desaulniers
