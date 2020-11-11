Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD872AEE22
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgKKJwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:52:07 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4183 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgKKJwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:52:06 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fabb44a0000>; Wed, 11 Nov 2020 01:52:10 -0800
Received: from [10.25.102.95] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Nov
 2020 09:51:59 +0000
Subject: Re: [PATCH v3 1/3] dt-bindings: Convert graph bindings to json-schema
To:     Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <kuninori.morimoto.gx@renesas.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
References: <20201102203656.220187-1-robh@kernel.org>
 <20201102203656.220187-2-robh@kernel.org>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <4185c162-8a71-7402-f46e-4a2495f152f2@nvidia.com>
Date:   Wed, 11 Nov 2020 15:21:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102203656.220187-2-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605088330; bh=NfxvzToOPwpWqNdT7c6nJmyYl3Oqi8uprhuIHTusw1c=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=Kp5aKdWsLz+oM0ZFDkbHzLdXS97I2jXg93A1a0ELRXevnfi76caPAr5Wr9vas0ZSO
         EFf38c7LyRbr4fslN3SX+SJKTeKYS5031AwCfUh2DGL6IX1w290T7omSWHdxVRLqPp
         7A6/xmrekM6hxY5N2S4XV/nzWyBx/SONWtrdAkc6VGNXqbRVQ5/VR+JoBZIEtGeajx
         yBlILxTdtFk/L6OzCc1lJQn3Kf6qnlbFD8J4brfJaNHDGPqiaUuQjCFZgQ1rcODqMA
         +vCHK0VoaqdoYo7yxBLhJvuSW9lesYPilSyGESGVhLVMCByy49gwHxHJXLimQShzif
         IO+QKuQtcyqmA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> From: Sameer Pujar <spujar@nvidia.com>
>
> Convert device tree bindings of graph to YAML format. Currently graph.txt
> doc is referenced in multiple files and all of these need to use schema
> references. For now graph.txt is updated to refer to graph.yaml.
>
> For users of the graph binding, they should reference to the graph
> schema from either 'ports' or 'port' property:
>
> properties:
>    ports:
>      type: object
>      $ref: graph.yaml#/properties/ports
>
>      properties:
>        port@0:
>          description: What data this port has
>
>        ...
>
> Or:
>
> properties:
>    port:
>      description: What data this port has
>      type: object
>      $ref: graph.yaml#/properties/port
>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v3:
>   - Move port 'reg' to port@* and make required
>   - Make remote-endpoint required
>   - Add 'additionalProperties: true' now required
>   - Fix yamllint warnings
>
>   Documentation/devicetree/bindings/graph.txt  | 129 +-----------
>   Documentation/devicetree/bindings/graph.yaml | 199 +++++++++++++++++++
>   2 files changed, 200 insertions(+), 128 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/graph.yaml
>
...
> diff --git a/Documentation/devicetree/bindings/graph.yaml b/Documentation/devicetree/bindings/graph.yaml
> new file mode 100644
> index 000000000000..b56720c5a13e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/graph.yaml
> @@ -0,0 +1,199 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/graph.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common bindings for device graphs
> +
> +description: |
> +  The hierarchical organisation of the device tree is well suited to describe
> +  control flow to devices, but there can be more complex connections between
> +  devices that work together to form a logical compound device, following an
> +  arbitrarily complex graph.
> +  There already is a simple directed graph between devices tree nodes using
> +  phandle properties pointing to other nodes to describe connections that
> +  can not be inferred from device tree parent-child relationships. The device
> +  tree graph bindings described herein abstract more complex devices that can
> +  have multiple specifiable ports, each of which can be linked to one or more
> +  ports of other devices.
> +
> +  These common bindings do not contain any information about the direction or
> +  type of the connections, they just map their existence. Specific properties
> +  may be described by specialized bindings depending on the type of connection.
> +
> +  To see how this binding applies to video pipelines, for example, see
> +  Documentation/devicetree/bindings/media/video-interfaces.txt.
> +  Here the ports describe data interfaces, and the links between them are
> +  the connecting data buses. A single port with multiple connections can
> +  correspond to multiple devices being connected to the same physical bus.
> +
> +maintainers:
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +
> +select: false
> +
> +properties:
> +  port:
> +    type: object
> +    description:
> +      If there is more than one endpoint node or 'reg' property present in
> +      endpoint nodes then '#address-cells' and '#size-cells' properties are
> +      required.
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^endpoint(@[0-9a-f]+)?$":
> +        type: object
> +        properties:
> +          reg:
> +            maxItems: 1
> +
> +          remote-endpoint:
> +            description: |
> +              phandle to an 'endpoint' subnode of a remote device node.
> +            $ref: /schemas/types.yaml#/definitions/phandle
> +
> +        required:
> +          - remote-endpoint

Does 'remote-endpoint' have to be a required property?
In case of pluggable modules, the remote-endpoint may not be available 
unless the module is plugged in. In other words, device-2 in below 
example may not always be available, but still device-1 endpoint 
configuration and usage may be required?

...

> +  # Links between endpoints:
> +  #
> +  # Each endpoint should contain a 'remote-endpoint' phandle property that
> +  # points to the corresponding endpoint in the port of the remote device.
> +  # In turn, the remote endpoint should contain a 'remote-endpoint' property.
> +  # If it has one, it must not point to anything other than the local endpoint.
> +  # Two endpoints with their 'remote-endpoint' phandles pointing at each other
> +  # form a link between the containing ports.
> +  - |
> +    device-1 {
> +        port {
> +            device_1_output: endpoint {
> +                remote-endpoint = <&device_2_input>;
> +            };
> +        };
> +    };
> +
> +    device-2 {
> +        port {
> +            device_2_input: endpoint {
> +                remote-endpoint = <&device_1_output>;
> +            };
> +        };
> +    };
> +
> +...
> --
> 2.25.1

