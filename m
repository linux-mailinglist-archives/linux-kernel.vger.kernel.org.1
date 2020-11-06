Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD602A9A95
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 18:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgKFRPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 12:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgKFRPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:15:39 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9B9C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 09:15:39 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id ed14so777690qvb.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 09:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ANXxIZx8OahFtF4xzwzNX4YdqVaHg2s+5GptZte/gOE=;
        b=L63lbg2QmniDGJd5a4dxIrAFndNycIdwZhwtxYs+Qxv7y5+4iN6IKBL80tLuQ8W+ML
         8u0wO9MMvdmY0nZkdoO4X4PhNpnlmGn/jmuN5i0zBP41zIiuLPdN2qYWkoP8fwvUEdr8
         i3asb9BAg8ipiJPc5IdL8RfO3v4YzJIs0OOtUEvGvVOYKtHkAKMyj5B+rfHHYlbdRKhy
         hU7hN/sbEQw1EqDBD9c5duJHpeoPY1EnAZRbwbDgVk3DuXXBlTbwAEXtWhlVj+UheA9q
         iMn5NdRk+MyS6zFBsGNx6Gkd6a/cBIp/gTYZtLAgZrlzIdJoAhUMboc4TSdoZw5slaBM
         hmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ANXxIZx8OahFtF4xzwzNX4YdqVaHg2s+5GptZte/gOE=;
        b=pFB7hzu1U3AAkfV32Opb75NRs/3f2YcW+ef+u+fWKyRZvAD60UK0DDqg+sMqIEKB1j
         KxbL17WOehtoFsjfYrjrUpdC2onevbve6CJIOtP1pYPABUyRWXMZaEiccEZw5+zvcAWY
         tNJTi7FdDISry3s8FAxoVACvEnJRPMQ5aO5xWmWv0+B/xnnd8A97999jcj0vRJeldAyk
         gFOBbc8fYuu3tizYdudusMM4pyMwmEOkLVzSlIMmqynWKnKm025fCH3PWlHWxKOQuD1R
         zCnHjXN3mrLknB8CPktFciLka3a1nBprMjkioFWtRr2uNyB9I93yiijRKefCvnh+67xp
         bZLw==
X-Gm-Message-State: AOAM530/3LNTQ2TNIJdDIz7tyRdzAA5HAzkwGf9tNgXfJeEyU5ILS78P
        KthnWODqOUivXisbOCNKWCKSuQ==
X-Google-Smtp-Source: ABdhPJyN/9SAhQ9aRdjQ+lvSquSge3ay9Lrb+110kCzcwVvPbLGoYFikdNP97xpth1ZeP4uZJiI83Q==
X-Received: by 2002:a0c:9b91:: with SMTP id o17mr2367164qve.8.1604682938171;
        Fri, 06 Nov 2020 09:15:38 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x31sm932075qtb.81.2020.11.06.09.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 09:15:37 -0800 (PST)
Subject: Re: [GIT PULL][PATCH v5 0/9] Update to zstd-1.4.6
To:     Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>
References: <20201103060535.8460-1-nickrterrell@gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <025719a2-2432-8204-201f-adbbd293fa9a@toxicpanda.com>
Date:   Fri, 6 Nov 2020 12:15:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103060535.8460-1-nickrterrell@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/20 1:05 AM, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> 
> Please pull from
> 
>    git@github.com:terrelln/linux.git tags/v5-zstd-1.4.6
> 
> to get these changes. Alternatively the patchset is included.
> 

Where did we come down on the code formatting question?  Personally I'm of the 
mind that as long as the consumers themselves adhere to the proper coding style 
I'm fine not maintaining the code style as long as we get the benefit of easily 
syncing in code from the upstream project.  Thanks,

Josef
