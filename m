Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708F424B7B0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 13:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgHTLCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 07:02:09 -0400
Received: from auth-smtp.nebula.fi ([217.149.52.145]:54815 "EHLO
        auth-smtp.nebula.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731668AbgHTK6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:58:49 -0400
Received: from [192.168.1.109] (82-203-173-204.bb.dnainternet.fi [82.203.173.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: xipheracom)
        by auth-smtp.nebula.fi (Postfix) with ESMTPSA id C5D874065;
        Thu, 20 Aug 2020 13:58:15 +0300 (EEST)
Subject: Re: [PATCH 2/3] dt-bindings: rng: add bindings for Xiphera XIP8001B
 hwnrg
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-crypto@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Mackall <mpm@selenic.com>, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <20200819122135.25316-1-atte.tommiska@xiphera.com>
 <20200819122135.25316-3-atte.tommiska@xiphera.com>
 <20200819223733.GA2088539@bogus>
From:   Atte Tommiska <atte.tommiska@xiphera.com>
Message-ID: <824023bc-2d91-6a38-cafe-019702186ce4@xiphera.com>
Date:   Thu, 20 Aug 2020 13:58:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819223733.GA2088539@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=8.0 tests=NICE_REPLY_A
        autolearn=unavailable autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        authsmtp1-hki2.nebula.fi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2020 01:37, Rob Herring wrote:
> On Wed, 19 Aug 2020 15:21:34 +0300, Atte Tommiska wrote:
>> Document the device tree bindings of Xiphera's XIP8001B-trng IP.
>>
>> Signed-off-by: Atte Tommiska <atte.tommiska@xiphera.com>
>> ---
>>  .../bindings/rng/xiphera,xip8001b-trng.yaml   | 30 +++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/rng/xiphera,xip8001b-trng.yaml
>>
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rng/xiphera,xip8001b-trng.yaml: 'maintainers' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rng/xiphera,xip8001b-trng.yaml: ignoring, error in schema: 
> warning: no schema found in file: ./Documentation/devicetree/bindings/rng/xiphera,xip8001b-trng.yaml
> 
> 
> See https://patchwork.ozlabs.org/patch/1347768
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.
> 

Thank you.

Fixed and submitted v2 of the patch.
