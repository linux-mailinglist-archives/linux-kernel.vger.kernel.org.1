Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E7429E8E9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgJ2KY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:24:59 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:37593 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgJ2KY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:24:59 -0400
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [151.80.165.199])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 78A6B260EB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 10:24:56 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id 186903ECDA;
        Thu, 29 Oct 2020 11:24:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 570452A0F9;
        Thu, 29 Oct 2020 06:24:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1603967093;
        bh=4swhytK2zsubih5GZHoRetLtnB5qvjMkgDk1gv1OedQ=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=F8uPFAWMCQh3vgTbD0UmiYLgDfzXwAknKrxShCCkfsdHFSQav5B1AZJCDeila32BT
         vT5oExYFHmddeBLLZxt0k5jdZ0Xe62zNvGQFwzIc0h5Sx4O/USh/C6gjF7qdTkisS0
         0vtScpdhkH/4ByLEdz4/X+sLNtKRAAJsgjqZRmug=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iiyFK8Joi_7B; Thu, 29 Oct 2020 06:24:52 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Thu, 29 Oct 2020 06:24:52 -0400 (EDT)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 1C4B640B5A;
        Thu, 29 Oct 2020 10:24:51 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="civFcXEp";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [172.19.0.1] (unknown [64.225.114.122])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id D731940B4D;
        Thu, 29 Oct 2020 10:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1603967082; bh=4swhytK2zsubih5GZHoRetLtnB5qvjMkgDk1gv1OedQ=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=civFcXEpvuF+IJPSRAkyisaBLrx0SMEMb9huNRDka7dahtOVEcmYUpZGWhqYVmySR
         9thlYkTqzUEAVBHEwjJeks/MiYpXXA26EwrcetKCIH49j33V1aSxZKRfw+KwKXs9cv
         K5FURPKfzvcNhA5jxBpc/7BSfkBagDhk+s8fUrzk=
Date:   Thu, 29 Oct 2020 18:24:34 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20201029101304.yja4m747pc62re34@gilmour.lan>
References: <20201029022000.601913-1-matteo.scordino@gmail.com> <20201029022000.601913-5-matteo.scordino@gmail.com> <20201029101304.yja4m747pc62re34@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/5] dt-bindings: arm: sunxi: add Elimo bindings
To:     Maxime Ripard <maxime@cerno.tech>,
        Matteo Scordino <matteo.scordino@gmail.com>
CC:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <92612D42-FF4C-450C-ADB1-A220B94838CB@aosc.io>
X-Rspamd-Queue-Id: 1C4B640B5A
X-Spamd-Result: default: False [1.40 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[7];
         FREEMAIL_TO(0.00)[cerno.tech,gmail.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B410=E6=9C=8829=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
6:13:04, Maxime Ripard <maxime@cerno=2Etech> =E5=86=99=E5=88=B0:
>Hi,
>
>On Thu, Oct 29, 2020 at 02:19:59AM +0000, Matteo Scordino wrote:
>> Document board compatible names for Elimo Engineering Impetus and
>Initium
>>=20
>> Signed-off-by: Matteo Scordino <matteo=2Escordino@gmail=2Ecom>
>> ---
>>  Documentation/devicetree/bindings/arm/sunxi=2Eyaml | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/arm/sunxi=2Eyaml
>b/Documentation/devicetree/bindings/arm/sunxi=2Eyaml
>> index 0f23133672a3=2E=2E55405809ec91 100644
>> --- a/Documentation/devicetree/bindings/arm/sunxi=2Eyaml
>> +++ b/Documentation/devicetree/bindings/arm/sunxi=2Eyaml
>> @@ -898,3 +898,13 @@ properties:
>>          items:
>>            - const: xunlong,orangepi-zero-plus2-h3
>>            - const: allwinner,sun8i-h3
>> +
>> +      - description: Elimo Engineering Impetus SoM
>> +        items:
>> +          - const: elimo,impetus
>> +          - const: allwinner,sun8i-s3
>> +
>> +      - description: Elimo Engineering Initium
>> +        items:
>> +          - const: elimo,initium
>> +          - const: allwinner,sun8i-s3
>
>This should be ordered alphabetically, and most importantly, must match
>the ones you have in the DT=2E
>
>Here, we have kind of a mess already: the Lichee Zero+ uses
>,sipeed,lichee-zero-plus, sochip,s3, allwinner,sun8i-v3, while the
>pinecube uses pine64,pinecube, allwinner,sun8i-s3
>
>IIRC the S3 and V3 are pretty much the same SoCs, so the first one
>seems
>to make more sense to me, but then we should fix the pinecube=2E

I agree with this=2E

PineCube is originally designed for S3L (which is branded under Allwinner)
but switch to S3 finally, so I may made error when adapting=2E

>
>Maxime
