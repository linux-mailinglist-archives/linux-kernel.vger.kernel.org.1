Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9851A1CFB92
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 19:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgELREm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 13:04:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27567 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725904AbgELREm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589303080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2FfH4r0y3JqkUn17wrFKeY534DtufylV4MIjoIKqTfI=;
        b=Wwy7sKY2gTkOvba88mwl1ew+1mxCpCXIfKVICCRn0qWHAC87wunTvXzTIu0VXRI+uh0mvr
        mLWzeklZ9akZVqiEySDxurmJ19/zg5fnbeFFpxiUiznNshcGDC10ghtGFgGclznf2TmQ3h
        I9bNV3Mk07MxkjA2BU3OwnT1RNJpZhg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-o96OxpI-OqauR9VPhBw_MA-1; Tue, 12 May 2020 13:04:39 -0400
X-MC-Unique: o96OxpI-OqauR9VPhBw_MA-1
Received: by mail-wr1-f70.google.com with SMTP id 90so7150742wrg.23
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 10:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2FfH4r0y3JqkUn17wrFKeY534DtufylV4MIjoIKqTfI=;
        b=M4LyiO5Yxr9mkVoJmb/4qX0kWm8X0zyithPgPs7ZNjQ1K5tvXM+D5ktq/50P3UF0gq
         1xjlZaXfGpWCsRyKN4ByJEOjo13GXih7vU8/8CsRmz8kodHBB2zhYGNj/SiWsG/xIOhg
         Mx0764/Zu6FMgLb7ATg2LiaoN2sVfzbMCK8aARurVJE8/xfqqAa3Fz90k0fSPht1VNWM
         2mdrLp0YXi4LN8QNqFQP9f8/2MpVOo5E0IlJD1vCJ8bZ25XepDxOlkjahMhRJzwSRVJV
         SUTwfxgkd4MybkgYTSpFuNnlZ0TJBCp5qJYKs8N4sSOxdOsFMcieVADWJfKR14DBmCp6
         IXyw==
X-Gm-Message-State: AGi0PuYN+hD8ycmGMJo4I1LvZMkzqz/NTlCFsaEAjdR+9VYSv+KYY+mM
        ED6CINLoFSgG447RgODp/r5wiHtVK4SigXkUIF0B/aj/BiyGH+XzBJAB297u6AzrxJW7oCNogO5
        rVFIn08L40hs1BnAU5joNA3+P
X-Received: by 2002:adf:e489:: with SMTP id i9mr17967364wrm.373.1589303073763;
        Tue, 12 May 2020 10:04:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypKVLrB308VRcO6bj0ZQfxpY4cUD0463YSCv6Yceb9YcXZ4+uoJR7jS7j4Up4h8iAMvGiVZL0Q==
X-Received: by 2002:adf:e489:: with SMTP id i9mr17967350wrm.373.1589303073590;
        Tue, 12 May 2020 10:04:33 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id j1sm12059386wrm.40.2020.05.12.10.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 10:04:32 -0700 (PDT)
Subject: Re: [RFC][PATCH 0/5] Enable objtool multiarch build
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1588888003.git.mhelsley@vmware.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <c20c2aba-fd64-f4b9-ae4d-0a93817a3e8f@redhat.com>
Date:   Tue, 12 May 2020 18:04:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cover.1588888003.git.mhelsley@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On 5/11/20 6:35 PM, Matt Helsley wrote:
> My previous RFC[1] tried to add recordmcount as the mcount subcommand
> of objtool. As a necessary first step that required enabling building
> of objtool for more than the x86 architecture.
> 
> Some folks have been working on enabling objtool checking functionality
> for arm64. Rather than repeat that work here I aim to show a minimal
> set which ensures that objtool builds for any architecture. This
> will allow for not only building the check and ORC subcommands
> but also incorporating more subcommands -- such as recordmcount.
> 

Thanks for putting the effort to simplify adding support of the 
different command for new architectures.

I have a few some comments on some commits.

Cheers,

-- 
Julien Thierry

