Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764C82DAE0F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgLONe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgLONeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:34:03 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69742C06179C;
        Tue, 15 Dec 2020 05:33:23 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id v22so20995556edt.9;
        Tue, 15 Dec 2020 05:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DwitwfTtwjBMbHFgPhiZUy9rSg/91bxVwR6kPXtgAFc=;
        b=nm1UWzFOC+Yxsb//GqZrsXLF7Z/WAafLbOMVXUuVQGYnkUICQge0B3jVp150UwU8qA
         8GqegEIXeWUKk2UO7MxXVJnkgt1egzAGWRyatQFRv4R0eugRMOs/1ylk8SzQAJaLNgkZ
         sysl3I6zMD7M34AnPbgOLWbqsaSCXfBgxfiyYOENyKZ9gHCiKOTTKPqNWYtpS8IQ4DfS
         1TfeH5qJNwIas5/xMuAx6JILrXnJBNWsv1HJc/xBDQTI1xTzw2+O6sFwwnG75UmauoNL
         CUp3MnMakKAskxg2AtgAMbMCN/CLA/0Y84GlCqM1FhaXNARyEAyZrc/qUVWmNCUhb4Wi
         kPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DwitwfTtwjBMbHFgPhiZUy9rSg/91bxVwR6kPXtgAFc=;
        b=mW1I9KLzWlbZMk226kIK+iT8OP0FQiIqrCN4mC+WK2r6XpUrauoMNGswX1FVvd5cxY
         Foy3P/1mjqIsLRzjILO8nYPpijNizg/FcZ5ulJkBhJSeION5OfHs4OqvJCiK1tLRKLFU
         pKg3+tXsvfEU1cmnATQpkoQ0lGazOtrnwugQwBtGSIJUejYCt2u2dCu6JFTTOz+7jJ9y
         t8SHPsd3QGi4ZQNUeChOJwp3ERQM1zn0icjIozmWvtl4D3tN3HAH5AS3wIOrqY6eOm8j
         n6g4fJTITlkYrAWPZgxbzRjv3yXXI8I++yk8QfM7Db70tXsV7H1S00pypn4CreiLVJln
         bdZg==
X-Gm-Message-State: AOAM530LQ6gTju5auLRXAeOFA0uT86R+t4uovVsSUOGt/kopyAFCzsea
        dfnTsMgTdw0Tt9PKycocy3B66ZFNtaa+4B5tUjU=
X-Google-Smtp-Source: ABdhPJxUqoXfAC8kw7FI3HL0zpok8Mtz3fMXJr2XZrZcCgq5QJAeD7Yk+h9KidqBFixlZ0Knxjnfrfy1nRHOvKtoqUk=
X-Received: by 2002:a05:6402:1a2f:: with SMTP id be15mr29728784edb.209.1608039202182;
 Tue, 15 Dec 2020 05:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20201214225851.23342-1-adrien.grassein@gmail.com>
 <20201215130622.GD4738@sirena.org.uk> <CABkfQAEAe0XGj16CkmH7xMNxgdQ+SRq0BYzvP+V5PdDqVbyAAw@mail.gmail.com>
 <CAOMZO5A_Gtwn=AFwJXf_wpC4k902Hg=tCMWpcFUGNWOg9me6_w@mail.gmail.com> <20201215132400.GE4738@sirena.org.uk>
In-Reply-To: <20201215132400.GE4738@sirena.org.uk>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Tue, 15 Dec 2020 14:33:11 +0100
Message-ID: <CABkfQAFNQv3nfoyC2=Un1VWdWh7bbC4RukT0DYLChk0=K2_K8w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add support of nxp pf8x00 regulator
To:     Mark Brown <broonie@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just cloned the linux-next repo.

I will try to fix things Mark tells me to fix on my own driver.

Thanks again,


Adrien



Le mar. 15 d=C3=A9c. 2020 =C3=A0 14:24, Mark Brown <broonie@kernel.org> a =
=C3=A9crit :
>
> On Tue, Dec 15, 2020 at 10:20:02AM -0300, Fabio Estevam wrote:
> > On Tue, Dec 15, 2020 at 10:16 AM Adrien Grassein
> > <adrien.grassein@gmail.com> wrote:
>
> > > Could you please tell me where this driver was merged?
> > > I checked the main kernel Linux and I can find out this one.
>
> > It is in the linux-next tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/drivers?h=3Dnext-20201215&id=3Dd3795d6321ecaa55d94dc24c3b1e3cce608aabd6
>
> Coming to there from my for-next branch - it's also already been sent in
> a pull request to Linus so will hopefully be hitting his tree soonish.
