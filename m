Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE4E2A46EC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgKCNwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729362AbgKCNv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:51:28 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D44C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 05:51:28 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id x11so6860663vsx.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 05:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dyUYOcjllfFZt74DfN+Csqx5pBnDAf0Ujg4JJ2J6DWI=;
        b=D3+1Gx4Mvug++MFnpMZ6W6WrP9GjI4Nnkl04l9thXx4ygrWTuubcyof9vR8jiJby3Q
         8g51nnx6Z9IPk4/2BH1aQdup5vDm0qu/uuhQhgRnM5oVyBYq3wiAw+REqhgxxCeGyYwP
         z+h907vWorEpf/kGXyXGcojoQyJwo9OBt+1e5uC7LbwaYPzvvl7CSS5MNUrUbAJIRqsX
         cGWoX59Obqcs4W9Y/so6Sruw6/PsRm3GJjoS6sN7PRfX20Si9tI9ZDxlRRg3m870wzZE
         f6NwnAASZuQk1Zx6KWiX/DAi+OEiSFgClfXkiN4I9ktJl05cJ88JYY4urWZGkgASmgSC
         UWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dyUYOcjllfFZt74DfN+Csqx5pBnDAf0Ujg4JJ2J6DWI=;
        b=n5gl9IN/+m6vFHJwD9h9dGRGwS9WOSZqOPVgrGPPZpS4r75d2+povUFX7cql4mAPVI
         C0C4v0M/yXllStJYoHym05RpPanFyQyPAq4MVCyONyotnItlulpMHB9a/eU3wEiArZVH
         OlTka+zwWdHwIfxmBBJ8dxZX6FlLaPwN36z3S3bCL/+b6/XKVNPg6W/nm6ckuC7AlAP6
         YyUG0jyZbLQfiqx3ptOXuVS375siPC3VcsSL9tJs+KeNqvhPGVg5CtGeLv77lU8q4EpU
         TzmNWBFPnFs+wNi7IqPzzYekUHcQKmrW3XaywJCmlSz02uz58ki5UwUQt/VWlCThpeqO
         1h3g==
X-Gm-Message-State: AOAM530DiRw2lEChtf2iYpX2UDgzPmhVgFzdv3c90afndvljJm+4k+/5
        /Kt53Fabx0dLGLi8LMMIIFYdOK1R+Ck=
X-Google-Smtp-Source: ABdhPJzTQusjY0zPuq0HZlC8DACjDTVxV3ojN27BZFn20Lt6lbczkaKoskrWQIqm44Z7QkRGPWLwBw==
X-Received: by 2002:a67:1644:: with SMTP id 65mr18920203vsw.41.1604411486364;
        Tue, 03 Nov 2020 05:51:26 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 102sm2055814uan.14.2020.11.03.05.51.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 05:51:23 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id t8so6668007vsr.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 05:51:22 -0800 (PST)
X-Received: by 2002:a05:6102:240f:: with SMTP id j15mr8193952vsi.22.1604411481813;
 Tue, 03 Nov 2020 05:51:21 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR18MB26799492A423DDB096B05F45C5110@BYAPR18MB2679.namprd18.prod.outlook.com>
In-Reply-To: <BYAPR18MB26799492A423DDB096B05F45C5110@BYAPR18MB2679.namprd18.prod.outlook.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 3 Nov 2020 08:50:44 -0500
X-Gmail-Original-Message-ID: <CA+FuTScjywqryEsqtj6EcRcZWbUqYZ+CBQRGtcm_EXuTOT8j0A@mail.gmail.com>
Message-ID: <CA+FuTScjywqryEsqtj6EcRcZWbUqYZ+CBQRGtcm_EXuTOT8j0A@mail.gmail.com>
Subject: Re: [net-next PATCH 2/3] octeontx2-af: Add devlink health reporters
 for NPA
To:     George Cherian <gcherian@marvell.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  static int rvu_devlink_info_get(struct devlink *devlink, struct
> > devlink_info_req *req,
> > >                                 struct netlink_ext_ack *extack)  { @@
> > > -53,7 +483,8 @@ int rvu_register_dl(struct rvu *rvu)
> > >         rvu_dl->dl = dl;
> > >         rvu_dl->rvu = rvu;
> > >         rvu->rvu_dl = rvu_dl;
> > > -       return 0;
> > > +
> > > +       return rvu_health_reporters_create(rvu);
> >
> > when would this be called with rvu->rvu_dl == NULL?
>
> During initialization.

This is the only caller, and it is only reached if rvu_dl is non-zero.
