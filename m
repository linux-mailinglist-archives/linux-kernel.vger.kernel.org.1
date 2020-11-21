Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C1D2BC167
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 19:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgKUSXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 13:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgKUSXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:23:35 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50F9C061A4B
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 10:23:33 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id s30so18138565lfc.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 10:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7cZfFDWETupzrz1W/PA0N75+saduUeI+gk15nXI7Q0=;
        b=dH00Lj87XUWDjVhZTS31u5fK+b2ZiXmaVewWBK/V48aWDdpvmlY8lYEZ3TsPZy+JuP
         Piggiet9UE2qE2SNHmspoYRK7bxHTomINqVwsLJcANApC/MOgACoEjU5ZxHckGmnDp1N
         lQ0V7X3C4QU5N8npwm/3beAXsfs54Clu8S4xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7cZfFDWETupzrz1W/PA0N75+saduUeI+gk15nXI7Q0=;
        b=UQqDOEUZEKRNyHifN/I7W+OilMZOLPwdRAcbpTWwlF3eCDyWHuRhwnlf4I/0d6fMO5
         Vc1V89svSobhee85Ra/chK0I5oHdEyp4mz0npmZKlZ9Bj9utrLTJuX29MRKxu0ZenGtP
         UuPFElYxilSqjOdXLQn+a6Xz5bTlYHi5FkcA+gxSyTQhwyvxSTvbPvYH5uRBdzOh5TJX
         fdTH0kwr/d/Ls4UBaCCI57MRrM8MoHp+MpJVYcX13m8fkd6l4YBf+RAYczNg+unLqY0i
         /KPzylvOXAfW5XbcI3n5DkGzhFoPu3acjefQIxoWQLiq4GBsF3DobWfgUeOLb5AkhzEL
         UG+g==
X-Gm-Message-State: AOAM5303pdiJYBQCC04dmdIG/A5iAJ+3UVvrnmMTk/GTPFmkl4ynqxmW
        TvGgmWDIGbJxrBs7baELeW2rXt3EbA2LZQ==
X-Google-Smtp-Source: ABdhPJweQkJlFUUlqu3hY7mzh7E2qkWdSF3IG8+uzlZNLwDOq3KD413d6r4Om2cfGtrnsrzBVi52Pw==
X-Received: by 2002:a05:6512:2033:: with SMTP id s19mr11042366lfs.462.1605983011722;
        Sat, 21 Nov 2020 10:23:31 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id g22sm685654ljl.78.2020.11.21.10.23.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 10:23:30 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id a9so18133177lfh.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 10:23:29 -0800 (PST)
X-Received: by 2002:a19:ae06:: with SMTP id f6mr11146486lfc.133.1605983009454;
 Sat, 21 Nov 2020 10:23:29 -0800 (PST)
MIME-Version: 1.0
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Nov 2020 10:23:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj3p3eScaULtpCtWwS9NGFxT7dVTTC3mg1VyAyO2L5j7w@mail.gmail.com>
Message-ID: <CAHk-=wj3p3eScaULtpCtWwS9NGFxT7dVTTC3mg1VyAyO2L5j7w@mail.gmail.com>
Subject: Re: [PATCH 00/29] RFC: iov_iter: Switch to using an ops table
To:     David Howells <dhowells@redhat.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 21, 2020 at 6:13 AM David Howells <dhowells@redhat.com> wrote:
>
> Can someone recommend a good way to benchmark this properly?  The problem
> is that the difference this makes relative to the amount of time taken to
> actually do I/O is tiny.

Maybe try /dev/zero -> /dev/null to try a load where the IO itself is
cheap. Or vmsplice to /dev/null?

         Linus
