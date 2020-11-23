Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884982C0E97
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389391AbgKWPQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733292AbgKWPQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:16:30 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95E7C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:16:28 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id t13so16223005ilp.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dm0rY0bGNQ8BC+Ys+3XZJCyEaVm0ttig9ehZJ7XDdtY=;
        b=bW0FaHv8S94Z2tJDElfalYw7sCTYMCorQcLlYh69PwQ93a+tckqMdLkPkc+72K8VvF
         I09w/Il3U+AyhT6DlIbwt6XG6+lQRqxxO9RO3Lm1rKicycoyyAJ4EsvvBmL+6PTx1WRD
         B2dsBRlumQyRJNMVfU1aYqnP0U1bxHqFcrHk6I7RKjJXHePsTE6aHDi9c1noEyWbBaL7
         9TfLd8kZ/BL8wdkKb+SoEDuFdftjDbp9shuexIYj89uH+FgdpX0K7mGofAnZRYpjCXtM
         5yfWZA1K81WWE9rfajsYq3q+KPM2gElLRGAk0F5HzvmlYW6tcPIb/dushMzbR6ymlr3q
         MwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dm0rY0bGNQ8BC+Ys+3XZJCyEaVm0ttig9ehZJ7XDdtY=;
        b=AylbT2Bzp5o3kXZkgbZk5ERkREcVw7zHtBnDDYqV5+TvdcMDCMUfkxZkB/4sYWjLYr
         +ax2IgJVGerxINaNTijbanS6eNAPwYfAXOjjgdPjN4FfV5Ii3P7qO3EOx7vE/5SSx8YP
         k7l8irKBrND6Qv3t5tazf8Y/W4jxdGHWm1obVBNWZeiVLAwfxuKjQOzGgFDoSEzi1sj1
         fMUJJPwIuM63L1cxf8QGPdmngE46INeR8e3SPGAczGRq/cFLGGScHVKvR5JY02CR5TSU
         O79B+KeQaLIAIhIWzUnbkfm0k6rjybXqRd1SYJve4QnRz1EEQ/uLEK1+CPBZBX1EXU74
         4ZGg==
X-Gm-Message-State: AOAM530u+GNwKwsSzlYuAqmKATd/v89K7XMzGGTdNMnBrOIbciEVvXVQ
        59+kLV2E7SWqu73w2aRnT2MJf6EKtsYRNK/vX/0=
X-Google-Smtp-Source: ABdhPJzXsaEbxvQHZ4CVobyBRv2T+x2gHPTCETEYfM46NFf2UXDcuyvB3BkXiuaCKC7vHWe37bgl40fmYckrrngJCX8=
X-Received: by 2002:a92:aacc:: with SMTP id p73mr218215ill.64.1606144587910;
 Mon, 23 Nov 2020 07:16:27 -0800 (PST)
