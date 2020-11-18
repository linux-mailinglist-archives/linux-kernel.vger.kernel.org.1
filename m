Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F682B8694
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgKRV1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 16:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKRV1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:27:12 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F69CC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:27:11 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id m13so3639890ioq.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eeM7fvU8Uo79E6Y3uNDD9FvmacgHALhMrr4AV1XqxP0=;
        b=PunnfcYpbpMRJUZjucBpq/I4yqUTk9Ywtf0HDRuOgldBli9h0gqL6uycoXQpPVYNd3
         SIKHm5l9sv8NrWaLKJr/ob4gAHdc5pz6T9/qGf5WYu6pfsHy3RBmNl6yb0HIUqRYWvTj
         92/UikKStZsnh8ARCVAdN6yjtmhNOIFSF4zNyRdkhMI+GaHZhnYohD5SQDm/Mnpf/i4R
         qgugEv3iRAF1lqUfyxkEdkGoBZt4ybue+bAyKy7hZbFdXMRL5YZPnoqOrp8JVfUMxa78
         vDa/IA1W99U7UNacYiouKBxgusHbBjMDmVC7m004xjMusLeen0pLclJaq9IsKhEdrZpy
         QyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eeM7fvU8Uo79E6Y3uNDD9FvmacgHALhMrr4AV1XqxP0=;
        b=V9Q+m1Ythpp6y/s31Z5M3Nv0tNmcb/sBture1XgRlxpWjOJbVgDMDlQDNStYub7GDJ
         eBKob7uwBGGesDerqOgH2Gu/b6FBKYOk7avKDensAb8Pg7sooxGe3u6tVM8O9vOM84bx
         +hshrBDnxpSoQgzcuhOG3zzZVTMPVf7j6DNzpFvjyAohIJafS1A7O48LSNeMgIAVJk67
         rBwHiwrQ88CkZHEMla+lMUY/CHS3PuEwRZQipf2e1tSVC+HZi4hYbSi9a9marWsug+pU
         qsgpCa8rE5fpBRuGaEjYDLIBq8KYN8x6cqf2P5Wazwe3tP7kNDNMPPthQwR3zU50H8xX
         byJA==
X-Gm-Message-State: AOAM531JxESzTcRmBHA7DAuNcxpA5vzm4bSUB95EWBwK7heGLe7RWyHV
        Df9Q84iDKQ5L765YxES16BryKWx5h6FeQA==
X-Google-Smtp-Source: ABdhPJxgpkYgNjZTur0BdZsWqdFVlKCtR8FHXQvzpQPnaFRYF7/LDl7QxStAqVnPjpkw7h2TZg3Y5g==
X-Received: by 2002:a05:6638:124d:: with SMTP id o13mr10383581jas.98.1605734830152;
        Wed, 18 Nov 2020 13:27:10 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z6sm16264337ilm.69.2020.11.18.13.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 13:27:09 -0800 (PST)
Subject: Re: [PATCH] eventfd: convert to ->write_iter()
To:     Michal Kubecek <mkubecek@suse.cz>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8a4f07e6ec47b681a32c6df5d463857e67bfc965.1605690824.git.mkubecek@suse.cz>
 <20201118151806.GA25804@infradead.org>
 <20201118195936.p33qlcjc7gp2zezz@lion.mk-sys.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4e4d222c-ed8b-a40d-0cdc-cf152573645c@kernel.dk>
Date:   Wed, 18 Nov 2020 14:27:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118195936.p33qlcjc7gp2zezz@lion.mk-sys.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/20 12:59 PM, Michal Kubecek wrote:
> On Wed, Nov 18, 2020 at 03:18:06PM +0000, Christoph Hellwig wrote:
>> On Wed, Nov 18, 2020 at 10:19:17AM +0100, Michal Kubecek wrote:
>>> While eventfd ->read() callback was replaced by ->read_iter() recently,
>>> it still provides ->write() for writes. Since commit 4d03e3cc5982 ("fs:
>>> don't allow kernel reads and writes without iter ops"), this prevents
>>> kernel_write() to be used for eventfd and with set_fs() removal,
>>> ->write() cannot be easily called directly with a kernel buffer.
>>>
>>> According to eventfd(2), eventfd descriptors are supposed to be (also)
>>> used by kernel to notify userspace applications of events which now
>>> requires ->write_iter() op to be available (and ->write() not to be).
>>> Therefore convert eventfd_write() to ->write_iter() semantics. This
>>> patch also cleans up the code in a similar way as commit 12aceb89b0bc
>>> ("eventfd: convert to f_op->read_iter()") did in read_iter().
>>
>> A far as I can tell we don't have an in-tree user that writes to an
>> eventfd.  We can merge something like this once there is a user.
> 
> As far as I can say, we don't have an in-tree user that reads from
> sysctl. But you not only did not object to commit 4bd6a7353ee1 ("sysctl:
> Convert to iter interfaces") which adds ->read_iter() for sysctl, that
> commit even bears your Signed-off-by. There may be other examples like
> that.

A better justification for this patch is that users like io_uring can
potentially write non-blocking to the file if ->write_iter() is
supported.

-- 
Jens Axboe

