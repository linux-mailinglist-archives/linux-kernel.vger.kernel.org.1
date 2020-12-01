Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61CD2CAE12
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbgLAVKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgLAVKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:10:11 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED22FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 13:09:25 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id bj5so1900900plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 13:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kleAjzFWz3OtpNLf1se50VCeK2jIcs1puUlgppjlZ1k=;
        b=hegUEwHK7aBzv388RWHuQf1ZvdsqiuwqJ7fIe1QhmYtAUMH/uEp09Noqwbh1zwG+rE
         ShFkiMjifoU1x1uMGh+6kzGQ2P6fi3Xla29QypgH5/EoNNpumHq/OvbVh5fTlebWmO1Z
         +54VveptOaiRCl9gfzwHRmIUI879W+t4ldBAcTYTNLCCiAaCE9kZjutGfcTI9UzQb/co
         CzCBXtXp/0rlU0EkOEw5fVNW8EZOmGvz1P1Q+WRJqtQ7867HvialFzKiRCyb7Q6mnBE+
         WnfoTlGN0sqfnj/EmlgrWilnB04enIItURSBYTXt56Ja9nacl6FH30+qUvPOIqDdOs8L
         Zg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kleAjzFWz3OtpNLf1se50VCeK2jIcs1puUlgppjlZ1k=;
        b=p1fQwMvaE/XVwm13q0CeuifWadDP/qPc/uNoWnqkfvD7P/vmtgdXsc08YxdPK7v/vt
         SdTHBW33LutqOkYA5EJSrSETuAwK3QrpObBmmvSF4XeswyOILxbcWM+33aPXFs/GCP9O
         WxR1JUxRMZhTRNHVtqNWj7nS87d8AYxQJiHvH1e3DYlspctBEtVbSRxcjVBl9SvTX4vA
         GkmK5EitI9G4hNiYfsIKbBUPUL0rzrQPnbkGmS6/qFNlv+HvFi+m7u0IM9+91gX61QT9
         nlUcuYaeuJUtp07YCejOTIGLTpmbzwa7TuILYmJLEW5aeaiFeERNgDgTEVEx6KQ090Ir
         hQFg==
X-Gm-Message-State: AOAM533Efk7fMu2O60VN2PGC755ogwbgMKN3pX0R5M4hDeaRbIu359w9
        ZUdEn/fxA/jA2dtpo+Jk80nacW8DB8stbQ==
X-Google-Smtp-Source: ABdhPJx/BGxD+kEKndgvRce77NwrUIEJ2SIBBz3GSo7W9NgywajW0dPPa9AHd8ZZm+U5I3c4y90Kww==
X-Received: by 2002:a17:90b:1a90:: with SMTP id ng16mr4645117pjb.58.1606856965447;
        Tue, 01 Dec 2020 13:09:25 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id o132sm652093pfg.100.2020.12.01.13.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 13:09:24 -0800 (PST)
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20201202080254.4e8dbb43@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9ef33d53-a98e-7608-da86-f3cf7b4b6da1@kernel.dk>
Date:   Tue, 1 Dec 2020 14:09:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202080254.4e8dbb43@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 2:02 PM, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   573cc9d095bc ("blk-cgroup: fix a hd_struct leak in blkcg_fill_root_iostats")
> 
> Fixes tag
> 
>   Fixes: ef45fe470e1 ("blk-cgroup: show global disk stats in root cgroup io.stat")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
> 
> For the future, this can be fixed by setting core.abbrev to 12 (or more)
> or (for git v2.11 or later) just making sure it is not set (or set to
> "auto").

It's in Linus's tree, not in -next. The ship has sailed...

-- 
Jens Axboe

