Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C43E2D5F55
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389363AbgLJPRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:17:21 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12319 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391116AbgLJOpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:45:08 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd2344c0000>; Thu, 10 Dec 2020 06:44:28 -0800
Received: from [10.25.96.159] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Dec
 2020 14:44:24 +0000
Subject: Re: [PATCH] ASoC: audio-graph-card: Drop remote-endpoint as required
 property
To:     Rob Herring <robh@kernel.org>
CC:     <broonie@kernel.org>, <kuninori.morimoto.gx@renesas.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1607498532-19518-1-git-send-email-spujar@nvidia.com>
 <20201210021550.GA1498001@robh.at.kernel.org>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <1fd0f074-c437-2b83-e395-d4b83ae49444@nvidia.com>
Date:   Thu, 10 Dec 2020 20:14:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210021550.GA1498001@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607611468; bh=Cn2SdbKc4vj3vjwSOffVYXifLl5CSX4BiFvujeiwYyA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=IWYTgTMQuAogrtBAGH0xtCBdKpmv1/fmKy+5tfawqo47inp5CQyf830M5uwP7Avp/
         GZVOehJ6zMj1kckajdiEHHvCakFIV3s8eulB2PtSPTa2Rh7tu58bry/JPfyFL/5vHZ
         Plbl6Nc7/0iNEArrM6yRhraUS1havEPGZGgrRkvpxPBH9VlGY3v7Q3dQnN43VLvKbD
         A5qyYaW+QVPCLFOrsz6j5x0dSOH8mBhnek9nbOukM8EDAsX+oIKX/KjmMfSVQgVC+O
         MUJEbEVXVDQAxCNIr1KeYxBYNobgSOboZqa0pMH80NrvwQsL6BYyL/yjwNm55/3rKm
         mMIS/zNo0Gdxw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

>> The remote-endpoint may not be available if it is part of some
>> pluggable module. One such example would be an audio card, the
>> Codec endpoint will not be available until it is plugged in.
>> Hence drop 'remote-endpoint' as a required property.
> Please hold off on this. I have more changes coming.

OK, I will wait for your patch. Kindly note that this is currently 
blocking series 
https://patchwork.kernel.org/project/alsa-devel/list/?series=391735&state=*

Thanks,
Sameer.
