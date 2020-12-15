Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4382DB12F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbgLOQUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730981AbgLOQTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:19:40 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19910C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 08:19:00 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id b24so2399302otj.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 08:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aCkVEQ4DfY7UEiZxhpJyqTIgP64jvnjvzg8WB3+ib4Q=;
        b=fDYN9e7tBQaSyAPOS4Fv588nJRsMBJ9TiTm431rZ2LeTIWgt+LVC7SiKsZe6OfQQ+s
         g6SBv92kZMlmJdD34d0nQZySHoxykZzGUf20FpANe+XRyIVQi6QxAKDhlaDNqSRZEbXk
         aVUioDMG+8hTyrhhMNFRRLlQmmU4jI4AX2LDfAP9Zg7AgUZC6IMRcVYVqdvISDwC4j7Q
         Xjw98qo7liSZKcVvxx7QC+r1D3/5hcNSzoufc5vdGwc3gM5NDGkgss903JSrvmXu4oIO
         U+nEezyydUZ3RDaRpnt4ulTngIiryjyF7UfxVJ684hotdALHK6aQQPvrm3sR980sdwSN
         P7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aCkVEQ4DfY7UEiZxhpJyqTIgP64jvnjvzg8WB3+ib4Q=;
        b=axaeUMIue/lw5LbbrrxGNvjO6hmTX6aA9HfNVB86n0OMD1ZVoqUqXruNJ+r4ZVymyK
         CSe0i5anH80bnQIWWE8vM4dXnc9vH50BTJG+86yxfxEzhhaufxzVepmH5qyg5mwTE2c8
         bQscKKxoAv57VvIr0VACaFas5bnt//zgORpCB0hYq/Pz56khFsjZZWtK/RqaX2OZGUqC
         FTEmIu0XofjJJd6OIV4U4Eff+COJ648akZfSfeMWpCJA6pWI1sWFt2vr9NNRTz9LQn7P
         czVD+o3cQFqWZuwRlyvCAx+hGe2ihuWYulA9k8WW5l9cKQ+RCxAIV5sjzYIJdcO5Owcg
         TQCA==
X-Gm-Message-State: AOAM531yrRMtOG2rVlkTrzSyf/rw6X+rpelr06KZEM5zaKD/cRzpd5Wq
        9LLU67XI/OADscsT4b6k82iQgRvMVlKihe5p65o=
X-Google-Smtp-Source: ABdhPJz0OCQxpufG1tSCB+YfaAwzuotWyePhGP+Neea8fyEu5pwz26NwbvPMEuMpzUrTScWLakssk8wPCu3bud2UyCM=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr24460356ote.132.1608049139341;
 Tue, 15 Dec 2020 08:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20201211155553.GC25974@zn.tnic> <20201215154703.6gwm2ew337pqysq4@outlook.office365.com>
 <20201215155622.GC9817@zn.tnic> <20201215160720.ewce4usgb53pzt2j@outlook.office365.com>
In-Reply-To: <20201215160720.ewce4usgb53pzt2j@outlook.office365.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Dec 2020 11:18:48 -0500
Message-ID: <CADnq5_MSJdrmxNW9jhdQPOZLUdkJtZMyA6FmqjyZsgGHBWoXVg@mail.gmail.com>
Subject: Re: 8353d30e747f ("drm/amd/display: disable stream if pixel clock
 changed with link active")
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Chiawen Huang <chiawen.huang@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 11:07 AM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> Hi,
>
> Could you try on Alex's repo?
>
>  git://people.freedesktop.org/~agd5f/linux
>  branch: amd-staging-drm-next
>
> My patch should apply without any issue on top of this branch.

Can you help me identify what patches we need to backport to 5.10?
Depending on the patches, it might be easier to just revert this for
5.10 and apply the proper fix for 5.11.

Alex


>
> Thanks
>
> On 12/15, Borislav Petkov wrote:
> > On Tue, Dec 15, 2020 at 10:47:03AM -0500, Rodrigo Siqueira wrote:
> > > Hi Boris,
> > >
> > > Could you check if your branch has this commit:
> > >
> > >  drm/amd/display: Fix module load hangs when connected to an eDP
> > >
> > > If so, could you try this patch:
> > >
> > >  https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
patchwork.freedesktop.org%2Fseries%2F84965%2F&amp;data=3D04%7C01%7CRodrigo.=
Siqueira%40amd.com%7C1f7ff595746543f597a708d8a111fbdd%7C3dd8961fe4884e608e1=
1a82d994e183d%7C0%7C0%7C637436445910587407%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi=
MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DPESE3uBZeNjdWtIFRP6l07AyfhASpXCfaZa03l%2FFi6s%3D&amp;reserved=3D0
> >
> > So I did a bisection between
> >
> > git bisect start
> > # bad: [3650b228f83adda7e5ee532e2b90429c03f7b9ec] Linux 5.10-rc1
> > git bisect bad 3650b228f83adda7e5ee532e2b90429c03f7b9ec
> > # good: [bbf5c979011a099af5dc76498918ed7df445635b] Linux 5.9
> >
> > and the patch in $Subject came in in 5.10-rc1.
> >
> > I can test any tree you want me to so just tell me on which tree to
> > apply this patch and I'll run it.
> >
> > In any case, it doesn't apply on v5.10 though:
> >
> > $ test-apply.sh /tmp/rodrigo.siqueira
> > checking file drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> > Hunk #1 FAILED at 120
> >
> > You can push a tree of yours somewhere which I can try directly,
> > alternatively.
> >
> > Lemme know.
> >
> > Thx.
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeo=
ple.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=3D04%7C01%7CRodrigo=
.Siqueira%40amd.com%7C1f7ff595746543f597a708d8a111fbdd%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637436445910587407%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DkiGm0%2B2d2nXiEwUs0omOYv3ZtyfwTtoD9OhrT59Dv5c%3D&amp;reserved=3D0
>
> --
> Rodrigo Siqueira
> https://siqueira.tech
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