MIME-Version: 1.0
References: <20201123150430.7985-1-yashsri421@gmail.com>
In-Reply-To: <20201123150430.7985-1-yashsri421@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 23 Nov 2020 16:16:17 +0100
Message-ID: <CAKXUXMx8siSm67jkBP_r+OKyKALfT2EDcX_SfX7JGBy3YisXcQ@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add fix and improve warning msg for
 Non-standard signature
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 4:04 PM Aditya Srivastava <yashsri421@gmail.com> wrote:
>
> Currently, checkpatch.pl warns for BAD_SIGN_OFF on non-standard signature
> styles.
>
> This warning occurs because of incorrect use of signature tags,
> e.g. an evaluation on v4.13..v5.8 showed the use of following incorrect
> signature tags, which may seem correct, but are not standard:
>
> 1) Requested-by (count: 48) => Suggested-by
> Rationale: In an open-source project, there are no 'requests', just
> 'suggestions' to convince a maintainer to accept your patch
>
> 2) Co-authored-by (count: 43) => Co-developed-by
> Rationale: Co-developed-by and Co-authored-by are synonyms
>
> 3) Analyzed-by (count: 22) / Analysed-by (count: 5) => Co-developed-by
> Rationale: Analyzing is a part of Software Development, so
> 'Co-developed-by' is perfectly fine, even if contributor did not create
> code
>
> 4) Improvements-by (count: 19) => Co-developed-by
>
> 5) Noticed-by (count: 11) => Reported-by
>
> 6) Inspired-by (count: 11) => Suggested-by
>
> 7) Verified-by (count: 8) => Tested-by
> Rationale: Used by a single user. On reading mailing list, it seems
> Tested-by might be a suitable alternative
>
> 8) Okay-ished-by (count: 8) => Acked-by
> Rationale: Used by a single user. On reading mailing list, it seems
> Acked-by must be suitable alternative
>
> 9) Acked-for-MFD-by (count: 6) => Acked-by
>
> 10) Reviewed-off-by (count: 5) => Reviewed-by
>
> 11) Proposed-by (count: 5) => Suggested-by
> Rationale: On observing the mailing list, this tag is always used for a
> maintainer. It seems that the changes might have been suggested by them
> and the tag is used as acknowledgment for the same
>
> 12) Fixed-by (count: 3) => Co-developed-by
> Rationale: Fixing bug is a part of Software Development, so
> 'Co-developed-by' is perfectly fine, even if contributor did not create
> code
>
> 13) Pointed-out-by (count: 3) / Pointed-at-by (count: 2) => Suggested-by
> Rationale: The tags are used for maintainers. It seems that the changes
> might have been suggested by them and the tag is used as acknowledgment
> for the same
> E.g., Pointed-at-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> 14) Suggestions-by (count: 3) => Suggested-by
>
> 15) Generated-by (count: 17) => remove the tag
> On observing the mailing list, this tag is always used for quoting the
> tool or script, which might have been used to generate the patch.
> E.g. Generated-by: scripts/coccinelle/api/alloc/kzalloc-simple.cocci
>
> 16) Celebrated-by (count: 3) => remove the tag
> This tag was used for only one commit. On observing mailing list, it seem
> like the celebration for a particular patch and changes.
>
> Provide a fix by:
> 1) replacing the non-standard signature with its standard equivalent
> 2) removing the signature if it is not required
>
> Also, improve warning messages correspondingly, providing users
> suggestions to either replace or remove the signature. Also provide
> suitable rationale to the user for the suggestion made.
>
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> changes in v2: replace commit specific example with brief evaluation
>
> changes in v3: provide rationale to users for every signature tag suggestion;
> modify commit message describing arrival to conclusion in a structured way
>
>  scripts/checkpatch.pl | 101 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index fdfd5ec09be6..f402c9c3958f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -506,6 +506,81 @@ our $signature_tags = qr{(?xi:
>         Cc:
>  )};
>
> +our %standard_signature_fix = (
> +       "Requested-by:" => {
> +               suggestion => "Suggested-by:",
> +               rationale => "In an open-source project, there are no 'requests', just 'suggestions' to convince a maintainer to accept your patch",
> +       },
> +       "Co-authored-by:" => {
> +               suggestion => "Co-developed-by:",
> +               rationale => "Co-developed-by and Co-authored-by are synonyms",
> +       },

Maybe this reads better:
Co-developed-by is the standard tag for patches developed by multiple authors.

> +       "Analyzed-by:" => {
> +               suggestion => "Co-developed-by:",
> +               rationale => "Analyzing is a part of Software Development, so 'Co-developed-by' is perfectly fine, even if contributor did not create code",
> +       },
> +       "Analysed-by:" => {
> +               suggestion => "Co-developed-by:",
> +               rationale => "Analysing is a part of Software Development, so 'Co-developed-by' is perfectly fine, even if contributor did not create code",
> +       },
> +       "Improvements-by:" => {
> +               suggestion => "Co-developed-by:",
> +               rationale => "Performing improvements are a part of Software Development, so 'Co-developed-by' is perfectly fine, even if contributor did not create code",
> +       },
> +       "Noticed-by:" => {
> +               suggestion => "Reported-by:",
> +               rationale => "Reported-by and Noticed-by are synonyms",
> +       },

Similarly:

Reported-by is the standard tag for denoting any notice or report.

> +       "Inspired-by:" => {
> +               suggestion => "Suggested-by:",
> +               rationale => "Suggested-by is the standard signature tag for acknowledging user for their suggestions",
> +       },
> +       "Verified-by:" => {
> +               suggestion => "Tested-by:",
> +               rationale => "Tested-by and Verified-by are synonyms",
> +       },

Similarly here.

> +       "Okay-ished-by:" => {
> +               suggestion => "Acked-by:",
> +               rationale => "Acked-by is the standard signature tag for recording your approval",
> +       },

I think "your" is wrong here; the person that runs checkpatch may not
be the person providing the approval.

So maybe:

- for recording one's approval.

or:
- for recording acknowledgement.

> +       "Acked-for-MFD-by:" => {
> +               suggestion => "Acked-by:",
> +               rationale => "Acked-by is the standard signature tag for recording your approval",
> +       },
> +       "Reviewed-off-by:" => {
> +               suggestion => "Reviewed-by:",
> +               rationale => "Reviewed-by is the standard signature tag for recording your approval",
> +       },

for recording the review.

> +       "Proposed-by:" => {
> +               suggestion => "Suggested-by:",
> +               rationale => "Proposing changes is same as suggesting changes, so Suggested-by seems perfectly fine",
> +       },

Similarly, the sentence as above could be used.

> +       "Fixed-by:" => {
> +               suggestion => "Co-developed-by:",
> +               rationale => "Fixing bug is a part of Software Development, so 'Co-developed-by' is perfectly fine, even if contributor did not create code",
> +       },
> +       "Pointed-out-by:" => {
> +               suggestion => "Suggested-by:",
> +               rationale => "Pointing out certain changes is synonymous to suggesting changes, so Suggested-by seems perfectly fine",
> +       },
> +       "Pointed-at-by:" => {
> +               suggestion => "Suggested-by:",
> +               rationale => "Pointing at certain changes is synonymous to suggesting changes, so Suggested-by seems perfectly fine",
> +       },
> +       "Suggestions-by:" => {
> +               suggestion => "Suggested-by:",
> +               rationale => "Suggested-by is the standard signature tag for acknowledging user for their suggestions",
> +       },
> +       "Generated-by:" => {
> +               suggestion => "remove",
> +               rationale => "Signature tags are used to acknowledge users for their contributions. It is advised to describe about tools in commit description instead",
> +       },
> +       "Celebrated-by:" => {
> +               suggestion => "remove",
> +               rationale => "Signature tags are used to acknowledge users for their contributions. This tag may not be required at all",
> +       },
> +);
> +
>  our @typeListMisordered = (
>         qr{char\s+(?:un)?signed},
>         qr{int\s+(?:(?:un)?signed\s+)?short\s},
> @@ -2773,8 +2848,30 @@ sub process {
>                         my $ucfirst_sign_off = ucfirst(lc($sign_off));
>
>                         if ($sign_off !~ /$signature_tags/) {
> -                               WARN("BAD_SIGN_OFF",
> -                                    "Non-standard signature: $sign_off\n" . $herecurr);
> +                               my $suggested_signature = "";
> +                               my $rationale = "";
> +                               if (exists($standard_signature_fix{$sign_off})) {
> +                                       $suggested_signature = $standard_signature_fix{$sign_off}{'suggestion'};
> +                                       $rationale = $standard_signature_fix{$sign_off}{'rationale'};
> +                               }
> +                               if ($suggested_signature eq "") {
> +                                       WARN("BAD_SIGN_OFF",
> +                                            "Non-standard signature: $sign_off\n" . $herecurr);
> +                               }
> +                               elsif ($suggested_signature eq "remove") {
> +                                       if (WARN("BAD_SIGN_OFF",
> +                                               "Non-standard signature: $sign_off. Please consider removing this signature tag. $rationale\n" . $herecurr) &&
> +                                       $fix) {
> +                                               fix_delete_line($fixlinenr, $rawline);
> +                                       }
> +                               }
> +                               else {
> +                                       if (WARN("BAD_SIGN_OFF",
> +                                               "Non-standard signature: $sign_off. Please use '$suggested_signature' instead. $rationale\n" . $herecurr) &&
> +                                       $fix) {
> +                                               $fixed[$fixlinenr] =~ s/$sign_off/$suggested_signature/;
> +                                       }
> +                               }
>                         }
>                         if (defined $space_before && $space_before ne "") {
>                                 if (WARN("BAD_SIGN_OFF",
> --
> 2.17.1
>
