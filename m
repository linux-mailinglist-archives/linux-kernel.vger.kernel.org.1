Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5772B1E45
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKMPIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMPIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:08:40 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BE8C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:08:40 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u18so14245176lfd.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGwVdhfGcvEmkdbFGAAQ61slya8H21zM/TxBTsp4bmQ=;
        b=UKA/i/yaQnCfreh4DHUnB2gEWyAePwkaJJ7TD82bCeCH4H57HZbdwoNhNH91isW+ib
         bS+NW4a0xgX2xSkWCAxCvMX6spK+zyDmVPeL+hQRDs6VRoJbVnuNmwCU/ZvzAtK67jwa
         Ds3tQghul4J/kI83FXV8MFiwCxNgMPCKGCck30j76vKCuST5Aj7mxJZNWrb+toIlrXGa
         kz+/LeHVJvl/YlpxTupN5DWZnuxL/lnlAvS+xxg0bZnMZiGiiGz7kksRQ5Ba2u1513bV
         l/v3R4HAkA+PWPuYpLnJnoHCv+Xkhv8tjdnXS1ffMVlL5k8j03nMaLv6SLjlkxtwsF82
         Hspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGwVdhfGcvEmkdbFGAAQ61slya8H21zM/TxBTsp4bmQ=;
        b=k6CPsHbKzu4aqXigH4gWg8uvpG5HEMjg3lgIxjhkaRb8MCSepF4wsNDOZUhQMpn/Je
         Ikl1r9xZ8ei+5w+nFCwqZA5ILxg59qecuDa4iuHdn/UxqFQIdC2cAMuf1jq+42rv26VB
         VJSYunaWiDBtakIe0MaFLFIn/OAKwFJQSjOt0I5ivhpnyzpQ7YqQWUqgCiq0BaEJcH+k
         XsyXKpJGzVkkiTpICIGVslnwhYjNkZtk/hhYbJJYC+Kr023TcLSyaA22TX8KFvAnYMIJ
         WTfnIaeA5slLHTEZr098/U3iz/DIXZiH/LPuP858ONTMbJeimstnzeJ6xSy0WUoU3yOX
         5PyQ==
X-Gm-Message-State: AOAM531S/5hpfjNXwP4R7yftF89OL7zF+8I4XT2lUCzqEq2VSzWVxDkI
        SYWCY1kmNZiDCrXNXZZGpL/gCuPa6nK19A84GUY=
X-Google-Smtp-Source: ABdhPJy6mLMMN5UtXzcyMwT25QN7J5QiX3HYzjM1FDbL76I9MMKAEc9dxKmj/EVkK/dlyTMJXgxdvbOIIqS3VX4K2z0=
X-Received: by 2002:a19:4890:: with SMTP id v138mr1059175lfa.254.1605280118638;
 Fri, 13 Nov 2020 07:08:38 -0800 (PST)
MIME-Version: 1.0
References: <20201113135739.46776-1-dwaipayanray1@gmail.com> <3a0455c93dfd6749cf2050dd973c5bee1cc9f237.camel@perches.com>
In-Reply-To: <3a0455c93dfd6749cf2050dd973c5bee1cc9f237.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Fri, 13 Nov 2020 20:38:07 +0530
Message-ID: <CABJPP5AVgXLh5-JmBX_hSjtP35ATHUR2T4Rt7pFhM+aZ0KmktQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: fix typo and remove duplicate word
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 8:30 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-11-13 at 19:27 +0530, Dwaipayan Ray wrote:
> > Delete repeated word in scripts/checkpatch.pl:
> > "are are" -> "are"
> >
> > Fix typos:
> > "commments" -> "comments"
> > "falsly" -> "falsely"
> >
> > Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> > ---
>
> style: this should have subject prefix:
>
> "[PATCH V2] checkpatch: Fix spelling errors and remove repeated word"
>
> And here below the --- line you should add a V2 changelog like:
>
> o Add correction for falsly
>
> Other than that, you might consider sending a V3 just to get
> used the proper patch resubmission form but thanks.
>

Thanks, I will do that.

Regards,
Dwaipayan.
