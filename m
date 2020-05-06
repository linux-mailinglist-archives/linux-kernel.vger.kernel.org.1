Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5891C75CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgEFQKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 12:10:11 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15094 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbgEFQKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:10:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eb2e0e00000>; Wed, 06 May 2020 09:08:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 06 May 2020 09:10:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 06 May 2020 09:10:10 -0700
Received: from [10.25.100.73] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 May
 2020 16:10:01 +0000
CC:     <spujar@nvidia.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>, <nicoleotsuka@gmail.com>,
        <alsa-devel@alsa-project.org>, <swarren@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <nwartikar@nvidia.com>,
        <lgirdwood@gmail.com>, <jonathanh@nvidia.com>,
        <viswanathl@nvidia.com>, <sharadg@nvidia.com>,
        <thierry.reding@gmail.com>, <atalambedu@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <digetx@gmail.com>,
        <rlokhande@nvidia.com>, <mkumard@nvidia.com>, <dramesh@nvidia.com>
Subject: Re: Re: [RFC] DPCM for Tegra
To:     Mark Brown <broonie@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <1588250483-10014-1-git-send-email-spujar@nvidia.com>
 <1jzhalffhh.fsf@starbuckisacylon.baylibre.com>
 <fe842d81-22da-fbbe-b5e2-9872cefb9d8b@nvidia.com>
 <1jwo5pf7de.fsf@starbuckisacylon.baylibre.com>
 <20200506155311.GG5299@sirena.org.uk>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <74e724ec-72c9-e06a-cada-85110c9b145b@nvidia.com>
Date:   Wed, 6 May 2020 21:39:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506155311.GG5299@sirena.org.uk>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588781280; bh=luEZbp/2pQikNm6FKyeutAkc6bT22MBQsDLNbbelIrA=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=a9mOjW6RuG26hYzX7UOGzVEZDVrreu3mqV6fw12xry5J1FudrZ+vEg9ndnajwE97Q
         UvxZTMPsQg6LlL2Db0Z+bSoHxp2ygtUeO2JxAJauQRWWKt44llawNCjfCIBKFs3gV9
         LWQi1aF3m7ewByj1PsniavquSAbPLxtrLslPRveM122li9gSihnjFuLY6zgfQU7cWR
         9q3+wy/DGpzQCGvM4l5dJxVFoXIXiw/xbo1bnfP7ib1tdfL8cHi5vn8CSW7DXzO6k4
         FdsOiiYA7EtaQXVOjkZW0TCMFSHgwUH8fBYjN60WgW/unKVFhREP9lKoGw470ibQFw
         mhwElpSkq9KhQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/2020 9:23 PM, Mark Brown wrote:
> On Wed, May 06, 2020 at 04:47:09PM +0200, Jerome Brunet wrote:
>> On Wed 06 May 2020 at 16:12, Sameer Pujar <spujar@nvidia.com> wrote:
>>> XBAR currently exports all routing widgets which can be used to
>>> interconnect multiple components and thus implements Mux widgets. Fixing
>>> the routing paths in driver would limit anyone to try a different
>>> combination as per the need, unless driver is modified.
>> I did not mean that you should restrict the routing ability of your SoC,
>> quite the opposite actually.

>> You should just expose it correctly
> Yes, it's going to be less effort in the long run if nothing else.

This is what below reference tried to achieve in the original series, 
where all Mux widgets and corresponding kcontrols were exposed.
[1] 
http://patchwork.ozlabs.org/project/linux-tegra/patch/1582180492-25297-6-git-send-email-spujar@nvidia.com/

However it has DAI declarations too, that was mainly because 
codec-to-codec links were used to connect multiple components. DT would 
expose all these links (please note that machine driver was not sent as 
part of the original series). May be with DPCM these additional DAIs can 
be avoided, but it comes with few challenges highlighted in this RFC patch.


