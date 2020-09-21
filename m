Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC89E271E02
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgIUIcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 04:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgIUIcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:32:01 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5000BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 01:32:01 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t76so16055173oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1L23WxraydIewy7QcSbacwm2P7ka8MVKI+aBaOXEGZI=;
        b=oSVs8Nh5yQid5/qmttpylrTUy1Ah87gx3o0oxd7LeJUeUff3U45mRnut4hPTVhlfT+
         3rcSdd/jotiv0PO1R2mZ3Z0fuJdzUU91oTUCCl6GQ4dt/3Mr1SAd/UNvUG53Js1tkixN
         7EkG/fW6lz/dnn1HjABRGKtxQH22Mi8AMl2crCG9PSpn4V8Ln4uUfJh01RkAL0Z7Pbnm
         PSbRnFLzGU2a4NuJmuqqj9r1MqiWgHZYGuw+EoDrKL4jX1ugydJMMHVJzEEAv5c4StEO
         sc0QdeoVhpjN4aI5A4hsn8eW+/2766bkXirdWyMnZfAOffc4mXRRl/Hs6Il5TrmkUcB0
         7oaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1L23WxraydIewy7QcSbacwm2P7ka8MVKI+aBaOXEGZI=;
        b=o9WOXVYgV8ic5MOiWzHLKpFsiR8awBu2cPGbi58mNDw8XRhXw+4OCKvtgpqITXFtN9
         /bwqAcwRhcWuydVye7D37bIjZHoX6ZjE+qf3hCVf+dO09K1tKKp1piYJ1dhKnfm3Nf/2
         qSFXRJQa260bkjF+xqCXgO/U+Ce8hGvvwSEAzpZzpvt8fi44bjRLCxGElplbJSYF9Bz0
         GhPeAvJcKg3HlV3hT6h0JTg4z299y0c/PEF/VISTEXKa3Sx/cABTVVraQac19Xvf6v3X
         tlAfvjg45UcTRQPXAghFK5WuLUPiUIPaIJNDCTc7+bq/1kmfUsG6/wAgvgxaY3zepja6
         9A6Q==
X-Gm-Message-State: AOAM5314fd+2CkVHWyPRiH0jO6CP50kckWD6FLKLEilkGHY+ZDt7PNP/
        xou2YgJj1ZxvnGSZVs1I6lP/YNXUhF5or1j6PAX9//Kh1yGuyqZo
X-Google-Smtp-Source: ABdhPJy7VmwK5B+Tj7OcaE2Li+SvVUYV24q3hotYfmb3X5/RIbHoiEifdRFAO9UyOhsEg6G3Saxk0Sq2A7t2u/QYeOk=
X-Received: by 2002:aca:b2d7:: with SMTP id b206mr17149640oif.110.1600677120500;
 Mon, 21 Sep 2020 01:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200920091706.56276-1-dwaipayanray1@gmail.com> <alpine.DEB.2.21.2009210940060.7483@felia>
In-Reply-To: <alpine.DEB.2.21.2009210940060.7483@felia>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 21 Sep 2020 14:01:41 +0530
Message-ID: <CABJPP5Coi2b3xHcmf+dGTmFpsQ1QjNKixA1Yz-n42Mzjc4YngQ@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: extend author Signed-off-by check for
 split From: header
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org, apw@canonical.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 1:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
>
> Dwaipayan, just a quick nitpick:
>
> Your subject line has two spaces in front of 'From:'
>
> On Sun, 20 Sep 2020, Dwaipayan Ray wrote:
>
> > Checkpatch did not handle cases where the author From: header
> > was split into multiple lines. The author identity could not
> > be resolved and checkpatch generated a false NO_AUTHOR_SIGN_OFF
> > warning.
> >
> > A typical example is Commit e33bcbab16d1 ("tee: add support for
>
> You can write 'Commit' lowercase as 'commit'.
>
> > session's client UUID generation"). When checkpatch was run on
> > this commit, it displayed:
> >
> > "WARNING:NO_AUTHOR_SIGN_OFF: Missing Signed-off-by: line by nominal
> > patch author ''"
> >
> > This was due to split header lines not being handled properly and
> > the author himself wrote in Commit cd2614967d8b ("checkpatch: warn
> > if missing author Signed-off-by"):
> >
>
> Same here.
>
> > "Split From: headers are not fully handled: only the first part
> > is compared."
> >
> > Support split From: headers by correctly parsing the header
> > extension lines. RFC 2822, Section-2.2.3 stated that each extended
> > line must start with a WSP character (a space or htab). The solution
> > was therefore to concatenate the lines which start with a WSP to
> > get the correct long header.
> >
> > Suggested-by: Joe Perches <joe@perches.com>
> > Link: https://lore.kernel.org/linux-kernel-mentees/f5d8124e54a50480b0a9fa638787bc29b6e09854.camel@perches.com/
> > Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
>
>
>
> On v5.4..v5.7 using data from a previous evaluation, I found 116 commits
> with
> the error message "Missing Signed-off-by: line by nominal patch author
> ''",
> when running ./scripts/checkpatch.pl on v5.9-rc6.
>
>
> After this patch application, all 116 warnings disappeared with "Missing
> Signed-off-by: line by nominal patch author ''"
> and these three new warnings appeared:
>
> 322f6a3182d42df18059a89c53b09d33919f755e:35: WARNING: Missing Signed-off-by: line by nominal patch author 'Johnson CH Chen <JohnsonCH.Chen@moxa.com>'
> 18977008f44c66bdd6d20bb432adf71372589303:37: WARNING: Missing Signed-off-by: line by nominal patch author '"Marek Szyprowski via Linux.Kernel.Org" <m.szyprowski=samsung.com@linux.kernel.org>'
> ed3520427f57327f581de0cc28c1c30df08f0103:51: WARNING: Missing Signed-off-by: line by nominal patch author 'Chengguang Xu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>'
>
> With that said, I think am happy to add my tags:
>
> Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Tested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>
> Dwaipayan, you can fix the minor commit message issues above, add the tags
> from Joe and me to the end of your commit message and send the patch as v3
> out to Andrew Morton with everyone sofar as CC. Andrew Morton will pick up
> the patch and make it travel to Linus Torvalds.
>
> Good job so far!
>
> After you did that, let us develop and discuss a plan to refine the
> 'trickier' part of false AUTHOR_SIGN_OFF warnings for developer and
> maintainers with some known special author and sign-off procedures.
>
> Lukas
>
> > ---
> >  scripts/checkpatch.pl | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 504d2e431c60..9e65d21456f1 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -2661,6 +2661,10 @@ sub process {
> >  # Check the patch for a From:
> >               if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
> >                       $author = $1;
> > +                     my $curline = $linenr;
> > +                     while(defined($rawlines[$curline]) && ($rawlines[$curline++] =~ /^[ \t]\s*(.*)/)) {
> > +                             $author .= $1;
> > +                     }
> >                       $author = encode("utf8", $author) if ($line =~ /=\?utf-8\?/i);
> >                       $author =~ s/"//g;
> >                       $author = reformat_email($author);
> > --
> > 2.27.0
> >
> >

Hi,
Sure! I will do that and get back to you.

Thanks,
Dwaipayan.
