Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972C62A5F18
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgKDIFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDIFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:05:33 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8B7C061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 00:05:32 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id gn41so11170112ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 00:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WOMWgWeotGz02y1OCfCO5T8Q2arx3bVYsMb8EgGzCd0=;
        b=Z+9tP6RkBdXk6Y9IAMjDbheni5BJGFSxnMW1CYuoCFshL+vNCol7lWuRRcu2ZC+KSL
         IgX3AFo+rJOAVJDrQCs93uvGXR2PhahaS4YfyiH1n+UyneYInQqvvr7aGHyDrxvlpnXt
         9Uj2AKe+fXTaFFQcKhlXdoZMGolTL+LJ0Do5wUAkOsYcYyqJNWUGxKh6mBk/ey+eItGD
         kNYMtgoBT+ZK/mQGn60I5PImqFytZ2+DoWoLA6E+U+4wkwd6Dg6slx4xblQsfcPtSNmV
         ZvG/rMTuJ4GtXL2LcxCdqPxAglYJamwXxpTt2Ip2YqO5tqS7gKx0Rh8BGDYMQEzkl02v
         ligw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WOMWgWeotGz02y1OCfCO5T8Q2arx3bVYsMb8EgGzCd0=;
        b=VzDuia7fTJx/D1AZ++QgaY61aHYPnQdDgASh7SDJIO2xp86Z0ycecLGLfJ7PIsRQOk
         Mfc+/tZHB+U46sXqlcQ9H50op0wDUcfrOkfGO+vXvzEOUhy5kHxEvU1UAZlcZCJFnHF1
         flV8G1g/OUVk1lNOkIrHunt9sm7s2HxPCLAqMYaug2f8cn1+Xk1QVIvhAsfUUGoDlyQB
         jrIIPyRQsIgXX7r3kbamRcNz+SZOoXxZR9MASua3XQd8lMP4ZhjM8Ap5lyhMsFFhjEQL
         rOXijVYGRsO7rquAe+y3uK154HyR+ba5vuKgL6QeCoa45Nnc11hSUZdR9az2n/ydut0S
         5IFQ==
X-Gm-Message-State: AOAM530msDhen5nGbPY9TJoioh+MpA8XbP1r/aVPStg1Ejm9tjo98Oew
        AVlgmuRhEGzJQNOQkF2PrEg=
X-Google-Smtp-Source: ABdhPJxTbSkVnGzrsQoq6aStC7vkS1i2BKZ221hDwgKBN4UWOkeEKpRv88hGHOzEX9DlA+9XVYZs+Q==
X-Received: by 2002:a17:906:3087:: with SMTP id 7mr23586689ejv.375.1604477131554;
        Wed, 04 Nov 2020 00:05:31 -0800 (PST)
Received: from felia ([2001:16b8:2df3:e100:d1f6:5677:9c1c:230a])
        by smtp.gmail.com with ESMTPSA id a1sm603607edv.88.2020.11.04.00.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 00:05:30 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 4 Nov 2020 09:05:29 +0100 (CET)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aditya Srivastava <yashsri421@gmail.com>
Subject: Re: [PATCH v2] checkpatch: improve email parsing
In-Reply-To: <6c275d95c3033422addfc256a30e6ae3dd37941d.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2011040848420.21917@felia>
References: <20201103054810.21978-1-dwaipayanray1@gmail.com> <CABJPP5DkJ3gwZDW+FBShs3Yo8z6GfP4LSMRW4hO5hL+fVXjShQ@mail.gmail.com> <e9d540c35ac04f0bb69e26d29c76c7cbd5693df8.camel@perches.com> <CAKXUXMwH+tEBSV6xA952xQQFe+HvdJ5ew6V=n63sk89enj6p7Q@mail.gmail.com>
 <6c275d95c3033422addfc256a30e6ae3dd37941d.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Nov 2020, Joe Perches wrote:

> On Tue, 2020-11-03 at 09:10 +0100, Lukas Bulwahn wrote:
> > Maybe you can coordinate among each other who would want to create
> > suitable fix rules here?
> 
> Yes please.
> 
> > Also, start with the class of the most frequent mistakes for
> > unexpected content after email addresses.
> > 
> > I imagine that a maintainer can simply run a tag sanitizing script
> > which just cleans up those stupid mistakes before creating their git
> > trees or sending git pulls to Linus.
> 
> Does anyone really do that?
> It generally requires rebasing or post processing each commit after
> being committed before another commit occurs.
>

As far as I know from private converations, some maintainers do have 
early testing branches, rebase those, squash commits and hence, they 
might also sanitize the 'commit messages' if it works reliably; but I am 
not a maintainer. I guess we implement something useful and then ask some 
early-adopting maintainers to give it a spin and get some feedback.

> > Let us try to add these
> > sanitizing rules to checkpatch.pl with fix options for now; if that
> > sanitizing feature becomes a monster script of its own within
> > checkpatch.pl, we can refactor that into an independent script for
> > cleaning up.
> 
> I rather doubt an independent script is going to be worthwhile
> as these rules shouldn't be all that complex.
>

Good to know. Okay, so let us add the rules and corresponding fix options 
to checkpatch.pl.

> The only prefixes acceptable for a stable address should be
> CC:|Cc:|cc:.  There are 2 uses in the last 100k commits for
> Signed-off-by: and Acked-by: with stable addresses, those should have a
> message/warning emitted in the future.
> 
> The forms used with those cc: stable addresses:
> 
> 2777	stable without comment
> 1381	stable # comment
> 74	stable [ comment ]
> 
> So I suggest standardizing on no comment and # comment with any other
> style getting a warning.
> 
> For non-stable <foo>-by: and cc: addresses and other signatures:
> 
> Likely any content after a email address other than a parenthesized
> block should have some checkpatch message emitted.
> 
> This should be OK:
> 
> Signed-off-by: Full Name (comment) <address@domain.tld> (maintainer:...)
> 
> But perhaps this should not be OK:
> 
> Signed-off-by: Full Name (comment) <address@domain.tld> # comment
> 
> There are 316 uses of this # comment style in the last 100k commits
> and 103 with (comment) after the address.
> Maybe the # use should be ok, maybe not.
> 
> And anyone that uses a multiple comments in a name or a even
> a single comment in the email address should also get warned.
> 
> The below should not be OK even if actually valid address forms:
> 
> Signed-off-by: Full (comment1) Name (comment2) <address@domain.tld>
> Signed-off-by: Full Name <address@(comment)domain.tld>
>  
> 

Thanks for your evaluation and hints.
I agree with them as well. Let us try to establish one common way from 
comments.

Dwaipayan, if you code this into checkpatch.pl, maybe you can also add 
some hints on conventions for tags in the kernel (process) documentation 
to explain the rules and conventions we think make sense.

Lukas
