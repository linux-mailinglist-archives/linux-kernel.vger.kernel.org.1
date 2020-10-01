Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F6B2802F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbgJAPg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbgJAPgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:36:47 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F8EC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 08:36:46 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id z26so5993608oih.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTRcLiitCGxtErYo95DQsuhS+3OUv5XK3IV763QSggk=;
        b=eAIryjrGkerzMGunb1ZsmgjTEM6lxDD9ynZkPH6JSZRoOCVtbiBQ9lnOdtK1vRhDda
         iV2Uwnxf7YD4ZzGTXuc1D91QRjfrGEmJlykSRyYduyZ7LvfCLRWNayoLerQVmPpV7XLI
         ZhNj8NBOmSJPfd89OtYYnxCdzkKyxsoILt0Y1ZCcujnXmQqqBB/zRbTszNS4gGeGsRI7
         LsmSikTfFgOXC+HBrTsOkmJbCwFguMFRbV8oeWtcQ59XmYERg9oTjo3HiXXgJ5IOhJH1
         YPN2NYuAaSh0JvTQmMBXmD0q1YndiHnf62j0WZYkOXUI2n/3JxMf57CMFilRWJKLj8oB
         DbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTRcLiitCGxtErYo95DQsuhS+3OUv5XK3IV763QSggk=;
        b=IF6Ct0Fa0Fzpescdu8mBUl8HHa+k1Cbd4MUarTeCMTDx89GFIV92NK+vZHwU4huetk
         oiMkzB0X2RdxPGI6GIDrTkvgJcdGsSDaHJmhOSeZ6D8cIPz6MVDvbl2Fpe38sMzlXH9a
         TOo0OgX3jQLGtb5Z2hkjH3r2/+XLeuWhD5d8KbkIjIIr119opjc8SmdF88nmv+t/mgmR
         1NiI8WyB0tIg7GeOFvFMRSETRnRduCwehNifwzYv3Rmg821cVaeIaZLAQ2z4ap0zksid
         JJVXOcv6rsWi+E0YJbT+VaQZ1TpJh5xYePgGNelI868LaPWEY6u4cD6p0UKm7B2BVx1g
         t9aA==
X-Gm-Message-State: AOAM533jAYdmVeYGo5EPg9jsqLu/TYwQLGgPsB1IePuxpa1y6p+ortGR
        KoVuKXGmZQCTdYsGtnj2h7lmI0u9ADB+3yQ6VRcNPbQ0A4OJkQ==
X-Google-Smtp-Source: ABdhPJxpPLsfUZNUyhh5FlvHaLwRFS9ey7i+2W4qyQeVK5y8yLqt8zz98x9DwIGkY+BvHmS93cOgBJdKSmLm0uUu3cU=
X-Received: by 2002:a05:6808:6:: with SMTP id u6mr347726oic.74.1601566605366;
 Thu, 01 Oct 2020 08:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201001103314.136645-1-dwaipayanray1@gmail.com>
 <8e110121c89414ab1601071868dbcf410195a209.camel@perches.com>
 <CABJPP5CFE3KXzMzuvVxtJt5tOg8Ye6y1V7-mqT5pqazHjVWvJw@mail.gmail.com>
 <f3dadda8af7eef6613d7a4105170058f2759507d.camel@perches.com>
 <CABJPP5AM01voDwARL4G0vMhFw4hMY+=dEQ7=obiKPzNtunyb7Q@mail.gmail.com>
 <361bda20762efce0e374bd2ba7c82d1c64628a67.camel@perches.com> <dc985938aa3986702815a0bd68dfca8a03c85447.camel@perches.com>
In-Reply-To: <dc985938aa3986702815a0bd68dfca8a03c85447.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 1 Oct 2020 21:06:22 +0530
Message-ID: <CABJPP5AvdWDJP1mkpdk_y-OVQnJb7utC3qCqOn=vP93DC7QwGg@mail.gmail.com>
Subject: Re: [PATCH RFC] checkpatch: fix multi-statement macro checks
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > All I'm trying to point out to you is that $Constant\s*$Constant
> > isn't a proper test as the first $Constant will pull the test
> > entire sequence of digits and the second $Constant will not be
> > met.
> >
> > It may take some conversion of the collapsing of the dstat
> > block to work appropriately
> >
> >
> >                       # Flatten any parentheses and braces
> >                       while ($dstat =~ s/\([^\(\)]*\)/1/ ||
> >                              $dstat =~ s/\{[^\{\}]*\}/1/ ||
> >                              $dstat =~ s/.\[[^\[\]]*\]/1/)
> >                       {
> >                       }
> >
> > Maybe the /1/ should be / 1 / but I didn't look to see what
> > happens to the exclusion tests below that.
>
> I think your patch would work well enough if the /1/ bits
> here were simply changed to /1u/.
>
> 1 is a $Constant as it's just a number.
> 11 though is also a $Constant.
> 1u is also a $Constant but it stops the acquisition of
> digits that 11 would not and the sequence of
> "while1u1u" should match your newly introduced test
> of $Constant\s*$Constant as "while11" would not match.
>
>

Hi,
That's an amazing idea! I tried it and this time it seems to
detect it properly. Also this fixes the similar case in
for(...) {...}.

It should not have any side effects also for other checks.
Pretty amazing.

I will rewrite the patch with your suggestion and send it
back.

Thanks,
Dwaipayan.
