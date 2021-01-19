Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785552FBB17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390611AbhASPYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbhASPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:22:30 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56800C061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 07:21:50 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z6so6841666qtn.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 07:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2KppPTacTVT7N3+e7UjFJfespfp6ycO/Q7U7/d+lx9Q=;
        b=DE48pgeszLoponGtlzOJdCzPLaItCn+LoaMEHHAByNm03yykCnrcTp4yUn89RtBHQF
         GT8IvFsaPfQtqUKnEX+R23CkH4W9KlFphm9WoLGA/42EQXzsG2xpyOPrWVLpkaJsSI1U
         Uaf5DA/SmX31gZoejeI/0WxKsxYSLLho0lSD0IE3sRE3XRyEkXd4DvjnPCHRUElS5AfO
         USzQuLmREjq8ONff5F23uUuMRurjRtlt+1uZG1mA9adrnSM+jL7bFR3qXfNxIbxTjEBU
         tRjvE65wqjVRcFPOU+r8PBJHSUDYa53bgSWo7UUDmbPBxVvqa1Eo1DzZ6yCkamDCxwe6
         Ty7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2KppPTacTVT7N3+e7UjFJfespfp6ycO/Q7U7/d+lx9Q=;
        b=Z1iBaLJgtnfWtE56tt1VWlIb0wHSGYfmqRqqK21saWY0pqLElIWYyDNml8QZRHLXGz
         n0hekpYp4niSe+o4oEWC3rOkevGpWoYiEHDzxS0btY5tIbgREq4j02Q69SNRyrRxmrBI
         +PCZrtBz/rFzKOpOh9WU30lj03cX3fUZCJUz0xBAgAK+Qe9jDj9fTD+mkcqvJ94yry8v
         ryihhnKO82+FN5n7DfxRXwe7qwXJVGcDCPD1b6Z8bjL87JJJZwHImGC2K4HfMQ9eWAn+
         rGLzDkLw3D78lFc3laTFJAIkU53woOwagZTSHeECVtJNzNBUnG5bbrHy1rY3VVzEujK6
         A4/g==
X-Gm-Message-State: AOAM532hmZXeBqkaU2URMeLlsmdKUKxIdaZO5lwk8S8xo4fbkcakK145
        //d0QU/Q3cFpx1+rD57kJok=
X-Google-Smtp-Source: ABdhPJyRLxVQgKXD4j8cw0xsZYUVAq/wrCMbm3kLE+ksSeem9Y+XNNPc/9lBg5Ia4bKH+Q9o8r14ng==
X-Received: by 2002:ac8:4e53:: with SMTP id e19mr4759756qtw.77.1611069709470;
        Tue, 19 Jan 2021 07:21:49 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:4cbf])
        by smtp.gmail.com with ESMTPSA id k23sm5244562qtp.61.2021.01.19.07.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 07:21:48 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Jan 2021 10:21:04 -0500
From:   Tejun Heo <tj@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: Re: [PATCH] workqueue: fix annotation for WQ_SYSFS
Message-ID: <YAb44NN5d8uOB7Rj@mtj.duckdns.org>
References: <20210118080455.33499-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118080455.33499-1-dong.menglong@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 12:04:55AM -0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> 'wq_sysfs_register()' in annotation for 'WQ_SYSFS' is unavailable,
> change it to 'workqueue_sysfs_register()'.
> 
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>

Applied to wq/for-5.12.

Thanks.

-- 
tejun
