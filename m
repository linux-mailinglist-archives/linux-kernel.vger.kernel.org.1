Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EADE2F9A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbhARHfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732756AbhARHfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:35:14 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA87AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 23:34:33 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id i7so10402505pgc.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 23:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ywQNKVlf2poEZ83Otrv418DuwRel+caQS4R6nBdZFz4=;
        b=lMr1sCkCo6dFuFtVHlMTg5WVsH5ih1D6GLxY/PMouhmKNU1TKY7NNgL/GDXlON6PrK
         Ja7oDtuwViEpcfsEBZR2unIRW5VlXZD5MLKBXGHS63T+wGxda6TQ8cgj9SAjpXJvnuY4
         0AWY/5aisDW0pB/u8ysda46sc/GoEEqtehs/pC9AsqyntIEZMwadawFIQaXzhDpZnCkr
         HDSdGkKsyYI3DpSY4mi0wVNBhOo0mJZT4+R/0rxi/0JDAahIXGAczZYTrT/97E1AVaYN
         MRgTjRVSoyovfJgXajRPbvObn7QlWOeZEwzixzucakZn8Y6jQZ0WGU/yZEopt2LNAlis
         0gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ywQNKVlf2poEZ83Otrv418DuwRel+caQS4R6nBdZFz4=;
        b=OhmIMfGPyCBB9YtGsh5dfDOfzCM/5IbEYftz+B/izWg+6ibAtCL6E7TudU4p39e8yz
         /TjquWb4s8WbPsXY5O45W3nhF2o20CoGQg9A+9wlzoTtx9sMwRoM9yHds2Hu+dAjHmYK
         vGw+fFFiU2JWfacDy9+2TLkdcoAiRcMgVkBDASU6nyrxhPQtXvyRzmWPQy7Mo2nrBLN+
         dTfnuu9KRJlfYnB34nlOWwMoyUoCgVQXhUXy7eEdojetK5wPpMjxh90fWFES4LEhoOep
         1wZ9ladSGXfAR+Y3DkRoWa3DeeVnjDlFCQ1NNZPMJZidJijClcmg94vlqkbb9+iScj6g
         xRtw==
X-Gm-Message-State: AOAM530mPnMiEYwfj9hb/sHFoKmK39hLM67EjE17NbJh2DfjPF0h9CvV
        xPsCp57E9rzt/eEzbePOYgFk+w==
X-Google-Smtp-Source: ABdhPJwPyitLP9VSByIJur8eBQUTlY/ClbZkLaKcRY0zhmcjgGaC+EOB7h+9IZLfuMqjxcs+4uCVgg==
X-Received: by 2002:a63:4c4f:: with SMTP id m15mr24590882pgl.54.1610955273308;
        Sun, 17 Jan 2021 23:34:33 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id np7sm14506840pjb.10.2021.01.17.23.34.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 23:34:32 -0800 (PST)
Date:   Mon, 18 Jan 2021 13:04:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
Message-ID: <20210118073430.a6lr3ynkd2duv34l@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-4-saravanak@google.com>
 <20191125112812.26jk5hsdwqfnofc2@vireshk-i7>
 <20200127061118.5bxei6nghowlmf53@vireshk-i7>
 <b0be1275-c5cb-8171-58fa-64d65f60eaf8@codeaurora.org>
 <20200130042126.ahkik6ffb5vnzdim@vireshk-i7>
 <CAJMQK-gmO-tLZkRRxRdgU9eyfo95omw_RnffFVdhv2A6_9T-nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJMQK-gmO-tLZkRRxRdgU9eyfo95omw_RnffFVdhv2A6_9T-nQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-01-21, 15:21, Hsin-Yi Wang wrote:
> Do you still have plans to push this? I've tested on mt8183 cci with:

I was never able to get Saravana to test this, if you are interested
in this stuff then I can rebase this and resend and we can see if it
works.

-- 
viresh
