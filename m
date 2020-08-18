Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93772489EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 17:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgHRPdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 11:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgHRPdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:33:32 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1FAC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 08:33:32 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id di22so15572657edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a6JBuZhVYWp23R6HGvWW9nRcBBE4mX5ykNxzEwYLGKc=;
        b=Ac/Dzu3FoXOA6oUvQv+5yd66VJmRWG0TPTYZXLVCZhZ4XGLWHKfhHvYLK89FQ+LGKK
         bU8jBb9tSJU/9bNKH2g389dVKDn23kZ3IeUw0+p9c6iVLightb+zUKKgg7pN6l8WM7XN
         dTrSvLt5iuvwFupu3p0EAeJnaCYoYuw/Vn51w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a6JBuZhVYWp23R6HGvWW9nRcBBE4mX5ykNxzEwYLGKc=;
        b=NOs0o9X4YwtUdxfbk8DB6lJdBsYQqrYGb8TUd2N7HDk5GzmlAjQ3pD/hajvPIjax22
         iBcxbvuX1GBErRQ8fP8VWIRdsEgu9mXXH8ef2AR4hsLr2yoUpvkiaVzK+5ZG0HyKZwER
         vfF5bQ7kXXb+oA5823TqFQLCZukGiT2lM7GOsfJakPv3t0lHcsrEuV6zV2wVfaIsXzo5
         5QbuqjcWy6yeZF3uveM+ovw6+yQr3SptUVUACfj31DD8YQvnokrCBKz9X30hfA/kb/Xe
         +2HOkNQKNvTx8Zk7QA4d9oDgjQOd8mdS33prCnjOEgmkdMjuu75ZRZJ4UhQR505bo+Ca
         nfrg==
X-Gm-Message-State: AOAM532eBKwEgIQnAR9ZjIzrY90MBZcyhKoZETNegF8J9ATebODDnQ0B
        xD/zTwmOMn73/9/XjX86rA9i8g==
X-Google-Smtp-Source: ABdhPJwK0rMXcmZjLSnIfUTDa+I60/0YARRpPhkhaEKKvECvklhauoQ6XXcKSJeD0BL0upcmv4+7+Q==
X-Received: by 2002:a05:6402:3070:: with SMTP id bs16mr20055627edb.269.1597764810834;
        Tue, 18 Aug 2020 08:33:30 -0700 (PDT)
Received: from [192.168.2.66] ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id q2sm17169535edb.82.2020.08.18.08.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 08:33:30 -0700 (PDT)
Subject: Re: [PATCH bpf-next v8 5/7] bpf: Implement bpf_local_storage for
 inodes
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
 <20200803164655.1924498-6-kpsingh@chromium.org>
 <20200818012758.4666zlknkr4x6cbl@kafai-mbp.dhcp.thefacebook.com>
 <60344fad-f761-0fee-a6ef-4880c45c3e52@chromium.org>
 <20200818152316.pkyko6gcpzeqp5sn@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Message-ID: <9a1544ac-309b-4c16-3f6a-e34d90b275b8@chromium.org>
Date:   Tue, 18 Aug 2020 17:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818152316.pkyko6gcpzeqp5sn@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/20 5:23 PM, Martin KaFai Lau wrote:
> On Tue, Aug 18, 2020 at 05:10:34PM +0200, KP Singh wrote:
>>
>>
>> On 8/18/20 3:27 AM, Martin KaFai Lau wrote:>>> On Mon, Aug 03, 2020 at 06:46:53PM +0200, KP Singh wrote:

[...]

a get_file
>> rather fcheck followed by get_file_rcu:
>>
>> #define get_file_rcu_many(x, cnt)	\
>> 	atomic_long_add_unless(&(x)->f_count, (cnt), 0)
>> #define get_file_rcu(x) get_file_rcu_many((x), 1)
>> #define file_count(x)	atomic_long_read(&(x)->f_count)
>>
>> But there is an easier way than all of this and this is to use 
>> fget_raw which also calls get_file_rcu_many 
>> and ensures a non-zero count before getting a reference.
> ic. Make sense.
> 
> There are fdget() and fdput() also which are used in bpf/syscall.c.

Yeah we could use fdget_raw but we don't really need the struct fd but just the 
struct file.

he non-raw versions masks away FMODE_PATH (O_PATH) files, we should still be able to
access blobs on the O_PATH files, thus the _raw version here.

- KP

> 
