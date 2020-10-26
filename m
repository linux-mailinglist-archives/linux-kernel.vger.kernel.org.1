Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F5A29878A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 08:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770178AbgJZHkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 03:40:09 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:39118 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390893AbgJZHkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 03:40:09 -0400
Received: by mail-pg1-f181.google.com with SMTP id o7so5621280pgv.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 00:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Li9SlnQWDTKcmKGmcnd191ygBRsIiOth5WepatvR5ApFEpLVojjl9sLvfkZns+NTX6
         RE12zNaNOTo+yvF9KTRW9w6TafN5oYj/tiaw8PtMs75YHvvNUaBTQNuslpAaLSkOpyz3
         u0iFr1oMBPI+WlLWvC+AItp0vqTKXFf+XrA00OPAygtOHQU5qwtoD+yPDFSYsNuGPuCz
         +MB/WjOmqjNHxhGHRTnEZZ5wiHJHHfRRseEQo5bNZp+ys3vcSScS32ZiyErOUQQSg7Xm
         X1HxjUqRfk9kTlRUE1+MAWYChLTApijz32qWr3DugYW3nW3dqpN/WFLdfVEkKA9ObW32
         bX3w==
X-Gm-Message-State: AOAM532azOANmBCpSlJcQtyT0G2yrXHOzYVpYEhu8WBeQazDeNp6OfeS
        rVha5FJGYsfj8EeLuPR762Y=
X-Google-Smtp-Source: ABdhPJxxhyjyZmhrcv3ON2RrqikdeJICOeooY+lzLU+0D0DGLkAtlFsXKuI3XCt9RBFiNyjoG2A2zg==
X-Received: by 2002:a62:7744:0:b029:152:4223:1b4e with SMTP id s65-20020a6277440000b029015242231b4emr10263525pfc.60.1603698008578;
        Mon, 26 Oct 2020 00:40:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f815:47f7:1bca:3fe9? ([2601:647:4802:9070:f815:47f7:1bca:3fe9])
        by smtp.gmail.com with ESMTPSA id q24sm12352082pfn.72.2020.10.26.00.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 00:40:07 -0700 (PDT)
Subject: Re: [PATCH v3] nvme-rdma: handle nvme completion data length
To:     zhenwei pi <pizhenwei@bytedance.com>, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        lengchao@huawei.com
References: <20201025115124.1430678-1-pizhenwei@bytedance.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <146e7680-264e-7b70-0a5c-a6e7dd520a2d@grimberg.me>
Date:   Mon, 26 Oct 2020 00:40:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201025115124.1430678-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
