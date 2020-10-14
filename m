Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373D028E10D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgJNNON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgJNNOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:14:12 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB51C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:14:12 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x13so1934702pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UawW9kr1VSlFsZgDsJocSNaJ6Xn7ZSJWICbrc18ExZo=;
        b=f/kAX/pvagRkeIdnKXg+eLk1YQEk8AEaSMO4v/LAVYvP9aXQ7OTpenGA2Rt5D3rPdz
         9bos2WL/Li5bhZSEKkSLHSRWQh9fdnr2OkZnrZrcp7Z94LP8r3maCBQFCFYHdrTilqE1
         Xg/nHZJlGyNPZTsYoKnN+oQGmixOkHfnOywaqQqyzN6v0tLpxFX1KopZ4VpYO6Myf7e6
         JsrCEYpJmqWTwVqQFnifj86I7K7zAybo3a3Cjg+1aMkqNb/JQrezvJQa3jaV7Ngp5k9o
         h1A5SEjXvly0shYu332fHNUlFNUCp8ZSJVg3d8iLBA1BonYHZJBefZYHdrw5NzITkeod
         F80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UawW9kr1VSlFsZgDsJocSNaJ6Xn7ZSJWICbrc18ExZo=;
        b=PdBBJ1eI6qNNekZqq0BWw0OrdxvjIiXBoSSxCDhIIWcYBiBCX+dteSRxtIRejU/5Vq
         e6d+XdUy2JCOD0T0UAOaA8lGy1Oj6O7JQIkMcDAyrn/pn/tvGmZ+Us6UujuCSNivZ9bB
         V48Ahe22U+K/jf0yCMyZ9FehVejn66IGBOAeedMTiHjog1rqTUjegWHhl78+23F12+Xu
         aSVHPW7Id0EkmRhkqRylcNwcPDSlSMukLU6pI1PYnA9fgfz/PdCBoObLy/aAYc3tzeUO
         Zfm79aM7n3g2GNVlaEIEnPi67ghf4sgag5h7xGcapqt8OM3YkkjZlZPK7KPIm0OG2Xpg
         xm7g==
X-Gm-Message-State: AOAM532SCU+vQK7moBwgydAWA2nJIMj6GmT/+j2bsPRLgAocdqsQrp7K
        7u90pexda2PmRmHmxGhkH8naUICm/XYrJuKpR/c=
X-Google-Smtp-Source: ABdhPJworPLHLh5PTrbbUgBQX2HKwQrgckVM4USyKQLbZcOTMHSKev+j9cMneIwyEplnuMSOiDJ0Hg==
X-Received: by 2002:aa7:9358:0:b029:152:b349:8af8 with SMTP id 24-20020aa793580000b0290152b3498af8mr4352952pfn.9.1602681251951;
        Wed, 14 Oct 2020 06:14:11 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.205.44])
        by smtp.gmail.com with ESMTPSA id p6sm3327907pjd.1.2020.10.14.06.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 06:14:11 -0700 (PDT)
Subject: Re: [Cluster-devel] [PATCH] fs: gfs2: prevent OOB access in
 gfs2_read_sb()
To:     Andrew Price <anprice@redhat.com>
Cc:     rpeterso@redhat.com, agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        syzbot+a5e2482a693e6b1e444b@syzkaller.appspotmail.com,
        Fox Chen <foxhlchen@gmail.com>
References: <20201013152648.438887-1-anant.thazhemadam@gmail.com>
 <d75dc535-00be-3aa7-addb-c2615b202b56@redhat.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <48a1f8ca-54ce-09f4-45c2-b1091d4e358a@gmail.com>
Date:   Wed, 14 Oct 2020 18:44:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d75dc535-00be-3aa7-addb-c2615b202b56@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/10/20 6:34 pm, Andrew Price wrote:
> On 13/10/2020 16:26, Anant Thazhemadam wrote:
>> In gfs2_read_sb(), if the condition
>>     (d != sdp->sd_heightsize[x - 1] || m)
>> isn't satisfied (in the first 11 iterations), the loop continues,
>> and begins to perform out-of-bounds access.
>> Fix this out-of-bounds access by introducing a condition in the for loop
>> that ensures that no more than GFS2_MAX_META_HEIGHT + 1 elements are
>> accessed.
>>
>> In addition to this, if the above condition is satisfied when
>> x = GFS2_MAX_META_HEIGHT (which = 10), and the flow of control breaks
>> out of the loop, then an out-of-bounds access is performed again while
>> assigning sdp->sd_heightsize[x] = ~0 (since x would be 11 now.), and
>> also the assertion that spd->sd_max_height <= GFS2_MAX_META_HEIGHT would
>> fail.
>> Fix this out-of-bounds access and ensure that the assertion doesn't fail
>> by introducing another variable "index", which keeps track of the last
>> valid value of x (pre-increment) that can be used.
>
> That's not quite the right approach. Your analysis below is correct: the problem stems from the block size in the superblock being zeroed by the fuzzer. So the correct fix would be to add a validation check for sb_bsize (gfs2_check_sb() is lacking somewhat). Valid values are powers of 2 between 512 and the page size.
>

I see. Thanks for the review! I'll send in a v2 that implements this check soon enough.

Thanks,
Anant

