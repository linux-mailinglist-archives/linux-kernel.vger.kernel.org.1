Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9562A02F2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgJ3Kdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:33:40 -0400
Received: from relay2.mymailcheap.com ([151.80.165.199]:37615 "EHLO
        relay2.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgJ3Kdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:33:38 -0400
X-Greylist: delayed 86921 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Oct 2020 06:33:37 EDT
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id 9F53D3ECD9;
        Fri, 30 Oct 2020 11:33:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id DE1C02A0F9;
        Fri, 30 Oct 2020 06:33:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1604054014;
        bh=HvwCgKOnxLXkV7fUAyLVaPhbNSLuoL4UnVDpoRKO5Kg=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=Fm0byw7jlzccZB+zMK7lXj2pl1+GWZRFIMX6f2XuzT46cnrpAaAtoRLZ9XENCQ3Am
         NLCGQxaGaew63CpCDFrJoEpqUHLpF3YiDbVAGNM7bIqwSEjYgUlJoBublfONQg6LA4
         NZ4aO1H7Zn/1fXBZNZyFnacNjGt46yrj7epbWaAk=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f_bVXTqV9dFy; Fri, 30 Oct 2020 06:33:33 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Fri, 30 Oct 2020 06:33:33 -0400 (EDT)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id D724B400BD;
        Fri, 30 Oct 2020 10:33:31 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="bQQzw09A";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [172.19.0.1] (unknown [64.225.114.122])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 4062F400BD;
        Fri, 30 Oct 2020 10:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1604054003; bh=HvwCgKOnxLXkV7fUAyLVaPhbNSLuoL4UnVDpoRKO5Kg=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=bQQzw09AhBf1fcMG1g5A5AbW2rRQ2NCYTZlrP4+heMj4ZK0QAbV5szky5Y+njkkpf
         C12sXCns7PwVONVkFLm2oXlp5v4MrH7S4RewLm4OEspbQFzw3G01Ze4h1l9B/wUPBH
         hKQ6zwTA7LJg43lTn4lGPz+2eGAi7OKLLgHTt+GI=
Date:   Fri, 30 Oct 2020 18:33:12 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <ea5967cdbd6281557d6a739c0eb63a979351b453.camel@gmail.com>
References: <20201029022000.601913-1-matteo.scordino@gmail.com> <20201029022000.601913-5-matteo.scordino@gmail.com> <20201029101304.yja4m747pc62re34@gilmour.lan> <92612D42-FF4C-450C-ADB1-A220B94838CB@aosc.io> <ea5967cdbd6281557d6a739c0eb63a979351b453.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/5] dt-bindings: arm: sunxi: add Elimo bindings
To:     Matteo Scordino <matteo.scordino@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
CC:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <A93A2E6B-DF6A-40C2-93C7-BA0335C52658@aosc.io>
X-Rspamd-Queue-Id: D724B400BD
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
         FREEMAIL_TO(0.00)[gmail.com,cerno.tech];
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



=E4=BA=8E 2020=E5=B9=B410=E6=9C=8830=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=88=
8:24:04, Matteo Scordino <matteo=2Escordino@gmail=2Ecom> =E5=86=99=E5=88=B0=
:
>Hello,
>
>thank you both for reviewing=2E
>
>I didn't realise the file was kept in alphabetical order, I will fix
>that=2E
>And I agree that board/som + "sochip,s3, allwinner,sun8i-v3" makes
>sense,
>I will resubmit the patch with those (and sync them with the dt
>bindings file)=2E
>
>Should I submit a patch to update the pinecube to use "sochip,s3,
>allwinner,sun8i-v3", too?

If possible, thanks=2E
