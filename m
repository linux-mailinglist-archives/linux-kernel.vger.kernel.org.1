Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2D28DBAE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgJNIel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbgJNIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:34:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982D0C051118
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 00:17:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h7so2470609wre.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 00:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zWbmKsf7IfupN9FPaXSI1lJLjmRLF2ZdDZQcOkrBeJ4=;
        b=XjBsGCRCGL7NkLsW0d6QaMBRXBLLsyTMsWFj2+AaNNpryijP4NwC2NHqgGIWW8tan2
         ENlDexL4OAC491RhF7sljUSuuOWnHZHX9kbiYgsI74OIXGccrmbYu0+5kNkhwqyOKGfg
         PY9+e7SyTwr7l/s9VwE5Sx3P2RlQUTl7RxIi2vsnR3f5am0GBENuNv1I7k08us05EbXl
         cXHiqodFJmNiBgdvZg85oiHYOcJFjwKJh0F0p1PA1IaEjgbJo70B3PMqu7fUULmeFplH
         Z7/IQjSZOrkOihEFvGeBjazQVBRCJharKkLqwY1OkvN60WZtnHN1e62vC2X8I30cqEhJ
         km0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zWbmKsf7IfupN9FPaXSI1lJLjmRLF2ZdDZQcOkrBeJ4=;
        b=bqgwP+tAU+9mAsQhCeHzN8RvCLbvzEy/VYtjzMG8vEpGBHbACOFWvwgfbcojJg+GB8
         emjHKUpIpVAw1+TS+jVdq7Cz+bFfZxtUASOtqzI/RCD67pOesJ7hoOEXB6KXluCRGvgc
         obeD5xBMGU2lZ76Cy5BYUgdz8JBtrzWEE8bGtR4gbRe57xcGRl7GT4RxYuWNCd8989d7
         n25JENFzk3BvbKxd1KU9+9/p0JikTYUxBBUDeYTS9/Mlgax8ybomVbfOlr/TIYHVtwaJ
         HoC3itJgkZNh5SuQBMOA7Z5SCx/xCZePlDRtfa90j0z4pbDrNEdeHmNQpTyrXs6/f0Co
         Ccvg==
X-Gm-Message-State: AOAM533rbdR3bD3ldnkIECZZuPPNrFsDUeYEf8VL7qGX4Y/Ta2zgtOoY
        MgIWMe1+9x+ZNvxL3lpQVWY=
X-Google-Smtp-Source: ABdhPJz1bPXTbhaAmSmG7cwvswYL3JoerujxB5UdsEHiq9Ylw4lTfQybWIKjHn+zZiVOnqjCqFEjtw==
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr3663436wro.22.1602659822214;
        Wed, 14 Oct 2020 00:17:02 -0700 (PDT)
Received: from felia ([2001:16b8:2da8:8200:4c70:9c82:f3bf:bebb])
        by smtp.gmail.com with ESMTPSA id c185sm2328304wma.44.2020.10.14.00.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 00:17:01 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 14 Oct 2020 09:17:00 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ujjwal Kumar <ujjwalkumar0501@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC PATCH v2] checkpatch: add shebang check to
 EXECUTE_PERMISSIONS
In-Reply-To: <084a2dabe5463a3528bb052515555f939235c012.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2010140908240.6186@felia>
References: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com> <alpine.DEB.2.21.2010140734270.6186@felia> <316d5a53351d10cd1a26ce0c54883da05642c898.camel@perches.com> <alpine.DEB.2.21.2010140812370.6186@felia> <be7deeec0937327e0ddaadf8468d934ed363a533.camel@perches.com>
 <alpine.DEB.2.21.2010140829150.6186@felia> <04325089b524f20d3de167051bfb81b05083d8b1.camel@perches.com> <alpine.DEB.2.21.2010140842310.6186@felia> <084a2dabe5463a3528bb052515555f939235c012.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Oct 2020, Joe Perches wrote:

> On Wed, 2020-10-14 at 08:47 +0200, Lukas Bulwahn wrote:
> > 
> > On Tue, 13 Oct 2020, Joe Perches wrote:
> > 
> > > On Wed, 2020-10-14 at 08:36 +0200, Lukas Bulwahn wrote:
> > > > On Tue, 13 Oct 2020, Joe Perches wrote:
> > > > 
> > > > > On Wed, 2020-10-14 at 08:21 +0200, Lukas Bulwahn wrote:
> > > > > > What does checkpatch.pl warn about and what does clang-format still warn 
> > > > > > about, which is generally accepted okay as style in the kernel?
> > > > > 
> > > > > clang-format doesn't warn at all, it just reformats.
> > > > > 
> > > > You can run clang-format with --dry-run and then it would just state the 
> > > > proposed changes, right?
> > > 
> > > clang-format through at least version 10 does not have
> > > a --dry-run option.
> > > 
> > > 
> > 
> > Just a quick check:
> > 
> > version 9 does not have the --dry-run option:
> > 
> > https://releases.llvm.org/9.0.0/tools/clang/docs/ClangFormat.html
> > 
> > version 10 does:
> > 
> > https://releases.llvm.org/10.0.0/tools/clang/docs/ClangFormat.html
> 
> Perhaps some version 10 variants do, but 10.0.0 does not.
> 
> $ which clang-format
> /usr/local/bin/clang-format
> $ clang-format --version
> clang-format version 10.0.0 (git://github.com/llvm/llvm-project.git 305b961f64b75e73110e309341535f6d5a48ed72)
> $ clang-format --dry-run
> clang-format: Unknown command line argument '--dry-run'.  Try: 'clang-format --help'
> clang-format: Did you mean '  --debug'?
>

Hmm... either the documentation is wrong; or the clang-format version 
10.0.0 you are was an early version 10 during development before the 
release and did not have that feature yet? 

$ clang-format-10 --version
Ubuntu clang-format version 
10.0.1-++20200928083909+ef32c611aa2-1~exp1~20200928185400.194

$ clang-format-10 --help | grep 'dry-run'
  --dry-run                  - If set, do not actually make the formatting 
changes
  --ferror-limit=<uint>      - Set the maximum number of clang-format
    errors to emit before stopping (0 = no limit). Used only with --dry-run or -n
  -n                         - Alias for --dry-run


You have probably seen that clang/llvm-11 was released; I guess a good 
motivation for us to update our clang setup? :)

Lukas
