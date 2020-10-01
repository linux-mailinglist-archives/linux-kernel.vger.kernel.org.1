Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB3728001C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbgJAN1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731993AbgJAN1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:27:45 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661DCC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 06:27:45 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g96so5331029otb.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 06:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54jWxrzqyFpoWS/nH1oxHVPT/HijFa0iC+/U3qb2j+s=;
        b=OHIJe+LhGh33epY+sAO/8r3vP3rGOJ/j6OTslVkoAM0ElWNzjB7Q9ATGftK/BuIP3+
         WQ9ZMOILZg/IKzjYXAzZl6UJ+VVxzjQhnT+IV4NOxcivbqlSoIAzHtoW75+pDGnvCdQ5
         HuN83OEpg3Edy7NhONlasFCO4zbLJ1fLJkpPS/pXcmg8zP+G2cy1Kh9ccd5kr5Cabfa2
         ury3dzdPVyMco0Rjf2qbi8jcNi/2qmN0iQI466HHYeRvPJuJn8HbMAWLAtrhNsJgw7X9
         SddcWEYo17eWl4Y5LgQZRaAuO9TF2patTqOz6+byCDf/mAKX8/+C7EGSjAHFWHXRF3o3
         MaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54jWxrzqyFpoWS/nH1oxHVPT/HijFa0iC+/U3qb2j+s=;
        b=ZY8y4xgTVmTtu7nOXpsjK59SrCocriXoinDqTKRAUDgeal40Ub+N+tEBvq6hgpCSOc
         kTWZe2zrg1crwyXoO0qqDz6ImY6MLQrhr2eaAfbdtJOumVBseFHErCYsAqE+nGa7bokG
         o7RT+To/tqHv7EN6ZslNZ03dJARndLP+w6QoBgch9dc46hJGJ3GpvoVN/QVwRi5Q1IPt
         cGZTlzMN3kwl8cvoXQV6biOx29lJmYPDlT3d52QdINI7HTb3aQNR8noeHCN9vREBCPpP
         yg6OV8M5P1u3zpfozfr8PeLp5zhujGDvddmNNfqPO+p+Rwi5+vCB1X/Ft8kheftGaDCl
         wXMA==
X-Gm-Message-State: AOAM530yCWpE8EXZeGPhf3a4z67LquUI/06w+i+RooXQekBDHkzGkUC6
        x0DIXjSn8GslXNAnkZKixN3mOs37PtELwdbpBgs=
X-Google-Smtp-Source: ABdhPJwzewIYeVADq7evoRRe7F6mHw5AX4J4KHstv+lWgVjNEKg6KX1nUk2lHnVc87S+tabWH2pAQm102KXrtdMqwKo=
X-Received: by 2002:a05:6830:c4:: with SMTP id x4mr5183094oto.30.1601558864513;
 Thu, 01 Oct 2020 06:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201001103314.136645-1-dwaipayanray1@gmail.com> <8e110121c89414ab1601071868dbcf410195a209.camel@perches.com>
In-Reply-To: <8e110121c89414ab1601071868dbcf410195a209.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 1 Oct 2020 18:57:22 +0530
Message-ID: <CABJPP5CFE3KXzMzuvVxtJt5tOg8Ye6y1V7-mqT5pqazHjVWvJw@mail.gmail.com>
Subject: Re: [PATCH RFC] checkpatch: fix multi-statement macro checks
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 6:47 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-10-01 at 16:03 +0530, Dwaipayan Ray wrote:
> > Checkpatch.pl doesn't have a check for excluding while (...) {...}
> > blocks from MULTISTATEMENT_MACRO_USE_DO_WHILE error.
> >
> > For example, running checkpatch.pl on the file mm/access.c in the
> > kernel generates the following error:
> >
> > ERROR: Macros with complex values should be enclosed in parentheses
> > +#define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)        \
> > +     while (len >= sizeof(type)) {                                   \
> > +             __get_kernel_nofault(dst, src, type, err_label);        \
> > +             dst += sizeof(type);                                    \
> > +             src += sizeof(type);                                    \
> > +             len -= sizeof(type);                                    \
> > +     }
> >
> > The error is misleading for this case. Enclosing it in parantheses
> > doesn't make any sense.
>
> OK
>
> > Checkpatch already has an exception list for such common macro types.
> > Added a new exception for while (...) {...} style blocks to the same.
> > This effectively fixed the wrong error message.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -5342,6 +5342,7 @@ sub process {
> >                           $dstat !~ /^\.$Ident\s*=/ &&                                # .foo =
> >                           $dstat !~ /^(?:\#\s*$Ident|\#\s*$Constant)\s*$/ &&          # stringification #foo
> >                           $dstat !~ /^do\s*$Constant\s*while\s*$Constant;?$/ &&       # do {...} while (...); // do {...} while (...)
> > +                         $dstat !~ /^while\s*$Constant\s*$Constant\s*$/ &&           # while (...) {...}
>
> Did you try to output $dstat for some matching cases?
> What was the $dstat value for the cases you tried?
>
>
Hi,
I did check $dstat values.

For example on file mm/maccess.c, there were two such macros:

Case 1:

$ctx:
+#define copy_from_kernel_nofault_loop(dst, src, len, type, err_label) \
+ while (len >= sizeof(type)) { \
+ __get_kernel_nofault(dst, src, type, err_label); \
+ dst += sizeof(type); \
+ src += sizeof(type); \
+ len -= sizeof(type); \
+ }

$dstat:
while 1 1

Case 2:

$ctx:
+#define copy_to_kernel_nofault_loop(dst, src, len, type, err_label) \
+ while (len >= sizeof(type)) { \
+ __put_kernel_nofault(dst, src, type, err_label); \
+ dst += sizeof(type); \
+ src += sizeof(type); \
+ len -= sizeof(type); \
+ }

$dstat:
while 1 1


Thanks,
Dwaipayan.
