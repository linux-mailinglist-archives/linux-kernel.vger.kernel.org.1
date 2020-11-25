Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD912C4074
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgKYMqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbgKYMqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:46:11 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42E1C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:46:11 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id dm12so838298qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7R3km/7YgHo1sfvn914rRqBdqUPVd1zF91vgKVUo3Xc=;
        b=M/mxYq+6WVSJhqtHcll5G9Kc6LxBo4B/uly2oIt2xggPLKmAE5ON5TTsR4WRNE84F0
         Sn2sYhIAcPCbulkEJYySVktqOr9fVzTbFTyaDhRvE7sa8aPagCShUpsN1zLfCANAi3VW
         a8gY6VcXQdm8NGzEGbhTULgG8H0ro9c+I7y15qVi5Ca+DiCiN9tObzcB0VklcePCvd+e
         8UvMma0/Xy770YNeIbIP9FmJ+M5X2c1MM0tuDBk0mJvYwSMrthgS7rbsTHwehv12aCLv
         UrAHrnfeOiTqhKHt0xO10T9R//3yYaJx0D1wIs8xTWRR+PFMJ/gVVyCiEu7ldORDk/nV
         XaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7R3km/7YgHo1sfvn914rRqBdqUPVd1zF91vgKVUo3Xc=;
        b=OArQEHrz9xcbPd5lkLxB/AP8jA+KJMeS8DLvtFxXKNwSQwsDbVgREVNo4QIN3kRhbn
         gV5AcHMI8xbzwitTTA/HTOjvOlcmqjVClKuDd1x1B6fZcJsBiZZ9WUESO37rqh4osccw
         oEU4ffxuEHQnrPTQONUuHFkmt7VfQfn2xggGjPLEdUGno2fmymzDFcqycDTkeXeGeJzs
         PcFpeaUpPYAqI+VzJ4vyIUD6522ZJvmdDNRoWd0JxqRjcoQ4XMQbEgWsK5UcIU/EYIkM
         2UB5GAVbaDjtnZNk7btwskXCp7jYQ/vwXLYUl18/x7Zb20Sbfh5fAcwGlBAB4/Ndqy05
         /iXw==
X-Gm-Message-State: AOAM530ZeUjzmsIDLm+YdCbGeZmmeGq6DUbxF/dK+3K7vLbBAL0+ssSR
        tFSfYIbsNlofgh6oxrflxfQ=
X-Google-Smtp-Source: ABdhPJy9eE/ZP/OoqYf1TdWxnL8blzdDqm/Jxxnovc0Ljdqsk2ZRRLc+2lHWZzNMZaTjK3IJQI5xfA==
X-Received: by 2002:a05:6214:1848:: with SMTP id d8mr2963731qvy.7.1606308370783;
        Wed, 25 Nov 2020 04:46:10 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id s3sm2333587qtd.49.2020.11.25.04.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:46:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 07:45:47 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH v2] workqueue: Kick a worker based on the actual
 activation of delayed works
Message-ID: <X75R+8CRIOyu1IzE@mtj.duckdns.org>
References: <3837a2ee-f3d5-2732-7d15-7e9616319f05@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3837a2ee-f3d5-2732-7d15-7e9616319f05@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 02:21:25PM +0800, Yunfeng Ye wrote:
> In realtime scenario, We do not want to have interference on the
> isolated cpu cores. but when invoking alloc_workqueue() for percpu wq
> on the housekeeping cpu, it kick a kworker on the isolated cpu.
> 
>   alloc_workqueue
>     pwq_adjust_max_active
>       wake_up_worker
> 
> The comment in pwq_adjust_max_active() said:
>   "Need to kick a worker after thawed or an unbound wq's
>    max_active is bumped"
> 
> So it is unnecessary to kick a kworker for percpu's wq when invoking
> alloc_workqueue(). this patch only kick a worker based on the actual
> activation of delayed works.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Applied to wq/for-5.10-fixes w/ minor comment updates.

Thanks.

-- 
tejun
