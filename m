Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2512B266711
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgIKRhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIKMuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:50:00 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992E9C061756
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 05:49:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g4so11375545wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 05:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nWbc4yMI9H7bl97CVcSxQv/EwnVj0ipCdrn8uq6XpTE=;
        b=ZhF6FLOxM6x7I7r0tgZIcmqTW3FgLmQpAWreu6Oijs+tt1JDiTN4xtO7gS09FKoB6s
         EEYVj7HbEIGTUtbiNnMv+MJFArYQN2vqI69IYqhzMjQCcikIpz3g7KdgI4fJ7czvczEa
         Z23sitHp3PUt/TfvriiI8vSjX1VBgfLlnLZ9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nWbc4yMI9H7bl97CVcSxQv/EwnVj0ipCdrn8uq6XpTE=;
        b=KuqqOf3cA2V/2HnN4BFBc9qdsPsSn+2EhAratfdWlFshpenh1Y//6OprgIsM+4hRoO
         vk8++yTnfhgZ3+S6JGg0Uj2Z6gVxXGb5FauAP5vL4mCdmiYyvxX8BjXcyI8Zc/c/WoCw
         zRdmUm0Q1dW43bRz6v4SM5oI917ietH2nZ3YO9qZY1cLOLoFn+/oNjsVqSGv8wV94QB7
         SKyG6MkILtPmc5r0DHa4foIBtymPwCkEYOEpe16xnrh+vtBzQR8XZ9Y0z6ostebg+PLE
         tQFZf3DYauCyFGlMPGCoHRpMpvQjPV5oy5kd3uIT29HoRKd1ukWeCbHaB0JkQnNFXcYo
         HkWA==
X-Gm-Message-State: AOAM530Dl+U2LKqwuEUQ8ZZVYtufNIkqblgbAokcMimsPJLtjn+SFrqY
        cW95PJypcd6OeT9E5FBeHQQYM6hw5U694PEkPVmF6w==
X-Google-Smtp-Source: ABdhPJzU5HHpYZ8aksLleECyLkPPJqWQEXktBFbiMMFXDO29AEh31KF19A1HSjNHai2b4blpPhdazL9YED11Fp9K+Y0=
X-Received: by 2002:a5d:4bcf:: with SMTP id l15mr1918848wrt.384.1599828598125;
 Fri, 11 Sep 2020 05:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <f79159af-4408-dc2f-6efa-45c5b45cf2d9@web.de> <CAEYrHj=pfGB7OuHt90t2aaawr31W9XZCHeHJurt3o0rK44jZ+A@mail.gmail.com>
 <59440849-23b1-9c69-ecf6-78f8a0b82c7a@web.de>
In-Reply-To: <59440849-23b1-9c69-ecf6-78f8a0b82c7a@web.de>
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Date:   Fri, 11 Sep 2020 21:49:46 +0900
Message-ID: <CAEYrHjmsd4Sp2R54y55pVL3CXr1KXedoBnTEczCBkpE9+SsFNg@mail.gmail.com>
Subject: Re: [PATCH] qedr: fix resource leak in qedr_create_qp
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-rdma@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Takafumi Kubota <takafumi@sslab.ics.keio.ac.jp>,
        Yuval Bason <yuval.bason@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
thank you for the comment.
I will fix the line break and re-post the patch

Thanks,
Keita

2020=E5=B9=B49=E6=9C=8811=E6=97=A5(=E9=87=91) 4:48 Markus Elfring <Markus.E=
lfring@web.de>:
>
> > I will re-label the goto statements and post the patch as version 2.
>
> Thanks for such a positive feedback.
>
>
> Another suggestion:
>
> > > Fixes: 1212767e23bb ("qedr: Add wrapping generic structure for qpidr =
and
> > > adjust idr routines.")
>
> Please omit a line break for this tag.
>
> Regards,
> Markus
