Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A702F3526
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392565AbhALQMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:12:49 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1791 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392470AbhALQMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:12:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffdca580002>; Tue, 12 Jan 2021 08:12:08 -0800
Received: from [10.25.100.239] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Jan
 2021 16:12:05 +0000
Subject: Re: [PATCH] dt-bindings: Remove plain text OF graph binding
To:     Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210112154631.406250-1-robh@kernel.org>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <67a0141f-569c-9fce-d21e-4de41baeb8d9@nvidia.com>
Date:   Tue, 12 Jan 2021 21:41:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210112154631.406250-1-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610467928; bh=pE1ckwOq4xU4jWcYirvlxe/6tr3etDsHPOoWVwGsw6k=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=ACf6r1TENo9KK91crXjfPgQAHb4C8jZAzRCa33IeejvldKrER37s0l/mfMtuGHfZ9
         WluKv+SO2iTQv2o+pAp0WJBdxe90n17/+/k+tFHvru+hW1ZUf0LgyN8UvgqWPlJm/e
         3sLlsa7tx5yLr6n0jvKWSyqTBANvFCy63bd/geeQYiv7EbOmlz9Hep/+ZvVV7PK5L2
         f1L1TyTK1fU/0+5rOYB04+bdYWwbHXcht4xwKTk1CtkyHZW7su0S4/16UU1PRusSGx
         TCrPeOybBp6S5pXLALRcLs3Cz0RvBsuyggPtYYyfkgQeLEWQ4HMqn92ceY3OFctWJj
         Wf7YK1WCLWgBA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/2021 9:16 PM, Rob Herring wrote:
> External email: Use caution opening links or attachments
>
>
> From: Sameer Pujar <spujar@nvidia.com>
>
> A schema for the OF graph binding has been added to the dt-schema repo
> based on graph.txt contents. Let's replace graph.txt now duplicated
> contents with a reference to the schema.
>
> For users of the graph binding, they should reference to the graph
> schema from either 'ports' or 'port' property:
>
> properties:
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>
>      properties:
>        port@0:
>          $ref: /schemas/graph.yaml#/properties/port
>          description: What data this port has
>
>        ...
>
> Or:
>
> properties:
>    port:
>      description: What data this port has
>      $ref: /schemas/graph.yaml#/properties/port
>
> Cc: Sameer Pujar <spujar@nvidia.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> [robh: moved graph.yaml to dt-schema repo, expanded commit msg]
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/graph.txt | 129 +-------------------
>   1 file changed, 1 insertion(+), 128 deletions(-)

Acked-by: Sameer Pujar <spujar@nvidia.com>
