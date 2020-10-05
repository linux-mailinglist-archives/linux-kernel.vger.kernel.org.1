Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FC6283295
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgJEIw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJEIw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:52:56 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69AEC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 01:52:56 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id l4so4398335ota.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 01:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zBv6kKM3dGEQmeeDgKUdUDXl4YNkEuWp7ZkHMGBjG2U=;
        b=PbSorY/wjjyVTk6RWJP+7cLPX10on36ynefRf8xyVUV5nAIJbPs+YkIvpcKyCD+P8Z
         78/fpujGqqB18pss8znR6iTX5WUiWstDXbwlKc+yAIvesg4wvZb8iICgRWWhT1lFPboh
         oF+4juoKRGnS3g9W0f6RRB+5Mzf71rLrN/5ruotfSWGEr8zLK4/klmym2TODYTum/xKb
         2gerYU+p4VjUx1vgWRjFfaLI23jZiZfjHtsl58jWkHLzNkjiRfhgiR6W/fy8gfxUoHY+
         Socntdc3fnENfynf+mdFXPPSH7XMXzWvArB8EwD688En2ndkzfFlWtRzMH1W9cS7kV3Q
         sszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBv6kKM3dGEQmeeDgKUdUDXl4YNkEuWp7ZkHMGBjG2U=;
        b=S02leKfMhdCbcbefusKl8vzmwr790QnyyW5NrP/97MFyhrWyj9A8Z+lsmVU7OL0WdT
         EH1iC2FovlE7KkVfuAwnXnnTeuZPdkAOK9vagIep7jBkk/kIn4S0hcCOHbGL+bHOZ55K
         2XDdwaUQ987PyX7aXT7rzNFWl3IthUzPHaWggEZan4RlQETniDZdtcjPDHIkxncctve6
         6Epk4TbiSyL1AcCEdvaS9jH7yiWA/BxHkb11At9hm1TUb3U+5gClIYyQIHelEqdQorWS
         NoErpg6HNNkxRngA/LdXm07dt8bJ6f6iF5IID+qzz1o+T/xNsAYQPSM+Fzy8ZYdf/E6S
         A9Xg==
X-Gm-Message-State: AOAM532HTBBAFDbPSBWclRELPnhauWypSoRIAWBbo8ON1HhY5G9Q7fYA
        wfB6xhQJnFa9D4EZO10Dn/Z1hJbq/4V4GyKTFj/lS3PiCfcwIg==
X-Google-Smtp-Source: ABdhPJxC6iKQENcB3w7OV28e3Th1vuHlgdW/e6/U6XO33nCwqKtHv/SsDDmYMV1XhbRBBEoNYlf2Ql4KjJ9TSY46q08=
X-Received: by 2002:a9d:4b18:: with SMTP id q24mr10631578otf.265.1601887975881;
 Mon, 05 Oct 2020 01:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201005064842.33495-1-dwaipayanray1@gmail.com>
 <a5cba9bb723626091f8790c794efe8de4ab184b8.camel@perches.com>
 <CABJPP5BwVmWiFcxHKdCYnN_mOE1G=eHUDq8yqqHFaO3cYhp+oA@mail.gmail.com>
 <c51588b4e8a2096c1453070b983da5ce8617a622.camel@perches.com>
 <CABJPP5CAY+qJU8wnGZ7JgugeN9CyFbdct6nAsxpY0NdyaNuWLQ@mail.gmail.com> <f1536dd1c1fbf53a848b27a2817a973fbf809719.camel@perches.com>
In-Reply-To: <f1536dd1c1fbf53a848b27a2817a973fbf809719.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 5 Oct 2020 14:22:33 +0530
Message-ID: <CABJPP5ASsEu5n3cwYxSB4PWYnW+gjXuL_+zSmrpivgHBE7fcnw@mail.gmail.com>
Subject: Re: [PATCH RFC] checkpatch: add new warnings to author signoff checks.
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 2:13 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-10-05 at 13:50 +0530, Dwaipayan Ray wrote:
> > On Mon, Oct 5, 2020 at 1:35 PM Joe Perches <joe@perches.com> wrote:
> > > On Mon, 2020-10-05 at 13:10 +0530, Dwaipayan Ray wrote:
> > > > On Mon, Oct 5, 2020 at 12:48 PM Joe Perches <joe@perches.com> wrote:
> > > > > On Mon, 2020-10-05 at 12:18 +0530, Dwaipayan Ray wrote:
> > > > > > The author signed-off-by checks are currently very vague.
> > > > > > Cases like same name or same address are not handled separately.
> > > []
> > > > > And for mismatches, it's really not known that
> > > > > it should be one way or the or the other is it?
> > > > >
> > > >
> > > > I think that's true. But since the mail in the
> > > > From: part is the one which with others are being
> > > > compared, I think maybe it should have the higher
> > > > priority, and be treated as the expected one.
> > >
> > > I rather expect it to be the other way around.
> > >
> > > The Signed-off-by: line should be authoritative
> > > as that is what is put in the commit log.
> > >
> > >
> > Yes that makes sense. So is it just better to point at
> > the difference?
> > Like:
> > Author email in From: (something) differs from
> > Signed-off-by: (something2).
>
> I think so yes.
>
> That's what I suggested when I replied to you
> with your first attempt.
>
> https://lore.kernel.org/lkml/7958ded756c895ca614ba900aae7b830a992475e.camel@perches.com/
>
>                         WARN("NO_AUTHOR_SIGN_OFF",
>                              "From:/SoB: email address mismatch: 'From: $author' != 'Signed-off-by: $authorsignoff'\n");
>
> And please keep replies on list.
>
Yes sure, I missed to cc the list.

I will fix the issues and get back to you with a new patch.

Thanks,
Dwaipayan.
