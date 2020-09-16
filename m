Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D2926BF0A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgIPIUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgIPIUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:20:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F353DC06178A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:20:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id bd2so2789647plb.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sRXlNUBpPcwJG7ho8pSC2fr2qmBCJPPXn/Et4SZ94jM=;
        b=uXcCQQf1wRad6t5p2EHZA4cSWvYgoQlphQaCvr/9edBc5HxS0t//4SYiFFUnRZhqYW
         IswJYeCPEn7Pcg3Ht1vyBHX3rTSSSpUqO6HGt4sVZx2qgJRqYUz9i8YgXE5GG7OqvkkB
         pwLYfQD3Rux7wdnPNwWJGULhZbYCNTXkoWcoJLHc8+vqPXTF6kdEctgSwCnPp6Pxt1nr
         Puc07ryj+iTZCS3RjWXfO1X/XVeY+Z6WvUU0ugjL4YRKGe2wzYqtIECkpkc34xPjWBFj
         /r9YElLOcghJZotk+hz4TE7oyjYsvlsDHVDmT6bnYUXGeaPpiW/klZxXn2lObe0DxLb5
         +1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sRXlNUBpPcwJG7ho8pSC2fr2qmBCJPPXn/Et4SZ94jM=;
        b=dyGJFqR0rq/jlWUuK0guK4/tinWaHWg3ttUMId7TijWn5KBs22PvQkyLbF83SSVJRq
         eTA4gKXUfV0ehvho0WnUZHqvpnyOadrDZuoaxVbDYY4v7vKRv6vUMJP95oq3Dy4isXYW
         QXZLxDwmfwUzNdRRMHITFeqgIJP7bBXwNx433ZZZdLkNH2CIVkBTLMdjU79ZBiaa/aS9
         QVDYR0MOei/WpTxEH+2iySEqCtDKmU38Py7N0CdXj7ahTh+FUtHoIzjGw6HgWVXu9nbg
         Mb6waKaOR3YQKOCYVkd2k5q6YoJoUOe4UZfa86cveJK324CdEK0rURDJwL50ujwm8kKD
         1diA==
X-Gm-Message-State: AOAM533tLIvPtjGzpppzDe10y/iAjThQQaDB5NS9HGnJucQ4YNLHEXCl
        0tgUGVlmMmQ8mVPz8tqOO4x8tw==
X-Google-Smtp-Source: ABdhPJwosX1dsPVfU63m3wT2UBevBfM4fKezt19L7wNgzT1UIcYSHOCQMswM6ddtbiUlQI0YoPBIFQ==
X-Received: by 2002:a17:90a:d496:: with SMTP id s22mr2812015pju.167.1600244445510;
        Wed, 16 Sep 2020 01:20:45 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id a1sm15944760pfr.12.2020.09.16.01.20.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 01:20:44 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:50:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-clk <linux-clk@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: Unable to handle kernel paging request at virtual address dead -
 __clk_put
Message-ID: <20200916082042.ejzaje62k4bl2hhy@vireshk-i7>
References: <CA+G9fYvYEsxjU_cnm6oWFgOrU4x0T1CMoN-L2SHLGeJC6MF54Q@mail.gmail.com>
 <CAPDyKFqVB_hgDghaYU1B1BbWUuL6GHhWMbZEYM-cXDQ8T8ThfQ@mail.gmail.com>
 <20200916052239.7c5z4wqqrdpauti4@vireshk-i7>
 <CAPDyKFrxrKRuJec0pDLooovV3BJBVvmDizoL6N4eb+hv1D0NgA@mail.gmail.com>
 <20200916080728.ajqzw75spcmbbwsc@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916080728.ajqzw75spcmbbwsc@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-20, 13:37, Viresh Kumar wrote:
> On 16-09-20, 09:37, Ulf Hansson wrote:
> > I have the board as well. If you need some help with testing, just let me know.
> > 
> > In any case, I will try the revert and see how that changes things.
> 
> I am testing this with help of Naresh currently, will try to update
> back today itself.

I think I have found the issue and it is with a new patch from the opp
tree (which isn't merged upstream yet):

commit 99f1c7ff37b0 ("opp: Handle multiple calls for same OPP table in
_of_add_opp_table_v1()")

I have asked Naresh to run it again, lets see.

-- 
viresh
