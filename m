Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB78B273D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgIVIoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:44:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:51266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgIVIoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:44:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600764261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p3AfavqP40RUc2ETYtkDYnb3b9veh8eZpjijhPHw0fc=;
        b=TWukYMwD7NFNDXCfb/SO1wW+Oz14Lc4t+udWA6n+g3RqJeXVz2Juwadua8CE15vItHHMrs
        X6WmgQfgzuJ2s2nZDqn6V++LThK0r867znHK8COMio8Ev1fv4NV1F1uVtxdHD6OCRwLsKU
        rvXF2wfA4LKaMQ6GOgWLDnTfsNUc0CE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 733E9ACBF;
        Tue, 22 Sep 2020 08:44:58 +0000 (UTC)
Subject: Re: [PATCH] xen: remove redundant initialization of variable ret
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20200919031702.32192-1-jingxiangfeng@huawei.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <94b57348-2a8c-b0b9-1b83-b92b1e0216c9@suse.com>
Date:   Tue, 22 Sep 2020 10:44:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200919031702.32192-1-jingxiangfeng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.20 05:17, Jing Xiangfeng wrote:
> After commit 9f51c05dc41a ("pvcalls-front: Avoid
> get_free_pages(GFP_KERNEL) under spinlock"), the variable ret is being
> initialized with '-ENOMEM' that is meaningless. So remove it.
> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
