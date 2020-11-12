Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5912B09B0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgKLQPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:15:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgKLQPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:15:35 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51DDA22227;
        Thu, 12 Nov 2020 16:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605197734;
        bh=F+gcoIj4yektFMcpbgXVAAJo3evAy3thhHuS6cGiWGY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=llGhNUuHHJ1cZOa93pHbFGlgET5Ako9FEYpIcAzFW+F9QTfGi0WmzaCT7cifUA8yg
         X1XRdWCILClCkpSVjW6OAPBDYVHQyXOUtrecIei265zKYFLIhPtQ8iaeQeCEg6kifF
         ogwOlEMR6WmwBofpo2ZDcONw7O0+/aAt+spdtjOQ=
Received: by mail-qk1-f176.google.com with SMTP id v143so5768949qkb.2;
        Thu, 12 Nov 2020 08:15:34 -0800 (PST)
X-Gm-Message-State: AOAM531qj9pIYkqdc2SGICbSz8U69DrdFSNKhVGFUc8CpHpsscGwkrBg
        HJS4DbXQc5esFLn7IICRdPmcQGu9aA99uOBwNA==
X-Google-Smtp-Source: ABdhPJwc5ZhfLhx4nInnP6kIhq5fTs3ZM0G91SsTL6q6TAA4lRZBtLIPN8apKhz/mQugOLAjRcEybAs2pzvOty+1fTA=
X-Received: by 2002:a05:620a:148c:: with SMTP id w12mr455546qkj.311.1605197733415;
 Thu, 12 Nov 2020 08:15:33 -0800 (PST)
MIME-Version: 1.0
References: <1605097613-25301-1-git-send-email-spujar@nvidia.com>
 <1605097613-25301-3-git-send-email-spujar@nvidia.com> <20201112160746.GA3681609@bogus>
In-Reply-To: <20201112160746.GA3681609@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Nov 2020 10:15:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJOqXvHhazzZ9qFAOcdG5UrFrvThbX2D64Tk+c6f=Leqg@mail.gmail.com>
Message-ID: <CAL_JsqJOqXvHhazzZ9qFAOcdG5UrFrvThbX2D64Tk+c6f=Leqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: renesas,rsnd: Update audio graph references
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 10:07 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 11, 2020 at 05:56:53PM +0530, Sameer Pujar wrote:
> > Since audio graph schema is refactored now update the related
> > references here.
> >
> > Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
>
> This should be part of the first patch. Things break in between.
>
> >
> > diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> > index 51f4dca..fc2ae22 100644
> > --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> > +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> > @@ -112,12 +112,10 @@ properties:
> >          - pattern: '^clk_(a|b|c|i)$'
> >
> >    port:
> > -    description: OF-Graph subnode
> > -    $ref: "audio-graph-card.yaml#/properties/port"
> > +    $ref: /schemas/sound/audio-graph.yaml#/properties/port
> >
> >    ports:
> > -    description: multi OF-Graph subnode
> > -    $ref: "audio-graph-card.yaml#/properties/ports"
> > +    $ref: /schemas/graph.yaml#/properties/ports

Actually, with the graph.yaml dependency that doesn't work either. I
think this probably needs to be a ref to just audio-graph.yaml at the
top level and that should pick up port and ports schemas.

Rob
