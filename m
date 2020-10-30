Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8942229FFF6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJ3I32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3I31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:29:27 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4ACC0613CF;
        Fri, 30 Oct 2020 01:29:27 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h12so3576984qtu.1;
        Fri, 30 Oct 2020 01:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2SmP2XG2z3yyrdfUO9SkbT5PkhpXi9KOLge2mZeMb5U=;
        b=i1bDXsBm1niQ4dkdDbmR9gg6PC1JZxcVuqDMoIU0x9yV4eCKiO7o8WT1gLVhGbua+W
         VSQZz/9X1dfTZK7P3wLdKlpscV6K9QmiH3GTCxZkVydSulOWMgGtX1r8H2KdukRelmYV
         edizOroqwJafVC6nOIPEiBOx37tjE8bEon36kr6517o7gv5RrScCd7ln8wa8xhnpGqsU
         b3auk81D2jZttt3Ztoa/HIhlJh3DakWKMdVWiXa85ZDKeLn4IAPgv7Zo/hpuTilTU9gA
         oyW+WpiGsqHa2x3pWM0/xE7mMhPGN5KP4Gb11NEJo4XszZzED+eirG1lNWhaHn4vo1Dl
         upGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SmP2XG2z3yyrdfUO9SkbT5PkhpXi9KOLge2mZeMb5U=;
        b=saPZliaV5pZ6F3tqtFDYWoHy31ee1OLs9LEmYQX9lfzbFGF8T0lAnzoY4V41B0RPiJ
         XqoqXgxz+4JzDaJI1etK95ksB7lz4Le2/D/JOICMFNB7gCiWpPRMw6JYMJbojJo4i9yz
         B7KwuUreMPTTdFS5U8bxRtDm6B1SDWYDE9u556VINYDILAvWA6WDrMA6jwFDm0ebXAfr
         ANETw3z1gI/s7ZnFtGz0liJ1+AK+I8S5j3Q7uPLl1PiwUNYIVLoy9rnnU1KTygiLm2/v
         EOeD1twsRpWo0ubXXhMhcWRr5ojwMHVQF0qIdVVUL3UNkh1834z/sO3QasysW49Qd+BA
         V1JQ==
X-Gm-Message-State: AOAM530yQa7y90PVb/Yy4kHQ3W1S2Nei43MK+tlFZ4CgRCJQ4OrPF+qy
        U+wknP7eG0g1Oh6JoHhDnl3/CR/nFScPO8jhYO0=
X-Google-Smtp-Source: ABdhPJzkbx+wUo5qTc/A5mLSgJdG9vfP6tbrvgVQoe1Oj4ip/QKJPl/1/B4em0IUQc5bqYk4VWdgJWXeCNWIuiLyc9s=
X-Received: by 2002:aed:26e3:: with SMTP id q90mr947606qtd.121.1604046566560;
 Fri, 30 Oct 2020 01:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <1603877930-10553-1-git-send-email-shengjiu.wang@nxp.com> <20201029152721.GB1901783@bogus>
In-Reply-To: <20201029152721.GB1901783@bogus>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 30 Oct 2020 16:29:15 +0800
Message-ID: <CAA+D8AOC3FSCH48p8e61W7Vz5Ri9Hhz_Hbw24cXtEp0OO2gT8g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: fsl_aud2htx: Add binding doc
 for aud2htx module
To:     Rob Herring <robh@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:28 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 28 Oct 2020 17:38:49 +0800, Shengjiu Wang wrote:
> > AUD2HTX (Audio Subsystem TO HDMI TX Subsystem) is a new
> > IP module found on i.MX8MP.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> > changes in v2:
> > - fix indentation issue
> > - remove nodename
> >
> >  .../bindings/sound/fsl,aud2htx.yaml           | 64 +++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
> >
>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml: 'additionalProperties' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml: ignoring, error in schema:
> warning: no schema found in file: ./Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
>
>
> See https://patchwork.ozlabs.org/patch/1389813
>
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>

ok, will fix it.

best regards
wang shengjiu
