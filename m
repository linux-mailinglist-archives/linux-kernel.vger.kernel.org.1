Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46432DC114
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgLPNUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:20:33 -0500
Received: from relay4.mymailcheap.com ([137.74.199.117]:55843 "EHLO
        relay4.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgLPNUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:20:33 -0500
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 651F93F1CF;
        Wed, 16 Dec 2020 14:19:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 3252B2A4E9;
        Wed, 16 Dec 2020 14:19:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1608124740;
        bh=UZHvg525nSqI0TSQI9i4UYDD0yZBuXSVv9YWeoAXwlY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=u0ZHLB757tMdQYzO/rFaaYkoo9IJoZFwsmdEVesVOXuK8UHJ6jrs1FR36NQ8QIua5
         WOu1ZKt+ZlPUAzgDFLFsKEd6p+/8CSSYFbq1eA+h8IEfPWAiJR8ayM0gr2H+z/t/Bs
         3RhouDDPqyE9FpbSv2Ywr5odO8qQhMhZXGA6vsC0=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JkWQ0YxGb1KP; Wed, 16 Dec 2020 14:18:56 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Wed, 16 Dec 2020 14:18:56 +0100 (CET)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 776E942EF5;
        Wed, 16 Dec 2020 13:18:55 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="EH1iuMJP";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ICE-E5V2.lan (unknown [59.41.163.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 9634C42EF5;
        Wed, 16 Dec 2020 13:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1608124729; bh=UZHvg525nSqI0TSQI9i4UYDD0yZBuXSVv9YWeoAXwlY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EH1iuMJPzjUnQH3O6fKwBSsuSC1PL3fkqObArmltFHpfg7hdnep7rIUD62JMBBGTB
         2l7eCKDFZwr7O1nIRz7srS7Y0prYS5IjMFoHxks3PcBiIlAes7/ml4/wBG4crlXvZp
         PlOe6vqZ6uAYBRm/HxYjmwIdSaWMZWij9vZWLKtk=
Message-ID: <d0afbf23472f0e62517433eb273576937df65427.camel@aosc.io>
Subject: Re: [linux-sunxi] Re: [PATCH 1/3] dt-bindings: arm: sunxi: add
 PineTab new panel DT binding
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Date:   Wed, 16 Dec 2020 21:18:41 +0800
In-Reply-To: <20201216130012.jah7ubzbjx5g632n@gilmour>
References: <20201210083722.1912981-1-icenowy@aosc.io>
         <20201210084232.1913871-1-icenowy@aosc.io>
         <20201214103704.bkgwh4bdelrtovgd@gilmour>
         <7C38287D-F4E7-412A-A7F2-3787A1B04573@aosc.io>
         <20201216130012.jah7ubzbjx5g632n@gilmour>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: mail20.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.163.134:received];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[9];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Queue-Id: 776E942EF5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020-12-16星期三的 14:00 +0100，Maxime Ripard写道：
> On Tue, Dec 15, 2020 at 06:59:33AM +0800, Icenowy Zheng wrote:
> > 于 2020年12月14日 GMT+08:00 下午6:37:04, Maxime Ripard <maxime@cerno.tech
> > > 写到:
> > > On Thu, Dec 10, 2020 at 04:42:32PM +0800, Icenowy Zheng wrote:
> > > > Early adopters' PineTabs (and all further releases) will have a
> > > > new
> > > LCD
> > > > panel different with the one that is used when in development
> > > (because
> > > > the old panel's supply discontinued).
> > > > 
> > > > Add a new DT compatible for it.
> > > > 
> > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml
> > > b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > > > index 6db32fbf813f..73a6c8421172 100644
> > > > --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > > > @@ -700,6 +700,11 @@ properties:
> > > >            - const: pine64,pinetab
> > > >            - const: allwinner,sun50i-a64
> > > >  
> > > > +      - description: Pine64 PineTab with new LCD panel
> > > > +        items:
> > > > +          - const: pine64,pinetab-new-panel
> > > > +          - const: allwinner,sun50i-a64
> > > > +
> > > 
> > > We're on the right track, but new panel seems a bit too vague.
> > > What is
> > > going to happen when they will change the panel again?
> > > 
> > > pinetab-early-adopter seems more robust there
> > 
> > This name will only match a batch.
> 
> Look, I know the situation sucks. Can we actually move forward?

Descriptive name will match more things.

I think we should still have something descriptive, even if "new panel"
is too generic.

> 
> Maxime
