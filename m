Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8351023A0AD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 10:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgHCIIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 04:08:48 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:40245 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgHCIIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:08:48 -0400
Received: by mail-ej1-f66.google.com with SMTP id o18so37646380eje.7;
        Mon, 03 Aug 2020 01:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a0yu7M1tVw0zmP1gDFbyNUMxQCWzxTIkdFlcO1sI50Q=;
        b=Tm9ZXWjzATs8hxYjcDO4hoclmKu7YD02YJ5lvDJcBvVEd7j5XcT74jAEvMfQqIKOu1
         wxeiP0f793jY34Rw46P7wGrDsmfrQyc5rjyjO1t0Piy157bFFZ4ZtVukjKT3ONNMOOTp
         uNuHLvvF7fx7uK1V5uNYAUrqaS0isDoqxK8z+d0DTrMBTjJURtZBVbGL8Qfn6IB2GrBP
         5pyPX122yNQTwMDvNKftonRsHA9rRsbg652FfSBKAvy5F2uXSm/6dxRTZXxQoNmdjxrX
         3ibdEUlMU1iQmJd4PUJrFXMX/a5ZhrCTaSzi2KaBG3mDs7csqZl2ZqstgRQR18zeHcXf
         7JWg==
X-Gm-Message-State: AOAM532ljj1tM4Vu7VKe3VQPfruWkAj/dny6znf3R3kPHrhSWcDvgmEI
        ThrmWU5svLakYEFdMIOBMW+nu35D
X-Google-Smtp-Source: ABdhPJwHcrqjaA28yGyrQjj55BAldR5dFDJiHH5/aOZ4EtnAnmSi9OPoDdHmcKT4tHNj8sn++fO6hg==
X-Received: by 2002:a17:907:20db:: with SMTP id qq27mr16105471ejb.550.1596442125868;
        Mon, 03 Aug 2020 01:08:45 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id dm5sm6828068edb.32.2020.08.03.01.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 01:08:45 -0700 (PDT)
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
To:     =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>,
        Solar Designer <solar@openwall.com>
Cc:     b.zolnierkie@samsung.com,
        Yang Yingliang <yangyingliang@huawei.com>,
        Kyungtae Kim <kt0755@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <greg@kroah.com>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Anthony Liguori <aliguori@amazon.com>,
        xiao.zhang@windriver.com,
        DRI devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <659f8dcf-7802-1ca1-1372-eb7fefd4d8f4@kernel.org>
 <dbcf2841-7718-2ba7-11e0-efa4b9de8de1@nsfocus.com>
 <9fb43895-ca91-9b07-ebfd-808cf854ca95@nsfocus.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <9386c640-34dd-0a50-5694-4f87cc600e0f@kernel.org>
Date:   Mon, 3 Aug 2020 10:08:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9fb43895-ca91-9b07-ebfd-808cf854ca95@nsfocus.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31. 07. 20, 7:22, ÕÅÔÆº£ wrote:
> Remove whitespace at EOL

I am fine with the patch. However it should be sent properly (inline
mail, having a PATCH subject etc. -- see
Documentation/process/submitting-patches.rst). git send-email after git
format-patch handles most of it.

There is also question who is willing to take it?

Bart? Greg? Should we route it via akpm, or will you Linus directly? (I
can sign off and resend the patch which was attached to the mail I am
replying to too, if need be.)

thanks,
-- 
js
suse labs
