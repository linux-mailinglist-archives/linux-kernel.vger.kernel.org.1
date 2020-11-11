Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC4C2AE898
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 07:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgKKGCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 01:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKKGCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 01:02:31 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F78C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 22:02:29 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id x15so433843pll.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 22:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v8ICRdbZhgZQq1yfBPmN1lNtv7KOdjfMg3ncaP3mzKw=;
        b=uU1MV07i8zGoB2ppE2ls+j+FQD4KXUTJKhd7doflmornIuwXfe42bmKsqRIZxta3mp
         RbeeSdQinfQKumSb6/mlT/hH1oBWCHfVUp8v7aXMdCNXjEj7uaKj4zNzRROYZHXnEAKo
         nEtw1RLugsM1TJgmxw2THhOPgChfqeWnc21/0gjKmiLrMBkKCxLnwqDENI0XEDtiUYoT
         I31OR0S5n2NVV9ivVZARdNnH598vOrN+KHOs3VYFcI8ZHw1CW3uoSRVDfYHO13qeDsNY
         7pRzVPoMG0rOLBYhKAd2/lICKvtaizh9P9px3EPgXE45Amlr/Gd7t+Mu0Nn81RNkB6mX
         aGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v8ICRdbZhgZQq1yfBPmN1lNtv7KOdjfMg3ncaP3mzKw=;
        b=JDjM06oj7uVnSVqzWZ0Utzm6QyEKGitF57CkXkEjuFR3MAEk39HiKxgkjyC3dm2Vc4
         2ZCetO0+NhnK1PFy4VoU7mJXa7x+lLHIpn4swK63wWnHOPAnyxrAdziN3cre+t+w99jt
         MoeSMDS2a9rysGj5zPyPk80n82tvKZhtkrplQnb6ah4HTbSVyR2Ln97b11VZ0B4US8L0
         HM/yFdy8jUjl4gr51hUhxwxNL/mIsmybt+T/OulnVqMvOiKEum9u49RXPZs2u1ENaOxe
         oL08rx8F9O/POomIMsJXaBNyHPPVgJK6EXP6sYoy4O9xBQIsJC+6qtbpaew2solV873F
         5maQ==
X-Gm-Message-State: AOAM531vs3gPGHDmGJmh/uDp4libDj0HnEku0T19+dNzzCTXMlJMwbS7
        D9qMzaTJnlFy66wIHDt5gXJJHxL5QmJOYQ==
X-Google-Smtp-Source: ABdhPJwsJh88njKtxsO6DX5+YRRXSTKvW58AxI+VV1Sm0c4v8I1p5eZvKyuzhtUEOBlV810TNsvYfw==
X-Received: by 2002:a17:90a:fd88:: with SMTP id cx8mr2181542pjb.220.1605074549468;
        Tue, 10 Nov 2020 22:02:29 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id w70sm1038060pfc.11.2020.11.10.22.02.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 22:02:28 -0800 (PST)
Date:   Wed, 11 Nov 2020 11:32:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, Sudeep.Holla@arm.com,
        robh+dt@kernel.org, morten_bp@live.dk,
        linux-arm-kernel@lists.infradead.org,
        Usama Arif <usama.arif@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: arm_mhuv2: Add driver
Message-ID: <20201111060226.cbq4pmwtrt7s2weq@vireshk-i7>
References: <eab9d7165fe30a74afc62d5b540b2dc3258196a4.1603799360.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab9d7165fe30a74afc62d5b540b2dc3258196a4.1603799360.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-10-20, 17:23, Viresh Kumar wrote:
> This adds driver for the ARM MHUv2 (Message Handling Unit) mailbox
> controller.
> 
> This is based on the accepted DT bindings of the controller and supports
> combination of all transport protocols, i.e. single-word, multi-word and
> doorbell.
> 
> Transmitting and receiving data through the mailbox framework in
> multi-word mode is done through struct arm_mhuv2_mbox_msg. Rest of the
> implementation details can be seen in the bindings document or in the
> driver itself.
> 
> Based on the initial work done by Morten Borup Petersen from ARM.
> 
> Co-developed-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
> Signed-off-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
> Tested-by: Usama Arif <usama.arif@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Bindings are already reviewed by Rob and are present here:
> 
> http://lore.kernel.org/lkml/61ca14fc441f92c1e7994e5bebae5c49811a3050.1602563406.git.viresh.kumar@linaro.org

Jassi, Any inputs on this ?

-- 
viresh
