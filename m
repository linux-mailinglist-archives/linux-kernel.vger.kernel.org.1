Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513792BB255
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgKTSVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgKTSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:21:07 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7CEC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:21:07 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id k7so5285019plk.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=z57Wr8DH9BlC/Qe77qam1fPDKnckrZ20gmU4aNfz0xw=;
        b=iM8ncfLX0KgbORCi3DAs6OCEBfV1IkEbs3JYjXFbbSK67PH18FGG/fgkur+7PonVId
         irV6MfiK7gnrjX18hw8PLLxYYYQoXG8xGvdaATA7WodBlpJ+5UzhggjnuusKi2MxdL1P
         faJLAbvboPKw6hKPOR7papt0PmWMAtRwnuyX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=z57Wr8DH9BlC/Qe77qam1fPDKnckrZ20gmU4aNfz0xw=;
        b=ng4LUdKMHlCfjHEYpeA9iTwCWq5Z+P0fC593zxy0Zx1St+qKgwvW3E4o5z2j5EoVzQ
         BdgFMRiwyP9tz5f2q7VFNp8A4jjrbhLHgjgXQ6p6Yz/d6fWHRinLnWKVvpaJXGYtG/kH
         SqMtCximgKNu+4cpPXil2aAXugS4gKCqsE8KVRavevatKdAv90mDthkNGKIa1piS/v3N
         i9PiV65d24JqYZtf3qrk+9/cU7Aa2iLujskT/Kh2VJdZmJLvnPsRE/yCGoJMOFEO6JFT
         h2P9l6HN6DWt5ChypPNsF/M+YuxQwJfgI3Wql3qCZu9dvZtqgaoJsaslAUv33ltKZy1A
         1r9A==
X-Gm-Message-State: AOAM5326hXbjR1elmLU29KTtTnMTBm/wMf6hoEN6QHe4sSUmhvHERee/
        PDB/aENa8UX7gr2FOQcWFq9neA==
X-Google-Smtp-Source: ABdhPJzNTshQS5bLT73HPE73invTSxue9XswE5YAY4s2fpE0SJ6tzet022K9Lc9J2/KfxvjCyhXgHw==
X-Received: by 2002:a17:902:6943:b029:d6:bd35:c84b with SMTP id k3-20020a1709026943b02900d6bd35c84bmr14696252plt.53.1605896466813;
        Fri, 20 Nov 2020 10:21:06 -0800 (PST)
Received: from chromium.org ([100.99.132.239])
        by smtp.gmail.com with ESMTPSA id h16sm4015852pgd.62.2020.11.20.10.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 10:21:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=Ue_fjEPv_S=21=Mq8cCzo2FOVJB+Y0vzT1jyehsQzDZA@mail.gmail.com>
References: <20201120073842.3232458-1-swboyd@chromium.org> <CAD=FV=Ue_fjEPv_S=21=Mq8cCzo2FOVJB+Y0vzT1jyehsQzDZA@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9310: Fix semtech,avg-pos-strength setting when > 16
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Nov 2020 10:21:04 -0800
Message-ID: <160589646471.2717324.9945709609037099045@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2020-11-20 10:16:28)
>=20
> Checking the math for the documented possible values of pos.  What we wan=
t:
>=20
> 0 =3D> 0
> 16 =3D> 1
> 64 =3D> 2
> 128 =3D> 3
> 256 =3D> 4
> 512 =3D> 5
> 1024 =3D> 6
> 4294967295 =3D> 7
>=20
> So looks OK.  Do we care about anything other than the documented
> numbers?  If my understanding of ilog2 is correct, then you'll get the
> wrong answer for 17.  I think you could fix it with:
>=20
> pos =3D min(max(ilog2(pos), 3), 11) - (pos >=3D 32 ? 4 : 3);
>=20

I don't think we really care about the rounding but to be consistent
with the first two it is better to do that. I'll send a fix.
