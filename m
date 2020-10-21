Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED612952C6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441509AbgJUTMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408959AbgJUTMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:12:48 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFEDC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:12:48 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id g7so3535631ilr.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cicLxiZ2pJxeNcrsla6aQZQxECgsVNk7QwFVKAmvVic=;
        b=LtZOp7+bO31gS11qb7YgWyXytfCn3sfkOqfqT9tb7FTmqFPD+7SviB5IPlhX5CjdPp
         BIxzNvUjC0L6/rX7xcHpV7ibCg5x76DkD9A7AsJkC1akhMdNR0ueq7aVCXKdq70hn2ng
         8RQenoz1r3sdh74gyWsGdJupJ3SLYl7e6LP8yjflXQ1simfX3k+QkIVBi7XRmMsvFKO3
         RwV2DWFhZ743dn/27g99rhm2uge71DRd/eKDNavflidLQUETvRuGhHOb5/yDfuY9zedD
         /70afm/frJWXd2M5T8Qoq/AOgL1tSrIRE+kCAH+akg1xKshv/2yxsukItM+t17fXdp1C
         bwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cicLxiZ2pJxeNcrsla6aQZQxECgsVNk7QwFVKAmvVic=;
        b=ViofdtBdDrEMuq7UKkJHb6LSV6baA36NJzYIm8cnOCYkmBnnC+wMiceQZ8dWF24//T
         zTYZexDNbANwVpaNx+mxVpLqQEi0PijPRUwXG17ex6BFombfoSIKQC0/7qBVlW+iCYxm
         R3gv3EVrtja3a8i1NmVhrMPiurninqLkCse3BzImvC1+ueeXM8osM7V1qmnTow/vRNgU
         fXmkh8dFcy3722+JSXORznp+HnlGrgMuvm6RV9vY2dd0K36oYSfVlRLNJeng3as+almf
         c+gzsDm+xlRfhdYPjx36/2Puhs8By/WpS5dHyL1Tc2mO0q38rej8uUPbdd8V072qguNZ
         37yg==
X-Gm-Message-State: AOAM533sfED8PS0kvSJw3DjjOLjlJZ1043u4gFJhqYpfLnoT915NVWj3
        h0pmz09jCPuGmnU3GGYSkKiobFcaVGAIPaSJ8GM=
X-Google-Smtp-Source: ABdhPJy2peqg3nBLiM2eNvvIgRbEE8Ctr9quk7enFj9RmgHgo5LIK+1wClgBM701B1VkH/bKmYvpI4Rj8hSjfWq58bE=
X-Received: by 2002:a92:de43:: with SMTP id e3mr3291056ilr.62.1603307567874;
 Wed, 21 Oct 2020 12:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201021150120.29920-1-yashsri421@gmail.com> <f073750511750336de5f82600600ba6cb3ddbec0.camel@perches.com>
 <26647abf8cf14595a0dd22f10ec1c32e3dc2a8c0.camel@perches.com>
 <40ca3f0f9a960799ad0e534b77d778c90119e468.camel@perches.com>
 <c4f8aae0-d805-8d09-1a87-ba64bc01c29a@gmail.com> <d44e35ec1d923fd09ea6530ca5d1988cc8e59347.camel@perches.com>
 <0871715a-e605-91c0-ffa5-389a313ec34d@gmail.com>
In-Reply-To: <0871715a-e605-91c0-ffa5-389a313ec34d@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 21 Oct 2020 21:12:32 +0200
Message-ID: <CAKXUXMzdjV8aPL=Paf2QJs1iWB5swxYXFJozyPi_JxJVXRArxQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: fix false positive for REPEATED_WORD warning
To:     Aditya <yashsri421@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 8:25 PM Aditya <yashsri421@gmail.com> wrote:
>
> On 21/10/20 11:35 pm, Joe Perches wrote:
> > On Wed, 2020-10-21 at 23:25 +0530, Aditya wrote:
> >> Thanks for your feedback. I ran a manual check using this approach
> >> over v5.6..v5.8.
> >> The negatives occurring with this approach are for the word 'be'
> >> (Frequency 5) and 'add'(Frequency 1). For eg.
> >>
> >> WARNING:REPEATED_WORD: Possible repeated word: 'be'
> >> #278: FILE: drivers/net/ethernet/intel/ice/ice_flow.c:388:
> >> + * @seg: index of packet segment whose raw fields are to be be extracted
> >>
> >> WARNING:REPEATED_WORD: Possible repeated word: 'add'
> >> #21:
> >> Let's also add add a note about using only the l3 access without l4
> >>
> >> Apart from these, it works as expected. It also takes into account the
> >> cases for multiple occurrences of hex, as you mentioned. For eg.
> >>
> >> WARNING:REPEATED_WORD: Possible repeated word: 'ffff'
> >> #15:
> > []
> >> I'll try to combine both methods and come up with a better approach.
> >
> > Enjoy, but please consider:
> >
> > If for over 30K patches, there are just a few false positives and
> > a few false negatives, it likely doesn't need much improvement...
> >
> > checkpatch works on patch contexts.
> >
> > It's not intended to be perfect.
> >
> > It's just a little tool that can help avoid some common defects.
> >
> >
>
> Alright Sir. Then, we can proceed with the method you suggested, as it
> is more or less perfect.
> I'll re-send the patch with modified reduced warning figure.
>

Aditya, you can also choose to implement your solution;
yes, it is more work for you but it also seems to function better in
the long run.

Clearly, Joe would settle for a simpler solution, but his TODO list of
topics to engage in and work on is also much longer...

Lukas
