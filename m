Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C692B45D9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgKPO2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgKPO2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:28:34 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF217C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:28:32 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so18874914wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=singlestore.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JrKflSgSOMe93aJ6VW7ZfmXyv0vu7DMT8yvbPc0RDdc=;
        b=WQhmlf08AdBsMPPsXLBeb7z+Go8g1FnQhZyC6WpJ9GvtDYxj6pNpz+8sZnjNOFPcjC
         svBeMIXJu2PUqSCHpauT0JVXYcdN6AdutzM5rlMs+NqXKwRJwT/jvIc2gAqE4j4T2nWz
         db/WDtZxKHi1uHbuUtl+NyclDgoapLqql0VHdWh44iMzCe+lB+Q6AtVn0Lr6owbuxFVo
         mZpcjJQMWDzyYzgk4uvWBLohlYwYxEbdFnFVfnY5dCG6eUKimjIpmN2YHQv6cu9vaOvI
         IAHHPm7lGzbpSKifagADv3uii6Ipfcfgn/zrf0Tg8mGT+JzrQPodqj0yhnL5IQAviODU
         tABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JrKflSgSOMe93aJ6VW7ZfmXyv0vu7DMT8yvbPc0RDdc=;
        b=LPeS6AudSedI1Q6CUd0IfrBsqbA449nEl9V7i4/5kn9/dWpyRK8DxdJjfNBc/uaRpT
         nAfnG2QHpPSVJCsGhbE6eMue9BOHUlBQaZ1sraPkBLNI1Q9LC0hlPdzt7yxYaEjkKdRz
         /k80qa2mYPvXPgTicOyCCkuLvpkvVZj5AEpl6YHvT/1ttbXPGKCW7L5/n+RqxutDlTTi
         0kKm43ranEUBgEXB1WA4pDeLs46XqEW2wm0YCGQ800kdi1OmFe2p4GK2qS/0Yf+t//ip
         HHg3ZxWGVgwjaUwvNXueqILp8DnQNJ4vuwWLEbuLNDg17qKMkdfZQsUgfeyh9M0ofQqU
         q6BA==
X-Gm-Message-State: AOAM5321dGoOHjnQjhe1w+4gxlXoNqT59smxQuJhVh1aeQ3my4GpPXnA
        OVjb55Lto6PVBa2035V3ldohnA==
X-Google-Smtp-Source: ABdhPJynWW8LqCCuROcMY2njI5+Vv3gGgDlkIGQt8yivBkhzu55DbD+0wMXhhpnh7Y4Sai4HP9OgXQ==
X-Received: by 2002:a5d:66d2:: with SMTP id k18mr18829273wrw.327.1605536911509;
        Mon, 16 Nov 2020 06:28:31 -0800 (PST)
Received: from rdias-suse-pc.lan (bl13-26-148.dsl.telepac.pt. [85.246.26.148])
        by smtp.gmail.com with ESMTPSA id j8sm19294687wrx.11.2020.11.16.06.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 06:28:30 -0800 (PST)
Date:   Mon, 16 Nov 2020 14:28:28 +0000
From:   Ricardo Dias <rdias@singlestore.com>
To:     davem@davemloft.net, kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] tcp: fix race condition when creating child sockets
 from syncookies
Message-ID: <20201116142828.GA188138@rdias-suse-pc.lan>
References: <20201116120608.GA187477@rdias-suse-pc.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116120608.GA187477@rdias-suse-pc.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please to not consider this version for review. I'll send a new patch
version soon.


