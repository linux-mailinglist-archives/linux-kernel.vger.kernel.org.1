Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2872E28C979
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 09:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390478AbgJMHf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 03:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390362AbgJMHfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 03:35:55 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D63FC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 00:35:55 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id t15so18229481otk.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 00:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NydgkElo7XN0w7dOFhQcATjfq0XSR9/Rmc/KkVh/UNo=;
        b=g2jK8ADvml1TkUXLjZski7IS+ee6pe6Co5HzJixwVYoCWxRdgZLvBrx+0ANkHJmlQI
         tEURuNYGyPgVZS9+vZ/0wFPVXvmaPKDUsQihZobECvGyRja4cUgQ6uWgzBn8EoL20OMN
         QPkWLagE1eGUmi1PVsL71mPQiJm3/Fesw4Jo4WcEjoOe1qvJRy1ACtErYVrqWUqcKWEr
         eSlg4kkwkJKdLWX1B/YLurJSRBuL3JJBe2GG6BnImHa/Xyx9PZ/O8MkQ6aRpSqLyQeWn
         0CTcWuHN2Y+BpLTzD5AkV/4w8479HkoCDgOJcTXwVzr/10RHczHbAGDfcHvHpZtq93ig
         SV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NydgkElo7XN0w7dOFhQcATjfq0XSR9/Rmc/KkVh/UNo=;
        b=NBgmfBtjT0smbZKsXkVUpOzxcmuwWADYLZideP5jp2vCBQfFph8gOecl4Q2RO4y4be
         YE5Um/LLZDm6NONNYYtKN2BWwm7tN+P+IKdPTQtjBa8s6s/9HRZi2GaBH+dWOMklLctP
         TvqdQlhHua8IPidg22AmsuRZ8avP82T4OI07dpIA4Sw0qle++iUAmEL4AJK67gKFx+Ul
         qcF92atNw/7m8jSdOOtdarRMilcGsVWTgWrcHdyNdURkGohFS1zRqyoJHiMP6KZLWOT7
         O52Ao8Z5MJgv7UB/dnajruE0JkTYHOkys63apFO+n8/B453qFfRhTcN7W/8A9Jk40nno
         Oetw==
X-Gm-Message-State: AOAM532KZCdemyrnT65VZNHcjwDdo3mREvSp46vnEdAFWA4BWO/9VCEk
        D1TVbODwItbw09DSl3PTfx/cXdGdQfjTKxcqYBedI31GF+b7MkXvetg=
X-Google-Smtp-Source: ABdhPJwiKTvxH15gM58AG/oy+ufV+gstifJHwYzearYrKsKtzkZUwklzEu+aFfxpQSzivMzNcyzWj8nFt4pX67xcL4U=
X-Received: by 2002:a9d:6c4b:: with SMTP id g11mr18934047otq.265.1602574554214;
 Tue, 13 Oct 2020 00:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201013063642.39810-1-dwaipayanray1@gmail.com> <a15a6cc0ddea068d78113f5e315eaba6f52b917a.camel@perches.com>
In-Reply-To: <a15a6cc0ddea068d78113f5e315eaba6f52b917a.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Tue, 13 Oct 2020 13:05:28 +0530
Message-ID: <CABJPP5CN3SHV+z2wM0ZW-2C6WggqhKPYkiTFnaYf_ERVBzXezQ@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: fix missing whitespace in formatted email
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 12:27 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-10-13 at 12:06 +0530, Dwaipayan Ray wrote:
> > Commit 0c01921e56f9 ("checkpatch: add new warnings to author signoff
> > checks.") introduced new checks for author sign off. The format_email
> > procedure was modified to add comment blocks to the formatted email. But
> > no space was added between the email address and mail comment.
> >
> > This causes wrong email formatting in cases where the email is in the form
> > "author@example.com (Comment block)". The space between the address and
> > comment block is removed, which causes incorrect parsing of the
> > formatted email.
> >
> > An evaluation on checkpatch brought up this case. For example,
> > on commit 1129d31b55d5 ("ima: Fix ima digest hash table key calculation"),
> > the following warning was reported:
> >
> > WARNING:BAD_SIGN_OFF: email address 'David.Laight@aculab.com (big endian
> > system concerns)' might be better as 'David.Laight@aculab.com(big endian
> > system concerns)'
>
> Strictly, a comment or multiple comments can exist
> in any part of an email
>
> "John (Jon) Smith (Smitty) <jsmith@domain.tld> (tld is the best tld)
>
> > Add a single space in between the address and comment when the
> > extracted comment is not empty.
>
> So after the address is not necessarily the best
> location for a comment.
>
>

Yes I agree and in cases like that the check works perfectly.
But now consider the case when the name is empty:

Like:
jsmith@domain.tld (tld is the best tld).

In this case when the formatted email is generated, we have
the following: "jsmith@domain.tld(tld is the best tld)".
If this email is parsed again, the entire part is parsed as the email address,
which causes a mismatch later on.

It is for only this case that an extra white space is needed for the
parsing, probably because of how the comment is captured, for emails
with empty names:
  $formatted_email =~ /(\S+\@\S+)(.*)$/
So it depends on the whitespace after address to demarcate the comment.

Some more examples of what I intend to solve:
'<stable@vger.kernel.org> [5.3+]'
'<stable@vger.kernel.org> # v5.7+'
'David.Laight@aculab.com (big endian system concerns)'


Thanks,
Dwaipayan.
