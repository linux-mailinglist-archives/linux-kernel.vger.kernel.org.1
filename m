Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5430283EF4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 20:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgJESrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 14:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgJESrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 14:47:21 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C26AC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 11:47:21 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id l4so6171527ota.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 11:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQjx4ARCOaA2Q3w4kWrTamyGCaoXmzrJw6IcbfLdyk4=;
        b=hbADtAEgbdwpvlYNo3faqt+P+U0ye7bUZqMOOg6MFw6APVUSBDhEB9pOLtDWotBoxj
         h/ol56CXi/ZM09Su4P+xHHA8yoFXKO+yKouICKddLgjIwzY8qO9KUHWBFyAVpmrmbfw4
         s6+sDUUDpCCrFrmS9fioCiVegCgTTzsBu8CEg/79jYVxQn701bHyJmURrjkZ8P+aEkWb
         oWnobPquo/nwPxiOEmMebRPc+KBi7+F7O2aK9a5tVpNKw+yke5d0hIRVaET2pbzlO9os
         1ppHKBytY+wmahSasdz/Jj/+YoIemLO76yY16My6Rx77tkDMyBvLwvsYMnKV0FzE/t1x
         ZWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQjx4ARCOaA2Q3w4kWrTamyGCaoXmzrJw6IcbfLdyk4=;
        b=EyIVKbGE+js0ejE2A+DUfRZJ8jkl7PoE4KfSib+qK8w5KUeB4o9lVt5lg1FZkRZQH4
         WDKXpSRjlmKQ4jEWJ+7vjZVgqtg8JECtYfYTw8K6On46y5V8j4CGDKgExCMdP0Azals2
         6fsKmQZj8gZ/Si9o2fYwtFGpTNn+t8sZptWRP1UvlBjeep5nkaazWExqG4WtPuNFknlV
         /s9cBgDRd5o7SE3stYmF1sNjOuqano4KAJp6/2eHCyWCUsR1ih7pPSlwPLu5fPe87/su
         k0+2EJ9lya68/05E37z4Sis21kida0oZB/y0YbALs9u4NSjw2oAE/SXMjctyDnq+nML1
         Fvcg==
X-Gm-Message-State: AOAM533TlPCogKBCmP9tToibcQiD47d1wNkgJz4wDtqYIeEn//jfTBJf
        buISncUJxPozty1jyBIPDSrRJY1ZwWLm+4z4RTD5IfjG46jRSQ==
X-Google-Smtp-Source: ABdhPJyLCnElkhzehx+gGblvdGwyvr63QqKxsu4szbqFIma5EJahiU+IMo+92Sx6DaOFjnKvArimCbYKbikZz9YRX/w=
X-Received: by 2002:a9d:4b18:: with SMTP id q24mr443856otf.265.1601923640321;
 Mon, 05 Oct 2020 11:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201005173933.171074-1-dwaipayanray1@gmail.com> <14c9d8808feabe987e7fdac867d21ff88561011a.camel@perches.com>
In-Reply-To: <14c9d8808feabe987e7fdac867d21ff88561011a.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Tue, 6 Oct 2020 00:16:58 +0530
Message-ID: <CABJPP5D9d7egEMWbYJnp7STYyB9OeW3sWzcnyXvRTKFbUmXU4g@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: add new warnings to author signoff checks.
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 11:53 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-10-05 at 23:09 +0530, Dwaipayan Ray wrote:
> > The author signed-off-by checks are currently very vague.
> > Cases like same name or same address are not handled separately.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > +                                             if ($address1 =~ /(\S+)\+\S+(\@.*)/) {
> > +                                                     $address1 = $1.$2;
>
> More common in this code is "$1" . "$2" not $1.$2
>
> > @@ -6891,9 +6917,29 @@ sub process {
> []
> > +                     # 4 -> names match, addresses excuding mail extensions (subaddresses) match
>
> excluding
>
> perhaps "subaddress detail" instead of "mail extensions (subaddresses)"
>
> And maybe add "from RFC 5233"
>
> > +
> > +                     my $sob_msg = "'From: $author' != 'Signed-off-by: $author_sob'";
> > +
> > +                     if ($authorsignoff == 0) {
> > +                             WARN("NO_AUTHOR_SIGN_OFF",
> > +                                  "Missing Signed-off-by: line by nominal patch author '$author'\n");
> > +                     } elsif ($authorsignoff == 2) {
> > +                             WARN("NO_AUTHOR_SIGN_OFF",
> > +                                  "From:/Signed-off-by: email name mismatch:\n$sob_msg\n");
>
>
> Still no need for a newline to separate the output message.
>

Thanks, I will fix these.

Are there any more changes needed? I shall try to wrap it
in v3 then.

Thanks,
Dwaipayan.
