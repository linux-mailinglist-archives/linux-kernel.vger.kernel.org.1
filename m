Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949BC2DA3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407765AbgLNXBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:01:45 -0500
Received: from relay3.mymailcheap.com ([217.182.119.157]:60606 "EHLO
        relay3.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441382AbgLNXB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:01:28 -0500
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id D86843F1CC;
        Mon, 14 Dec 2020 23:59:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 268172A0F7;
        Mon, 14 Dec 2020 17:59:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607986792;
        bh=CuVmgnP4fCT8Ur8XRqvAJnHl3yE3cC3/oU4X1h23clo=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=A+Qyk89AZrQZGBxRASn3bw1FHqw9wI6/idHd7nQ4NyInG6zJai21jT9fdGk62IlOp
         vZLV4OsA0TAcwSIiLgOgOmdjlNXaEzs0EJqNYlafNuZCg44RZ9sxQRigZ2vtQ2EEn8
         kXs9TO0sQgx1JfVsFiDGr3Wt1ebXD22VJDD4rpBo=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GUQutluy3ivu; Mon, 14 Dec 2020 17:59:51 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Mon, 14 Dec 2020 17:59:51 -0500 (EST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 4990842374;
        Mon, 14 Dec 2020 22:59:49 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="HFiuRgiE";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [172.19.0.1] (unknown [64.225.114.122])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 49E0742374;
        Mon, 14 Dec 2020 22:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1607986780; bh=CuVmgnP4fCT8Ur8XRqvAJnHl3yE3cC3/oU4X1h23clo=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=HFiuRgiEkRA1LLM2eRYxqVPPrpAyw7UF1NL++AgsrZkdZ75mgrYE8eMA15tTXRonk
         FLhOsBlIizLmbrb4WpSzcg6QFrXJ5onBqwj+b4c5OOZFBTb5MJIsCELoaSKHlYksv3
         9Jg19uDon9QeK0UXAuGf06K0oKPKttrRXge3wJ7Y=
Date:   Tue, 15 Dec 2020 06:59:33 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20201214103704.bkgwh4bdelrtovgd@gilmour>
References: <20201210083722.1912981-1-icenowy@aosc.io> <20201210084232.1913871-1-icenowy@aosc.io> <20201214103704.bkgwh4bdelrtovgd@gilmour>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [linux-sunxi] Re: [PATCH 1/3] dt-bindings: arm: sunxi: add PineTab new panel DT binding
To:     maxime@cerno.tech, Maxime Ripard <maxime@cerno.tech>
CC:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <7C38287D-F4E7-412A-A7F2-3787A1B04573@aosc.io>
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
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[10];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Queue-Id: 4990842374
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B412=E6=9C=8814=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
6:37:04, Maxime Ripard <maxime@cerno=2Etech> =E5=86=99=E5=88=B0:
>On Thu, Dec 10, 2020 at 04:42:32PM +0800, Icenowy Zheng wrote:
>> Early adopters' PineTabs (and all further releases) will have a new
>LCD
>> panel different with the one that is used when in development
>(because
>> the old panel's supply discontinued)=2E
>>=20
>> Add a new DT compatible for it=2E
>>=20
>> Signed-off-by: Icenowy Zheng <icenowy@aosc=2Eio>
>> ---
>>  Documentation/devicetree/bindings/arm/sunxi=2Eyaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/arm/sunxi=2Eyaml
>b/Documentation/devicetree/bindings/arm/sunxi=2Eyaml
>> index 6db32fbf813f=2E=2E73a6c8421172 100644
>> --- a/Documentation/devicetree/bindings/arm/sunxi=2Eyaml
>> +++ b/Documentation/devicetree/bindings/arm/sunxi=2Eyaml
>> @@ -700,6 +700,11 @@ properties:
>>            - const: pine64,pinetab
>>            - const: allwinner,sun50i-a64
>> =20
>> +      - description: Pine64 PineTab with new LCD panel
>> +        items:
>> +          - const: pine64,pinetab-new-panel
>> +          - const: allwinner,sun50i-a64
>> +
>
>We're on the right track, but new panel seems a bit too vague=2E What is
>going to happen when they will change the panel again?
>
>pinetab-early-adopter seems more robust there

This name will only match a batch=2E

>
>Maxime
