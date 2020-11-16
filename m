Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5182B4E70
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbgKPRsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:48:11 -0500
Received: from fallback24.m.smailru.net ([94.100.187.223]:57402 "EHLO
        fallback24.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730657AbgKPRsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:48:10 -0500
X-Greylist: delayed 2120 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 12:48:09 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=orpaltech.com; s=mailru;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=rNYPYwb/+laiTFUmEzlkSlwpaedCk38vRbca2cqYiLU=;
        b=S78p4Ftq1z1ZMZBcnvpVzpWMsF4V4X9fmhXYU2PtRBKRBTchTPtdZsTXtv1tAVrz3ShZ74y3oz7yv3Eu2BrMaIG8y9k3EzakcUK3VrAck8BInlUUtWt0lVS7gbmgzHTlrI7rrOQTAJAqFSGchiA5HIMXQCtFprMgVjstCulT9Uk=;
Received: from [10.161.100.15] (port=35286 helo=smtpng3.m.smailru.net)
        by fallback24.m.smailru.net with esmtp (envelope-from <ssuloev@orpaltech.com>)
        id 1kei3Z-0000Q1-6x; Mon, 16 Nov 2020 20:12:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=orpaltech.com; s=mailru;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=rNYPYwb/+laiTFUmEzlkSlwpaedCk38vRbca2cqYiLU=;
        b=KarBP9eC1TmHNg8cgnxQQaJsvuaRK3Dx4/UxP8+7BWFtkn4or1ZEjy9ZuKZHFJsXfYpJrdeSKr+Q9W0khu6XXtRpyUkyPwCkPWH62GGtO6nWW0VksmkxmJoLffTHMRe5KP7Hjocjr4V29RCOAIl3UYUDnz3sR5WyytlakBzTEtA=;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <ssuloev@orpaltech.com>)
        id 1kei3T-0003Mn-Gz; Mon, 16 Nov 2020 20:12:40 +0300
Subject: Re: BananaPi M2 support
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <9436b07d-7704-6a21-dfdb-b6aa9211d456@orpaltech.com>
 <20201116155253.n3nuvzxup6izhh3m@gilmour.lan>
From:   Sergey Suloev <ssuloev@orpaltech.com>
Organization: ORPALTECH
Message-ID: <1b4bc573-05ae-7c93-75af-50af12054b86@orpaltech.com>
Date:   Mon, 16 Nov 2020 20:12:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201116155253.n3nuvzxup6izhh3m@gilmour.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD911112A01BCD94C8790FF3BBA24F9ECB0ACDD9039095C161A182A05F538085040A0638A4C6AB2496C994F72DE22A4EFBB3E003A11F75BE60EA8D0BE65B10BB0C0
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7DECE8D0A5E25C0FCEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637352A1F9739ED04D38638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FC88A04C88274C1C0AEA130A1BCED085D26E21F99C1F38098A389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C07E7E81EEA8A9722B8941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C317B107DEF921CE79117882F4460429728AD0CFFFB425014E324EE88A153DDB72089D37D7C0E48F6CA18204E546F3947C680B5A81FBA2CF5042539A7722CA490CC8A9BA7A39EFB7666BA297DBC24807EA089D37D7C0E48F6C8AA50765F7900637E1D28260EDACD3A0EFF80C71ABB335746BA297DBC24807EA27F269C8F02392CD20465B3A5AADEC6827F269C8F02392CD5571747095F342E88FB05168BE4CE3AF
X-C8649E89: 4FC519BF23DD427EC542F89CE3CC61B3BB3E6FDE8AC61FC137A9EC13D7EBB23AA9955A18ECBC4F14
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojp+2EUM09doGKaCpIFikk2A==
X-Mailru-Sender: 689FA8AB762F73937240DDB2502DDB706A485F5A64250F25BC25966AA7EC22DE778B5FB1219D8779F6BCD4B1DE95BF653AE5922765F965CDF1D7D1B96E5495AE10FCEA6DFE3E0A150D4ABDE8C577C2ED
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4F0F7332D917A15D0CDF3CA9657A6418B355FE6599C239A1668F3CF0E9FE49B696483609C6A5B38FE51BF9C2D076648B3F0B3BEE0BE1FB0776706E0FEFBC44258
X-7FA49CB5: 0D63561A33F958A5AE274083EF49C191125AF2845831C4C2F29F9188C9FCDE298941B15DA834481FA18204E546F3947CB4B51A2BAB7FBE05117882F4460429724CE54428C33FAD30A8DF7F3B2552694A4A5EC4583E1CDF108941B15DA834481F8AA50765F79006370D8CD50B7E84063A389733CBF5DBD5E9B5C8C57E37DE458B9CE521CEE623D0CE67F23339F89546C55F5C1EE8F4F765FC9A03B082221C895775ECD9A6C639B01BBD4B6F7A4D31EC0BC0CAF46E325F83A522CA9DD8327EE4931B544F03EFBC4D575705F49E3A860CEDC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojp+2EUM09doFWi2XyKs2LjA==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C90052060E016933BC03958FAECF3676B843BAB34100DB18A3DA35DA019BDE6EBFE7F30E0C387E5A547B11458020726E2BC9F3DCCAA514539E16D84263029B993B78B51B7A74EF4A1C2D70DA7A0AF5A3A8387
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Maxime,

it just hangs on that last lines and nothing happens anymore, see 5.18 log.


On 16.11.2020 18:52, Maxime Ripard wrote:
> Hi,
>
> On Sat, Nov 14, 2020 at 08:20:54PM +0300, Sergey Suloev wrote:
>> Hi,
>>
>> I noticed that BananaPi M2 (A31 SoC) does not boot anymore on modern
>> kernels. The problem arises somewhere between 5.7.19 - 5.8.18. I have saved
>> boot logs for both versions https://pastebin.com/DTRZi8R7  and
>> https://pastebin.com/PS2hq07A. Logs have been taken on clean/non-patched
>> kernel with default config, u-boot v2020.10.
>>
>> The kernel versions 5.7.x and below work well (I tried 5.5.19 and 5.6.19).
>> The versions 5.8.18 and above all fail (5.9 and 5.10).
>>
>> Could you look at the problem or provide an advice about further
>> investigation, please ?
> I'm not quite sure what the issue is exactly? How does it fail to boot?
>
> Maxime


Thank you,
Sergey

