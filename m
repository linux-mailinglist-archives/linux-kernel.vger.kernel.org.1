Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D062848FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 11:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgJFJMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 05:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJFJMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 05:12:24 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8E0C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 02:12:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ds1so1246003pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 02:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=iI+T0jVC0awhFlyLVkFV9k9t0yQtugtoKHCQe1uH6jQ=;
        b=wKmmUuU5R9eGNGqNyvYvD1AwgACh+oJv3hlwhFnw/YvjBuTRwA/qjRLtcMlQNd5baB
         A/ev7foNXQG1GXjgT3nJMtSIF80i37LmOfRtyOOWzfT+nDJ6YM3Fkzz/OswofaMS+yIO
         yhZ2zDpcY7/kMC+SRP/PCIRhjvdsAtHPCCUIbG74iG+zk/vBqecpTkFO5JgPOGDffOvv
         XgsK4+8vtVsP7XDlV7w2ZgozgngV6ahrXz9rq/YeT83/15KtuAgSG/4/cz7AATYm3oKA
         MJbGcirZ8PhaET4iuWvl4vW23yUvu85KSfjVqu5dKGHYcEv23FdHNbHdwd4yA0FCPtlG
         p1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=iI+T0jVC0awhFlyLVkFV9k9t0yQtugtoKHCQe1uH6jQ=;
        b=es2PAQPXNhuSsdfdrUg3J7SDkVObYPgenutz7hZ+8A6qLJvETTH5nnf9qboClH045M
         yD+fcOb/8Zt+V7WlYWkaFY+TNekEYXZtV1fNeB6P01qB0H3Ea7KrZTwLVjuUsoV9ZXPD
         MrYcKFbTh7CI2AUn0AWm09hfUAYwiQAtdN5qLco2wo+aFBRQXCe3cWZud6RqB2AJHskC
         TJxA82tAM0mXp0VO7orfxH4IZ2Aorn79mA6VqPgUDZ56FoB3ljScQSTFV8vDgm9GElGx
         wMlXIb6q81boU1ykwvvlfTeYx2QFvxmg9xX5mYwMi8OyXfKbxHTk5MnId/IkKwMP2ntA
         obtg==
X-Gm-Message-State: AOAM530Kg+HXOah7xEm3LsOPzKHgvsGj1bMjhosBGFd9gB4zgfS4Ru1X
        JUqDc+Mv/9s3KDgGKfuoAYdrdPIHAAqn/w==
X-Google-Smtp-Source: ABdhPJwhZoSWoDd082no1r7ReHiODxsjE5mZb8A+LxCdLOAy4JqU+2nMmElrGuVbmsLEcNRtU0s3EQ==
X-Received: by 2002:a17:90a:2ec8:: with SMTP id h8mr3484965pjs.173.1601975542231;
        Tue, 06 Oct 2020 02:12:22 -0700 (PDT)
Received: from debian ([122.174.189.32])
        by smtp.gmail.com with ESMTPSA id d1sm2665259pfn.220.2020.10.06.02.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 02:12:21 -0700 (PDT)
Message-ID: <fca6c83971bd30ee6e9e12b2d45560d0d4a1004d.camel@rajagiritech.edu.in>
Subject: Re: [PATCH 5.8 00/85] 5.8.14-rc1 review
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Tue, 06 Oct 2020 14:42:19 +0530
In-Reply-To: <20201005142114.732094228@linuxfoundation.org>
References: <20201005142114.732094228@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-05 at 17:25 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.8.14 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied,
> please
> let me know.
> 
> Responses should be made by Wed, 07 Oct 2020 14:20:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	
> https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
> stable-rc.git linux-5.8.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

forgot to add...

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>



-- 
software engineer
rajagiri school of engineering and technology

