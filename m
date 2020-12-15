Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B2A2DADDE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgLONPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgLONPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:15:15 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF14C0617A6;
        Tue, 15 Dec 2020 05:14:34 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id ga15so27605747ejb.4;
        Tue, 15 Dec 2020 05:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mv8PeOrcfK/msUcUWlX+I7EMcnD/0TTIDrC/nTcaRwk=;
        b=acoN0lkkxRDrJ2MhS+T7pMghrhbE72m6fH46Ka6gAdWAWdzXhqJfuYo6ct0LzBbmgo
         265yBe5XQq2Gj37IrDw99vcrXxmBycCf1NwZlW4lrCmgCUGqVZL6WhDJdfPqVug244LL
         DeyNY4gF4hUAE6UtjvDsBghm+TTsvf/Ri7yxfCf9Aqjk2Jnp3b/Mbv4Z/RkTyPnhzQid
         cK3KdDUhpSrAUhmUt3tjYmlhqAcx83nOs2P3HL5KPClfeBwW2W33BsG35ahrhTFVIBM3
         +e1Rudd4QgrqRYGkjrBjtvfmRxRK47042ZEndRcD6LWtIH85Q5mt65myBFz3pyKYFyOx
         LHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mv8PeOrcfK/msUcUWlX+I7EMcnD/0TTIDrC/nTcaRwk=;
        b=uRzM29cVDqO8ismP64EzDfa3o3v9u3LRa5Qm52aFEcgodm1e4IJd40556pTqowiUFb
         yFdCXYQjLzxbjqj4YxR0vWVWeuq0DdE07OSaFs7Gc6msUR6gDFvY4Am8/H9ockahn7Xf
         eNjstciR7RU+128/CSHXiOl8GvmQVE6aNfF8efUfUndAc32wNFvQ0hnCt25LvJnGbqP4
         OQfryXj2FSlziQ+HAD/hayxakmRKfe7VAZQluIZXiPox6nDwPoY1bJzj8UNUV8EWZYkW
         qJntpKZDFkAuQIYrX/iOSRqjn8xVG5XQVe+RslaMyp7uYcOBbAxZOXsa7gt0ow4H1sPc
         xhLw==
X-Gm-Message-State: AOAM531SlTbtdvWyow/kWhiP98hOccliA3wMair39cyoeKp6x+V0cAi+
        qm8S6ki3pWQBvcAMwnBGuivjrqMsZwngXStv/V0=
X-Google-Smtp-Source: ABdhPJwq346DJ84gtq4kEAbErht/H3gGqWGfg0wF2YshoTnovg8lpk3couRtBc2Fir7zFbyu1sxJossrZBIisaBYZpA=
X-Received: by 2002:a17:906:4d17:: with SMTP id r23mr28106943eju.87.1608038073275;
 Tue, 15 Dec 2020 05:14:33 -0800 (PST)
MIME-Version: 1.0
References: <20201214225851.23342-1-adrien.grassein@gmail.com> <20201215130622.GD4738@sirena.org.uk>
In-Reply-To: <20201215130622.GD4738@sirena.org.uk>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Tue, 15 Dec 2020 14:14:22 +0100
Message-ID: <CABkfQAEAe0XGj16CkmH7xMNxgdQ+SRq0BYzvP+V5PdDqVbyAAw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add support of nxp pf8x00 regulator
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        troy.kisky@boundarydevices.com,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 15 d=C3=A9c. 2020 =C3=A0 14:06, Mark Brown <broonie@kernel.org> a =
=C3=A9crit :
>
> On Mon, Dec 14, 2020 at 11:58:49PM +0100, Adrien Grassein wrote:
>
> > this set of patch intends to add the support of the pf8x00 PMIC
> > regulators. This family of PMIC contains 12 regulators (7 bucks
> > converters, 4 LDO, 1 RTC supply). All these 12 regulators are
> > configurable via an OTP memory and by i2c at runtime for some
> > specific properties.
>
> This looks to have raced with the addition of support for the same
> device by Jagan Teki - unfortunately I didn't register that I'd seen
> other patches for the same driver go past so I applied Jagan's version
> (both look to be based on original work by Troy), sorry about that.
> Could you please take a look at what got merged and send incremental
> improvements on top of it - I do notice that I missed the use of the
> wildcard compatible in there so that needs fixing at least.  :/

No problem for me, I learned many things about trying to upstream this driv=
er :)

Could you please tell me where this driver was merged?
I checked the main kernel Linux and I can find out this one.



Thanks again,
Adrien
