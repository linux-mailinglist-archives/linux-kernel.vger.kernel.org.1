Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895772DB511
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgLOUYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgLOUYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:24:24 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274CFC061285
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:17:45 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id cm17so22461920edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p4IfDAsFT+1pIweofB2DvGvloM8Try3h+0NfT8+jEF4=;
        b=C0PuUe/yOGU0mFP0Q7Hd/fulYcJnz3YUWU3oGj9Ijlu+B7gWdx+DC2ZRGgv5gptgBL
         dEF6fUtRL+ct2AWOHyvvZaVUhMMiynSRYeKu2+61ElyQKgjq3YIDAeFzSo0F+Ty9tlxw
         z4OYHYY+gV3IrIpl55U3TnYK9JUppntdjCB5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4IfDAsFT+1pIweofB2DvGvloM8Try3h+0NfT8+jEF4=;
        b=TrEeJrm9m0dStZiSNN8cFUA8UaJ0H6y2c+xlmqIQrwImekNtW2cidsDar2JVIhsGaa
         CtMKERTHWh6qRPs8zT1xvSGuESk2DzYWevQ/D/wjQSzHoDmaNb4+KGDrwRBZst0Q4mi7
         b+tMjdifXTi0+ulM8WrEiDZakA0KUy44gOU74FOEjE5Fnxdb1Xcq/R+dCCeLnzYayj4R
         sVmCK5JAXMWtwp6/yzj4c35CcTqBCdpRmo/2aeTZ0DIQNDC+DnTSpxTsV30nbN9yG5HO
         0IY/lbECxFCEL4WYhj6Eeno9yTnk1A3FaJaoUKeCFSnBLlVzob21zQN2AoSH6N26XdMc
         LqNQ==
X-Gm-Message-State: AOAM533XDwCEoBRboo9zyoNpmDKpaeX7P7PypPPCTlXbo46ZcUB6Uib3
        ydT1zWtg3w/1s3lg88SdRKIEjrlfOZr3VhedfyGlgw==
X-Google-Smtp-Source: ABdhPJziZIKr6/+fuDejYAesDr2tpqYBDCF5FBi5/xYYKJGEjfXIuVzMPP/E8UAUlxkY5OKE6Xm4GPxMe8ioVMuV0yY=
X-Received: by 2002:a05:6402:2041:: with SMTP id bc1mr15589729edb.369.1608063463836;
 Tue, 15 Dec 2020 12:17:43 -0800 (PST)
MIME-Version: 1.0
References: <20201214225851.23342-1-adrien.grassein@gmail.com> <20201215130622.GD4738@sirena.org.uk>
In-Reply-To: <20201215130622.GD4738@sirena.org.uk>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 16 Dec 2020 01:47:32 +0530
Message-ID: <CAMty3ZB1SPVwU_GA8PCYgrrPExLfjj+koij45evzef5BYQrAmw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add support of nxp pf8x00 regulator
To:     Mark Brown <broonie@kernel.org>,
        Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 6:36 PM Mark Brown <broonie@kernel.org> wrote:
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

Sorry, I'm unable to understand the pharse here.  is there any issue
with the existing patchset?

Thanks,
Jagan.
