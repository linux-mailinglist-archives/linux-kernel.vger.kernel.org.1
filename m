Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2BE2851FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgJFTBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgJFTBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:01:32 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AF0C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 12:01:32 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n61so13298292ota.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YSymH4vd/R57ZcKC0GdaMdmbsJkR/uPBbSzo5j6VwGI=;
        b=WYCtXI6u/py4vSrocw3RaLLovCI1JxT5ISmnl3Cx2aVM2XY/kv/f/+IV2MEz3qejW5
         CstYX+nDT2/lYjGF+onBkWGgL1k6jRJjbXI9H/t9kHWAgJ4DREu1VWnA6y98qyulp4Bc
         5lh6t4bbo7XH9xKRzR/Zype2yl63f+eaLxFnME3uk7+llKI7qurGMhBkoMYADAe0dVxw
         +QTYra5wUEtSupM3LdA5JkStECMvPIH4cGJatO3we+aNOGspa/mu9k+v5kA7zEHJ1Nbw
         6Olm66WRO5BGRZ2MgDfvfk8QexwDVH3li5Wg4sMQA/YCkngCl8j3NA60NN6UFy+U9RJS
         1Irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSymH4vd/R57ZcKC0GdaMdmbsJkR/uPBbSzo5j6VwGI=;
        b=ZZCiv/FaBOn50lgZWVUorxpi1weEe9//5xgugbqNfPGXzlqn+z0/sJSmmj8LKSrDoY
         smLi06vT5uXFcrrtriCc6CEML+vdB16sjv9IMSwjJC+511EtWFqRYDXEYcQRiF6Xk/c0
         Pjw7gsnwqTLQbUflmU9hoBf/OQdqicL9uC1ihPSgehQFsy9yoyQWt9JPI35oiMDk4ZmU
         mtr3nzEwQYyhXOwWY0FDGpls7aznrEKeCWXW4tWCTsZJhYmFNV7e/O/5OkHJklF/wz9n
         G6IjYCrKe4NjhDrmOvjc4zHblcVQ2CUUXPLxZ5NsXnxaVae5D766wJG/qKw36sHgR0vF
         /1YQ==
X-Gm-Message-State: AOAM533VrULTUeG5CBLBs0Oyixmt6sIlEgE/l1lhxeFE712nKDT0omCc
        oIy6OzG229spVF4qSr+Q1FVHAMJNPcObSmSG2kk=
X-Google-Smtp-Source: ABdhPJz9lz/9PlcW/fDp6CK8frwTEfGJVwHqpkf+vqobGR9FlivLWUs9JnrTHt/RdlwgWZLE8PY/RWYaA28brxuUdl4=
X-Received: by 2002:a9d:4b18:: with SMTP id q24mr3709804otf.265.1602010891747;
 Tue, 06 Oct 2020 12:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201006185114.168358-1-dwaipayanray1@gmail.com> <8553d6679f97ae9d285a9ffd61198f5e3c11dc35.camel@perches.com>
In-Reply-To: <8553d6679f97ae9d285a9ffd61198f5e3c11dc35.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Wed, 7 Oct 2020 00:31:08 +0530
Message-ID: <CABJPP5Awe=CDC7riYBBVDf9WRO4aAMXK2QROYdtGyJXNjqB-ew@mail.gmail.com>
Subject: Re: [PATCH v4] checkpatch: add new warnings to author signoff checks.
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 12:25 AM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-10-07 at 00:21 +0530, Dwaipayan Ray wrote:
> > The author signed-off-by checks are currently very vague.
> > Cases like same name or same address are not handled separately.
> >
> > For example, running checkpatch on commit be6577af0cef
> > ("parisc: Add atomic64_set_release() define to avoid CPU soft lockups"),
> > gives:
>
> Aren't you still missing emitting an message for cases like
>
> From: "J. Random Developer" <jrd@bigcorp.com>
> [...]
> Signed-off-by: "J. Random Developer" (BigCorp) <jrd@bigcorp.com>
>
> Where a comment does not match?
>
>

Yes, messages for comments were not emitted previously too
cause the same_email_address() function just matches name
and email (discarding name comments and email comments).

So should I add it to this patch, or should I work on it in a different
patch perhaps because it involves change on another subroutine?

Thanks,
Dwaipayan.
