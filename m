Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B21A2F5935
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbhANDWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbhANDWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:22:03 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2297C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:21:16 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id b19so6054697ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:date:from:to:cc:subject:in-reply-to:references
         :user-agent:message-id:content-transfer-encoding;
        bh=e8o9nnXi5RG4XQOctynawgvO1Wqca26EMiyBfJ6Ucxo=;
        b=Nhvz6CiQmuaJ5NDzM4wOUVBfwPD/Oa7cKP0K57low62jXxbFmdebNQjwrpVK/iiIUU
         lLCBq1k872iItvCyjPgpQBGWBBRhgq7SXyh1kJFZ9MyJ9Ya894jO0nRZaAbULhQRDOSd
         kRIHjjuiDdhYuRCXfVF1dGfUIB7NJD3xiSCd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:from:to:cc:subject:in-reply-to
         :references:user-agent:message-id:content-transfer-encoding;
        bh=e8o9nnXi5RG4XQOctynawgvO1Wqca26EMiyBfJ6Ucxo=;
        b=tkmHLS42Lx4jwBpY1WAx/rNdGbzHsqDxIJ3qNjaCptSw6KAvgT3xGf3fWRQqQDyN17
         72Gox64rW4Y9mwi/OYkAtPHkaOI5ko52w4+OdGF1WhvefFUg9HJRHQt8p9kTX7mga+4P
         nrjHUYs4vQglJoq6xdz3R/Z9unYTVed/Z0ccGcMnLwxdQqXZ7dMHVALiV9U/vFMsz3Mh
         iq3i/fZgaO96ufcDAO5jwZMNfX2lmULALlkwNh/gFz7vaw11C5tIoS+KGA9YJr0qVtbJ
         iW6tkWZIjMMb2PIfpuJ5YOMDXUGWgUH5jthmfm/UMA0KVFDe5s6pjJBUcAy+2pQAokun
         MGKw==
X-Gm-Message-State: AOAM532lqPo+mGiyrfSst2knMdG0X6XwbZZIiia2AbraVAWzaGq09txx
        Xn2J+83qWoh67Nt9NF1F0joNdMNF8/4niw==
X-Google-Smtp-Source: ABdhPJxD+e+EShCCPdgb5iF8MxiRPwctxHD+pc3D99zfl+l7eyYGi4kJWvzU1WdSaSVcyMyP6JJkzA==
X-Received: by 2002:a92:845c:: with SMTP id l89mr5111026ild.114.1610594476086;
        Wed, 13 Jan 2021 19:21:16 -0800 (PST)
Received: from sunraycer.home ([2601:246:4400:318::100])
        by smtp.gmail.com with ESMTPSA id o15sm246979ilq.44.2021.01.13.19.21.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 Jan 2021 19:21:15 -0800 (PST)
Received: from 10.10.2.100 (sunraycer [10.10.2.100])
        by sunraycer.home (Postfix) with ESMTPSA id 916D1376D3A;
        Wed, 13 Jan 2021 21:21:14 -0600 (CST)
MIME-Version: 1.0
Date:   Wed, 13 Jan 2021 21:21:14 -0600
From:   Steve Magnani <magnani@ieee.org>
To:     =?UTF-8?Q?=E5=B8=B8=E5=BB=89=E5=BF=97?= 
        <changlianzhi@uniontech.com>
Cc:     jack <jack@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>,
        282827961 <282827961@qq.com>
Subject: Re: [PATCH] udf: fix the problem that the disc content is not
 displayed
In-Reply-To: <1400033179.660265.1610592703732.JavaMail.xmail@bj-wm-cp-9>
References:  <20210112055304.31842-1-changlianzhi@uniontech.com>,
 <9495f2dcd2882a43678532eb8df356bc@ieee.org>
 <1400033179.660265.1610592703732.JavaMail.xmail@bj-wm-cp-9>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <25d238d333d16079d4cc992c8dc0ff94@ieee.org>
X-Sender: magnani@ieee.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-13 20:51, 常廉志 wrote:

> On 2021-01-11 23:53, lianzhi chang wrote:
> 
>>> When the capacity of the disc is too large (assuming the 4.7G
>>> specification), the disc (UDF file system) will be burned
>>> multiple times in the windows (Multisession Usage). When the
>>> remaining capacity of the CD is less than 300M (estimated
>>> value, for reference only), open the CD in the Linux system,
>>> the content of the CD is displayed as blank (the kernel will
>>> say "No VRS found"). Windows can display the contents of the
>>> CD normally.
>>> Through analysis, in the "fs/udf/super.c": udf_check_vsd
>>> function, the actual value of VSD_MAX_SECTOR_OFFSET may
>>> be much larger than 0x800000. According to the current code
>> l>ogic, it is found that the type of sbi->s_session is "__s32",
>>> when the remaining capacity of the disc is less than 300M
>>> (take a set of test values: sector=3154903040,
>>> sbi->s_session=1540464, sb->s_blocksize_bits=11 ), the
>>> calculation result of "sbi->s_session << sb->s_blocksize_bits"
>>> will overflow. Therefore, it is necessary to convert the
>>> type of s_session to "loff_t" (when udf_check_vsd starts,
>>> assign a value to _sector, which is also converted in this
>>> way), so that the result will not overflow, and then the
>>> content of the disc can be displayed normally.
>>> 
>>> Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
>>> ---
>>> fs/udf/super.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> diff --git a/fs/udf/super.c b/fs/udf/super.c
>>> index 5bef3a68395d..6c3069cd1321 100644
>>> --- a/fs/udf/super.c
>>> +++ b/fs/udf/super.c
>>> @@ -757,7 +757,7 @@ static int udf_check_vsd(struct super_block *sb)
>>> 
>>> if (nsr > 0)
>>> return 1;
>>> - else if (!bh && sector - (sbi->s_session << sb->s_blocksize_bits) 
>>> ==
>>> + else if (!bh && sector - ((loff_t)sbi->s_session <<
>>> sb->s_blocksize_bits) ==
>>> VSD_FIRST_SECTOR_OFFSET)
>>> return -1;
>>> else
>> 
>> 
>> Looks good. Perhaps consider factoring out the conversion (which also
>> occurs
>> earlier in the function) so that the complexity of this "else if" can 
>> be
>> reduced?
>> 
> 
>> Reviewed-by: Steven J. Magnani <magnani@xxxxxxxx>
> 
> Thank you very much! So, which one of the following methods do you 
> think is better:
> 
> (1) Change the type of s_session in struct udf_sb_info to __s64. If you 
> modify this way, it may involve some memory copy problems of the 
> structure, and there are more modifications.
> 
> (2) Definition: loff_t sector_offset=sbi->s_session << 
> sb->s_blocksize_bits, and then put sector_offset into the "else if" 
> statement.
> 
> (3) Or is there any other better way?

I had #2 in mind.
------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
                                   Earthling, return my space modulator!"
  #include <standard.disclaimer>
