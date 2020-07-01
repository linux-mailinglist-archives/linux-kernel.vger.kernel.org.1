Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEF52110C2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbgGAQeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 12:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732255AbgGAQeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:34:08 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB11C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 09:34:07 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q8so25689392iow.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 09:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MoybjELZfC8f+lXSCtoUVME2X9MJfIpV+bdz3fRbLPs=;
        b=UIQesNKyPGHb0LsgKEkEqKC04ivhJDSLff+nAYrcTcn1rxfacGjyvsw8a6MHdkh2OU
         dysTn5Deu/gEZ6sPLxswsTnoXY8MNBef2h7eQigzrb8i+UA/fScu+ZhchmeakIiuK9y5
         lWUtPL1yADHz4EeusxKEafPF/8hJSssq923JNp/E/Yybr3deh+6cYHVsW2lzeTghXLxX
         ZgGXH5e5fXYPugjAkgWJ89Ps8b7S5pw8vRtOtrJAGP85BydIP5Dfzu/BNSxI6BNFh6FS
         ooCn2W2QvCgGubrpoe1aQ4cWXJ8lpknkPZs0MDAdOLmDkjGjoTOM3guUedfZID0WQTLx
         JHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoybjELZfC8f+lXSCtoUVME2X9MJfIpV+bdz3fRbLPs=;
        b=Iz2NVSLZE6SFjgdj7dDklkcrvPS8pNKajM74XCQpvUvhzEUks/0u/GozrZCjzJZnKK
         1ukbVuVLI+O2W7nBoy5cIuy09lgzA6IEWNT7F6N7E600YIcjr/KrP8ZIYVkbYOfO2Rg6
         gEY0WykafABSxTzPW9ZZGEfaxq06ADJXXZ+Cc0QfAPu+/6UkThau5Mf3J8CDtsqiEUS0
         diU7NBtayIx8/tS6pAUc8tOsPuP2VIWQbwZxj8/xjLyMmPnTK8rNCxE69Dq6zE8avg0y
         ZtNOZDbBSa3uShaFIPnYuKcK9Wq795kgHSA0jKU80RegHgfXcBPKJ3vL03Rs+KCRoxw6
         SGuw==
X-Gm-Message-State: AOAM533mfje18ljVJqmEBUSvzH7bWe1RoHsurdwkLhDMs/dYiYEehcdX
        L71UlLnI7wDlsaewF+x4EJZl/QnW7St3rE6oow==
X-Google-Smtp-Source: ABdhPJyvkzjjp3Dg16h9W16pWaYpiojKXdtxSoSo0JgxzCryuV4rnIzZSZrN/Fkw4QQZ2XiCYSCYxFItVNiYZ1CA3jg=
X-Received: by 2002:a02:3501:: with SMTP id k1mr28948520jaa.133.1593621247338;
 Wed, 01 Jul 2020 09:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200701110650.16172-1-jgross@suse.com> <20200701110650.16172-2-jgross@suse.com>
In-Reply-To: <20200701110650.16172-2-jgross@suse.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 1 Jul 2020 12:33:56 -0400
Message-ID: <CAMzpN2iuwv=05vpxeP6eyVqEH9_093gDtDV3QAXYQ2QrucznBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] x86/xen: remove 32-bit Xen PV guest support
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 7:08 AM Juergen Gross <jgross@suse.com> wrote:
>
> Xen is requiring 64-bit machines today and since Xen 4.14 it can be
> built without 32-bit PV guest support. There is no need to carry the
> burden of 32-bit PV guest support in the kernel any longer, as new
> guests can be either HVM or PVH, or they can use a 64 bit kernel.
>
> Remove the 32-bit Xen PV support from the kernel.

If you send a v3, it would be better to split the move of the 64-bit
code into xen-asm.S into a separate patch.

--
Brian Gerst
