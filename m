Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE162B7A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgKRJjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgKRJjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:39:06 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9781DC061A4D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 01:39:06 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id h12so758993pjv.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 01:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lST301jSjmBSq10zdHWdNa3dguE3h2ga71kmHkIDesY=;
        b=wsu2HEenfL7Thmo+t9FdUkwaWLB48UNcL8uUVRp19HOYk8GozIMCYNqa/kBoZfEIDj
         /T6FraKwmjw0Rs1E6Bo5EmGrX8RkC1t6lIlwByWPHM62sZ8uPw6klOaqfuzU9ff2ZtSf
         rinO4d1bFtSrmFgs7UMmWJEZbn51q9VBMy32/6FSGVIe6MfmbBJ/SoDKtOaeVcULmmE8
         zpZXos6NG9xWLW+AD4Yp4u7YdmSK5LJMlKF3Db3RffHmcxwp9YdLbNA3uWVOpcLygpYG
         SjJQQBprpBpsyfN3REiP5dPbI5yLZ2I7+CXLEfVPwRGzJAvVQnRegeA9f8xYMiTCpi9k
         JWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lST301jSjmBSq10zdHWdNa3dguE3h2ga71kmHkIDesY=;
        b=oyBhSrYLZ7tI883aMghytV6TT+OU9/DGy3Ue5/XM0OSZI4sWLNc3MenBCW9FmwlWcq
         cUX9ZRdCHkJO7YlXOJ2pEREUYaOqbSMbIT9hN8ifXOFQTCZq0Rx7PqMuJroce12eOwyg
         00f79/fd18XfgZ93oaIpc1398QyXre5xt6dPWZAGKnnlC390BtlPj9RzqVf0/rJskEjh
         fiL/DaXBPfCyTj0k+yeEyMcSbhrptyr6u4Cnj0dt0+wAPXrQ4QJvVPOt8Bme6J1TZ+0T
         pTJsO5ccRC/1mKlYJyNRLERt8Pr/w+od6rW/r/RZndWZiaENzYvH1HVwe/RuwDUh6n5A
         lFUg==
X-Gm-Message-State: AOAM531oznyfrPK8m5fTGaEdi1oB48wCz/lFzPzJEfbLok/+hq25OjmN
        nN+IwfhVq1Uw6+AFgmllZQTu
X-Google-Smtp-Source: ABdhPJzVUakyVdAR0GHELEuSJ5PfNeYyaU2S76+o3VpsnwdXURLic/dmc2oZgt8eLHpvOIg+br2aOw==
X-Received: by 2002:a17:90a:aa13:: with SMTP id k19mr3300365pjq.145.1605692345968;
        Wed, 18 Nov 2020 01:39:05 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id e184sm24725991pfe.146.2020.11.18.01.39.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Nov 2020 01:39:05 -0800 (PST)
Date:   Wed, 18 Nov 2020 15:09:00 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mhi tree
Message-ID: <20201118093900.GD3286@work>
References: <20201117151225.6a50abf8@canb.auug.org.au>
 <20201117042359.GB7787@work>
 <20201118153912.1decf6cf@canb.auug.org.au>
 <20201118154500.127aaba6@canb.auug.org.au>
 <20201118155128.64c97667@canb.auug.org.au>
 <20201118050640.GA3286@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118050640.GA3286@work>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 10:36:40AM +0530, Manivannan Sadhasivam wrote:
> Hi Stephen,
> 
> On Wed, Nov 18, 2020 at 03:51:28PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > On Wed, 18 Nov 2020 15:45:00 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > On Wed, 18 Nov 2020 15:39:12 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >
> > > > Why isn't that "fix patch" in the mhi tree (with necessary Acked-bys)?  
> > > 
> > > Ignore that, I missed its appearance :-)
> > 
> > Ignore that, my question stands (git confused me a lot :-().
> > 
> > I have applied the fix patch to the mhi tree merge today.
> 
> After discussing with Kalle, we decided to have a single patch which
> changes MHI and ath11k (fix patch) to avoid issues. I'll send it today and
> get it applied to mhi-next soon (via immutable branch).
> 

Patch applied to immutable branch and merged into mhi-next. Now you can
remove the fix patch.

Thanks,
Mani

> Thanks,
> Mani
> 
> > -- 
> > Cheers,
> > Stephen Rothwell
> 
> 
