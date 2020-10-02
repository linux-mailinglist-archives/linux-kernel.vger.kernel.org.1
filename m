Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59CE280F3F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbgJBIvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:51:00 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9998 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBIu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:50:59 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f76e98c0000>; Fri, 02 Oct 2020 01:49:16 -0700
Received: from [10.25.97.216] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 08:50:50 +0000
Subject: Re: [PATCH v3 01/13] ASoC: soc-core: Fix component name_prefix
 parsing
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <kuninori.morimoto.gx@renesas.com>,
        <pierre-louis.bossart@linux.intel.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, <nwartikar@nvidia.com>,
        <swarren@nvidia.com>, <nicoleotsuka@gmail.com>
References: <1601573587-15288-1-git-send-email-spujar@nvidia.com>
 <1601573587-15288-2-git-send-email-spujar@nvidia.com>
 <20201001185308.GC23339@qmqm.qmqm.pl>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <a63c8898-540c-f89b-8997-27d6385cb2c3@nvidia.com>
Date:   Fri, 2 Oct 2020 14:20:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001185308.GC23339@qmqm.qmqm.pl>
Content-Type: text/plain; charset="iso-8859-2"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601628556; bh=BI4fp6pD/W2VIRJQVhnrK4iPbG7U8OWA4NPdWAoCl4I=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=GKeHIFRBa0MxGfztlF548b8USZc5XGny2A7IUep8pOfpw2vGOX46cC9Ajb167YL1Q
         b5DEJ5hTAB7ZH27nNMNvtdG+IKgiJV4y3d1UKqaRV9Lb4//rXSx6JrHZHVtKmD+wWk
         eqyG/IzxhUrWUAi7RPWzxbPWfvOYPYfvZCpZpcAE7qAJ9GroRgorLmjl7E6/rFxiLx
         MZRWLuUPagxloUc9yhKBi7Qu+xxDPax+fCeyA+GsvmRxE4p64qTdXJUS5KetSs4yEG
         c3g8wKTvKSxgLfUF+gMF0uYkz4UEDFtf3kCyzq5yWYV0HVRJIwbmxFvqNnNmOtimAT
         wB0CsooB6zk/A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> The "prefix" can be defined in DAI link node or it can be specified as
>> part of the component node itself. Currently "sound-name-prefix" defined
>> in a component is not taking effect. Actually the property is not gettin=
g
>> parsed. It can be fixed by parsing "sound-name-prefix" property whenever
>> "prefix" is missing in DAI link Codec node.
> [...]
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -1124,7 +1124,8 @@ static void soc_set_name_prefix(struct snd_soc_car=
d *card,
>>        for (i =3D 0; i < card->num_configs; i++) {
>>                struct snd_soc_codec_conf *map =3D &card->codec_conf[i];
>>
>> -             if (snd_soc_is_matching_component(&map->dlc, component)) {
>> +             if (snd_soc_is_matching_component(&map->dlc, component) &&
>> +                 map->name_prefix) {
>>                        component->name_prefix =3D map->name_prefix;
>>                        return;
>>                }
> Hi,
>
> It is not obvious how the patch fixes the problem described. I guess now
> map->name_prefix is NULL on some level and overrides prefix found earlier=
?
>
> Best Regards,
> Micha=B3 Miros=B3aw

If map->name_prefix is NULL (which is the prefix defined for Codec DAI=20
component in a DAI link), then go ahead and check if "sound-name-prefix"=20
is provided under component device node itself.
