Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886502B6B12
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgKQRGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:06:24 -0500
Received: from smtpng3.m.smailru.net ([94.100.177.149]:44496 "EHLO
        smtpng3.m.smailru.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgKQRGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:06:24 -0500
X-Greylist: delayed 86021 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 12:06:23 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=orpaltech.com; s=mailru;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=4N7qnZVKZ6kP6QlmaqCLOL8IFxmq8nhjFL/g8l2nh9E=;
        b=hCTCqK5SrP2gcyF07z4p86APc/rv+yjKAF9Tgoz7111wXOWmBFRks8qz6CXzYyeBMMUFZ2+ZEFfynWtn+DNo9PuyUZJI2QHOSzEyVA6uPJCnxZ0seuJtwHPLzag1fZ0fF6Rf0W2wblQqRAJeX16C3kfDc6v8GVmEg5J6IC6FvnQ=;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <ssuloev@orpaltech.com>)
        id 1kf4Qu-0005mg-Mj; Tue, 17 Nov 2020 20:06:21 +0300
Subject: Re: BananaPi M2 support
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <9436b07d-7704-6a21-dfdb-b6aa9211d456@orpaltech.com>
 <20201116155253.n3nuvzxup6izhh3m@gilmour.lan>
 <1b4bc573-05ae-7c93-75af-50af12054b86@orpaltech.com>
 <CAGb2v64-Tq1ZsmX6D7T+s2XiooQwJDdwe2oO=1aSDGjU1c9TnA@mail.gmail.com>
From:   Sergey Suloev <ssuloev@orpaltech.com>
Organization: ORPALTECH
Message-ID: <d4e7ee22-8090-e165-393d-33a7363e554d@orpaltech.com>
Date:   Tue, 17 Nov 2020 20:06:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v64-Tq1ZsmX6D7T+s2XiooQwJDdwe2oO=1aSDGjU1c9TnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Authentication-Results: smtpng3.m.smailru.net; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD911112A01BCD94C87AF95B679045E9FBD19C6239BCC2F3603182A05F538085040F573B5607F4757F48634DFD11FB316A053A62DB5DE032E45BC10EDF8D3AB537E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE79145AB6E9E75F07EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063799A9E55CA76E18AB8638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FCBB0CEB90268CDE0D76D60006EA4315ADCCD3E45A70857085389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0A29E2F051442AF778941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C3E478A468B35FE767117882F4460429728AD0CFFFB425014E324EE88A153DDB72089D37D7C0E48F6CA18204E546F3947CBFBFE0634520CEB935872C767BF85DA22EF20D2F80756B5F40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7465FACE6EB770F7443847C11F186F3C5E7DDDDC251EA7DABCC89B49CDF41148FA8EF81845B15A4842623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-C8649E89: CBC1436E3DDFC5B780E6EF887D0F3B8A447F00EB6B81C0D0CE32E681697AD82B7D5E7EF9E52F8199
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj9XlJEe7UB2qkmQkHj37Vmw==
X-Mailru-Sender: 689FA8AB762F73937240DDB2502DDB70760953E572910E5DDF673E7E1FD321A6778B5FB1219D8779F6BCD4B1DE95BF653AE5922765F965CDF1D7D1B96E5495AE10FCEA6DFE3E0A150D4ABDE8C577C2ED
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, ChenYu,

I have tried to build and run linux-next  by tag  "next-20201117".
Now the boot log looks different but the kernel still hangs. See 
https://pastebin.com/gFk7XuBc

Thank you,
Sergey


On 17.11.2020 11:06, Chen-Yu Tsai wrote:
> Hi,
>
> Please try linux-next. There were some regulator fixes that got merged recently.
> One of them fixes an infinite recursion when resolving regulator supplies.
>
> ChenYu
>
> On Tue, Nov 17, 2020 at 1:12 AM Sergey Suloev <ssuloev@orpaltech.com> wrote:
>> Hi, Maxime,
>>
>> it just hangs on that last lines and nothing happens anymore, see 5.18 log.
>>
>>
>> On 16.11.2020 18:52, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Sat, Nov 14, 2020 at 08:20:54PM +0300, Sergey Suloev wrote:
>>>> Hi,
>>>>
>>>> I noticed that BananaPi M2 (A31 SoC) does not boot anymore on modern
>>>> kernels. The problem arises somewhere between 5.7.19 - 5.8.18. I have saved
>>>> boot logs for both versions https://pastebin.com/DTRZi8R7  and
>>>> https://pastebin.com/PS2hq07A. Logs have been taken on clean/non-patched
>>>> kernel with default config, u-boot v2020.10.
>>>>
>>>> The kernel versions 5.7.x and below work well (I tried 5.5.19 and 5.6.19).
>>>> The versions 5.8.18 and above all fail (5.9 and 5.10).
>>>>
>>>> Could you look at the problem or provide an advice about further
>>>> investigation, please ?
>>> I'm not quite sure what the issue is exactly? How does it fail to boot?
>>>
>>> Maxime
>>
>> Thank you,
>> Sergey
>>

