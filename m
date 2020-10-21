Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455252951E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 19:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438275AbgJUR4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 13:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409079AbgJUR4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 13:56:05 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F63C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 10:56:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a17so1550640pju.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lzul3FMJv/xeo11nXKkbOk4KrDGxaWV8W5UIU+yj0Ho=;
        b=qeNKjMskhs9+4r5kftT5Vpo+Ajd7JYFyChtNH3JmBV4t0pAXc30t/kemLfEu+5SAAm
         QBZ72+1/7uvSRdIiIpkF6EtyBMuwLxS5ZvH+Wkm+WYmToXIZFk89LxX2K1mPP7t+Gnb9
         7Nl/Jf42bt/EeN5W/LqXejB/77GJMRgUn08SWaPhU0nMWNMrmEizaGPwNI6IRu/1IXXx
         Fqj8LnFf8X2rmWF5s0llNbwB3QpaL/ELcdWZgfPnBqLzshjyjFWS3dppHrQKfbo8VtpP
         Bu04su66eGOeb89hxi3plNlmdHwAD+TbaCTli8mccjhSzFTEQh1xBQVrfAe4YDj3y9E5
         wpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lzul3FMJv/xeo11nXKkbOk4KrDGxaWV8W5UIU+yj0Ho=;
        b=QgPamVu36JxhIfOTY7Ee4NZsO9P/zuZDgI4JunN0KO/5uuPvyQ2SgF7xDoOJrQybjv
         Sy9rjCkaNQH/HNku5ovWE2QcbEUKkdadc2KJPEnwWqNsjDLBcE61+2pCHEAFiHnKtbmd
         L/X8cWNhmlEkUtIiGhgZrx67NJLvGlmLbwooKTG/ZxMAptcHXyCvMaYnhMleCSm0hyLo
         CpWvyTK/kTHnx+LDZZQPzmMNxZCwzP56svEovEAKDL8ZA+rr0nNYEXezl9cetpI8XUIc
         +j96bppu46sDhxpgxX9bwIPlqUxMJdfK2pXuTfxUJBtZbmRe/7ufRvXST16x8IBF4rUB
         zHtQ==
X-Gm-Message-State: AOAM533lJLGEpOlpdZ2k6CqwqCRUgdJ4w539Yr1OHtKQpj8FgjQZguVX
        wPEUY3rJbDFom3L58cOhhIacm1mRqyqLQxC1
X-Google-Smtp-Source: ABdhPJwl5z0xbugm0cEBUmWGWhiuC5cxC7/geDf7Ue2PpHCiJvhOkm/0ua8/MZIQWF73DJHS8nUdZA==
X-Received: by 2002:a17:90b:1096:: with SMTP id gj22mr4538856pjb.183.1603302964786;
        Wed, 21 Oct 2020 10:56:04 -0700 (PDT)
Received: from ?IPv6:2402:3a80:431:7ac0:8cb2:c45f:197:35d9? ([2402:3a80:431:7ac0:8cb2:c45f:197:35d9])
        by smtp.gmail.com with ESMTPSA id s20sm2947231pfc.201.2020.10.21.10.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 10:56:04 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: fix false positive for REPEATED_WORD warning
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
References: <20201021150120.29920-1-yashsri421@gmail.com>
 <f073750511750336de5f82600600ba6cb3ddbec0.camel@perches.com>
 <26647abf8cf14595a0dd22f10ec1c32e3dc2a8c0.camel@perches.com>
 <40ca3f0f9a960799ad0e534b77d778c90119e468.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <c4f8aae0-d805-8d09-1a87-ba64bc01c29a@gmail.com>
Date:   Wed, 21 Oct 2020 23:25:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <40ca3f0f9a960799ad0e534b77d778c90119e468.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/20 10:20 pm, Joe Perches wrote:
> On Wed, 2020-10-21 at 08:28 -0700, Joe Perches wrote:
>> On Wed, 2020-10-21 at 08:18 -0700, Joe Perches wrote:
>>> I might add that check to the line below where
>>> the repeated words are checked against long
>> []
>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> []
>>> @@ -3062,6 +3062,7 @@ sub process {
>>>  
>>>  				next if ($first ne $second);
>>>  				next if ($first eq 'long');
>>> +				next if ($first =~ /^$Hex$/;
>>
>> oops.  with a close parenthesis added of course...
> 
> That doesn't work as $Hex expects a leading 0x.
> 
> But this does...
> 
> The negative of this approach is it would also not emit
> a warning on these repeated words: (doesn't seem too bad)
> 
> $ grep -P '^[0-9a-f]{2,}$' /usr/share/dict/words
> abed
> accede
> acceded
> ace
> aced
> ad
> add
> added
> baa
> baaed
> babe
> bad
> bade
> be
> bead
> beaded
> bed
> bedded
> bee
> beef
> beefed
> cab
> cabbed
> cad
> cede
> ceded
> dab
> dabbed
> dad
> dead
> deaf
> deb
> decade
> decaf
> deed
> deeded
> deface
> defaced
> ebb
> ebbed
> efface
> effaced
> fa
> facade
> face
> faced
> fad
> fade
> faded
> fed
> fee
> feed
> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index fab38b493cef..79d7a4cba19e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3062,6 +3062,7 @@ sub process {
>  
>  				next if ($first ne $second);
>  				next if ($first eq 'long');
> +				next if ($first =~ /^[0-9a-f]+$/i);
>  
>  				if (WARN("REPEATED_WORD",
>  					 "Possible repeated word: '$first'\n" . $herecurr) &&
> 
> 
> 

Hi Sir,
Thanks for your feedback. I ran a manual check using this approach
over v5.6..v5.8.
The negatives occurring with this approach are for the word 'be'
(Frequency 5) and 'add'(Frequency 1). For eg.

WARNING:REPEATED_WORD: Possible repeated word: 'be'
#278: FILE: drivers/net/ethernet/intel/ice/ice_flow.c:388:
+ * @seg: index of packet segment whose raw fields are to be be extracted

WARNING:REPEATED_WORD: Possible repeated word: 'add'
#21:
Let's also add add a note about using only the l3 access without l4

Apart from these, it works as expected. It also takes into account the
cases for multiple occurrences of hex, as you mentioned. For eg.

WARNING:REPEATED_WORD: Possible repeated word: 'ffff'
#15:
	0x0040:  ffff ffff ffff ffff ffff ffff ffff ffff

These cases were getting missed with my approach.

Also, it is able to detect warnings for hex sequences which are
occurring less than 4 times(frequency 2), for eg,

WARNING:REPEATED_WORD: Possible repeated word: 'ff'
#38:
 Code: ff ff 48 (...)

I'll try to combine both methods and come up with a better approach.

Aditya
