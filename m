Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BDF29705A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464610AbgJWNYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373636AbgJWNYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:24:19 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 114D5207FF;
        Fri, 23 Oct 2020 13:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603459459;
        bh=G+G1NFp9JRYJ2dro4Br/7MRvnCJKwRWzwLiKAvbHXMw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TvwvXbS+GkFEkPvgBxp4l2VnS9df6+iB5O6NCGP6AZp4CrWe4l8ePd/rhBEFHu4j1
         e4XJUfyOhwpxpXqWdXhaly/jTblUYqLjUa8ciYjVTfrU0FHWfoT3qa8UBY2wuLOBHA
         zc/Bm2xN2TsLw+CG1Bvipd3cUDiOwN0qBzzczIT8=
Received: by mail-oi1-f178.google.com with SMTP id f8so1820956oij.10;
        Fri, 23 Oct 2020 06:24:19 -0700 (PDT)
X-Gm-Message-State: AOAM531FrMn6MQkgFnDU1N8MLgbuHxqNDEfweYVi2tiWLgu68APmOQPE
        Gl3aRF08dKhI4WmjomaLVcI6VzeDREdlOassWg==
X-Google-Smtp-Source: ABdhPJz4tFeZJDr7rzOvZGMNHZJWe/2fbjbgtc6bLDWUKizS54PAUe5/dg0vPDI/EoI/0wqVYwg+Wb2V7cwL+yFzGf0=
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr1741212oie.152.1603459458302;
 Fri, 23 Oct 2020 06:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201021183104.27949-1-sudeep.holla@arm.com> <20201022182233.hklq6j5n5kkqg4yv@bogus>
In-Reply-To: <20201022182233.hklq6j5n5kkqg4yv@bogus>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 23 Oct 2020 08:24:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKw8SiQ3vCYbf5vKgKP7dHgcpxCVET4XuV5rsR34EQLgw@mail.gmail.com>
Message-ID: <CAL_JsqKw8SiQ3vCYbf5vKgKP7dHgcpxCVET4XuV5rsR34EQLgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm,scmi: Do not use clocks for SCMI
 performance domains
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 1:22 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Oct 21, 2020 at 07:31:03PM +0100, Sudeep Holla wrote:
> > Commit dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return
> > -EPROBE_DEFER") handles -EPROBE_DEFER for the clock/interconnects within
> > _allocate_opp_table() which is called from dev_pm_opp_add and it
> > now propagates the error back to the caller.
> >
> > SCMI performance domain re-used clock bindings to keep it simple. However
> > with the above mentioned change, if clock property is present in a device
> > node, opps can't be added until clk_get succeeds. So in order to fix the
> > issue, we can register dummy clocks which is completely ugly.
> >
> > Since there are no upstream users for the SCMI performance domain clock
> > bindings, let us introduce separate performance domain bindings for the
> > same.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  .../devicetree/bindings/arm/arm,scmi.txt      | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > v1[1]->v2:
> >       - Changed the generic #perf-domain-cells to more SCMI specific
> >         property #arm,scmi-perf-domain-cells
> >
>
> Is more specific #arm,scmi-perf-domain-cells acceptable ?
> Sorry for the rush, but this fixes SCMI cpufreq which is broken after
> commit dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return
> -EPROBE_DEFER")

If you are in a rush, you'd better go the dummy clock route. We should
get this binding right and I think that means something common, not
SCMI specific.

Rob
