Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575BD27BCAF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 07:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgI2F74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 01:59:56 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51148 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgI2F74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 01:59:56 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08T5xoZD117847;
        Tue, 29 Sep 2020 00:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601359190;
        bh=TrXUDYwBoolpojQ6Vfg8wnJtYyuv0RloSLQXWZhaFZ0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gqGVhGn+kDNb1lIjakW9NjRvhoo4wDRrnfraR8al+W1Z/k11TgHKAqbFAPZMU7M+U
         Z8oGja6ui6vKhIiz2WMyENQK/X/cE15izZ/KTYefF70SOnKe8ktVDdrxv67ye39V8H
         heLIPyI57K4k+wwSPouA29JMJicOm2kw38vQtr0s=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08T5xohb101094
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 00:59:50 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 29
 Sep 2020 00:59:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 29 Sep 2020 00:59:49 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08T5xmPH048457;
        Tue, 29 Sep 2020 00:59:48 -0500
Subject: Re: sound/soc/ti/j721e-evm.c:528:34: warning: unused variable
 'j721e_audio_of_match'
To:     Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     kernel test robot <lkp@intel.com>, <kbuild-all@lists.01.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <202009271553.4OjMpGkX%lkp@intel.com>
 <76cae106-b643-57a9-e82e-48e46ebf1b70@ti.com>
 <CAKwvOdnsQY6S+3zAH6_SD0ifbUaSDFj9mBdhF4GVq6VB=tjFsA@mail.gmail.com>
 <20200928180412.GA4827@sirena.org.uk>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <c97e8363-1e8e-38fe-3214-cff47f09e459@ti.com>
Date:   Tue, 29 Sep 2020 09:00:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928180412.GA4827@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/09/2020 21.04, Mark Brown wrote:
> On Mon, Sep 28, 2020 at 10:52:54AM -0700, Nick Desaulniers wrote:
>> On Mon, Sep 28, 2020 at 12:27 AM 'Peter Ujfalusi' via Clang Built
>=20
>>> Right, in the attached .config:
>>> # CONFIG_OF is not set
>=20
>>> There must be a clean way to handle this without extensive ifedfery..=
=2E
>=20
>> Pretty sure I just saw a patch go by wrapping another device table
>> definition in #ifdef CONFIG_OF, so it's not unusual.
>=20
> It's the standard solution, it's just not as clean as would be ideal :/=


The ifdef would be preferred if the driver could work in non DT boot (to
save few bytes) but since it is not the case here:

https://lore.kernel.org/alsa-devel/20200928074330.13029-1-peter.ujfalusi@=
ti.com/

Not much point to size optimize for randconfig builds ;)

- P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

