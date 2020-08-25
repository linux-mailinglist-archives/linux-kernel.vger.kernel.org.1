Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEC02512E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 09:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgHYHTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 03:19:09 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14261 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgHYHTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:19:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f44bb5d0002>; Tue, 25 Aug 2020 00:18:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 25 Aug 2020 00:19:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 25 Aug 2020 00:19:07 -0700
Received: from [10.25.97.151] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 07:19:01 +0000
Subject: Re: [PATCH v2 3/9] ASoC: audio-graph: Identify 'no_pcm' DAI links for
 DPCM
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, <nwartikar@nvidia.com>,
        <swarren@nvidia.com>, <nicoleotsuka@gmail.com>
References: <1596605064-27748-1-git-send-email-spujar@nvidia.com>
 <1596605064-27748-4-git-send-email-spujar@nvidia.com>
 <87pn7ofs19.wl-kuninori.morimoto.gx@renesas.com>
 <97f325a6-96cc-11c5-8027-8c0a159e3da0@nvidia.com>
 <2d3aa11e-3c56-1f7a-3d41-2457f973d55b@nvidia.com>
 <87sgcbwcnf.wl-kuninori.morimoto.gx@renesas.com>
 <14691a05-cb29-a030-0e72-eca900d8eb7e@nvidia.com>
 <87o8mzwajg.wl-kuninori.morimoto.gx@renesas.com>
 <e9698ac3-0a2e-08a2-3f78-b0be0069d6ee@nvidia.com>
 <87lfi3w7hj.wl-kuninori.morimoto.gx@renesas.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <f3724be2-c79d-0815-6ff5-460a4f6c10cc@nvidia.com>
Date:   Tue, 25 Aug 2020 12:48:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87lfi3w7hj.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598339933; bh=PT6WTDioQCPbdq/KOc0iRkwH1Ym5t9uF4Cc1BSATpZg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=FNBSbR20FJjYN36jhj3xpPjRHmqNM7nWGKauDua6IkLSLhNKPdgvuM/uoUFedegK7
         gzOipcya4eeDda0nXog91znM2v0+H7z7wIfgrKeM6GzYmF2SFyLdFQ1baAF6HrAEZp
         k9aRvwS1FHBvDJHq+ybXvm/K5r66l4gF/1gP95mKdMNVJ3SCJ6DgGSJvZi3Ia98mmW
         nnobrWsOkbAXtJWjfDH5rfi52oxByhdpjoqsQfxnFme67iDBID4GBKVAXn0fv5cqSp
         1TIrSZCtQ7Mc5fp75aYgGQQnXBOg6Lw8GybFr+LSr7mGoW1Z3wd5ssPw0EJPA82lC+
         xYaUkAUFneZrw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,

>>> Other solution is create both snd_soc_find_dai_with_mutex()/without_mutex().
>>> I'm not sure which style is best.
>> I don't know how complex it is to have a unified solution. But if we
>> can protect snd_soc_find_dai() itself, things would be simpler may be
>> in long term. Right now there are separate source files for soc-core,
>> soc-dai and soc-component, but because of two approaches looks like
>> the function need to be moved around and need to be placed in
>> soc-core. Also the issue might go unnoticed if LOCKDEP is not enabled.
>>
>> May be start with a wrapper for now and eventually unify?
> Yeah, it seems has _with_mutex() can be better idea.
> I'm posting patch, but I noticed that Mark's branch vs Linus branch
> have some mismatch (?), and now I'm asking it to him.
> I can post _with_mutex() version as v2 if I could get answer.
> After that I'm happy your next patch can re-use it.
>

Sure. BTW, there are more such candidates which require 'lock' version 
of these helpers.
For example: soc_find_component(), snd_soc_add/remove_pcm_runtime() and 
snd_soc_register_dai().

Thank you for the feedback.

