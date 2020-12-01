Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BF82CA7F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404087AbgLAQPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391863AbgLAQPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:15:24 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBF0C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:14:44 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id i199so1764758qke.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=avgRXnd8j+QxsVfc7Ic+GJ02ooreXv3FnbHJhamyUPo=;
        b=OsET1qPLzEyC70kGFtKhMV9KFQpH1ETjgZxb/UxZQrmtvcuurbMCe2rm0DXg/yot6F
         cjSRiUQUIiO+8D63hPM/TW8rEVXksgKP0kWPDBIZ8AvTpctgVc0UvMaJxL2k4NqEaQVO
         3eyMq3bBKjE3RJVBxlYztaNerqAcGHnIxS3zp5xq51MOXhs87Wmb4N1xgAty8SVAZdPa
         uquTeta2cmxmX1PefNPXc5zPANlQspI/toAX0GtAF9z3fCYSeGTl+3YJXtLwgQGXNDDH
         v2DDjCWhIUuwQrZzL8v3MXZYWFnKFax0FvkPOobJVcrwcsAsGBZnL6aUZOmaTTqfqJcW
         02TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=avgRXnd8j+QxsVfc7Ic+GJ02ooreXv3FnbHJhamyUPo=;
        b=AgyO26mwGaP7vNSv+PUVgoFdsDvqbUU27iKj1IcTbfzo5jbEINoJaidVvQLTBnMxnA
         BLtGg6N3gYyML816nWSI/MGDyTDki6IS2yPE7vyOYtEo2Fe4dJUZSbBFpXL+opms97u8
         uom8qXgDZXimELyxLrvFLbfnXWLiTwNv2WLyZro9jbITFZh30obq8+54L1SJlchK/70v
         +5hwGN2XNfL3oZmgTYX2rBXueLGMFm3UrCw8DuU5F7n67A1Z9DrXh6KJchwXlqA4nF0H
         4rq/ywgMVX7okQFWGdkvfZ7u4fBLL8ln92hVDl6cczEhy/fcARx1AdgCHT9H+a2RVcWf
         ADhg==
X-Gm-Message-State: AOAM5311+g2C6LckKc98vvHigXmPfRoZLJ96tjMyQuDVND73XDA+AkVt
        6LK+MJMeB0IAF69wrmrLTZMepg==
X-Google-Smtp-Source: ABdhPJxTaP6VsLYhzVP+qI+scR+htUxHduxYT5kfooYOitLqz+QsvdotJZrFGHI77esG0ag8l8ODGw==
X-Received: by 2002:a37:9b17:: with SMTP id d23mr3599498qke.254.1606839283716;
        Tue, 01 Dec 2020 08:14:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id z26sm31460qki.40.2020.12.01.08.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 08:14:42 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kk8Ib-004Tj8-QB; Tue, 01 Dec 2020 12:14:41 -0400
Date:   Tue, 1 Dec 2020 12:14:41 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     Yejune Deng <yejune.deng@gmail.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] infiniband: i40iw: replace atomic_add_return()
Message-ID: <20201201161441.GG5487@ziepe.ca>
References: <1606726376-7675-1-git-send-email-yejune.deng@gmail.com>
 <b578b692d2ec4f598be584b809aed400@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b578b692d2ec4f598be584b809aed400@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 02:42:25PM +0000, Saleem, Shiraz wrote:

> >  	case I40IW_CM_STATE_ESTABLISHED:
> >  	case I40IW_CM_STATE_SYN_RCVD:
> > @@ -3020,7 +3020,7 @@ static int i40iw_cm_reject(struct i40iw_cm_node
> > *cm_node, const void *pdata, u8
> >  	i40iw_cleanup_retrans_entry(cm_node);
> > 
> >  	if (!loopback) {
> > -		passive_state = atomic_add_return(1, &cm_node->passive_state);
> > +		passive_state = atomic_inc_return(&cm_node->passive_state);
> 
> Fine with it as its consistent across i40iw. But aren't there many
> more instances of this across the tree?  Isn't this a choice best
> left to the developer?

I don't think it is a style choice, the narrowest applicable atomic
should always be used as a matter of clarity and performance.

Jason
