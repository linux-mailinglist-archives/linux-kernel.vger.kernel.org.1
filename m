Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8FE26F568
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 07:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgIRFfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 01:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgIRFfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 01:35:53 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A9DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 22:35:53 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y2so4739118lfy.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 22:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/bymMNxBgwleuFgLBFDrHQ+0acGZRuWjBwHuK7Z5b7Q=;
        b=uis/nomwrJdp6Sa3rXd3GZFRmneIHnmJ144MWqR6M1NezM3Q22H4qVfh9e6PEDvXNc
         v4QtqL5P9k2sujBt8HI6CISrawwHSoVtHQsSY4wTtOeV4lOukjdz4VOWrbtcuPpRFGSn
         sbdzBVsdKSWdprInrcUC7XM/R4aQ+BKeScm9ksph98RowCGbuyoVbhwIxeNbmx4Os7Lq
         qLse+H8sTuMqah6qgQ/imrwSHw/+g8BQ7EzeRlpNXILmAI8dArllygPDR0YLMvkCxViR
         WzpmKQo7Tieo6027ExjxX/lg/HNfwrcePr5qrzcQXLDZqFbJ+NJbQL8iJpEsg4CvqoO4
         w4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bymMNxBgwleuFgLBFDrHQ+0acGZRuWjBwHuK7Z5b7Q=;
        b=byM9fRDrV4vAHYl/8bpvmDirCdjUlhLlv1diCAkjSQ696xoBIUPjwqxXlCB8w1FnGI
         Q31x10TfYEEq+XmTdU4pxKj5qgJ49QQ5n1S7Ipdj3pTH1M6StIWw/s4AihPEL0qLGMCW
         yhZ4viEXSRA9KsL0m5ziEmXri9TMOWkxr/mYuMz5m+1XHjRh5YE6inkwraFmZDDL35tD
         T6iIJknwu7gBKDswAchZbEK2Ygd8apZPdxM67jmYfHM+qJkaJ8YgyvtTR8p8c53UafbF
         6mwZsj25UyFvkwUfWUvz6TcOHf6GQoK+pEbi1SpaaytKh+ZFbcFop90CwR+LgiAWlvxu
         OY1w==
X-Gm-Message-State: AOAM530DaxRp0Ou+a7kXWGnxkr+uzMtKiPqvZ/O7BYDaNqBmQH0CECS7
        QUDEtXPDKcNf9JLee4IFWZHZVYn8RpXzN8cUV/s=
X-Google-Smtp-Source: ABdhPJxUO5Mjm4nU4kjMJrck2nnWgufZgylAmB3qB/RUTziWwMuPPnsFPDdlJV6tTXsU8exjX5Nrv3AZPtk4XJ/shOE=
X-Received: by 2002:ac2:5193:: with SMTP id u19mr11584170lfi.518.1600407351407;
 Thu, 17 Sep 2020 22:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200917084905.1647262-1-ilie.halip@gmail.com> <20200917221620.n4vavakienaqvqvi@treble>
In-Reply-To: <20200917221620.n4vavakienaqvqvi@treble>
From:   Ilie Halip <ilie.halip@gmail.com>
Date:   Fri, 18 Sep 2020 08:35:40 +0300
Message-ID: <CAHFW8PTFsmc7ykbrbdOYM6s-y1fpiV=7ee49BXaHjOkCMhBzhQ@mail.gmail.com>
Subject: Re: [PATCH] objtool: ignore unreachable trap after call to noreturn functions
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Marco Elver <elver@google.com>,
        Philip Li <philip.li@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch looks good to me.  Which versions of Clang do the trap after
> noreturn call?  It would be good to have that in the commit message.

I omitted this because it happens with all versions of clang that are
supported for building the kernel. clang-9 is the oldest version that
could build the mainline x86_64 kernel right now, and it has the same
behavior.

Should I send a v2 with this info?

I.H.
