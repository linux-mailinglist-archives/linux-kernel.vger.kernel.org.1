Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE0727101E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 21:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgISTFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgISTFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 15:05:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3E6C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 12:05:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z9so8687339wmk.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 12:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PZQgCTVJaoPDkS3FQ6qHauGfZhEJ//51YELEu9Y52xE=;
        b=XRXcynIbW7WqgbArclPQcpE9rGo25dMyO2eSsemk/YFMHeLfbHiqjst0TEQ+78rHZb
         C68W7Sf5VfKD9bH+9ExiVuabozsCjiY4Efbb4xNDjOLHiu4AKdUEYXptc7wMoCFzzlpS
         G2JxK46RLqiV2GWYyBFtTT6JC/GaJhocAiNXhMfPpzQ8ABJFVhbupCIfiGZQ77aPR0/s
         TJV/phA0E6XQojM9jhIJOHuF66esjN6NqH6QVahCEN3RS/qosrAwNDO/k5a2y+eCrQtR
         bd75Ui8tLMG9whY1VYcRLE62cOubNjW7Pb7X17NbSZnFT4qp0BVCPWvp4WMW/wgZycWY
         SWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PZQgCTVJaoPDkS3FQ6qHauGfZhEJ//51YELEu9Y52xE=;
        b=K3LLCqB31ZZh6Jb61Adrc/pL6vLXVBPBzcZPKBHdwEqQXKjDVoV3LsQVasdhfJ0Q9p
         HzFkUFgvUm5tsgmjaLSeerHecYPtCy82My4VDLMgtZVkZFx+iqKKQFjLeGpCNAX5HmG+
         04Mvk+vvBwGyhlMUruEK0S/0w3/mw+9jAefKyVQKmNkoKfIKOHP/LMObbiu2si1Dhv0n
         IfooBBzkAG4X8n4Z8GEkMPhPyOz2X0aU74v+sF2bEIzOdK2WL5iY247mGQbJYiubHJ5d
         glXNZA8tb9DgbB5/n4iljgX/aulkdLVlwHYMrJSQNP/GRMTZ2d87xko6jwKeMi//U+UW
         RaoQ==
X-Gm-Message-State: AOAM5302Vs3PyfG65cAt51gR3dbHDkZE5ZJgwy0ULlvtPrCzXZwcZuN8
        skOmhLXc16Nq0jU8rSVyOCLb6w==
X-Google-Smtp-Source: ABdhPJxl+y2QxzQ9a3sEy1MWsd8chRltmFlrXrtZ/mWCfmxuovfU7S/Ah6OI/8mW9RcgzuuAzQFmfA==
X-Received: by 2002:a1c:bad5:: with SMTP id k204mr22538053wmf.111.1600542310996;
        Sat, 19 Sep 2020 12:05:10 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id x2sm12624431wrl.13.2020.09.19.12.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 12:05:10 -0700 (PDT)
Date:   Sat, 19 Sep 2020 21:05:08 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     arnd@arndb.de, davem@davemloft.net, mripard@kernel.org,
        wens@csie.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, stable@vger.kernel.org
Subject: Re: [PATCH 4/7] crypto: sun4i-ss: handle BigEndian for cipher
Message-ID: <20200919190508.GA15359@Red>
References: <1600367758-28589-1-git-send-email-clabbe@baylibre.com>
 <1600367758-28589-5-git-send-email-clabbe@baylibre.com>
 <20200918073128.GA24168@gondor.apana.org.au>
 <20200918080658.GA22656@Red>
 <20200918080915.GA24549@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918080915.GA24549@gondor.apana.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 06:09:15PM +1000, Herbert Xu wrote:
> On Fri, Sep 18, 2020 at 10:06:58AM +0200, LABBE Corentin wrote:
> >
> > But I think only me will see it and since I already have this on my TODO list, I dont see any interest to leave it failing.
> > Furthermore, having a clean BE boot will permit to enable BE boots for thoses SoCs on kernelCI.
> 
> I'll happily accept patches that fix the actual bug but not ones
> just papering over it.
> 

I am sorry, you are right.
Furthermore, while respining to fix it, it seems that the current fix is enough.
I have rerun a clean rebuild and test on A10/A13/A20/A33 with BE and sun4i-ss is working fine.

I will sent a clean v2.

Regards
