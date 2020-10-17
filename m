Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C75291343
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 18:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438521AbgJQQuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 12:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438056AbgJQQuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 12:50:24 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2063AC061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 09:50:24 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m11so5807529otk.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypO4D+lCWHgDUozLpM6wT/YiqQy0Ek26O6Lt6jvs4bM=;
        b=Wy2kowaOKHqRe1fM39TY92/SC/bIqm6XUoAijQ4N4HpxQop/hwXkeXftYa85hYOs06
         bjHUC52DEjroU/sRiCnO5IfmKS73WCWommHfiX2lZAOTpWqn63najeVp/9EHjdvPhLTU
         tt0TP4USQi0j6zU+jFf/RKC6Anr7qRynHAPYZJzz72o5B4TiLKQkkxAh2EEXdjNxUmG6
         gUepFqpUjOENGHsr2tMnqCexPPBHKEy3MmakeYXn7dipzt99u3uJdhYhgj51ip6fenBz
         HI4dxN5GIt7GmKUP2is8imiQTsXI48W6gS58WFHr6EddcXeGp3HvC2SUcMm9l0m6qsUy
         5YtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypO4D+lCWHgDUozLpM6wT/YiqQy0Ek26O6Lt6jvs4bM=;
        b=ClRvU/1nvMq9fKMICLl6UpEmdK8hGsSXxxd4fY/rd7mHD4qwhA3IE/k23pEi+bQvEV
         +qcvUEcgZiMzrsp+liiKVa1LOJkvNMrwWoJ18VDl2gWHO6i/LlVvLph9LmoLLKA29yOC
         BzQN1h9BA5+5lpOjLcIFfrTgPkyGvls+nSfmoAXaAD+OBKoaPUBbT2FBR1OZRGyM4Zd2
         +RvNwfMp5rxPt7boiy2U9xJN3VuteteexnR7/gM+0ef/jh/kikyIyNi5EZ2l2+ezO7+r
         0e3o3mpcCUh35OEDAqZzipCn/AYC2U1OwdUNPkw0c0LQxuINXPovz4OoH1kuRVhKXMI7
         VxpQ==
X-Gm-Message-State: AOAM533rnb/5SkunnNvRzNOgRkoH8hY3Wgum55GBpKMpjngF5mKAoDJ4
        ewf+cV6MLMFx8ammdsDALQyFCUHgEFoErCP8UwU=
X-Google-Smtp-Source: ABdhPJxao0Izqts8K9liVx7YNWZE7FEAhAAztRVYAiPrMuLoATgBQQ3jYYgI5CP/k7vwrb4/7yLHqU0/HJtVDAB3uik=
X-Received: by 2002:a9d:53cc:: with SMTP id i12mr6385715oth.215.1602953423381;
 Sat, 17 Oct 2020 09:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201017162732.152351-1-dwaipayanray1@gmail.com> <1ad9c5f49e10a192f0c6efb1116f3f0d31adce74.camel@perches.com>
In-Reply-To: <1ad9c5f49e10a192f0c6efb1116f3f0d31adce74.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sat, 17 Oct 2020 22:19:56 +0530
Message-ID: <CABJPP5DuQ_Y0LLS5BzNXUWyxjzp9ts5kgEH-3+7Pn7PPjq0Ljg@mail.gmail.com>
Subject: Re: [PATCH v5] checkpatch: add new exception to repeated word check
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 10:03 PM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2020-10-17 at 21:57 +0530, Dwaipayan Ray wrote:
> > Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
> > moved the repeated word test to check for more file types. But after
> > this, if checkpatch.pl is run on MAINTAINERS, it generates several
> > new warnings of the type:
>
> NAK.
>
> Slow down and test before you send more patch versions.
>
> > +                             next if (index(" \t.,;?!", $end_char) == -1);
>
> what does this do?

Um, it checks if end_char is not present in " \t.,;?!".
If end_char doesn't belong to this list, then the check shall
skip. That is the test will skip for "word word:", but will produce
a warning for "word word." or "word word?", etc.

Shouldn't this itself be the case or am I perhaps going wrong
somewhere?

Thanks,
Dwaipayan.
