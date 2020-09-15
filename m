Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBAD26B0FB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgIOWWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgIOQ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:26:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E96C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 09:26:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so3935430wrn.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 09:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dHrapBwpsWvrvFzuOTk0uSyWUcs2j2nE+q6aaks+S8Q=;
        b=R2LVUI6b3LVxmcrTw2T207w1f3CmBOTEi9U99KcQFNJPkUZB7c1kk0ZIGwsU/OCBLe
         /HEcFoxE65avOGVOhNe5ISlZ8qfobmAoFadWBJ+ndYPWqhHZ6joZqsANBSU8I0IZQJEA
         BpabIz5FjIi843oMPOrEpHjSITrza8CPGZVaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dHrapBwpsWvrvFzuOTk0uSyWUcs2j2nE+q6aaks+S8Q=;
        b=unbwcY75eIotuTLVOfuQkBSdJWzWAMHRyeBtx04VTqkBFVCmaTJ7wYm8NsC+seiU24
         wjLazJqBqw1LRN0cORca2RXu9BKDYQtntOtJh+KuSn7BzxhfhTs1SoVWu7lTawNuFmkQ
         xkAIhtcLtIlC62XlbIgvcwwq+3hlJtdS5h9z6eZkSGLF/V7Jgqi8DM6E+VDAomf1YSxX
         pl2WNHS9sEC7axuwbIagx79ZdjZvLc+i90anyaFehIIYIbBsgMAuCtJAZvI5p3PNaaM0
         kRU9X2CcLlQq6uDGWfJfhi4rcPMuRhNB3Z8DS5fheJlDv3KXz80GwNujNaic1NJyD09S
         D0Fw==
X-Gm-Message-State: AOAM5331npzDSyRYwlE0PyzIR/aRyk9n0httl08fX/MqHfDnWbKjXvLY
        SmIt9MVRUUsbrEDbTkEpV1ch24TU7+exa6VF
X-Google-Smtp-Source: ABdhPJxFWQTqFtIMY9NdvgB0CMac9uqPY+ZYKj6rRgzYfi5dn22n5jRh3rLISvWGGwuJeZam3KVBxQ==
X-Received: by 2002:a5d:6301:: with SMTP id i1mr21382993wru.323.1600187165281;
        Tue, 15 Sep 2020 09:26:05 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id 92sm29778577wra.19.2020.09.15.09.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 09:26:04 -0700 (PDT)
Date:   Tue, 15 Sep 2020 17:26:04 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@suse.com>
Cc:     zangchunxin@bytedance.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v4] mm/vmscan: add a fatal signals check in drop_slab_node
Message-ID: <20200915162604.GB2581123@chrisdown.name>
References: <20200915132741.84869-1-zangchunxin@bytedance.com>
 <20200915144737.GA2581123@chrisdown.name>
 <20200915145533.GG3736@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200915145533.GG3736@dhcp22.suse.cz>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko writes:
>On Tue 15-09-20 15:47:37, Chris Down wrote:
>> zangchunxin@bytedance.com writes:
>> > +		if (signal_pending(current))
>> > +			return;
>>
>> This doesn't match your patch title, please update it. :-)
>
>I have to admit I have completely missed this and I think that this
>should better be fatal_signal_pending because that would make sure that
>the userspace will not see an incomplete operation. This is a general
>practice for other bail outs as well.

Oh sorry, to be clear, I meant the patch should match the title, not the other 
way around.
