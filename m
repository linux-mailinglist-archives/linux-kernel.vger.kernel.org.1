Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF2D280F59
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgJBI7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:59:25 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5582 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBI7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:59:24 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f76ebb80001>; Fri, 02 Oct 2020 01:58:32 -0700
Received: from [10.25.97.216] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 08:59:13 +0000
Subject: Re: [PATCH v3 06/13] ASoC: simple-card-utils: Expose new members for
 asoc_simple_priv
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
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
 <1601573587-15288-7-git-send-email-spujar@nvidia.com>
 <878scpl7yg.wl-kuninori.morimoto.gx@renesas.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <4069b76e-cc15-2ad9-b241-caabee7e33e3@nvidia.com>
Date:   Fri, 2 Oct 2020 14:29:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <878scpl7yg.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601629112; bh=CXzFN7naPUdOMb1SLdfOKEry4YOkVLlT442HsRB7zzo=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=UMLxd9dkuisLOL3Ps+Ghf/Zo8zi6fbd2YWdiEY3H9JhFf7vI4mkdWb2NsHJBu/4Om
         PQ/1PRu6EdASNLQ0istYBCjrngmWqagzH+CvdJbhpW12F3MLvtyGzAf477BFH4MtOK
         8r0cDJ3PPwH5+LK9c+7bBjULHzq5yCszwuHXt5Ycln+sPj/p1XpRdao+eZ//IWA/j0
         51/3I/Kuw/qvno71K0482jgLrC1sTVy3XKyPnSCWHVXBZucEsjN+OWd0rekzsnEV+N
         HVzMg/rziLin2KumBlc5rc5Fhuufu+nop2k8PREYvQQg3Dwp9mOO+SYyyUxXb8cLHW
         9HAiN7ijjUodA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_ca=
rd_utils.h
>> index 86a1e95..9825308 100644
>> --- a/include/sound/simple_card_utils.h
>> +++ b/include/sound/simple_card_utils.h
>> @@ -56,6 +56,10 @@ struct asoc_simple_priv {
>>        struct asoc_simple_dai *dais;
>>        struct snd_soc_codec_conf *codec_conf;
>>        struct gpio_desc *pa_gpio;
>> +     const struct snd_soc_ops *ops;
>> +     unsigned int force_dpcm:1;
>> +     uintptr_t dpcm_selectable;
>> +     void *data;
>>   };
> I have opinions about these.
>

> About dpcm_selectable, indeed current audio-graph is using it as "uintptr=
_t",
> but as you know, it checks whether it was non-NULL or not only.
> This means we can use it as bit-field.

Yes that is true. Something like this would work?

graph_probe(...)
{
 =C2=A0=C2=A0=C2=A0 ...

 =C2=A0=C2=A0=C2=A0 if (of_device_get_match_data(dev))
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv->dpcm_selectable =3D 1;

 =C2=A0=C2=A0=C2=A0 ...
}


>
> BTW, do we need to have dpcm_selectable at priv ?

Tegra audio graph driver does not require this because already it is=20
populating 'force_dpcm' flag and having 'selectable' does not make much=20
sense for it.

>
> One note is that, -scu- user is only me (locally),
> and it will be removed when audio-graph2 was created.
> (My plan is keep code for you, but remove compatible)

Right now I am just keeping it to allow current code work. Later you can=20
remove this during graph2.

>
> About *data, I think we can avoid *data
> if driver side priv includes asoc_simple_priv ?
>
>          struct my_priv {
>                  struct asoc_simple_priv *simple;
>                  ...
>          };
>
>          #define simple_to_priv(_simple) container_of((_simple), struct m=
y_priv, simple)
>

This seems like a better plan, will do this.
