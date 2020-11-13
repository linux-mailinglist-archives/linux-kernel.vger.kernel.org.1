Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0292B1C63
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgKMNtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgKMNtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:49:10 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE66C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:10 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y16so10761078ljh.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xoAntw85OrO2y0K3IAZBBg2WATXrCYStlI6/UApq39E=;
        b=mLK9hnuEq73D5EM9nyjCIOx6eLT/2setVaiAMtJLoRFbcVnAEs34FHY5KSBoFGb4RG
         qdLhV+SQGmknqPJU4PBDSIZF9g0NYkmXfqlODHEm+gRhVVuqLspJjOyW9IeUAljYqncm
         Hr1miZ0A9+gJliOQ+5iFFK/XGE1yy3xjlnewK2Ske7EMsuQQYnROPGeAnZiFt8ySc+GQ
         plpFfKNwV/aqn5N3Rel8Ly4gXqZvtX2MXMxIIGSFOwTjqPMuqyxfRYTmAyR46WIwacGU
         DWoyB26SP0D0UDOlo3vTikptKi+MzSziWwIbG9rcQW2H3bJUvsK2rIeRxGfNTDUTZrL0
         XCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xoAntw85OrO2y0K3IAZBBg2WATXrCYStlI6/UApq39E=;
        b=MoFbWo6OcJTCemtlOAaMJLCKrHGZsKDynlFGQmcUcAGuvn3oYsSpJKdTa0kjqhq19U
         JWyGxqongBG0LigL7pCm5EjhUaqqJkBVzpp3gbYXF+BvVo1aN3E/wxELJDvImvlUBOMT
         dr/qEv+6ApjozrTos1J5cTaFMwlkDn53VQC6A51dDsbNkN/aZIdU8oXGxkpdk5yGeW3F
         qSozfw8HNV/1zm86f0worAuV3WyTQ7tbTFG4d8Mo+uE4y8+n82MCBkIwyS0+UNLke059
         6PCFlDNLc7RUp81LHZkBdIVfnEyzuksAiWjD2oYwNvIRKf8xDFVXHmLOPIOxGXmRQDe3
         dJ/A==
X-Gm-Message-State: AOAM533eJlGEEBMO9yXe7aSyYdcIYe/q+zRKc+mbVW50WIcuvKy5m+7f
        BjfdASTCshb8hVdaDkbVhsPLoghNjiOcZ+QqnsM+vf0BA6yfm/FJ
X-Google-Smtp-Source: ABdhPJzGRYNWvBxCbPT+1DHkMoaBf0rUlZ+FCjjE5ZGzGD1kkmGBSMGhLTj8ItfaR3/7NfWyFvRLXdoz3BzZZwnd7YQ=
X-Received: by 2002:a2e:9dda:: with SMTP id x26mr1082935ljj.331.1605275348829;
 Fri, 13 Nov 2020 05:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20201113131037.37519-1-dwaipayanray1@gmail.com> <CAKXUXMwsvj6Y3dEq-eAOyCoJV3qhV7K9U_uRrtbg9u4TV0zyeA@mail.gmail.com>
In-Reply-To: <CAKXUXMwsvj6Y3dEq-eAOyCoJV3qhV7K9U_uRrtbg9u4TV0zyeA@mail.gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Fri, 13 Nov 2020 19:18:37 +0530
Message-ID: <CABJPP5D5TyJcnkmJfLU8-AE71SAuDOYKpLSoXvOy6889agUutA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: fix typo and remove duplicate word
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 7:04 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Fri, Nov 13, 2020 at 2:11 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
> >
> > Delete repeated word in scripts/checkpatch.pl.
> > "are are" -> "are"
> >
> > Fix typo "commments" -> "comments"
> >
> > Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
>
> Does this make checkpatch.pl pass checkpatch without any further warnings?
>
> Nice idea to check if checkpatch.pl still fulfills the checkpatch
> rules we created...
>

Yes, all the rules pass.
$ ./scripts/checkpatch.pl --codespell --strict -f scripts/checkpatch.pl
gives:
total: 0 errors, 0 warnings, 10 checks, 7233 lines checked

9 of those checks are false positives. There is another misspelled
word:
#5003: FILE: scripts/checkpatch.pl:5003:
+## # falsly report the parameters of functions.

I will add that and resend.

Thanks,
Dwaipayan.
