Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD962B7C30
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgKRLOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:14:38 -0500
Received: from smtpng3.m.smailru.net ([94.100.177.149]:33952 "EHLO
        smtpng3.m.smailru.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKRLOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=orpaltech.com; s=mailru;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=cRIYs1UUxUrrAxf2a6Rf9XpnlZoC9URthboj7tR6tSg=;
        b=pOyBpzf6rv51/56awpurus9ZvJ+9EL/ctMubesetFMs2dSdHyesRj3NWMepLc14XrxIHxBajP5J1iuepz1/EaIVfXEvQJZMYDQZrvqC/whMtxz4GZ8yhUGy8Ny8kG1vkI45sEd6pyTO0Sdm3/18gvhCUQiGxCsNeWyCj4X5CII4=;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <ssuloev@orpaltech.com>)
        id 1kfLQ1-00019y-Du; Wed, 18 Nov 2020 14:14:34 +0300
Subject: Re: BananaPi M2 support
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <9436b07d-7704-6a21-dfdb-b6aa9211d456@orpaltech.com>
 <20201116155253.n3nuvzxup6izhh3m@gilmour.lan>
 <1b4bc573-05ae-7c93-75af-50af12054b86@orpaltech.com>
 <CAGb2v64-Tq1ZsmX6D7T+s2XiooQwJDdwe2oO=1aSDGjU1c9TnA@mail.gmail.com>
 <d4e7ee22-8090-e165-393d-33a7363e554d@orpaltech.com>
 <CAGb2v67Mhu7WzG37-5HYoZHKeFS6PNnh5--YS3YYOv=uSnaYLQ@mail.gmail.com>
From:   Sergey Suloev <ssuloev@orpaltech.com>
Organization: ORPALTECH
Message-ID: <0fd12dbb-75d6-163d-f0e1-bcb43887f5bc@orpaltech.com>
Date:   Wed, 18 Nov 2020 14:14:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v67Mhu7WzG37-5HYoZHKeFS6PNnh5--YS3YYOv=uSnaYLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Authentication-Results: smtpng3.m.smailru.net; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD911112A01BCD94C8752AD47D8602F73EF431BF067325DDFF1182A05F538085040CE5DB49809DE6E4E1D1C486DCA407035B1659DE29BA01F3848C8CC2BDA9785A2
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE721B3E54BB37EA0B4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637367CCE42412B8BE38638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FC3447104404BB7FE3E133E48A495CCE50824FA36387EEF0DB389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C07E7E81EEA8A9722B8941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C37EF884183F8E4D67117882F4460429728AD0CFFFB425014E1D3B0F1236BFD7A0089D37D7C0E48F6CA18204E546F3947C680B5A81FBA2CF506D8C47C27EEC5E9FC8A9BA7A39EFB7666BA297DBC24807EA089D37D7C0E48F6C8AA50765F7900637D9F2C517E34CD691EFF80C71ABB335746BA297DBC24807EA27F269C8F02392CD20465B3A5AADEC6827F269C8F02392CD5571747095F342E88FB05168BE4CE3AF
X-C8649E89: EC08344A4D79AF1201FEC3D17B1209534AFE6790B2E862EED8463DB6897BB69DBC17722AC869E13D
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj9XlJEe7UB2orXP/FRXSZIw==
X-Mailru-Sender: 689FA8AB762F73937240DDB2502DDB70E06EC420028CA4568BDCE0C8E7C8C476778B5FB1219D8779F6BCD4B1DE95BF653AE5922765F965CDF1D7D1B96E5495AE10FCEA6DFE3E0A150D4ABDE8C577C2ED
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, ChenYu,

thanks for for the help. I tried to use 
"root=PARTUUID=a09ef512-7f29-47b8-8e9a-db5d1d58d8be" in kernel boot 
parameters,
the new log is here  https://pastebin.com/EL3uaRpE.

Nothing has actually changed, the only difference  is that it now says:

[    1.750270] Waiting for root device 
PARTUUID=a09ef512-7f29-47b8-8e9a-db5d1d58d8be...


I verified that a09ef512-7f29-47b8-8e9a-db5d1d58d8be is the actual 
partition id from my sdcard.


Thank you,
Sergey


On 17.11.2020 20:36, Chen-Yu Tsai wrote:
> Hi,
>
> On Wed, Nov 18, 2020 at 1:06 AM Sergey Suloev <ssuloev@orpaltech.com> wrote:
>> Hi, ChenYu,
>>
>> I have tried to build and run linux-next  by tag  "next-20201117".
>> Now the boot log looks different but the kernel still hangs. See
>> https://pastebin.com/gFk7XuBc
> Due to the new asynchronous probing of mmc controllers, the mmcblock
> device numbers likely have changed, as seen here:
>
> [ 1.652275] mmc1: new high speed SDHC card at address 0001
> [ 1.652568] hub 1-1:1.0: USB hub found
> [ 1.658587] mmcblk1: mmc1:0001 EB1QT 29.8 GiB
> [ 1.661777] hub 1-1:1.0: 4 ports detected
> [ 1.670263] mmcblk1: p1
>
> You should change your root device specification to use PARTUUID,
> instead of hardcoding the index.
>
>
> Regards
> ChenYu
>
>> Thank you,
>> Sergey
>>
>>
>> On 17.11.2020 11:06, Chen-Yu Tsai wrote:
>>> Hi,
>>>
>>> Please try linux-next. There were some regulator fixes that got merged recently.
>>> One of them fixes an infinite recursion when resolving regulator supplies.
>>>
>>> ChenYu
>>>
>>> On Tue, Nov 17, 2020 at 1:12 AM Sergey Suloev <ssuloev@orpaltech.com> wrote:
>>>> Hi, Maxime,
>>>>
>>>> it just hangs on that last lines and nothing happens anymore, see 5.18 log.
>>>>
>>>>
>>>> On 16.11.2020 18:52, Maxime Ripard wrote:
>>>>> Hi,
>>>>>
>>>>> On Sat, Nov 14, 2020 at 08:20:54PM +0300, Sergey Suloev wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I noticed that BananaPi M2 (A31 SoC) does not boot anymore on modern
>>>>>> kernels. The problem arises somewhere between 5.7.19 - 5.8.18. I have saved
>>>>>> boot logs for both versions https://pastebin.com/DTRZi8R7  and
>>>>>> https://pastebin.com/PS2hq07A. Logs have been taken on clean/non-patched
>>>>>> kernel with default config, u-boot v2020.10.
>>>>>>
>>>>>> The kernel versions 5.7.x and below work well (I tried 5.5.19 and 5.6.19).
>>>>>> The versions 5.8.18 and above all fail (5.9 and 5.10).
>>>>>>
>>>>>> Could you look at the problem or provide an advice about further
>>>>>> investigation, please ?
>>>>> I'm not quite sure what the issue is exactly? How does it fail to boot?
>>>>>
>>>>> Maxime
>>>> Thank you,
>>>> Sergey
>>>>

