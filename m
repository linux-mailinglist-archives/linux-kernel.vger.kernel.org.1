Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1AD2F0BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 05:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbhAKEui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 23:50:38 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3506 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbhAKEui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 23:50:38 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffbd8f50000>; Sun, 10 Jan 2021 20:49:58 -0800
Received: from [10.25.100.239] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Jan
 2021 04:49:53 +0000
Subject: Re: [PATCH] ASoC: audio-graph-card: Drop remote-endpoint as required
 property
From:   Sameer Pujar <spujar@nvidia.com>
To:     Rob Herring <robh@kernel.org>
CC:     <broonie@kernel.org>, <kuninori.morimoto.gx@renesas.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1607498532-19518-1-git-send-email-spujar@nvidia.com>
 <20201210021550.GA1498001@robh.at.kernel.org>
 <1fd0f074-c437-2b83-e395-d4b83ae49444@nvidia.com>
Message-ID: <5bb5c1bf-34c8-6c59-63c1-fa93d4b68f08@nvidia.com>
Date:   Mon, 11 Jan 2021 10:19:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1fd0f074-c437-2b83-e395-d4b83ae49444@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610340598; bh=e8XqNFSxdK2VUGmE8qRW6SXK86Nnm5AcKjr9gMHphpI=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=SHyf0qx0lz6wC1LySFTX6c68Jw05DuZkrLD49WuG+GnRT+MaEvEf93UUbFuM6ib/C
         kZUGyNYmjqrB3UDOAu2J2P428P889msgtivFmL2WjyoToQfs4Jjip8bxsTG3n1rgL3
         SAhGhom8o2YdGo5xZD418i+GEDUqab35W5leyPlJ0PnW3Jhc67+AAxDpdtIcRm9uFd
         BtCTx3OsSW7h/z6DlGDoHmHzlCzzolDj7HY6AIe0e1ABaOsdUIIuyLCghljNYOhjCP
         E68vpgIjA0Yo71lOFeplpmHi1bH8K6S5tTjly2UVCm0Io2PYTQ3CNI8A0HK24M6voi
         X7eJ7K0GlPV1A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


On 12/10/2020 8:14 PM, Sameer Pujar wrote:
> Hi Rob,
>
>>> The remote-endpoint may not be available if it is part of some
>>> pluggable module. One such example would be an audio card, the
>>> Codec endpoint will not be available until it is plugged in.
>>> Hence drop 'remote-endpoint' as a required property.
>> Please hold off on this. I have more changes coming.

Sorry to bother you again. Is it possible if we take this patch now and 
your remaining changes can come later? This would help to unblock below 
series, which is pending quite some time now.

>
> OK, I will wait for your patch. Kindly note that this is currently 
> blocking series 
> https://patchwork.kernel.org/project/alsa-devel/list/?series=391735&state=*

