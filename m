Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8040C268ED0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgINPCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgINPBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:01:52 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB06C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:01:52 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g7so325181iov.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Cf728ufQMlkaRRmpgTVrbI8jMPrMzo462/844HeWfg=;
        b=hXOfb5IdAHnig/CoiXYkXTqvHzq3sr1rrH4THmQNVxM2dmXB02f/XEAVLa61Y5mi33
         gSyhHsYD2Sxkf2y6eXzm4+WGRuFuczL6PkLYrjWUkD9Rdm3gOXSXcy0HrDHwKE0s4JDC
         iD1RQht7+lNlGlTf2tdvCrd287HQGpFHDl2rYDDRingwycZXrpuH+nujBye6stn0GmeT
         6/oHfSLaWwYGBZBdL0oRILfKoS0B9x73h2u7xQDLe8TrDVDs+LWgMCAWnAdwWc+iCuCm
         ZebJDIEa0/vUtU003OaXASx3z4zQW+2ZnBPd5SEep4BKnKcp3T7Q2FtCJkUKO30e1nHC
         3F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Cf728ufQMlkaRRmpgTVrbI8jMPrMzo462/844HeWfg=;
        b=rSzEc7PjqPJfIlxwViAN06tS3FXRa1igeLL+UrtOygEMdEDzgB9WEktHBoJ3m5FM7k
         BLekcwaYTGSlJPP4MRL/3f2xYB7k5kjDy/jmuAjtV+6l4twN93j7IXNqdCoNGHiFhVbP
         YaCzciFtdEFh+l/XYcHOLvYUDQETymQtRaVxeBqA2QVsYPhUYaIPafU4d9Lb/RqtBR/B
         9luB7aklODgWBI8Y+7xWUN3UfgQLwcg+sPCRB+Br2DM2tJ8U0fXz0TgsWsRw/TJRRqUA
         wM4kN2X3lMAuj1S//fD+Sxockn0pSlHEk03YACqxRMbPFG3uU0Xx+iYiZ+XrWD8L+9YZ
         iTNA==
X-Gm-Message-State: AOAM530Zov1PRcDL5oJjgpYwYxkhpVvu1lcZC8v31vQ7HMsqmNG+n0bM
        MPKetqkxAXdZE2AY+fVMIAZ/BqS4giLMfA==
X-Google-Smtp-Source: ABdhPJyy7tefmL8O2LeKVCdpknfO8lPk8kd4rKmsv97N4OHa4fmIAxNnerIPmwMjNBJXVrNhSdKKQQ==
X-Received: by 2002:a02:a305:: with SMTP id q5mr13655395jai.121.1600095711411;
        Mon, 14 Sep 2020 08:01:51 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id y19sm6813776ili.47.2020.09.14.08.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:01:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kHpzJ-0068Jh-Ml; Mon, 14 Sep 2020 12:01:49 -0300
Date:   Mon, 14 Sep 2020 12:01:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com>,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in ucma_close (2)
Message-ID: <20200914150149.GF1221970@ziepe.ca>
References: <0000000000008e7c8f05aef61d8d@google.com>
 <20200911041640.20652-1-hdanton@sina.com>
 <20200911152017.18644-1-hdanton@sina.com>
 <20200912013514.18380-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912013514.18380-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 12, 2020 at 09:35:14AM +0800, Hillf Danton wrote:
> > Migrate is the cause, very tricky:
> > 
> > 		CPU0                      CPU1
> > 	ucma_destroy_id()
> > 				  ucma_migrate_id()
> > 				       ucma_get_ctx()
> > 	xa_lock()
> > 	 _ucma_find_context()
> > 	 xa_erase()
> > 				       xa_lock()
> > 					ctx->file = new_file
> > 					list_move()
> > 				       xa_unlock()
> > 				      ucma_put_ctx
> > 				   ucma_close()
> > 				      _destroy_id()
> > 
> > 	_destroy_id()
> > 	  wait_for_completion()
> > 	  // boom
> > 
> > 
> > ie the destrory_id() on the initial FD captures the ctx right before
> > migrate moves it, then the new FD closes calling destroy while the
> > other destroy is still running.
> 
> More trouble now understanding that the ctx is reported to be freed
> in the write path, while if I dont misread the chart above, you're
> trying to pull another closer after migrate into the race.

migrate moves the ctx between two struct file's, so the race is to be
destroying on fir the first struct file, move to the second struct
file, then close the second struct file. 

Now close and destroy_id can race directly, which shouldn't be
allowed.

Jason
