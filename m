Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB037269651
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgINUWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgINUVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:21:24 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4FEC061356
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 13:21:24 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e7so1145878qtj.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 13:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PibvaXKoznf5f0ofpz35J88QRgIi2RKLSkzT49/BMFo=;
        b=NsPJNjED9anboAsRVmaMfkp4+nZaSyWJ+pH6SjTdYa5ss7vIf+9uzg3ONT7cfz6sds
         TICFfkUMJpkTMW6KUP6/JqSzBsP0SiOE2pFGgIHQ7ihRq9ZyzAkGOUm2JqAa/+jZbr5h
         BcB3cxoPlx/vR/jNC21lvQAyKdd6LxPX/vSqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PibvaXKoznf5f0ofpz35J88QRgIi2RKLSkzT49/BMFo=;
        b=t+6fY9hjX/9PRrTVttklut30e63aPmK+ZeDg2U1x4k9uDRMvuGMqKts9XhsWnIoows
         IPIalwCm8/QoqsL5nv33UKeYEsXlLiFVPbnT8Nv6S4ln+hDYo4BDMFP9hYZ6NEniS3bz
         XHUBkZbmP+7tk3uVvruGaXERCG4nrdNSPHPb1WYyXMxlq7WcjUkj2ivU67Q5z9n6iBiO
         t1lwSYl/3j/5B+HknQI1HQfnY9p3YImSD6ACpj1N4NMqjUcrkrfTNKznYOfEnfVtBOJa
         zu6cFihmGGYUvhSS0b3NhDEOSo7Q8ez9PQz4RvKSbx9MVtRqlnxmiRtH6CTUO+6McW07
         Lt0Q==
X-Gm-Message-State: AOAM532g/j988yf9TysCFfaXwAB1hBlmnZgj8EMtvqBZjcTrDEEf/7T3
        L+8MZq1D5YHkDN7+ArXVCvD0ng==
X-Google-Smtp-Source: ABdhPJxVMkiX3m94aVgDXiGhsRMu0roOO/EAg17fNyawnWQkijB0WjKEVXEoiSXN9GYF6ralSMf9ew==
X-Received: by 2002:ac8:474a:: with SMTP id k10mr15348990qtp.115.1600114883163;
        Mon, 14 Sep 2020 13:21:23 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id v90sm15138751qtd.66.2020.09.14.13.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:21:22 -0700 (PDT)
Date:   Mon, 14 Sep 2020 16:21:22 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     nikolay@cumulusnetworks.com, davem@davemloft.net,
        netdev@vger.kernel.org, paulmck@kernel.org, josh@joshtriplett.org,
        peterz@infradead.org, christian.brauner@ubuntu.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au, roopa@nvidia.com
Subject: Re: [PATCH net-next] rcu: prevent RCU_LOCKDEP_WARN() from swallowing
 the condition
Message-ID: <20200914202122.GC2579423@google.com>
References: <20200908090049.7e528e7f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200908173624.160024-1-kuba@kernel.org>
 <5ABC15D5-3709-4CA4-A747-6A7812BB12DD@cumulusnetworks.com>
 <20200908172751.4da35d60@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908172751.4da35d60@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 05:27:51PM -0700, Jakub Kicinski wrote:
> On Tue, 08 Sep 2020 21:15:56 +0300 nikolay@cumulusnetworks.com wrote:
> > Ah, you want to solve it for all. :) 
> > Looks and sounds good to me, 
> > Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> Actually, I give up, lockdep_is_held() is not defined without
> CONFIG_LOCKDEP, let's just go with your patch..

Care to send a patch just for the RCU macro then? Not sure what Dave is
applying but if the net-next tree is not taking the RCU macro change, then
send another one with my tag:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks!

 - Joel

