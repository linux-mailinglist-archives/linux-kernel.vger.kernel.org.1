Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1C12AF2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgKKN7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgKKNfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:35:13 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A6C920829;
        Wed, 11 Nov 2020 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605101712;
        bh=GaQU9rM+P1s6S9ioMaD8ODMJuqhbgzej2Pwn224DULs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l9eP4xo3Dt8JIOzkI5XJDqS3pK0+YVQyYhIozCNMEA3Gxkl5kej27O0hDjPW6Wqes
         CXOSZ2UMDqAyXLSs7b0baDYs3ZyECh0yu0WFFWzqzJGzEtdcs4LcVPrUnXxTIxGvmG
         ME90S0lMZhMrHhDKmc33RrqkFn+8w+rI8twiPWDY=
Received: by mail-oi1-f172.google.com with SMTP id m143so2173282oig.7;
        Wed, 11 Nov 2020 05:35:12 -0800 (PST)
X-Gm-Message-State: AOAM532qQNAeOhXNyj2XUiW1bQNMH9oO4qcsHY6JP3rQBJGJC+e7hdFH
        jSOSCtieY+9zDqHaSqG/gJ655MXmDSHkB0Klyg==
X-Google-Smtp-Source: ABdhPJwVxej4pSf3XECc4BzNRNQ7R9EtApnK/+4WVvKLOte9oPRPUUpShUa/ZyNa7yt2H/HctrZNL9nqRvPr3bSejyo=
X-Received: by 2002:aca:fdd4:: with SMTP id b203mr2177696oii.152.1605101711667;
 Wed, 11 Nov 2020 05:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20201102203656.220187-1-robh@kernel.org> <20201102203656.220187-2-robh@kernel.org>
 <4185c162-8a71-7402-f46e-4a2495f152f2@nvidia.com>
In-Reply-To: <4185c162-8a71-7402-f46e-4a2495f152f2@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 11 Nov 2020 07:35:00 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+3_R9G=Lk4F3DMNgh4EhG_qsv1+HM2HgQOm+ePE4=hFA@mail.gmail.com>
Message-ID: <CAL_Jsq+3_R9G=Lk4F3DMNgh4EhG_qsv1+HM2HgQOm+ePE4=hFA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: Convert graph bindings to json-schema
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     devicetree@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 3:52 AM Sameer Pujar <spujar@nvidia.com> wrote:
>
> Hi Rob,
>
> > From: Sameer Pujar <spujar@nvidia.com>
> >
> > Convert device tree bindings of graph to YAML format. Currently graph.txt
> > doc is referenced in multiple files and all of these need to use schema
> > references. For now graph.txt is updated to refer to graph.yaml.
> >
> > For users of the graph binding, they should reference to the graph
> > schema from either 'ports' or 'port' property:
> >
> > properties:
> >    ports:
> >      type: object
> >      $ref: graph.yaml#/properties/ports
> >
> >      properties:
> >        port@0:
> >          description: What data this port has
> >
> >        ...
> >
> > Or:
> >
> > properties:
> >    port:
> >      description: What data this port has
> >      type: object
> >      $ref: graph.yaml#/properties/port
> >
> > Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> > Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v3:
> >   - Move port 'reg' to port@* and make required
> >   - Make remote-endpoint required
> >   - Add 'additionalProperties: true' now required
> >   - Fix yamllint warnings
> >
> >   Documentation/devicetree/bindings/graph.txt  | 129 +-----------
> >   Documentation/devicetree/bindings/graph.yaml | 199 +++++++++++++++++++
> >   2 files changed, 200 insertions(+), 128 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/graph.yaml
> >
> ...
> > diff --git a/Documentation/devicetree/bindings/graph.yaml b/Documentation/devicetree/bindings/graph.yaml
> > new file mode 100644
> > index 000000000000..b56720c5a13e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/graph.yaml
> > @@ -0,0 +1,199 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/graph.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Common bindings for device graphs
> > +
> > +description: |
> > +  The hierarchical organisation of the device tree is well suited to describe
> > +  control flow to devices, but there can be more complex connections between
> > +  devices that work together to form a logical compound device, following an
> > +  arbitrarily complex graph.
> > +  There already is a simple directed graph between devices tree nodes using
> > +  phandle properties pointing to other nodes to describe connections that
> > +  can not be inferred from device tree parent-child relationships. The device
> > +  tree graph bindings described herein abstract more complex devices that can
> > +  have multiple specifiable ports, each of which can be linked to one or more
> > +  ports of other devices.
> > +
> > +  These common bindings do not contain any information about the direction or
> > +  type of the connections, they just map their existence. Specific properties
> > +  may be described by specialized bindings depending on the type of connection.
> > +
> > +  To see how this binding applies to video pipelines, for example, see
> > +  Documentation/devicetree/bindings/media/video-interfaces.txt.
> > +  Here the ports describe data interfaces, and the links between them are
> > +  the connecting data buses. A single port with multiple connections can
> > +  correspond to multiple devices being connected to the same physical bus.
> > +
> > +maintainers:
> > +  - Philipp Zabel <p.zabel@pengutronix.de>
> > +
> > +select: false
> > +
> > +properties:
> > +  port:
> > +    type: object
> > +    description:
> > +      If there is more than one endpoint node or 'reg' property present in
> > +      endpoint nodes then '#address-cells' and '#size-cells' properties are
> > +      required.
> > +
> > +    properties:
> > +      "#address-cells":
> > +        const: 1
> > +
> > +      "#size-cells":
> > +        const: 0
> > +
> > +    patternProperties:
> > +      "^endpoint(@[0-9a-f]+)?$":
> > +        type: object
> > +        properties:
> > +          reg:
> > +            maxItems: 1
> > +
> > +          remote-endpoint:
> > +            description: |
> > +              phandle to an 'endpoint' subnode of a remote device node.
> > +            $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +        required:
> > +          - remote-endpoint
>
> Does 'remote-endpoint' have to be a required property?
> In case of pluggable modules, the remote-endpoint may not be available
> unless the module is plugged in. In other words, device-2 in below
> example may not always be available, but still device-1 endpoint
> configuration and usage may be required?

No, I've dropped it. I noticed the same thing converting some of the
schema over to use this.

Rob
