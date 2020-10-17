Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFEF290FFD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 08:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436799AbgJQGEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 02:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411671AbgJQGDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 02:03:20 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1633C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 23:03:19 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id n3so281037oie.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 23:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/xratYsaG9m9w7i50w062IVAUzhi04mGQ958Rmk2Lk=;
        b=trNNUHddJseMNBbnfx6kOTFiOLH2xL3FWPjEFHEs+AWDnATUzeCkTXMAQRM1gNYo8V
         Awd9+hF3HofiKGXgPw9yaCJcJ7V6UzLbruEgfIQuum0q0mpzX0ll3ElLtPETZUtFLul6
         NP51oTOrb79s/cl9VUiZOejqE2skgJHeR+1kNCuWwfQxX0CjD5vRlmupasD/+Bflsx8v
         Y4tv1JkfgvPDCqZz8pVhgcJnQ9wkQyGmZ2Trgp7vdsacW7sPH+gY1bmAo9WG0+HBwNBJ
         L6ctlqrFRt2A87H2g5neimD8ZjYgWC/HWc9MNWMSo2HydT99BSkLbRrEaKDhLYPOz5dA
         OQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/xratYsaG9m9w7i50w062IVAUzhi04mGQ958Rmk2Lk=;
        b=QVZkIsKklU/ORWNdmuJrP1uCEQUxwFH85t7iM7Ps9Z+6aK8Pxh7tW3l1DBHii7hYa+
         J8qKQDZR4ABxlx8vK+uA14Xi5pcqvUMVgag+w0B/xBrVSKDq2/NeVQLcmYahm2liN0rr
         F9YQAcEGpRL5ONLIKXzX7ZmYjMdmgPJLrVCrSG+NxR6BA/nThsk7x25ADuoE5zD2Va+H
         gugS5v3N27iIMCQH1B6AuqpkPg0GrRSsS8dOW61LLqSVxstIfSs97TPTYNr2GwWwCAcM
         PtMdJnuTi+X0xlnSpXuvT9ebBaQN6wINnJx3MHEhInRp48bSFx2SQO9Krj8sQBkgpAWu
         d/Aw==
X-Gm-Message-State: AOAM531f36S46NYqJMb45EDPxIshl+y4FLAu1nJMGZcSC24rq/AwCRQt
        zed1ZKjMvPbXVMPnCjKtyEpcfJ0kdth+LNL67URaDDrw/siLXg==
X-Google-Smtp-Source: ABdhPJxm9gt3p83GA5uwReGmw4Qs3y5MplDWeDvo4ggBqpcBaZPtjfHFWni47vt6vLpVOP30jN7kj1XetyWyQpIcJeI=
X-Received: by 2002:aca:420a:: with SMTP id p10mr4547482oia.117.1602914598788;
 Fri, 16 Oct 2020 23:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201017052243.17095-1-dwaipayanray1@gmail.com> <fc47f1e6babab1044c9dece4b30200e239438931.camel@perches.com>
In-Reply-To: <fc47f1e6babab1044c9dece4b30200e239438931.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sat, 17 Oct 2020 11:32:52 +0530
Message-ID: <CABJPP5CBh2TDwo9Z1hoaLPjk=d00N0r4VkLVdwAuMbWPyNbDYA@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add new exception to repeated word check
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why include a + character here?
>
Hi,
I tried it without + first, but then lines like
"The the repeated word."
didn't register a warning.

I think checkpatch adds a + to the line when used on
files. Am not sure but my $rawline was:
+The the repeated word.

> Please use "next if (test);" to be similar to the other uses above.
>
> And this doesn't work on end of phrase or sentence.
>
> ie: "my sentence is is, a duplicate word word."
>
> so $end_char could be a comma or a period.
>
> so likely the $end_char test should be !~
>

I tried on "my sentence is is, a duplicate word word.",
and got the following:

WARNING: Possible repeated word: 'is'
#8: FILE: MAINTAINERS:8:
+my sentence is is, a duplicate word word.

WARNING: Possible repeated word: 'word'
#8: FILE: MAINTAINERS:8:
+my sentence is is, a duplicate word word.

Am I doing something wrong?

> What is the reason to add and use $exclude_chars?
>
I am comparing both start_char and end_char to find
whether they have the characters which will exclude them
from repeated word check. So i am keeping the common
variable to match from. I thought I would do that so that
more exceptions could be added later on easily.

I might be wrong in doing that. What do you think?

Thanks,
Dwaipayan.
